module cifra_xor_tb;

    reg clk;
    reg reset;
    reg start;
    reg [7:0] plaintext;
    reg [7:0] key;

    wire [7:0] ciphertext;
    wire done;

    cifra_xor dut (
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
        plaintext = 8'b0;
        key       = 8'b0;
        reset     = 1'b0;
      $display ("-------------------------------------------");

//Teste 1
        plaintext = 8'b01001000;
        key       = 8'b10110111;
      $display("Teste 1: plaintext = %b, key = %b", plaintext, key);
      $display ("-------------------------------------------");
      #(tempo_clk);
        start     = 1'b1;
      #(tempo_clk * 11);

      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2);
      
      
      $display ("-------------------------------------------");
            if (ciphertext == (plaintext ^ key)) begin
        $display("CIFRA CORRETA CONFIRMADA!");
      end else begin
        $display("CIFRAGEM INCORRETA!");
      end
       $display ("-------------------------------------------");
      $display("Vamos reverter a cifra XOR para ver se chegaremos ao plaintext que foi escrito no teste anterior."); $display("Caso dê certo, isso quer dizer que a cifragem efetivamente funcionou.");

       $display ("-------------------------------------------");
//Teste 2
        plaintext = 8'b11111111;
        key       = 8'b10110111;
      $display("Teste 2: plaintext = %b, key = %b", plaintext, key);
      $display ("-------------------------------------------");
        #(tempo_clk);
        start = 1'b1;
      #(tempo_clk * 11);
      
      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2);  
      $display ("-------------------------------------------");
      if (ciphertext == (plaintext ^ key)) begin
        $display("CIFRA CORRETA CONFIRMADA!");
      end else begin
        $display("CIFRAGEM INCORRETA!");
      end
       $display ("-------------------------------------------");
      
//Teste 3      
        plaintext = 8'b00000000;
        key       = 8'b11111111;
      $display("Teste 3: plaintext = %b, key = %b", plaintext, key);
      $display ("-------------------------------------------");
      
        #(tempo_clk);
        start = 1'b1;
        #(tempo_clk * 11);
      
      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2); 
      $display ("-------------------------------------------");

      if (ciphertext == (plaintext ^ key)) begin
        $display("CIFRA CORRETA CONFIRMADA!");
      end else begin
        $display("CIFRAGEM INCORRETA!");
      end
       $display ("-------------------------------------------");
      
//Teste 4
   		plaintext = 8'b11111111;
        key       = 8'b11111111;
      $display("Teste 4: plaintext = %b, key = %b", plaintext, key);
      $display ("-------------------------------------------");
      
        #(tempo_clk);
        start = 1'b1;
        #(tempo_clk * 11);
      $display("Mensagem cifrada: Ciphertext: %b", ciphertext);
        #(tempo_clk);
        start = 1'b0;
        #(tempo_clk * 2);
      $display ("-------------------------------------------");
      if (ciphertext == (plaintext ^ key)) begin
        $display("CIFRA CORRETA CONFIRMADA!");
      end else begin
        $display("CIFRAGEM INCORRETA!");
      end
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