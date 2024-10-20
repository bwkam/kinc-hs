{-# LANGUAGE CPP #-}
{-# LANGUAGE ForeignFunctionInterface #-}

module Graphics where

import Data.Void (Void)
import Foreign
import Foreign.C (CString)
import Foreign.C.Types

data KincWindowOptions

data KincFrameBufferOptions

type UpdateCallback a = Ptr a -> IO ()

foreign import ccall "wrapper" mkFun :: UpdateCallback a -> IO (FunPtr (UpdateCallback a))

foreign import ccall "kinc_set_update_callback"
  c_kinc_set_update_callback :: FunPtr (UpdateCallback a) -> Ptr a -> IO ()

foreign import ccall "kinc_g4_begin" c_kinc_g4_begin :: Int -> IO ()

foreign import ccall "kinc_g4_end" c_kinc_g4_end :: Int -> IO ()

foreign import ccall "kinc_g4_swap_buffers" c_kinc_swap_buffers :: IO Bool

foreign import ccall "kinc_start" c_kinc_start :: IO ()

foreign import ccall "kinc_init" c_kinc_init :: CString -> Int -> Int -> Ptr KincWindowOptions -> Ptr KincFrameBufferOptions -> IO Int

foreign import ccall "kinc_g4_clear" c_kinc_g4_clear :: Word8 -> Word8 -> CFloat -> Int -> IO ()
