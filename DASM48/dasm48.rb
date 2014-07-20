require_relative 'lib/version.rb'

module CPME48

  INS = {
    "NOP" => 0b00000,
    "JMP" => 0b00001,   "JZ"  => 0b00010,
    "SUB" => 0b00100,   "ADD" => 0b00110,
    "MVI" => 0b01000,   "MOV" => 0b01010,
    "STA" => 0b01100,   "LDA" => 0b01110,
    "OUT" => 0b10000,   "IN"  => 0b10010,
    "AMOV" => 0b10001,  "CMP" => 0b10110,
    "JNE"  => 0b11100,  "JE"  => 0b11011,
    "JFR"  => 0b10110,  "JBR" => 0b11101,
    "PUSH" => 0b11001,  "POP" => 0b11110,
    "SPSH" => 0b11011,  "SPOP" => 0b10011,
    "CALL" => 0b11000,  "RET" => 0b11111,
    "INC"  => 0b10101,  "DEC" => 0b10111,
  }

  INSDUMP = INS.invert

  REG  = { "R0" => 0b000, "R1" => 0b001, "R2" => 0b010, "R3" => 0b011,
           "R4" => 0b100, "R5" => 0b101, "R6" => 0b110, "R7" => 0b111 }

  EREG = { "AX" => 0b000, "BX" => 0b001, "CX" => 0b010, "DX" => 0b011,
           "SI" => 0b100, "DI" => 0b101, "SP" => 0b110, "BP" => 0b111 }

  SREG = { "PC" => 0b000, "FLAG" => 0b111 }

  REQURE_ARGS = [
    %w{RET  NOP},
    %w{JMP  JNE  JE  JBR  JFR  POP  SPOP  PUSH  SPSH  INC  DEC CALL},
    %w{MVI  MOV  IN   JZ  CMP  OUT  STA  LDA  ADD   SUB   AMOV }
  ]

  class DASM48

    include CPME48

    ###
    # Assemble one file job
    def initialize(filename, report=false)
      @binary = []
      @report = []
      @source = filename
      @labels = {}
      @addr = 0 
      assmeble(report)
      generate
    end

    def show_error(msg, errno=1)
      $stderr.puts msg
      exit(errno)
    end

    def process_label(label)
      show_error("Label already defined!", 2) if @labels.has_key?(label)
      @labels[label[0..-2]] = @addr
      return nil
    end

    ###
    # Process argument, return register code if arg is like R0,R1 or AX,FLAG.
    # Else if arg is a defined label, then returns it's address. If it is a
    # integer, just read and parse to the caller. Otherwise it must be a
    # undefined lebel, feel free to return nil.
    #
    #   process_argument("123h")
    #   porcess_argument("R0")
    #   process_argument("start")
    #
    def process_argument(arg)
      return REG[arg]     if REG.has_key?(arg)
      return EREG[arg]    if EREG.has_key?(arg)
      return SREG[arg]    if SREG.has_key?(arg)
      return @labels[arg] if @labels.has_key?(arg)
      return arg.to_i(16) if arg =~ /^\d*[Hh]$/
      return arg.to_i(10) if arg =~ /^\d*$/
      return nil
    end

    def process_command(cmd)
      # not implement yet
    end

    ###
    # Parse single line
    def assmeble_line(line)
      return nil if line.nil?
      line = line.chomp.strip
      return nil if line.strip.empty?
      return nil if line.start_with?(";")
      return process_command(line) if line.start_with?(".")
      # remove comment
      line.strip.gsub!(/;.*/, "")
      
      # split the operator and the operands
      tuple = line.split
      case tuple.size
      when 1
        # No Argument instructions
        op = tuple.first.upcase
        return process_label(op) if op.end_with?(":")
        unless REQURE_ARGS[0].include?(op)
          show_error("ArgumentError for %s, too much or too few." % tuple, 1)
        end
        return (INS[op]<<11)&0xFFFF
      when 2
        op = tuple.first.upcase
        arg = tuple.last.split(",")
        unless REQURE_ARGS[arg.size].include?(op)
          show_error("ArgumentError for %s, too much or too few." % [op], 1)
        end
        # generate operation machine code
        opc = INS[op]<<11

        if %w{JMP JE JNE JFR JBR CALL}.include?(op)
          x = process_argument(arg.first)
          return x.nil? ? [opc, arg.first.dup] : ((x&0xFF)|opc)
        elsif %w{INC DEC POP SPOP PUSH SPSH}.include?(op)
          ad1 = process_argument(arg.first)
          return opc|(ad1<<8)
        elsif %w{ADD SUB MOV MVI IN OUT STA LDA CMP AMOV}.include?(op)
          ad1 = process_argument(arg.first)
          ad2 = process_argument(arg.last)
          return opc|(ad1<<8)|ad2
        end
      else
        show_error("Invalid instruction")
      end
    end

    def assmeble(report)
      f = File.open(@source, "rb+")
      f.each_line do |line|
        result = assmeble_line(line)
        unless result.nil?
          @binary[@addr] = result
          @report[@addr] = line if report
          @addr += 1
        end
      end
    end

    def generate
      origin = @source.split(".")
      report = origin[0..-2].join(".") + ".lst" unless @report.empty?
      f = File.open(report, "wb+")
      @binary.each_with_index do |bin, addr|
        bin = bin.first | @labels[bin.last.upcase] if bin.is_a?(Array)
        bin = 0 if bin.nil?
        out = sprintf("%04s %04s %016s %16s", addr.to_s(16), bin.to_s(16), bin.to_s(2), @report[addr])
        f.puts out
      end
      f.close
      end
    end

  end



report = ARGV.include?("-r")
source = ARGV.last

CPME48::DASM48.new(source, report)
