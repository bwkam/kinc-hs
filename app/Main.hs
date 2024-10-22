{-# LANGUAGE MagicHash #-}

module Main where

import Foreign (nullPtr)
import GHC.Ptr (FunPtr (FunPtr), Ptr (Ptr))
import Graphics4.Graphics

main :: IO ()
main = do
  c_kinc_init (Ptr "Foo"#) 1024 768 nullPtr nullPtr
  callback <- mkFun update
  c_kinc_set_update_callback callback nullPtr
  c_kinc_start
  putStrLn "hey"

update :: Ptr a -> IO ()
update x = do
  c_kinc_g4_begin 0
  c_kinc_g4_clear 1 0xFF0000 0 0
  c_kinc_g4_end 0
  c_kinc_swap_buffers
  return ()
