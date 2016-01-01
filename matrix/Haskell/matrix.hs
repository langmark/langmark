import Control.Arrow
import Control.Monad
import Data.Array.Unboxed
import System.Environment

(n, seed, ml, md, mds1, mds2) = (512, 42, 25189, 32749, 256, 65536)

genMat :: Int -> UArray (Int, Int) Int
genMat = array ((0, 0), (n - 1, n - 1)) . map (first (`divMod` n)) . take (n ^ 2) . iterate ((+ 1) *** (`mod` md) . (* ml)) . ((,) 0)

main = let  m1 = genMat seed
            m2 = genMat $ m1 ! (n - 1, n - 1) * ml `mod` md
            r = [0 .. n - 1]
            m :: UArray (Int, Int) Int
            m = array ((0, 0), (n - 1, n - 1)) [((i, j), sum [m1 ! (i, k) * m2 ! (k, j) | k <- r] `mod` mds2) | i <- r, j <- r]
            s = (`mod` mds2) . sum . map (\((i, j), v) -> (i * j `mod` mds1) * v) $ assocs m
        in
            m `seq` getArgs >>= (flip when) (print s) . not . null

