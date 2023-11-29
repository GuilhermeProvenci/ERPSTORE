-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 29-Nov-2023 às 19:50
-- Versão do servidor: 10.4.27-MariaDB
-- versão do PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `erpstore`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `telefone` varchar(50) NOT NULL,
  `endereco` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `telefone`, `endereco`) VALUES
(3, 'teste 3 ', '123\'', '123'),
(8, 'João Silva', '(123) 456-7890', 'Rua A, 123'),
(9, 'Maria Oliveira', '(987) 654-3210', 'Avenida B, 456'),
(10, 'Carlos Santos', '(555) 123-4567', 'Rua C, 789'),
(11, 'Ana Souza', '(777) 888-9999', 'Avenida D, 987'),
(12, 'Pedro Pereira', '(222) 333-4444', 'Rua E, 654'),
(13, 'Mariana Lima', '(999) 888-7777', 'Avenida F, 321'),
(14, 'Lucas Costa', '(444) 555-6666', 'Rua G, 555'),
(15, 'Juliana Santos', '(111) 222-3333', 'Avenida H, 222'),
(16, 'Rafael Oliveira', '(777) 666-5555', 'Rua I, 888'),
(17, 'Fernanda Silva', '(333) 444-5555', 'Avenida J, 111');

-- --------------------------------------------------------

--
-- Estrutura da tabela `condicional`
--

CREATE TABLE `condicional` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `data_entregue` date DEFAULT NULL,
  `data_devolucao` date NOT NULL,
  `nome_cliente` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `condicional`
--

INSERT INTO `condicional` (`id`, `cliente_id`, `data_entregue`, `data_devolucao`, `nome_cliente`) VALUES
(1, 3, '2023-10-18', '2023-10-21', 'teste 3 ');

-- --------------------------------------------------------

--
-- Estrutura da tabela `condicional_pendente`
--

CREATE TABLE `condicional_pendente` (
  `id` int(11) DEFAULT NULL,
  `id_produto` int(11) DEFAULT NULL,
  `nome_produto` varchar(255) DEFAULT NULL,
  `quantidade_condicional` int(11) DEFAULT NULL,
  `id_condicional` int(11) DEFAULT NULL,
  `nome_cliente` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `condicional_pendente`
--

INSERT INTO `condicional_pendente` (`id`, `id_produto`, `nome_produto`, `quantidade_condicional`, `id_condicional`, `nome_cliente`) VALUES
(NULL, 2, '123', 12, NULL, 'adm'),
(NULL, 4, 'teste', 12, NULL, 'adm'),
(NULL, 2, '123', 12, NULL, 'adm'),
(NULL, 2, '123', 123, NULL, 'adm');

-- --------------------------------------------------------

--
-- Estrutura da tabela `estoque`
--

CREATE TABLE `estoque` (
  `id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `nome_produto` varchar(255) DEFAULT NULL,
  `quantidade_em_estoque` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `estoque`
--

INSERT INTO `estoque` (`id`, `produto_id`, `nome_produto`, `quantidade_em_estoque`) VALUES
(1, 1, 'camiseta confortavel ', 0),
(2, 2, 'camiseta confortavel ', -24),
(3, 3, 'camiseta confortavel ', 0),
(4, 4, 'teste', 111),
(5, 5, 'Cropped Masculino kkk', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `tamanho` varchar(5) NOT NULL,
  `preco` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `tamanho`, `preco`) VALUES
(1, 'camiseta confortavel ', '', '0.00'),
(2, '123', '', '123.00'),
(3, 'QWE', 'QWE', '123.00'),
(4, 'teste', 'q', '123.00'),
(5, 'Cropped Masculino kkk', 'GGGGG', '69.90');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `condicional`
--
ALTER TABLE `condicional`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Índices para tabela `condicional_pendente`
--
ALTER TABLE `condicional_pendente`
  ADD KEY `id_produto` (`id_produto`),
  ADD KEY `id_condicional` (`id_condicional`);

--
-- Índices para tabela `estoque`
--
ALTER TABLE `estoque`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices para tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `condicional`
--
ALTER TABLE `condicional`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `estoque`
--
ALTER TABLE `estoque`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `condicional`
--
ALTER TABLE `condicional`
  ADD CONSTRAINT `condicional_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`);

--
-- Limitadores para a tabela `condicional_pendente`
--
ALTER TABLE `condicional_pendente`
  ADD CONSTRAINT `condicional_pendente_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`),
  ADD CONSTRAINT `condicional_pendente_ibfk_2` FOREIGN KEY (`id_condicional`) REFERENCES `condicional` (`id`);

--
-- Limitadores para a tabela `estoque`
--
ALTER TABLE `estoque`
  ADD CONSTRAINT `estoque_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
