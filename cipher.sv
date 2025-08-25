module cifra_xor(
    input clk,
    input reset,
    input start,
    input [7:0] plaintext,
    input [7:0] key,
    output reg [7:0] ciphertext,
    output reg done
);

    reg [1:0] current_state, next_state;

    parameter IDLE    = 2'b00,
              LOAD    = 2'b01,
              PROCESS = 2'b10,
              DONE    = 2'b11;

    reg [2:0] contador;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state   <= IDLE;
          	done            <= 1'b0;
            contador        <= 3'b000;
            ciphertext      <= 8'b0;
            
        end else begin
            current_state <= next_state;
          
          if(current_state == LOAD) begin
            ciphertext <= 8'b0;
            contador <= 3'b000;
          end
            if (current_state == PROCESS) begin
                ciphertext[contador] <= plaintext[contador] ^ key[contador];

                if (contador < 3'd7) begin
                    contador <= contador + 1;
                end
            end else if (current_state == IDLE) begin
                done       = 1'b0;
            end
        end
    end

    always @ (*) begin
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (start) begin
                    next_state = LOAD;
                end
            end
            LOAD: begin
                next_state = PROCESS;
            end
            PROCESS: begin
                if (contador == 3'd7) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;

                if (!start) begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule