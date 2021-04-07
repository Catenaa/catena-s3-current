-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.18-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping data for table catenas3.apartments: ~3 rows (approximately)
/*!40000 ALTER TABLE `apartments` DISABLE KEYS */;
REPLACE INTO `apartments` (`id`, `name`, `type`, `label`, `citizenid`) VALUES
	(1, 'apartment37988', 'apartment3', 'Integrity Way 7988', 'AFV00955'),
	(3, 'apartment55639', 'apartment5', 'Fantastic Plaza 5639', 'VAD21762');
/*!40000 ALTER TABLE `apartments` ENABLE KEYS */;

-- Dumping data for table catenas3.api_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `api_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_tokens` ENABLE KEYS */;

-- Dumping data for table catenas3.banks: ~8 rows (approximately)
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
REPLACE INTO `banks` (`id`, `name`, `coords`, `cashiercoords`, `beforevaults`, `vaults`, `vaultgate`, `finalgate`, `vg_spots`, `m_spots`, `bankOpen`, `bankCooldown`, `bankType`, `moneyBags`) VALUES
	(1, 'Fleeca', '{"x":149.88,"y":-1040.34,"z":29.37,"h":157.66}', '{"door":{"outside":{"x":145.26,"y":-1041.17,"z":29.37,"h":242.62},"coords":{"x":145.4186,"y":-1041.813,"z":29.64255}, "hash":-131754413, "oh":160.0 , "ch":249.846}, "counters":[{"x":146.87,"y":-1041.12,"z":29.37,"h":339.77},{"x":148.23,"y":-1041.62,"z":29.37,"h":345.57},{"x":149.66,"y":-1042.15,"z":29.37,"h":346.35},{"x":150.98,"y":-1042.62,"z":29.37,"h":332.29}]}', NULL, '{"door":{"thermite":{"spark":{"x":147.515,"y":-1044.41,"z":29.47},"drip":{"x":147.29,"y":-1045.41,"z":29.37},"bomb":{"offset":{"x":0.20,"y":-0.025,"z":0.15},"rotation":{"x":90.0,"y":-90.0,"z":0.0}},"heading":250.0},"coords":{"x":148.0266,"y":-1044.364,"z":29.50693}, "hash":2121050683, "oh": 160.0, "ch":249.846}, "coords":{"x":146.94,"y":-1046.14,"z":29.37,"h":247.43}}', '{"door":{"coords":{"x":150.2913,"y":-1047.629,"z":29.6663}, "hash":-1591004109, "oh": 90.0, "ch":159.478}, "coords":{"x":148.55,"y":-1046.29,"z":29.35,"h":162.25}}', NULL, '[{"x":151.18,"y":-1046.7,"z":29.35,"h":248.73},{"x":150.53,"y":-1045.16,"z":29.35,"h":340.25},{"x":149.03,"y":-1044.7,"z":29.35,"h":333.25}]', '[{"x":147.11,"y":-1047.69,"z":29.35,"h":77.05},{"x":146.6,"y":-1049.02,"z":29.35,"h":69.09},{"x":146.94,"y":-1050.24,"z":29.35,"h":160.26},{"x":149.21,"y":-1051.16,"z":29.35,"h":158.39},{"x":150.6,"y":-1049.09,"z":29.35,"h":253.12}]', 1, 0, 'Small', NULL),
	(2, 'Fleeca 2', '{"x":-350.83,"y":-49.6,"z":49.04,"h":156.65}', '{"door":{"outside":{"x":-355.5,"y":-50.52,"z":49.04,"h":250.89},"coords":{"x":-355.3892,"y":-51.06769,"z":49.31105}, "hash":-131754413, "oh":160.0 , "ch":249.846}, "counters":[{"x":-354.06,"y":-50.37,"z":49.04,"h":340.74},{"x":-352.64,"y":-50.92,"z":49.04,"h":342.21},{"x":-351.15,"y":-51.34,"z":49.04,"h":339.83},{"x":-349.83,"y":-51.82,"z":49.04,"h":332.06}]}', NULL, '{"door":{"thermite":{"spark":{"x":-353.235,"y":-53.645,"z":49.14},"drip":{"x":-353.41,"y":-54.53,"z":49.04},"bomb":{"rotation":{"x":90.0,"y":-90.0,"z":0.0},"offset":{"x":0.25,"y":-0.125,"z":0.15}},"heading":250.0},"coords":{"x":-352.7365,"y":-53.57248,"z":49.17543}, "hash":2121050683, "oh": 160.0, "ch":249.846}, "coords":{"x":-353.85,"y":-55.32,"z":49.04,"h":247.94}}', '{"door":{"coords":{"x":-350.4144,"y":-56.79705,"z":49.3348}, "hash":-1591004109, "oh": 90.0, "ch":159.478}, "coords":{"x":-352.16,"y":-55.5,"z":49.01,"h":155.42}}', NULL, '[{"x":-349.55,"y":-55.83,"z":49.01,"h":250.5},{"x":-350.3,"y":-54.37,"z":49.01,"h":335.7},{"x":-351.58,"y":-53.84,"z":49.01,"h":344.11}]', '[{"x":-353.56,"y":-56.99,"z":49.01,"h":71.28},{"x":-354.12,"y":-58.49,"z":49.01,"h":70.56},{"x":-353.35,"y":-59.59,"z":49.01,"h":159.66},{"x":-351.55,"y":-60.29,"z":49.01,"h":169.66},{"x":-350.17,"y":-59.12,"z":49.01,"h":252.22}]', 1, 0, 'Small', NULL),
	(3, 'Fleeca 3', '{"y":-278.46,"z":54.17,"h":161.96,"x":314.36}', '{"door":{"outside":{"y":-279.61,"z":54.16,"h":257.06,"x":309.62},"coords":{"x":309.74914550781,"y":-280.1796875,"z":54.439262390137}, "hash":-131754413, "oh":170.0 , "ch":249.86596679688}, "counters":[{"y":-279.47,"z":54.16,"h":336.19,"x":311.17},{"y":-280.04,"z":54.16,"h":335.54,"x":312.59},{"y":-280.57,"z":54.16,"h":348.41,"x":314.09},{"y":-281.04,"z":54.16,"h":346.89,"x":315.44}]}', NULL, '{"door":{"thermite":{"spark":{"x":311.85,"y":-282.7875,"z":54.26},"drip":{"x":311.6,"y":-283.75,"z":54.16},"bomb":{"rotation":{"x":-90.0,"y":-70.0,"z":0.0},"offset":{"x":0.2775,"y":-0.04525,"z":0.15}},"heading":250.8},"coords":{"x":312.35800170898,"y":-282.73013305664,"z":54.303646087646}, "hash":2121050683, "oh": 160.0, "ch":249.86596679688}, "coords":{"y":-284.47,"z":54.16,"h":238.11,"x":311.25}}', '{"door":{"coords":{"x":314.62387084961,"y":-285.99447631836,"z":54.463008880615}, "hash":-1591004109, "oh": 90.0, "ch":159.86486816406}, "coords":{"y":-284.65,"z":54.14,"h":156.52,"x":312.85}}', NULL, '[{"y":-282.92,"z":54.14,"h":332.43,"x":313.28},{"y":-283.55,"z":54.14,"h":342.97,"x":314.91},{"y":-285.06,"z":54.14,"h":269.63,"x":315.49}]', '[{"y":-286.9,"z":54.14,"h":65.4,"x":311.13},{"y":-288.78,"z":54.14,"h":161.69,"x":311.49},{"y":-289.41,"z":54.14,"h":161.05,"x":313.18},{"y":-288.29,"z":54.14,"h":250.12,"x":314.91}]', 1, 0, 'Small', NULL),
	(4, 'Fleeca 4', '{"y":-330.26,"z":37.79,"h":202.22,"x":-1212.98}', '{"door":{"outside":{"y":-334.43,"z":37.78,"h":297.06,"x":-1215.42},"coords":{"x":-1214.9053955078,"y":-334.72808837891,"z":38.055507659912}, "hash":-131754413, "oh":206.0 , "ch":296.86373901367}, "counters":[{"y":-333.21,"z":37.78,"h":20.72,"x":-1214.47},{"y":-332.53,"z":37.78,"h":27.31,"x":-1213.13},{"y":-331.85,"z":37.78,"h":23.82,"x":-1211.79},{"y":-331.23,"z":37.78,"h":29.4,"x":-1210.52}]}', NULL, '{"door":{"thermite":{"spark":{"x":-1210.84,"y":-334.672,"z":37.88},"drip":{"y":-335.82,"z":37.78,"h":292.56,"x":-1211.04},"bomb":{"rotation":{"x":-90.0,"y":-117.0,"z":0.0},"offset":{"x":0.2275,"y":0.18525,"z":0.15}},"heading":300.0},"coords":{"x":-1211.2609863281,"y":-334.55960083008,"z":37.919891357422}, "hash":2121050683, "oh": 206.0, "ch":296.86373901367}, "coords":{"y":-336.54,"z":37.78,"h":300.07,"x":-1210.74}}', '{"door":{"coords":{"x":-1207.3282470703,"y":-335.12893676758,"z":38.079254150391}, "hash":-1591004109, "oh": 116.0, "ch":206.86373901367}, "coords":{"y":-335.44,"z":37.76,"h":208.27,"x":-1209.54}}', NULL, '[{"y":-333.94,"z":37.76,"h":18.13,"x":-1210.35},{"y":-333.27,"z":37.76,"h":17.2,"x":-1208.9},{"y":-333.75,"z":37.76,"h":297.68,"x":-1207.46}]', '[{"y":-338.26,"z":37.76,"h":116.27,"x":-1209.09},{"y":-339.5,"z":37.76,"h":209.88,"x":-1207.77},{"y":-338.33,"z":37.76,"h":206.97,"x":-1205.55},{"y":-336.61,"z":37.76,"h":293.18,"x":-1205.48}]', 1, 0, 'Small', NULL),
	(5, 'Fleeca 5', '{"y":482.81,"z":15.7,"h":263.13,"x":-2963.45}', '{"door":{"outside":{"y":478.74,"z":15.7,"h":2.36,"x":-2960.71},"coords":{"x":-2960.1762695313,"y":479.0104675293,"z":15.971563339233}, "hash":-131754413, "oh":267.0 , "ch":357.54205322266}, "counters":[{"y":480.22,"z":15.7,"h":102.5,"x":-2961.21},{"y":481.59,"z":15.7,"h":80.38,"x":-2961.19},{"y":483.14,"z":15.7,"h":89.06,"x":-2961.07},{"y":484.51,"z":15.7,"h":89.16,"x":-2961.09}]}', NULL, '{"door":{"thermite":{"spark":{"x":-2957.353,"y":483.2,"z":15.75},"drip":{"y":481.9,"z":15.7,"h":292.56,"x":-2957.33},"bomb":{"rotation":{"x":-90.0,"y":-180.0,"z":0.0},"offset":{"x":-0.0495,"y":0.22525,"z":0.15}},"heading":355.0},"coords":{"x":-2958.5385742188,"y":482.27056884766,"z":15.83594417572}, "hash":-63539571, "oh": 267.0, "ch":357.54205322266}, "coords":{"y":481.7,"z":15.7,"h":4.28,"x":-2956.5}}', '{"door":{"coords":{"x":-2956.1162109375,"y":485.42059326172,"z":15.995308876038}, "hash":-1591004109, "oh": 197.0, "ch":267.54205322266}, "coords":{"y":483.33,"z":15.68,"h":273.76,"x":-2956.87}}', NULL, '[{"y":483.36,"z":15.68,"h":88.47,"x":-2958.6},{"y":485.0,"z":15.68,"h":84.28,"x":-2958.44},{"y":485.96,"z":15.68,"h":359.14,"x":-2957.34}]', '[{"y":482.38,"z":15.68,"h":177.51,"x":-2954.18},{"y":483.4,"z":15.68,"h":269.76,"x":-2952.52},{"y":485.46,"z":15.68,"h":265.06,"x":-2952.43},{"y":486.28,"z":15.68,"h":350.95,"x":-2954.08}]', 1, 0, 'Small', NULL),
	(6, 'Fleeca 6', '{"y":2706.07,"z":38.09,"h":3.7,"x":1175.15}', '{"door":{"outside":{"y":2708.92,"z":38.09,"h":93.29,"x":1179.26},"coords":{"x":1178.8695068359,"y":2709.3647460938,"z":38.362506866455}, "hash":-131754413, "oh":0.1 , "ch":90.0}, "counters":[{"y":2708.25,"z":38.09,"h":173.3,"x":1177.77},{"y":2708.23,"z":38.09,"h":181.91,"x":1176.23},{"y":2708.24,"z":38.09,"h":187.4,"x":1174.81},{"y":2708.21,"z":38.09,"h":183.0,"x":1173.38}]}', NULL, '{"door":{"thermite":{"spark":{"x":1175.66,"y":2713.025,"z":38.19},"drip":{"y":2712.09,"z":38.09,"h":92.71,"x":1175.86},"bomb":{"rotation":{"x":-90.0,"y":-270.0,"z":0.0},"offset":{"x":-0.2195,"y":-0.05925,"z":0.13}},"heading":90.0},"coords":{"x":1175.5421142578,"y":2710.861328125,"z":38.226890563965}, "hash":2121050683, "oh": 0.1, "ch":90.0}, "coords":{"y":2712.88,"z":38.09,"h":97.27,"x":1175.97}}', '{"door":{"coords":{"x":1172.2911376953,"y":2713.1462402344,"z":38.386253356934}, "hash":-1591004109, "oh": 289.0, "ch":359.0}, "coords":{"y":2712.49,"z":38.07,"h":2.81,"x":1174.41}}', NULL, '[{"y":2710.82,"z":38.07,"h":183.46,"x":1174.3},{"y":2710.73,"z":38.07,"h":186.75,"x":1172.99},{"y":2711.95,"z":38.07,"h":90.38,"x":1171.78}]', '[{"y":2715.16,"z":38.07,"h":271.11,"x":1175.2},{"y":2716.82,"z":38.07,"h":356.82,"x":1174.22}{"y":2716.82,"z":38.07,"h":356.82,"x":1174.22},{"y":2716.79,"z":38.07,"h":1.54,"x":1172.25},{"y":2715.23,"z":38.07,"h":99.02,"x":1171.22}]', 1, 0, 'Small', NULL),
	(9, 'Paleto', '{"x":-112.22,"h":314.95,"z":31.63,"y":6468.92}', '{"door":{"outside":{"y":6468.29,"z":31.63,"h":41.06,"x":-108.89},"reverse":1,"coords":{"x":-108.91468811035,"y":6469.1049804688,"z":31.910284042358}, "hash":-1184592117, "oh":325.0 , "ch":44.863204956055}, "counters":[{"y":6468.99,"z":31.63,"h":136.44,"x":-110.22},{"y":6470.04,"z":31.63,"h":134.15,"x":-111.27},{"y":6471.14,"z":31.63,"h":134.03,"x":-112.28},{"y":6472.25,"z":31.63,"h":132.97,"x":-113.35}]}', '{"door":{"coords":{"x":-104.60489654541,"y":6473.4438476563,"z":31.795324325562,"h":150.00003051758},"hash":-1185205679,"ch":45.0,"oh":150.00003051758},"coords":{"y":6471.9,"z":31.63,"h":40.24,"x":-105.54}}', '{"door":{"thermite":{"spark":{"x":-105.8085,"y":6473.49509,"z":31.80},"drip":{"y":6472.29,"z":31.63,"h":184.07,"x":-105.49},"bomb":{"rotation":{"x":-90.0,"y":-225.0,"z":0.0},"offset":{"x":-0.32795,"y":0.220195,"z": 0.175}},"heading":45.0},"reverse":1,"coords":{"x":-104.81363677979,"y":6473.646484375,"z":31.9547996521}, "hash":1622278560, "oh": 325.0, "ch":45.013021469116}, "coords":{"y":6472.36,"z":31.63,"h":37.87,"x":-105.43}}', '{"door":{"thermite":{"spark":{"x":-105.552,"y":6476.13,"z":31.95},"drip":{"y":6474.6,"z":31.63,"h":314.79,"x":-105.82},"bomb":{"rotation":{"x":-90.0,"y":-135.0,"z":0.0},"offset":{"x":0.26795,"y":0.5495,"z":0.36}},"heading":320.0},"coords":{"x":-106.47130584717,"y":6476.1577148438,"z":31.9547996521}, "hash":1309269072, "oh": 244.0, "ch":314.96466064453}, "coords":{"y":6474.72,"z":31.63,"h":316.34,"x":-105.76}}', NULL, '[{"y":6472.92,"z":31.63,"h":141.47,"x":-106.56},{"y":6474.14,"z":31.63,"h":133.41,"x":-107.76},{"y":6475.82,"z":31.63,"h":55.73,"x":-107.53}]', '[{"y":6475.52,"z":31.63,"h":225.83,"x":-102.89},{"y":6477.48,"z":31.68,"h":320.61,"x":-102.47},{"y":6478.97,"z":31.63,"h":316.32,"x":-103.95},{"y":6478.68,"z":31.63,"h":39.94,"x":-105.89}]', 1, 0, 'Paleto', '{"x":-113.32,"h":316.07,"z":31.63,"y":6469.96}'),
	(10, 'Pacific', '{"x":242.1,"y":224.44,"z":106.29,"h":336.9}', '{"door":{"thermite":{"spark":{"x":257.457,"y":221.105,"z":106.39},"drip":{"x":257.27,"y":219.8,"z":106.29},"bomb":{"rotation":{"x":90.0,"y":-20.0,"z":0.0},"offset":{"x":0.135,"y":0.385,"z":0.15}},"heading":339.0},"outside":{"x":256.79,"y":220.03,"z":106.29,"h":355.46},"coords":{"x":256.31155395508,"y":220.65785217285,"z":106.42955780029,"h":340.00003051758},"hash":-222270721,"ch":-19.999971389771,"oh":70.0},"coords":{"x":256.79,"y":220.03,"z":106.29,"h":355.46}}', '{"door":{"coords":{"x":262.19808959961,"y":222.51881408691,"z":106.42955780029,"h":256.77621459961},"hash":746855201,"ch":-110.22378540039,"oh":-20.0},"coords":{"x":261.95,"y":223.1,"z":106.28,"h":241.67}}', '{"door":{"coords":{"x":255.22825622559,"y":223.97601318359,"z":102.39321899414,"h":160.17094421387},"hash":961976194,"ch":160.17094421387,"oh":70.0},"coords":{"x":253.29,"y":228.46,"z":101.68,"h":65.44}}', '{"door":{"thermite":{"spark":{"x":252.99,"y":221.75,"z":101.78},"drip":{"x":253.0,"y":220.97,"z":101.68},"bomb":{"rotation":{"x":-90.0,"y":20.0,"z":0.0},"offset":{"x":-0.005,"y":-0.255,"z":0.15}},"heading":161.0},"coords":{"x":251.85757446289,"y":221.06549072266,"z":101.83240509033,"h":160.00001525879},"hash":-1508355822,"ch":160.00001525879,"oh":70.0},"coords":{"x":252.63,"y":221.29,"z":101.68,"h":156.96}}', '{"door":{"thermite":{"spark":{"x":261.65,"y":216.62,"z":101.78},"drip":{"x":261.4,"y":215.67,"z":101.68},"bomb":{"rotation":{"x":-90.0,"y":-70.0,"z": 0.0},"offset":{"x":0.25,"y":-0.0325,"z":0.15}},"heading":250.0},"reverse":-1,"coords":{"x":261.30041503906,"y":214.50514221191,"z":101.83240509033,"h":250.17224121094},"hash":-1508355822,"ch":-109.82776641846,"oh":170.0},"coords":{"x":261.12,"y":215.24,"z":101.68,"h":252.85},"coords":{"x":261.06,"y":215.22,"z":101.68,"h":247.37}}', '[{"x":258.16,"y":218.56,"z":101.68,"h":341.82},{"x":259.71,"y":218.03,"z":101.68,"h":359.39},{"x":261.44,"y":217.41,"z":101.68,"h":0.29},{"x":259.99,"y":213.48,"z":101.68,"h":159.81},{"x":258.27,"y":214.1,"z":101.68,"h":167.51},{"x":256.48,"y":214.76,"z":101.68,"h":169.49}]', '[{"x":263.19,"y":212.32,"z":101.68,"h":164.78},{"x":266.09,"y":213.42,"z":101.68,"h":275.82},{"x":264.66,"y":216.23,"z":101.68,"h":357.47}]', 1, 0, 'Big', NULL);
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;

-- Dumping data for table catenas3.bank_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `bank_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_accounts` ENABLE KEYS */;

-- Dumping data for table catenas3.bank_statements: ~0 rows (approximately)
/*!40000 ALTER TABLE `bank_statements` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_statements` ENABLE KEYS */;

-- Dumping data for table catenas3.bans: ~0 rows (approximately)
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;

-- Dumping data for table catenas3.bills: ~0 rows (approximately)
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;

-- Dumping data for table catenas3.crypto: ~0 rows (approximately)
/*!40000 ALTER TABLE `crypto` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto` ENABLE KEYS */;

-- Dumping data for table catenas3.crypto_transactions: ~0 rows (approximately)
/*!40000 ALTER TABLE `crypto_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto_transactions` ENABLE KEYS */;

-- Dumping data for table catenas3.ctnvehicles: ~1 rows (approximately)
/*!40000 ALTER TABLE `ctnvehicles` DISABLE KEYS */;
REPLACE INTO `ctnvehicles` (`id`, `citizenid`, `plate`, `fakeplate`, `model`, `props`, `stats`, `state`, `parking`, `depotprice`) VALUES
	(2, 'AFV00955', '08RLO573', NULL, 'sultan', '{"modCustomTyres":false,"modHood":-1,"wheels":0,"modExhaust":-1,"windowTint":-1,"modSteeringWheel":-1,"modEngineBlock":-1,"modArchCover":-1,"wheelColor":156,"modAPlate":-1,"modSideSkirt":-1,"modPlateHolder":-1,"color2":1,"pearlescentColor":5,"modTank":-1,"modVanityPlate":-1,"modLivery":-1,"modArmor":-1,"extras":[],"modTrunk":-1,"modShifterLeavers":-1,"modGrille":-1,"modWindows":-1,"color1":1,"modBackWheels":-1,"modRightFender":-1,"modFrontBumper":-1,"modSmokeEnabled":1,"model":970598228,"modXenon":false,"modSpoilers":-1,"modFrontWheels":-1,"modStruts":-1,"modEngine":-1,"modRoof":-1,"plate":"08RLO573","modSpeakers":-1,"modTrimA":-1,"modFender":-1,"modOrnaments":-1,"modSeats":-1,"tyreSmokeColor":[255,255,255],"modDial":-1,"modDoorSpeaker":-1,"modSuspension":-1,"modTurbo":false,"modTransmission":-1,"modHydrolic":-1,"modFrame":-1,"modHorns":-1,"modDashboard":-1,"neonColor":[255,0,255],"modTrimB":-1,"plateIndex":0,"modRearBumper":-1,"modAerials":-1,"modAirFilter":-1,"modBrakes":-1,"neonEnabled":[false,false,false,false],"health":1000,"dirtLevel":5.00238990783691}', '{"damage":10,"fuel":98}', 'impound', '', NULL);
/*!40000 ALTER TABLE `ctnvehicles` ENABLE KEYS */;

-- Dumping data for table catenas3.dealers: ~0 rows (approximately)
/*!40000 ALTER TABLE `dealers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dealers` ENABLE KEYS */;

-- Dumping data for table catenas3.fine_types: ~89 rows (approximately)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
REPLACE INTO `fine_types` (`id`, `label`, `amount`, `category`, `jailtime`) VALUES
	(1, 'Murder', 25000, 0, 0),
	(2, 'Involuntary Manslaughter', 10000, 0, 120),
	(3, 'Vehicular Manslaughter', 7500, 0, 100),
	(4, 'Attempted Murder on LEO', 1500, 0, 60),
	(5, 'Attempted Murder', 1000, 0, 50),
	(6, 'Assault w/ Deadly Weapon on LEO', 700, 0, 45),
	(7, 'Assault w/ Deadly Weapon', 350, 0, 30),
	(8, 'Assault on LEO', 150, 0, 15),
	(9, 'Assault', 100, 0, 10),
	(10, 'Kidnapping of an LEO', 400, 0, 40),
	(11, 'Kidnapping / Hostage Taking', 200, 0, 20),
	(12, 'Bank Robbery', 800, 0, 50),
	(13, 'Armored Truck Robbery', 650, 0, 40),
	(14, 'Jewelery Store Robbery ', 500, 0, 30),
	(15, 'Store Robbery', 150, 0, 15),
	(16, 'House Robbery', 100, 0, 10),
	(17, 'Corruption', 10000, 0, 650),
	(18, 'Felony Driving Under the Influence', 300, 0, 30),
	(19, 'Grand Theft Auto', 300, 0, 20),
	(20, 'Evading Arrest', 200, 0, 20),
	(21, 'Driving Under the Influence', 150, 0, 15),
	(22, 'Hit and Run', 150, 0, 15),
	(23, 'Operating a Motor Vehicle without a License', 100, 0, 10),
	(24, 'Criminal Speeding', 300, 0, 10),
	(25, 'Excessive Speeding 4', 250, 0, 0),
	(26, 'Excessive Speeding 3', 200, 0, 0),
	(27, 'Excessive Speeding 2', 150, 0, 0),
	(28, 'Excessive Speeding', 100, 0, 0),
	(29, 'Operating an Unregisted Motor Vehicle', 100, 0, 5),
	(30, 'Reckless Endangerment', 150, 0, 5),
	(31, 'Careless Driving', 100, 0, 0),
	(32, 'Operating a Non-Street Legal Vehicle', 200, 0, 5),
	(33, 'Failure to Stop', 100, 0, 0),
	(34, 'Obstructing Traffic', 150, 0, 0),
	(35, 'Illegal Lane Change', 100, 0, 0),
	(36, 'Failure to Yield to an Emergency Vehicle', 150, 0, 0),
	(37, 'Illegal Parking', 100, 0, 0),
	(38, 'Excessive Vehicle Noise', 100, 0, 0),
	(39, 'Driving without Proper Use of Headlights', 100, 0, 0),
	(40, 'Illegal U-Turn', 100, 0, 0),
	(41, 'Drug Manufacturing/Cultivation', 550, 0, 40),
	(42, 'Possession of Schedule 1 Drug', 150, 0, 15),
	(43, 'Possession of Schedule 2 Drug', 250, 0, 20),
	(44, 'Sale/Distribution of Schedule 1 Drug', 250, 0, 20),
	(45, 'Sale/Distribution of Schedule 2 Drug', 400, 0, 30),
	(46, 'Drug Trafficking', 500, 0, 40),
	(47, 'Weapons Caching of Class 2s', 2500, 0, 120),
	(48, 'Weapons Caching of Class 1s', 1250, 0, 60),
	(49, 'Weapons Trafficking of Class 2s', 1700, 0, 80),
	(50, 'Weapons Trafficking of Class 1s', 800, 0, 45),
	(51, 'Possession of a Class 2 Firearm', 800, 0, 40),
	(52, 'Possession of a Class 1 Firearm', 150, 0, 15),
	(53, 'Brandishing a Firearm', 100, 0, 5),
	(54, 'Unlawful discharge of a firearm', 150, 0, 10),
	(55, 'Perjury', 1000, 0, 60),
	(56, 'Arson', 500, 0, 30),
	(57, 'False Impersonation of a Government Official', 200, 0, 25),
	(58, 'Possession of Dirty Money', 200, 0, 25),
	(59, 'Possession of Stolen Goods', 100, 0, 15),
	(60, 'Unlawful Solicitation', 150, 0, 20),
	(61, 'Larceny', 150, 0, 20),
	(62, 'Felony Attempted Commision of an Offence/Crime', 350, 0, 20),
	(63, 'Tampering With Evidence', 200, 0, 20),
	(64, 'Illegal Gambling', 200, 0, 20),
	(65, 'Bribery', 200, 0, 20),
	(66, 'Stalking', 350, 0, 20),
	(67, 'Organizing an illegal event', 150, 0, 15),
	(68, 'Participating in an illegal event', 50, 0, 5),
	(69, 'Criminal Mischief', 100, 0, 15),
	(70, 'Prostitution', 250, 0, 15),
	(71, 'Failure to Identify', 150, 0, 15),
	(72, 'Obstruction of Justice', 150, 0, 15),
	(73, 'Resisting Arrest', 100, 0, 10),
	(74, 'Disturbing the Peace', 100, 0, 10),
	(75, 'Threat to do Bodily Harm', 100, 0, 10),
	(76, 'Terroristic Threat', 150, 0, 10),
	(77, 'Damage to Government Property', 150, 0, 10),
	(78, 'Contempt of Court', 250, 0, 10),
	(79, 'Failure to Obey a Lawful Order', 150, 0, 10),
	(80, 'False Report', 100, 0, 10),
	(81, 'Trespassing', 100, 0, 10),
	(82, 'Loitering', 100, 0, 0),
	(83, 'Public Intoxication', 100, 0, 0),
	(84, 'Indecent Exposure', 100, 0, 0),
	(85, 'Verbal Harassment ', 100, 0, 0),
	(86, 'Aiding and Abetting', 100, 0, 0),
	(87, 'Incident Report', 0, 0, 0),
	(88, 'Written Citation', 0, 0, 0),
	(89, 'Verbal Warning', 0, 0, 0);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dumping data for table catenas3.gangs: ~0 rows (approximately)
/*!40000 ALTER TABLE `gangs` DISABLE KEYS */;
/*!40000 ALTER TABLE `gangs` ENABLE KEYS */;

-- Dumping data for table catenas3.gang_territoriums: ~0 rows (approximately)
/*!40000 ALTER TABLE `gang_territoriums` DISABLE KEYS */;
/*!40000 ALTER TABLE `gang_territoriums` ENABLE KEYS */;

-- Dumping data for table catenas3.gloveboxitems: ~0 rows (approximately)
/*!40000 ALTER TABLE `gloveboxitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `gloveboxitems` ENABLE KEYS */;

-- Dumping data for table catenas3.gloveboxitemsnew: ~0 rows (approximately)
/*!40000 ALTER TABLE `gloveboxitemsnew` DISABLE KEYS */;
/*!40000 ALTER TABLE `gloveboxitemsnew` ENABLE KEYS */;

-- Dumping data for table catenas3.houselocations: ~0 rows (approximately)
/*!40000 ALTER TABLE `houselocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `houselocations` ENABLE KEYS */;

-- Dumping data for table catenas3.house_plants: ~0 rows (approximately)
/*!40000 ALTER TABLE `house_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_plants` ENABLE KEYS */;

-- Dumping data for table catenas3.jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping data for table catenas3.lapraces: ~0 rows (approximately)
/*!40000 ALTER TABLE `lapraces` DISABLE KEYS */;
/*!40000 ALTER TABLE `lapraces` ENABLE KEYS */;

-- Dumping data for table catenas3.laws: ~0 rows (approximately)
/*!40000 ALTER TABLE `laws` DISABLE KEYS */;
/*!40000 ALTER TABLE `laws` ENABLE KEYS */;

-- Dumping data for table catenas3.mdt_reports: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_reports` ENABLE KEYS */;

-- Dumping data for table catenas3.mdt_warrants: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_warrants` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_warrants` ENABLE KEYS */;

-- Dumping data for table catenas3.moneysafes: ~0 rows (approximately)
/*!40000 ALTER TABLE `moneysafes` DISABLE KEYS */;
/*!40000 ALTER TABLE `moneysafes` ENABLE KEYS */;

-- Dumping data for table catenas3.occasion_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `occasion_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `occasion_vehicles` ENABLE KEYS */;

-- Dumping data for table catenas3.permissions: ~19 rows (approximately)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
REPLACE INTO `permissions` (`id`, `name`, `steam`, `license`, `permission`) VALUES
	(1, 'Suspect', 'steam:110000119da0deb', 'license:9ed5c432ee56e2dab7d8383c202eb5b4b38c1678', 'vip'),
	(3, 'leghosty', 'steam:110000141979fb1', 'license:fd8dbd67bfd04b254c19f4b06ca2347eeb3d9d5d', 'vip'),
	(4, 'MSspoppy', 'steam:1100001071dbfd2', 'license:c03348a6a4fe13bce38176c0ea123a76293d9ee4', 'vip'),
	(5567, 'Wampire', 'steam:11000013a7e6e2d', 'license:dc05a72c30864051a2089766fd18c02f8d0411e8', 'admin'),
	(5574, 'Dtr0v', 'steam:11000010e648bf9', 'license:a94667d052573b656e7bdc0dd1f98c7b8bfd2d39', 'admin'),
	(5576, 'P ? T I X', 'steam:11000013c378e34', 'license:d2406f3bd97aa524dbcb9a767fda21e4109e5385', 'admin'),
	(5578, 'Mohsine Salhi', 'steam:11000011d267484', 'license:313fe6359038cb3ba85a8b0d3b105730afa3047b', 'god'),
	(5582, 'MABENZI', 'steam:11000011365293d', 'license:f58f59f294ca72aa71248c575e88a3158f638956', 'admin'),
	(5587, 'LmAcHaKiL', 'steam:110000113f26780', 'license:cdc8ae7d4dc97c89a49103ccf2a620632b74ce0c', 'admin'),
	(5591, 'NACER', 'steam:110000112cd59ca', 'license:c0ffc3b0ad297ce77cb45116d1a271838d82c214', 'admin'),
	(5596, 'Kura', 'steam:110000115b35d22', 'license:9ed5c432ee56e2dab7d8383c202eb5b4b38c1678', 'god'),
	(5602, 'Blake', 'steam:11000013b6878eb', 'license:2288dc2a93d711ac5aab449ac48f057f2a165b73', 'admin'),
	(5605, 'the only one', 'steam:11000011d412175', 'license:9ed5c432ee56e2dab7d8383c202eb5b4b38c1678', 'god'),
	(5607, 'eslayer', 'steam:110000115b6668d', 'license:756f9053cb833362860db4c4bcef3741f069c06a', 'god'),
	(5608, 't4ken', 'steam:11000013a93c531', 'license:e8b64b38b6aff803ae58581796fe37ba3b3c20eb', 'vip'),
	(5609, 'Frowmza', 'steam:11000013278fa3e', 'license:801b80054f9c4983433beac722a5a852c74d9284', 'god'),
	(5610, 'Lbhjawi', 'steam:11000013a8a5e16', 'license:4feea6073aaab723f75898f7a6bdfcbbddde57c4', 'admin'),
	(5611, 'QMasterMekkiQ', 'steam:11000010087ff15', 'license:61257e3ff51cc750cf2e6d7194dd8daae00e2372', 'god'),
	(5612, 'ixdragon', 'steam:110000108fa4e5d', 'license:82e34dd95f5660d7f30ce7f2504f1ef16939971b', 'god');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping data for table catenas3.phone_invoices: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_invoices` ENABLE KEYS */;

-- Dumping data for table catenas3.phone_messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping data for table catenas3.phone_tweets: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_tweets` ENABLE KEYS */;

-- Dumping data for table catenas3.playerammo: ~0 rows (approximately)
/*!40000 ALTER TABLE `playerammo` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerammo` ENABLE KEYS */;

-- Dumping data for table catenas3.playeritems: ~0 rows (approximately)
/*!40000 ALTER TABLE `playeritems` DISABLE KEYS */;
/*!40000 ALTER TABLE `playeritems` ENABLE KEYS */;

-- Dumping data for table catenas3.players: ~2 rows (approximately)
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
REPLACE INTO `players` (`#`, `citizenid`, `cid`, `steam`, `discord`, `license`, `name`, `money`, `charinfo`, `cards`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`, `tattoos`) VALUES
	(1, 'AFV00955', 1, 'steam:11000013278fa3e', '392415302014468097', 'license:801b80054f9c4983433beac722a5a852c74d9284', 'Frowmza', '{"bank":16160,"cash":7490,"crypto":0}', '{"card":0,"account":"RL02CTN153","nationality":"","phone":"0513341851","gender":0,"cid":"1","birthdate":"","firstname":"vvb","backstory":"placeholder backstory","lastname":"vb"}', NULL, '{"grade":{"level":7,"name":"Commissaire"},"onduty":true,"isboss":true,"name":"gendarme","payment":650,"label":"Gendarme"}', '{"label":"Geen Gang","name":"geen"}', '{"z":30.68954467773437,"a":304.6677551269531,"x":456.36029052734377,"y":-990.7581787109375}', '{"armor":0,"criminalrecord":{"hasRecord":false},"walletid":"ctn-93652343","status":[],"phone":[],"attachmentcraftingrep":0,"fingerprint":"VA521mhOp059009","currentapartment":"apartment37988","incarry":false,"ishandcuffed":false,"jobrep":{"taxi":0,"tow":0,"hotdog":0,"trucker":0},"craftingrep":0,"inlaststand":false,"walk":"reset","callsign":"NO CALLSIGN","tracker":false,"injail":0,"isdead":false,"inside":{"apartment":[]},"jailitems":[],"stress":0,"hunger":74.79999999999999,"commandbinds":[],"thirst":77.20000000000002,"licences":{"business":false,"driver":true},"bloodtype":"O+","fitbit":[],"dealerrep":0}', '[{"info":{"birthdate":"","firstname":"vvb","lastname":"vb","type":"A1-A2-A | AM-B | C1-C-CE"},"type":"item","amount":1,"name":"driver_license","slot":1},{"info":[],"type":"item","amount":1,"name":"phone","slot":2},{"info":{"citizenid":"AFV00955","gender":0,"birthdate":"","firstname":"vvb","nationality":"","lastname":"vb"},"type":"item","amount":1,"name":"id_card","slot":3},{"info":[],"type":"item","amount":14,"name":"orangeslushy","slot":4},{"info":[],"type":"item","amount":9,"name":"blueslushy","slot":8}]', '2021-03-18 10:14:38', '[{"Count":1,"collection":"mpairraces_overlays","nameHash":"MP_Airraces_Tattoo_003_F"},{"Count":1,"collection":"mpbiker_overlays","nameHash":"MP_MP_Biker_Tat_051_F"},{"Count":2,"collection":"mpbiker_overlays","nameHash":"MP_MP_Biker_Tat_047_F"}]'),
	(3, 'VAD21762', 1, 'steam:110000119da0deb', NULL, 'license:9ed5c432ee56e2dab7d8383c202eb5b4b38c1678', 'Suspect', '{"crypto":0,"cash":2500,"bank":10000}', '{"account":"RL09CTN156","cid":"1","phone":"0581146368","gender":0,"card":0,"firstname":"Xxx","nationality":"Catena","backstory":"placeholder backstory","lastname":"Xxx","birthdate":"1111-11-11"}', NULL, '{"payment":35,"label":"Unemployed","isboss":false,"grade":{"level":0},"onduty":true,"name":"unemployed"}', '{"label":"Geen Gang","name":"geen"}', '{"x":297.68603515625,"a":57.24235916137695,"z":29.35598754882812,"y":-1068.3736572265626}', '{"stress":0,"armor":0,"ishandcuffed":false,"criminalrecord":{"hasRecord":false},"walletid":"ctn-73885091","status":[],"walk":"reset","isdead":false,"tracker":false,"callsign":"NO CALLSIGN","currentapartment":"apartment55639","hunger":95.8,"jailitems":[],"inside":{"apartment":[]},"jobrep":{"taxi":0,"tow":0,"hotdog":0,"trucker":0},"phone":[],"inlaststand":false,"incarry":false,"licences":{"business":false,"driver":true},"fingerprint":"uc502EJDn913005","fitbit":[],"craftingrep":0,"dealerrep":0,"attachmentcraftingrep":0,"bloodtype":"A+","commandbinds":[],"thirst":96.2,"injail":0}', '[{"amount":1,"type":"item","slot":1,"info":[],"name":"phone"},{"amount":1,"type":"item","slot":2,"info":{"birthdate":"1111-11-11","firstname":"Xxx","lastname":"Xxx","type":"A1-A2-A | AM-B | C1-C-CE"},"name":"driver_license"},{"amount":1,"type":"item","slot":3,"info":{"nationality":"Catena","birthdate":"1111-11-11","firstname":"Xxx","gender":0,"lastname":"Xxx","citizenid":"VAD21762"},"name":"id_card"}]', '2021-03-17 18:06:53', NULL);
/*!40000 ALTER TABLE `players` ENABLE KEYS */;

-- Dumping data for table catenas3.playerskins: ~3 rows (approximately)
/*!40000 ALTER TABLE `playerskins` DISABLE KEYS */;
REPLACE INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
	(2, 'RDP46372', '1885233650', '{"face":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"arms":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"pants":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"decals":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"hair":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"t-shirt":{"texture":0,"defaultTexture":0,"defaultItem":1,"item":1},"eyebrows":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"mask":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"lipstick":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"bag":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"beard":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"watch":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"hat":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"glass":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"ageing":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"shoes":{"texture":0,"defaultTexture":0,"defaultItem":1,"item":1},"blush":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"makeup":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"torso2":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"bracelet":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"vest":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"accessory":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"ear":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1}}', 1),
	(4, 'AFV00955', '1885233650', '{"bag":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"vest":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"face":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"mask":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"beard":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"decals":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"ear":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"blush":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"pants":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"makeup":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"accessory":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"hair":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"watch":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"glass":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"hat":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"bracelet":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"lipstick":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"eyebrows":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"t-shirt":{"texture":0,"defaultTexture":0,"defaultItem":1,"item":15},"torso2":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":15},"arms":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":15},"shoes":{"texture":0,"defaultTexture":0,"defaultItem":1,"item":1},"ageing":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1}}', 1),
	(5, 'VAD21762', '1885233650', '{"t-shirt":{"defaultTexture":0,"texture":0,"item":15,"defaultItem":1},"blush":{"defaultTexture":1,"texture":1,"item":-1,"defaultItem":-1},"ageing":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1},"bracelet":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1},"glass":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"hat":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1},"decals":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"accessory":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"bag":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"watch":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1},"face":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"lipstick":{"defaultTexture":1,"texture":1,"item":-1,"defaultItem":-1},"mask":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"vest":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"shoes":{"defaultTexture":0,"texture":0,"item":1,"defaultItem":1},"eyebrows":{"defaultTexture":1,"texture":1,"item":-1,"defaultItem":-1},"hair":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"torso2":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"beard":{"defaultTexture":1,"texture":1,"item":-1,"defaultItem":-1},"arms":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"pants":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"makeup":{"defaultTexture":1,"texture":1,"item":-1,"defaultItem":-1},"ear":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1}}', 1),
	(6, 'EQN28051', '1885233650', '{"beard":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"mask":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"torso2":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":14},"watch":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"shoes":{"defaultTexture":0,"defaultItem":1,"texture":0,"item":1},"decals":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"hair":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":5},"pants":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":4},"bracelet":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"ageing":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"arms":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":25},"face":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"t-shirt":{"defaultTexture":0,"defaultItem":1,"texture":0,"item":15},"eyebrows":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"blush":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"hat":{"defaultTexture":0,"defaultItem":-1,"texture":2,"item":7},"glass":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"lipstick":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"vest":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"ear":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"accessory":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"bag":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"makeup":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1}}', 1);
/*!40000 ALTER TABLE `playerskins` ENABLE KEYS */;

-- Dumping data for table catenas3.player_boats: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_boats` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_boats` ENABLE KEYS */;

-- Dumping data for table catenas3.player_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_contacts` DISABLE KEYS */;
REPLACE INTO `player_contacts` (`id`, `citizenid`, `name`, `number`, `iban`) VALUES
	(1, 'AFV00955', 'dfdfg', '0644724789', '');
/*!40000 ALTER TABLE `player_contacts` ENABLE KEYS */;

-- Dumping data for table catenas3.player_houses: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_houses` ENABLE KEYS */;

-- Dumping data for table catenas3.player_mails: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_mails` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_mails` ENABLE KEYS */;

-- Dumping data for table catenas3.player_outfits: ~1 rows (approximately)
/*!40000 ALTER TABLE `player_outfits` DISABLE KEYS */;
REPLACE INTO `player_outfits` (`id`, `citizenid`, `outfitname`, `model`, `skin`, `outfitId`) VALUES
	(1, 'AFV00955', 'dfdf', '1885233650', '{"hair":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"bag":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"bracelet":{"defaultItem":-1,"item":-1,"defaultTexture":0,"texture":0},"shoes":{"defaultItem":1,"item":1,"defaultTexture":0,"texture":0},"makeup":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"blush":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"lipstick":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"t-shirt":{"defaultItem":1,"item":15,"defaultTexture":0,"texture":0},"glass":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"mask":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"ageing":{"defaultItem":-1,"item":-1,"defaultTexture":0,"texture":0},"ear":{"defaultItem":-1,"item":-1,"defaultTexture":0,"texture":0},"arms":{"defaultItem":0,"item":15,"defaultTexture":0,"texture":0},"torso2":{"defaultItem":0,"item":15,"defaultTexture":0,"texture":0},"beard":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"eyebrows":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"face":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"pants":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"watch":{"defaultItem":-1,"item":-1,"defaultTexture":0,"texture":0},"hat":{"defaultItem":-1,"item":-1,"defaultTexture":0,"texture":0},"decals":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"vest":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"accessory":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0}}', 'outfit-4-2078');
/*!40000 ALTER TABLE `player_outfits` ENABLE KEYS */;

-- Dumping data for table catenas3.player_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_vehicles` ENABLE KEYS */;

-- Dumping data for table catenas3.player_warns: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_warns` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_warns` ENABLE KEYS */;

-- Dumping data for table catenas3.profiles: ~0 rows (approximately)
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;

-- Dumping data for table catenas3.queue: ~0 rows (approximately)
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;

-- Dumping data for table catenas3.radios: ~10 rows (approximately)
/*!40000 ALTER TABLE `radios` DISABLE KEYS */;
REPLACE INTO `radios` (`id`, `name`, `url`, `citizenid`) VALUES
	(1, 'Hit Radio', 'http://hitradio-maroc.ice.infomaniak.ch/hitradio-maroc-128.mp3', NULL),
	(2, 'Skyrock', 'http://icecast.skyrock.net/s/natio_mp3_128k?tvr_name=radiofr&tvr_section1=128mp3', NULL),
	(3, 'Intenseradio', 'https://intenseradio.live-streams.nl:18000/live', NULL),
	(4, 'HIT Radio Dancefloor', 'http://dancefloor.ice.infomaniak.ch/dancefloor-128.mp3', NULL),
	(5, 'Medi 1 DJ', 'http://live.medi1.com/Dj', NULL),
	(6, 'Medi 1 nayda', 'http://live.medi1.com/Nayda', NULL),
	(7, 'Media 1 Radio - Dance', 'http://live.medi1.com/Dj', NULL),
	(8, 'Media 1 Radio - Hits', 'http://live.medi1.com/Hits', NULL),
	(9, 'Aswat FM', 'http://broadcast.ice.infomaniak.ch/aswat-high.mp3', NULL),
	(21, 'Stop Airpods', NULL, NULL);
/*!40000 ALTER TABLE `radios` ENABLE KEYS */;

-- Dumping data for table catenas3.reports: ~0 rows (approximately)
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;

-- Dumping data for table catenas3.stashitems: ~0 rows (approximately)
/*!40000 ALTER TABLE `stashitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `stashitems` ENABLE KEYS */;

-- Dumping data for table catenas3.stashitemsnew: ~1 rows (approximately)
/*!40000 ALTER TABLE `stashitemsnew` DISABLE KEYS */;
REPLACE INTO `stashitemsnew` (`id`, `stash`, `items`) VALUES
	(1, 'apartment37988', '[]'),
	(2, 'policestash_AFV00955', '[]');
/*!40000 ALTER TABLE `stashitemsnew` ENABLE KEYS */;

-- Dumping data for table catenas3.trunkitems: ~0 rows (approximately)
/*!40000 ALTER TABLE `trunkitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunkitems` ENABLE KEYS */;

-- Dumping data for table catenas3.trunkitemsnew: ~0 rows (approximately)
/*!40000 ALTER TABLE `trunkitemsnew` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunkitemsnew` ENABLE KEYS */;

-- Dumping data for table catenas3.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` (`id`, `username`, `password`, `name`, `role`, `rank`, `last_login`) VALUES
	(4, 'admin', '$2y$10$BluOSjKhmlChghc2luupuOmpVYiaYOtqSbUHMZ0yWUIcxASCIvKre', 'admin', 'admin', 'Catena', '2020-09-29');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping data for table catenas3.user_convictions: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_convictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_convictions` ENABLE KEYS */;

-- Dumping data for table catenas3.user_mdt: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_mdt` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_mdt` ENABLE KEYS */;

-- Dumping data for table catenas3.warrants: ~0 rows (approximately)
/*!40000 ALTER TABLE `warrants` DISABLE KEYS */;
/*!40000 ALTER TABLE `warrants` ENABLE KEYS */;

-- Dumping data for table catenas3.whitelist: ~0 rows (approximately)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
