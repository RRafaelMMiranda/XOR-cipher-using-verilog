module cifra_xor_tb;

    reg clk;
    reg reset;
    reg start;
  reg [16-1:0] plaintext;
  reg [8-1:0] key;

  wire [16-1:0] ciphertext;
    wire done;

  cifra_xor #(.tamanho_key(8),
              .tamanho_palavra(16)
             )
  	dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext),
        .done(done)
    );

    parameter tempo_clk = 10;

    initial begin
       $dumpfile("cifra_xor_waves.vcd");
       $dumpvars(0, dut);
        clk = 1'b0;
      forever #(tempo_clk/2) clk = ~clk;
    end

    initial begin
      $display("Estado inicial (inicialização)");
        reset     = 1'b1;
        start     = 1'b0;
        plaintext = 16'b0;
        key       = 8'b0;
        reset     = 1'b0;
      $display ("-------------------------------------------");

//Teste 1
        plaintext = 16'b0100100001001000;
        key       = 8'b11111111;
      $display("Teste 1: plaintext = %b, key = %b", plaintext, key);
      $display ("-------------------------------------------");
      #(tempo_clk);
        start     = 1'b1;
      #(tempo_clk * 19);

      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2);      
      $display ("-------------------------------------------");
      $display("Vamos reverter a cifra XOR para ver se chegaremos ao plaintext que foi escrito no teste anterior."); $display("Caso dê certo, isso quer dizer que a cifragem efetivamente funcionou.");
       $display ("-------------------------------------------");
//Teste 2
        plaintext = 16'b1011011110110111;
        key       = 8'b11111111;
      	$display("Teste 2: plaintext = %b, key = %b", plaintext, key);
      $display ("-------------------------------------------");
        #(tempo_clk);
        start = 1'b1;
      #(tempo_clk * 19);
      
      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2);  
      $display ("-------------------------------------------");
  //Teste 3
        plaintext = 16'b0000000000000000;
        key       = 8'b111111111;
      $display("Teste 3: plaintext = %b, key = %b", plaintext, key);
      $display ("-------------------------------------------");
      #(tempo_clk);
        start     = 1'b1;
      #(tempo_clk * 19);

      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2);
      
      $display ("-------------------------------------------");
//Teste 4
        plaintext = 16'b1111111111111111;
        key       = 8'b111111111;
      $display("Teste 4 - : plaintext = %b, key = %b. Queremos ciphertext: 0000000000000000", plaintext, key);
      $display ("-------------------------------------------");
      #(tempo_clk);
        start     = 1'b1;
      #(tempo_clk * 19);

      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2);
      
      $display ("-------------------------------------------");
//Teste 5
        plaintext = 16'b0101010101010101;
        key       = 8'b01010101;
      $display("Teste 5: plaintext = %b, key = %b", plaintext, key);
      $display ("-------------------------------------------");
      #(tempo_clk);
        start     = 1'b1;
      #(tempo_clk * 19);

      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2);
      
      $display ("-------------------------------------------");
      //Teste 6
        plaintext = 16'b0000000000000000;
        key       = 8'b01010101;
      $display("Teste 5: plaintext = %b, key = %b. Queremos ciphertext: 0101010101010101", plaintext, key);
      $display ("-------------------------------------------");
      #(tempo_clk);
        start     = 1'b1;
      #(tempo_clk * 19);

      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2);
      
      $display ("-------------------------------------------");

      $finish;
    end

    // Imprimir na tela a cada ciclo
    initial begin
      $monitor("Tempo: %0t | Current State: %b | Plaintext: %b | Key: %b | Ciphertext: %b | Done: %b",
                  $time,
                  dut.current_state,
                  plaintext,
                  key,
                  ciphertext,
                  done);
    end

endmodule