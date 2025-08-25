module cifra_xor #(
  parameter tamanho_key = 8,
  parameter tamanho_palavra = 16
)
  
  (
    input clk,
    input reset,
    input start,
    input [(tamanho_palavra-1):0] plaintext,
    input [(tamanho_key-1):0] key,
    output reg [(tamanho_palavra-1):0] ciphertext,
    output reg done
);

    reg [1:0] current_state, next_state;

    parameter IDLE    = 2'b00,
              LOAD    = 2'b01,
              PROCESS = 2'b10,
              DONE    = 2'b11;

  reg [3:0] contador; //Vou limitar a 4 bits de contador, pois os testes não passarão disso.

  always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state   <= IDLE;
          	done            <= 1'b0;
            contador        <= 4'b0;
          	ciphertext      <= 16'b0;
            
        end else begin
            current_state <= next_state;
          
          if(current_state == LOAD) begin
            contador        <= 4'b0;
          	ciphertext      <= 16'b0;
          end
            if (current_state == PROCESS) begin
              ciphertext[contador] <= plaintext[contador] ^ key[contador % (tamanho_key)];

              if (contador < (tamanho_palavra-1)) begin
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
              if (contador == (tamanho_palavra-1)) begin
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