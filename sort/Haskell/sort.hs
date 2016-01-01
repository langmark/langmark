import Control.DeepSeq
import Control.Monad
import Data.List
import System.Environment

(n, seed, ml, md, nprint) = (4194304, 3, 27487, 30491, 279121)

foo :: [Int]
foo = sort . take n $ iterate ((`mod` md) . (* ml)) seed

main = foo `deepseq` getArgs >>= (flip when) (print $ foo !! nprint) . not . null
