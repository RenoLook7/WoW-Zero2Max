local _, addonTable = ...

Zero2Max.ITEM_NAME =
{
	[5976]   = "Guild Tabard",
	[6948]   = "Hearthstone",
	[16060]  = "Common White Shirt",
	[27944]  = "Talisman of True Treasure Tracking",
	[69209]  = "Illustrious Guild Tabard",
	[69210]  = "Renowned Guild Tabard",
	[71634]  = "Darkmoon Adventurer's Guide",
	[109253] = "Ultimate Gnomish Army Knife",
	[110560] = "Garrison Hearthstone",
	[114943] = "Ultimate Gnomish Army Knife",
	[137642] = "Mark of Honor",
	[140192] = "Dalaran Hearthstone",
	[141605] = "Flight Master's Whistle",
	[163036] = "Polished Pet Charm",
	[210469] = "Personal Tabard",
}

Zero2Max.COLOR =
{
	white		= "|cffffffff",
	gold 		= "|cffffcc00",
	yellow 		= "|cffffff00",
	red 		= "|cffff0000",
	green 		= "|cff00ff00",
	blue 		= "|cff0000ff",
	springgreen = "|cff00ff98",
	purple 		= "|cff8788ee",
	pink 		= "|cfff48cba",
	lightblue 	= "|cff3fc7eb",
	lightgold 	= "|cffe6cc80",
	itemquality = {
					[0] = "|cff9d9d9d",
					[1] = "|cffffffff",
					[2] = "|cff1eff00",
					[3] = "|cff0070dd",
					[4] = "|cffa335ee",
					[5] = "|cffff8000",
					[6] = "|cffe6cc80",
					[7] = "|cff00ccff",
					[8] = "|cff00ccff",
					},
}

--<<Item Count
Zero2Max.ITEM_COUNT =
{
	-- Hearthstone, Garrison Hearthstone, Dalaran Hearthstone, Flight Master's Whistle
	[1] = { 6948, 110560, 140192, 141605 },
	-- Mark of Honor, Polished Pet Charm
	[2] = { 137642, 163036 },
	-- Guild Tabard, Illustrious Guild Tabard, Renowned Guild Tabard
	[3] = { 5976, 69209, 69210 },
	-- Common White Shirt, Darkmoon Adventurer's Guide, Ultimate Gnomish Army Knife, Ultimate Gnomish Army Knife (for Engineer), Personal Tabard, Talisman of True Treasure Tracking
	[4] = { 16060, 71634, 109253, 114943, 210469, 27944 },
	-- Stormwind Tabard, Ironforge Tabard, Gnomeregan Tabard, Darnassus Tabard, Exodar Tabard, Gilneas Tabard, Tushui Tabard
	[5] = { 45574, 45577, 45578, 45579, 45580, 64882, 83079 },
	-- Orgrimmar Tabard, Darkspear Tabard, Undercity Tabard, Thunder Bluff Tabard, Silvermoon City Tabard, Bilgewater Cartel Tabard, Huojin Tabard
	[6] = { 45581, 45582, 45583, 45584, 45585, 64884, 83080 },
}

--<<Profession Skill
Zero2Max.PROF_HERB = { 2912, 2877, 2832, 2760, 2549, 2550, 2551, 2552, 2553, 2554, 2555, 2556 } --182
Zero2Max.PROF_MINI = { 2916, 2881, 2833, 2761, 2565, 2566, 2567, 2568, 2569, 2570, 2571, 2572 } --186
Zero2Max.PROF_SKIN = { 2917, 2882, 2834, 2762, 2557, 2558, 2559, 2560, 2561, 2562, 2563, 2564 } --393
Zero2Max.PROF_BLAC = { 2907, 2872, 2822, 2751, 2437, 2454, 2472, 2473, 2474, 2475, 2476, 2477 } --164
Zero2Max.PROF_LEAT = { 2915, 2880, 2830, 2758, 2525, 2526, 2527, 2528, 2529, 2530, 2531, 2532 } --165
Zero2Max.PROF_ALCH = { 2906, 2871, 2823, 2750, 2478, 2479, 2480, 2481, 2482, 2483, 2484, 2485 } --171
Zero2Max.PROF_TAIL = { 2918, 2883, 2831, 2759, 2533, 2534, 2535, 2536, 2537, 2538, 2539, 2540 } --197
Zero2Max.PROF_ENGI = { 2910, 2875, 2827, 2755, 2499, 2500, 2501, 2502, 2503, 2504, 2505, 2506 } --202
Zero2Max.PROF_ENHA = { 2909, 2874, 2825, 2753, 2486, 2487, 2488, 2489, 2491, 2492, 2493, 2494 } --333
Zero2Max.PROF_JEWE = { 2914, 2879, 2829, 2757, 2517, 2518, 2519, 2520, 2521, 2522, 2523, 2524 } --755
Zero2Max.PROF_INSC = { 2913, 2878, 2828, 2756, 2507, 2508, 2509, 2510, 2511, 2512, 2513, 2514 } --773
Zero2Max.PROF_COOK = { 2908, 2873, 2824, 2752, 2541, 2542, 2543, 2544,
						975, 976, 977, 978, 979, 980,
						2545, 2546, 2547, 2548 } --185
Zero2Max.PROF_COOK_SUBGROUP = { false, false, false, false, false, false, false, false,
						true, true, true, true, true, true,
						false, false, false, false } --185
Zero2Max.PROF_FISH = { 2911, 2876, 2826, 2754, 2585, 2586, 2587, 2588, 2589, 2590, 2591, 2592 } --356
Zero2Max.PROF_ARCH = { 794 }

Zero2Max.PROF_TABLE = {}
Zero2Max.PROF_TABLE[182]  = Zero2Max.PROF_HERB
Zero2Max.PROF_TABLE[186]  = Zero2Max.PROF_MINI
Zero2Max.PROF_TABLE[393]  = Zero2Max.PROF_SKIN
Zero2Max.PROF_TABLE[164]  = Zero2Max.PROF_BLAC
Zero2Max.PROF_TABLE[165]  = Zero2Max.PROF_LEAT
Zero2Max.PROF_TABLE[171]  = Zero2Max.PROF_ALCH
Zero2Max.PROF_TABLE[197]  = Zero2Max.PROF_TAIL
Zero2Max.PROF_TABLE[202]  = Zero2Max.PROF_ENGI
Zero2Max.PROF_TABLE[333]  = Zero2Max.PROF_ENHA
Zero2Max.PROF_TABLE[755]  = Zero2Max.PROF_JEWE
Zero2Max.PROF_TABLE[773]  = Zero2Max.PROF_INSC
Zero2Max.PROF_TABLE[185]  = Zero2Max.PROF_COOK
Zero2Max.PROF_TABLE[356]  = Zero2Max.PROF_FISH
Zero2Max.PROF_TABLE[794]  = Zero2Max.PROF_ARCH

--<<Profession Knowledge
Zero2Max.PROF_KNOW =
{
	[182] = {3154, 2789, 2034},
	[186] = {3158, 2793, 2035},
	[393] = {3159, 2794, 2033},
	[164] = {3151, 2786, 2023},
	[165] = {3157, 2792, 2025},
	[171] = {3150, 2785, 2024},
	[197] = {3160, 2795, 2026},
	[202] = {3153, 2788, 2027},
	[333] = {3152, 2787, 2030},
	[755] = {3156, 2791, 2029},
	[773] = {3155, 2790, 2028},
}

--<<Main City Reputation
Zero2Max.REPU_MAIN_CITY =
{
	[1] = { 72, 47, 54, 69, 930, 1134, 1353 }, --Stormwind, Ironforge, Gnomeregan, Darnassus, Exodar, Gilneas, Tushui Pandaren
	[2] = { 76, 530, 68, 81, 911, 1133, 1352 }, --Orgrimmar, Darkspear Trolls, Undercity, Thunder Bluff, Silvermoon City, Bilgewater Cartel, Huojin Pandaren
}

Zero2Max.REPU_SPECIAL = { 1168, 909 } --guild, darkmoon

Zero2Max.EXPANSION_TITLE = {
	[1]  = "World of Warcraft",
	[2]  = "Burning Crusade",
	[3]  = "Wrath of the Lich King",
	[4]  = "Cataclysm Title",
	[5]  = "Mists of Pandaria",
	[6]  = "Warlords of Draenor",
	[7]  = "Legion",
	[8]  = "Battle for Azeroth",
	[9]  = "Shadowlands",
	[10] = "Dragonflight",
	[11] = "The War Within",
	[12] = "Midnight",
}

Zero2Max.EXPANSION = {
	[1]  = "Vanilla",
	[2]  = "Outland",
	[3]  = "Northrend",
	[4]  = "Cataclysm",
	[5]  = "Pandaria",
	[6]  = "Draenor",
	[7]  = "Legion",
	[8]  = "Battle for Azeroth",
	[9]  = "Shadowlands",
	[10] = "Dragonflight",
	[11] = "The War Within",
	[12] = "Midnight",
}

Zero2Max.AREA = {
	[1]  = "Kalimdor",
	[2]  = "Eastern Kingdoms",
	[3]  = "Outland",
	[4]  = "Northrend",
	[5]  = "Cataclysm",
	[6]  = "Pandaria",
	[7]  = "Draenor",
	[8]  = "Legion",
	[9]  = "Battle for Azeroth",
	[10] = "Shadowlands",
	[11] = "Dragon Isles",
	[12] = "Khaz Algar",
	[13] = "Quel'Thalas",
}

--<<Exploration
Zero2Max.EXPLORE = {
	[1]  = { 842, 861, 860, 844, 855, 857, 853, 852, 845, 847, 728, 750, 4996, 736, 848, 850, 849, 846, 851, 854, 856 },
	[2]  = { 868, 859, 858, 771, 770, 768, 769, 772, 773, 761, 841, 779, 627, 765, 774, 775, 780, 776, 802, 778, 777, 782, 766, 781, 4995 },
	[3]  = { 843, 865, 863, 862, 866, 867, 864 },
	[4]  = { 1269, 1270, 1267, 1268, 1457, 1265, 1266, 1264, 1263 },
	[5]  = { 4863, 4864, 4866, 4825, 4865 },
	[6]  = { 6976, 6351, 6977, 6979, 6978, 6969, 6975 },
	[7]  = { 8939, 8937, 10260, 8942, 8940, 8938, 8941 },
	[8]  = { 10667, 10666, 10668, 10669, 10665, 11543, 12069 },
	[9]  = { 12558, 13776, 12557, 12556, 13712, 12560, 12561, 12559 },
	[10] = { 14663, 15053, 14305, 14306, 14303, 14304, 15224 },
	[11] = { 17534, 16400, 16518, 16457, 19309, 16460, 17766 },
    [12] = { 40831, 40825, 40826, 40822, 41587 },
}

--<<Lore Quest
Zero2Max.QUEST_ALLIANCE = {
	[1]  = { 1678, 4926, 4928, 4940, 4931, 4925, 4936, 4937, 4930, 4929, 4932, 4938, 4935, 4939, 4934 },
	[2]  = { 1676, 4892, 4893, 4897, 4896, 12429, 4899, 4900, 4910, 4901, 4902, 4903, 12430, 4904, 4909, 4906, 4905 },
	[3]  = { 1262, 1194, 1193, 1190, 1189, 1192, 1191, 1195 },
	[4]  = { 41, 38, 40, 39, 36, 35, 37, 33, 34 },
	[5]  = { 4875, 4870, 4871, 4873, 4869, 4872 },
	[6]  = { 6541, 6537, 6300, 6539, 6540, 6301, 6535, 7928, 8099 },
	[7]  = { 9833, 8923, 8927, 8920, 8845, 8925 },
	[8]  = { 11157, 10059, 10698, 10790, 11124, 10763, 10617, 11340, 10877, 11546, 12066 },
	[9]  = { 12593, 13553, 12496, 12497, 12473, 13710, 12997, 12891, 12510, 13467, 13925, 13251, 13283, 14157 },
	[10] = { 14280, 14961, 14334, 14206, 14799, 13878, 14798, 14281, 14801, 14164, 14800, 15259, 14790, 15647, 15579 },
}

Zero2Max.QUEST_HORDE = {
	[1]  = { 1678, 4940, 4931, 4927, 4976, 4980, 4933, 4981, 4930, 4978, 4979, 4938, 4935, 4939, 4934 },
	[2]  = { 1676, 4908, 4892, 4893, 4894, 4895, 4897, 4896, 4900, 4910, 4901, 4904, 4909, 4906, 4905 },
	[3]  = { 1262, 1194, 1193, 1190, 1271, 1273, 1272, 1195 },
	[4]  = { 41, 38, 40, 39, 36, 1359, 1357, 1358, 1356 },
	[5]  = { 4875, 4870, 4871, 5501, 4982, 4872 },
	[6]  = { 6541, 6538, 6534, 6539, 6540, 6301, 6536, 7929, 8099 },
	[7]  = { 9923, 8924, 8671, 8928, 8919, 8926 },
	[8]  = { 11157, 10059, 10698, 10790, 11124, 10763, 10617, 11340, 10877, 11546, 12066 },
	[9]  = { 13294, 13700, 13709, 12478, 11868, 11861, 12480, 12479, 12509, 13466, 13924, 13284, 14157 },
	[10] = { 14280, 14961, 14334, 14206, 14799, 13878, 14798, 14281, 14801, 14164, 14800, 15259, 14790, 15647, 15579 },
}

--<<Kill Count
Zero2Max.KILL = {
	[1]  = { 1098, 1099, 1100, 6337, 1101 },
	[2]  = { 1084, 1083, 1085, 1086, 1087, 1088, 6148, 1089, 1090 },
	[3]  = { 1753, 1754, 2870, 3236, 4074, 4075, 4657, 4658, 1377, 1390,
			 1376, 1389, 1391, 1394, 2869, 2883, 4044, 4045, 4046, 4047,
			 4653, 4686, 4687, 4688, 4821, 4822, 4820, 4823 },
	[4]  = { 5774, 5773, 5578, 5981, 6170, 5576, 5577, 5565, 5566, 5572, 5571, 5976, 5977, 6167, 6168 },
	[5]  = { 6989, 6990, 8146, 8147, 8548, 6799, 6800, 7926, 7927, 6988,
			 6819, 6820, 7971, 7972, 7000, 6811, 6812, 7963, 7964, 6996,
			 8199, 8202, 8200, 8201, 8198, 8635, 8637, 8636, 8638, 8634,
			 8632 },
	[6]  = { 9277, 9278, 9279, 10200, 9313, 9314, 9315, 9312, 9363, 9364, 9365, 9362, 10250, 10251, 10252, 10249 },
	[7]  = { 10937, 10938, 10939, 10936, 11416, 11417, 11418, 11415, 10978, 10979,
			 10980, 10977, 11910, 11911, 11912, 11909, 11984, 11985, 11986, 12127 },
	[8]  = { 12818, 12819, 12820, 12817, 13380, 13381, 13382, 13379, 13411, 13412,
			 13413, 13408, 13617, 13618, 13619, 13616, 14136, 14137, 14138, 14135 },
	[9]  = { 14455, 14456, 14457, 14458, 15174, 15175, 15176, 15173, 15465, 15466, 15467, 15464 },
}

--<<Follower
Zero2Max.FOLLOWER_TYPE = {
			-- index, expansion title, follower title, display max, max active, max lvl, max ilvl, show not recruit, show lvl, show ilvl
	[1]  = {1, "Garrison", "Follower", 30, 25, 40, 675, false, true, true},
	[2]  = {2, "Shipyard", "Fleet", 10, 10, 40, 600, false, false, false},
	[3]  = {4, "Legion", "Champion", 9, 7, 45, 900, true, true, true},
	[4]  = {22, "Battle for Azeroth", "Champion", 6, 6, 50, 800, true, false, false},
	[5]  = {123, "Shadowlands", "Companion", 22, 22, 60, 800, false, true, false},
}

--<<War With In Delve Call
--Zero2Max.QUEST_DELVE = { 85648, 83758, 83759, 83766, 85649, 83769, 83768, 83767, 85664, 83770, 85666, 83771, 85667 }
Zero2Max.QUEST_DELVE = { 85648, 83758, 83759, 83766, 85649, 83769, 83768, 83767, 85664, 83770, 83771, 85667 }

--<<Dragonflight Profession Artisan Mission
--Zero2Max.PROF_ARTI_MISS_FULL = { 70026, 70028, 70034, 70025, 70033, 67080, 70027, 70030, 70029, 70032, 70031 }
Zero2Max.PROF_ARTI_MISS =
{
	[182] = 70026,
	[186] = 70028,
	[393] = 70034,
	[164] = 70025,
	[165] = 70033,
	[171] = 67080,
	[197] = 70027,
	[202] = 70030,
	[333] = 70029,
	[755] = 70032,
	[773] = 70031,
}

Zero2Max.EXPANSION_FRIEND = {
	[10] = {2544, 2517, 2518, 2550, 2568, 2553, 2615},
	[11] = {2601, 2605, 2607, 2640},
	[12] = {},
}

Zero2Max.EXPANSION_REPUTATION = {
	[10] = {2526},
--	[11] = {2673, 2677, 2675, 2671, 2669, 2685},
	[11] = {2673, 2677, 2675, 2671, 2669},
	[12] = {},
}

Zero2Max.OUTFITID_LIST = {
	[1]	 = 2,
	[2]	 = 3,
	[3]	 = 4,
	[4]	 = 5,
	[5]	 = 36,
	[6]	 = 37,
	[7]	 = 39,
	[8]	 = 40,
	[9]	 = 41,
	[10] = 42,
	[11] = 62,
	[12] = 63,
	[13] = 64,
	[14] = 65,
	[15] = 66,
	[16] = 67,
	[17] = 68,
	[18] = 69,
	[19] = 70,
	[20] = 71,
	[21] = 102,
	[22] = 103,
	[23] = 104,
	[24] = 105,
	[25] = 106,
	[26] = 107,
	[27] = 108,
	[28] = 109,
	[29] = 110,
	[30] = 111,
}
