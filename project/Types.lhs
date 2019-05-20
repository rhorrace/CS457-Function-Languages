> module Types where

The value for the cards used in the program

> data Val = V2 | V3 | V4 | V5 | V6 | V7 | V8 | V9 | V10 | VJ | VQ | VK | VA
>   deriving (Eq, Ord, Bounded, Enum)

The show instance being used and modified, s.t.
each type of Val is converted to the right value
it represents as a string

> instance Show Val where
>   show v = case v of
>     V2  -> "2"
>     V3  -> "3"
>     V4  -> "4"
>     V5  -> "5"
>     V6  -> "6"
>     V7  -> "7"
>     V8  -> "8"
>     V9  -> "9"
>     V10 -> "10"
>     VJ  -> "J"
>     VQ  -> "Q"
>     VK  -> "K"
>     VA  -> "A"

The suit of the cards used in the program.
Hearts, Diamonds, Spades, and Clubs

> data Suit = H | D | S | C
>   deriving (Eq, Ord, Bounded, Enum)

Show instance for suit

> instance Show Suit where
>   show s = case s of
>     H -> "H"
>     D -> "D"
>     S -> "S"
>     C -> "C"

The card data type containing a value and a suit

> data Card = Card { value :: Val, suit :: Suit}
>   deriving Eq

Ord instance, so cards are compared by value

> instance Ord Card where
>   compare (Card v1 _) (Card v2 _) = compare v1 v2 

Show instance to for converting card to a string

> instance Show Card where
>   show (Card v s) = show v ++ ":" ++ show s

Hand values, or Ranks or players hand

> data Rank = HighCard | OnePair | TwoPair | ThreeOfKind | Straight | Flush | FullHouse | FourOfKind | StraightFlush | RoyalFlush
>   deriving (Eq, Ord, Show) 

Player data type, containing a deal, the hand, the hand rank

> data Player = Player { deal :: [Card], hand :: [Card], hand_rank :: Rank } 

The table data type, containg the flop, the turn, and the river

> data Table = Table {flop :: [Card], turn :: [Card], river :: [Card]}

