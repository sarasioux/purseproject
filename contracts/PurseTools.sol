//   ___, __   _, ___,   ____  ____,
//  (-|_)(-|  |  (-|_)  (-(__`(-|_,
//   _|    |__|_, _| \_, ____) _|__,
//  (            (      (     (
//
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract Purse {

    string[] public weapons = [
    "Derringer",
    "Pepper Spray",
    "Glock",
    "Sharp Keychain",
    "Scissors",
    "Metal Nail File",
    "Ballistic Dart Launcher",
    "Taser",
    "Flashlight",
    "Whistle",
    "Umbrella",
    "Hair Pin",
    "Safety Pins",
    "Ball-point Pen",
    "Tweezers"
    ];

    string[] public creams = [
    "Sunscreen",
    "Moisturizer",
    "Baby Powder",
    "Roller Perfume",
    "Wet Wipes",
    "Band-Aids",
    "Neosporin",
    "Blotting Papers",
    "Stain-eraser Pen",
    "Hand Lotion",
    "Hand Sanitizer",
    "Mints",
    "Tissues",
    "Advil",
    "Tampons",
    "Sanitary Pads",
    "Deoderant"
    ];

    string[] public makeup = [
    "Red Lipstick",
    "Pink Lipstick",
    "Lip Balm",
    "Chap Stick",
    "Lip Gloss",
    "Eyeliner",
    "Powdered Compact",
    "Mascara",
    "Foundation",
    "Blush",
    "Bronzer",
    "Contour Kit",
    "Coverup",
    "Lip Liner",
    "Brow Brush",
    "Nail Polish"
    ];

    string[] public cards = [
    "Passport",
    "Driver's License",
    "State-issued ID",
    "Gym Membership Card",
    "Warehouse Membership Card",
    "Library Card",
    "Social Security Card",
    "Birth Certificate",
    "Credit Card",
    "Debit Card",
    "Medical Card",
    "Birthday Card"
    ];

    string[] public accessories = [
    "Scarf",
    "Gloves",
    "Earrings",
    "Bracelet",
    "Watch",
    "Arm Band",
    "Fitness Tracker",
    "Smart Watch",
    "Ballet Flats",
    "Strappy Sandals",
    "Bangles",
    "Aviator Sunglasses",
    "Giant Sunglasses",
    "Drug Store Sunglasses"
    ];

    string[] public sex = [
    "Condoms",
    "Magnums",
    "Vibrator",
    "Pocket Rocket",
    "Furry Handcuffs",
    "Silk Blindfold",
    "The Rabbit",
    "Hitachi Magic Wand",
    "Paddle",
    "Lube"
    ];

    string[] public necklaces = [
    "Necklace",
    "Pendant",
    "Choker",
    "Collar",
    "Long Necklaces",
    "Gold Necklace"
    ];

    string[] public rings = [
    "Engagement Ring",
    "Wedding Ring",
    "Promise Ring",
    "Purity Ring",
    "Independence Ring"
    ];

    string[] public suffixes = [
    "of Gucci",
    "of Chanel",
    "of Balenciaga",
    "of Versace",
    "of Prada",
    "of Tom Ford",
    "of Hermes",
    "of Fendi",
    "of Burberry",
    "of Givenchy",
    "of Bulgari",
    "of Armani",
    "of Louis Vuitton",
    "of Christian Dior",
    "of Calvin Klein",
    "of Marc Jacobs"
    ];

    string[] public namePrefixes = [
    "Age-Defying", "Bedazzled", "Sparkling", "Diamond", "Couture", "Bespoke", "Custom", "Last Season's",
    "This Season's", "Flattering", "Beautiful", "Lovely", "Angelic", "Sweet", "Demure", "Fierce",
    "Basic", "Fancy", "Luxury", "Exclusive", "Special", "Cherished", "Precious",
    "Youthful", "Clean", "Scented", "Brightening", "Lightening", "Smoothing", "Clarifying",
    "Sexy", "Sultry", "Voluptuous", "Curvy", "Antique", "Vintage", "Elite", "Warming", "Comforting", "Soft", "Fluffy",
    "Furry", "Faux", "Imitation", "Dainty", "Feminine", "Glorious", "Independent"
    ];

    string[] public nameSuffixes = [
    "Pleasure",
    "Silk",
    "Glow",
    "Communication",
    "Understanding",
    "Love",
    "Share",
    "Comfort",
    "Warmth",
    "Safety"
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function getWeapon(uint256 tokenId) public view returns (uint256[6] memory) {
        return pluck(tokenId, "WEAPON", weapons);
    }

    function getCream(uint256 tokenId) public view returns (uint256[6] memory) {
        return pluck(tokenId, "CREAM", creams);
    }

    function getMakeup(uint256 tokenId) public view returns (uint256[6] memory) {
        return pluck(tokenId, "MAKEUP", makeup);
    }

    function getCards(uint256 tokenId) public view returns (uint256[6] memory) {
        return pluck(tokenId, "CARDS", cards);
    }

    function getAccessories(uint256 tokenId) public view returns (uint256[6] memory) {
        return pluck(tokenId, "ACCESSORIES", accessories);
    }

    function getSex(uint256 tokenId) public view returns (uint256[6] memory) {
        return pluck(tokenId, "SEX", sex);
    }

    function getNeck(uint256 tokenId) public view returns (uint256[6] memory) {
        return pluck(tokenId, "NECK", necklaces);
    }

    function getRing(uint256 tokenId) public view returns (uint256[6] memory) {
        return pluck(tokenId, "RING", rings);
    }

    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal view returns (uint256[6] memory) {
        uint256[5] memory components;

        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));

        components[0] = rand % sourceArray.length;

        uint256 greatness = rand % 21;
        if (greatness > 14) {
            components[1] = (rand % suffixes.length) + 1;
        }
        if (greatness >= 17) {
            components[2] = (rand % namePrefixes.length) + 1;

            if (greatness == 19) {
                components[3] = (rand % nameSuffixes.length) + 1;
            } else {
                components[3] = (rand % nameSuffixes.length) + 1;
                components[4] = 1;
            }
        }

        components[5] = greatness;
        return components;
    }

    function getGreatness(uint256 tokenId, string memory keyPrefix) public returns (uint256 greatness) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
        greatness = rand % 21;
    }

    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT license
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    constructor() {}
}

/// [MIT License]
/// @title Base64
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Base64 {
    bytes internal constant TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(input, 0x3F))), 0xFF))
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}
