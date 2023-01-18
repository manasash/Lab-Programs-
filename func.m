classdef func
    methods(Static)
        %%%%%%%%%%%%%%%%%%%%%%%% Ploting Nodes %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function placeNodes(x, y, style, lwidth, edgecolor, facecolor, size)
            if style == '^'
                for i = 1:2
                    plot(x, y, style,...
                        'LineWidth', lwidth,...
                        'MarkerEdgeColor', edgecolor,...
                        'MarkerFaceColor', facecolor,...
                        'MarkerSize', size)
                    style = 'v';
                end
            else
                plot(x, y, style,...
                    'LineWidth', lwidth,...
                    'MarkerEdgeColor', edgecolor,...
                    'MarkerFaceColor', facecolor,...
                    'MarkerSize', size)
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%% Expanding Circle %%%%%%%%%%%%%%%%%%%%%%%%
        function expandingCircle(x, y, range, color)
            t = 0:0.05:6.28;
            for i = 1:range
                x1 = (x + i * cos(t))';
                y1 = (y + i * sin(t))';
                XS = [x1; x1(1)];
                YS = [y1; y1(1)];
                cir = line(XS, YS, 'LineWidth', 2, 'color', color);
                pause(0.01);
                delete(cir);
             end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%% Power Mod %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function temp = powermod(g, n, q)
            temp = 1;
            for i = 1:n
                temp = mod((temp * g), q);
            end
            return
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%% Prime No %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function q = primeNo(min, max)
            value = false;
            while(value ~= true)
                q = randi([min, max], 1, 1); 
                if isprime(q)
                    value = true;
                end
            end
            return
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%% Matrix G %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Known to everyone (Public)
        function genarate_matrix_G(g, q)
            global matrix_G lambda matObj no_of_clst
            matrix_G = zeros(2, 15);
            for i = 1:(lambda+1)
                for j = 1:matObj.nodes_clst(no_of_clst)
                    if i == 1
                        matrix_G(i, j) = func.powermod(g, j+1, q);
                    else
                        matrix_G(i, j) = func.powermod(matrix_G(1, j),i,q);
                    end
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%% Matrix D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function generate_matrix_D(min, max, q)
            global matrix_D lambda
            matrix_D = zeros(2, 2);
            
            for i = 1:lambda + 1
                for j = 1:lambda + 1
                    if i <= j
                        a = (mod(randi([min, max],1,1), (q - 1))) + 1;
                        matrix_D(i, j) = a;
                        matrix_D(j, i) = a;
                    end
                end
            end
            assignin('base', 'matrix_D', matrix_D);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%% Matrix A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function generate_matrix_A(clst_no, q)
            % matrix_D_x_matrix_G generation
            global matObj lambda 
            global matrix_A matrix_D matrix_G matrix_A_transpose
            matrix_A = zeros(2, 15);
            matrix_A_transpose = zeros(15, 2);
            
            for i = 1: lambda + 1
                for j = 1 : matObj.nodes_clst(clst_no)
                    matrix_A(i, j) = 0;
                    for k = 1 : lambda + 1
                        matrix_A(i, j) = mod(matrix_A(i, j) + mod((matrix_D(i, k) .* matrix_G(k, j)),  q),  q);
                    end
                end
            end
            
            %Transposing the matrix
            for i = 1: lambda + 1
                for j = 1 : matObj.nodes_clst(clst_no)
                    matrix_A_transpose(j, i) = matrix_A(i, j);
                end
            end
            
            assignin('base', 'matrix_A', matrix_A);
            assignin('base', 'matrix_A_T', matrix_A_transpose);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%% Matrix K %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function generate_matrix_K(clst_no, q)
            % matrixK_x_matrixA_transpose_x_matrixG
            global lambda matObj 
            global matrix_K matrix_A_transpose matrix_G
            matrix_K = zeros(2, 15);
            
            for i = 1 : lambda + 1
                for j = 1 : matObj.nodes_clst(clst_no)
                    for k = 1 : lambda + 1
                        matrix_K(i, j) = mod(matrix_K(i, j) + mod((matrix_A_transpose(i, k) .* matrix_G(k, j)), q), q);
                    end
                end
            end
            
            assignin('base', 'matrix_K', matrix_K);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%