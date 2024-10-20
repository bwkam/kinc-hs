{-# LANGUAGE MagicHash #-}

module Main where

import Foreign (nullPtr)
import GHC.Ptr (FunPtr (FunPtr), Ptr (Ptr))
import Graphics (c_kinc_g4_begin, c_kinc_g4_clear, c_kinc_g4_end, c_kinc_init, c_kinc_set_update_callback, c_kinc_start, c_kinc_swap_buffers, mkFun)

main :: IO ()
main = do
  c_kinc_init (Ptr "Foo"#) 1024 768 nullPtr nullPtr
  c_kinc_set_update_callback
    ( mkFun
        ( \_ -> do
            c_kinc_g4_begin 0
            c_kinc_g4_clear 1 0 0 0
            c_kinc_g4_end 0
            c_kinc_swap_buffers
        )
    )
    nullPtr
  c_kinc_start
  putStrLn "hey"
