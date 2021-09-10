# cmake_minimum_required(VERSION 3.6.0)
# cmake_policy(SET CMP0042 NEW)
# set (CMAKE_CXX_STANDARD 11)

# project(sort-cpp)

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

# if (WIN32)
#     # This help to find OpenCV and Eigen, some how cmake on
#     # Windows doesn't use ENV variables so I had to re-set it here
#     set(OpenCV_DIR $ENV{OpenCV_DIR})
#     set(EIGEN3_INCLUDE_DIR $ENV{EIGEN3_INCLUDE_DIR})
# endif()

# # Try to find OpenCV
# find_package(OpenCV REQUIRED)
# if (OpenCV_FOUND)
#     # If the package has been found, several variables will
#     # be set, you can find the full list with descriptions
#     # in the OpenCVConfig.cmake file.
#     # Print some message showing some of them
#     message(STATUS "OpenCV library status:")
#     message(STATUS "    version: ${OpenCV_VERSION}")
#     message(STATUS "    include path: ${OpenCV_INCLUDE_DIRS}")
# else ()
#     message(FATAL_ERROR "Could not locate OpenCV")
# endif()

# if(APPLE)
#     # Trying to include path to Eigen that was installed by brew
#     include_directories("../ios/Classes/include")
# elseif(WIN32)
#     include_directories(${EIGEN3_INCLUDE_DIR})
# endif()
# include_directories(${PROJECT_SOURCE_DIR}/include)

# file(GLOB SOURCE_FILES ../ios/Classes/src/*.cpp ../ios/Classes/src/*.cc ../ios/Classes/src/*.h)


# add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})


cmake_minimum_required(VERSION 3.4.1)

# TODO please change me!
set(OPENCV_BASE_DIR "/home/hieunt/Android_SDK_OpenCV/OpenCV-android-sdk")

set(OPENCV_INCLUDE_DIR "${OPENCV_BASE_DIR}/sdk/native/jni/include/")
set(OPENCV_STATIC_LIB_DIR "${OPENCV_BASE_DIR}/sdk/native/staticlibs/${ANDROID_ABI}")
set(OPENCV_3RDPARTY_STATIC_LIB_DIR "${OPENCV_BASE_DIR}/sdk/native/3rdparty/libs/${ANDROID_ABI}")

include_directories(${OPENCV_INCLUDE_DIR})

find_library(log-lib log)

add_library(highgui STATIC IMPORTED)
set_target_properties(highgui PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_highgui.a)

add_library(calib3d STATIC IMPORTED)
set_target_properties(calib3d PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_calib3d.a)

add_library(core STATIC IMPORTED)
set_target_properties(core PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_core.a)

add_library(dnn STATIC IMPORTED)
set_target_properties(dnn PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_dnn.a)

add_library(flann STATIC IMPORTED)
set_target_properties(flann PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_flann.a)

add_library(imgproc STATIC IMPORTED)
set_target_properties(imgproc PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_imgproc.a)

add_library(videoio STATIC IMPORTED)
set_target_properties(videoio PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_videoio.a)

add_library(imgcodecs STATIC IMPORTED)
set_target_properties(imgcodecs PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_imgcodecs.a)

add_library(features2d STATIC IMPORTED)
set_target_properties(features2d PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_features2d.a)

add_library(ml STATIC IMPORTED)
set_target_properties(ml PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_ml.a)

add_library(photo STATIC IMPORTED)
set_target_properties(photo PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_photo.a)

add_library(shape STATIC IMPORTED)
set_target_properties(shape PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_shape.a)

add_library(objdetect STATIC IMPORTED)
set_target_properties(objdetect PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_objdetect.a)

add_library(stitching STATIC IMPORTED)
set_target_properties(stitching PROPERTIES IMPORTED_LOCATION ${OPENCV_STATIC_LIB_DIR}/libopencv_stitching.a)

include(AndroidNdkModules)
android_ndk_import_module_cpufeatures()

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
find_package(Threads REQUIRED)

add_library(tbb STATIC IMPORTED)
set_target_properties(tbb PROPERTIES IMPORTED_LOCATION ${OPENCV_3RDPARTY_STATIC_LIB_DIR}/libtbb.a)

add_library(tegra_hal STATIC IMPORTED)
set_target_properties(tegra_hal PROPERTIES IMPORTED_LOCATION ${OPENCV_3RDPARTY_STATIC_LIB_DIR}/libtegra_hal.a)

add_library(ittnotify STATIC IMPORTED)
set_target_properties(ittnotify PROPERTIES IMPORTED_LOCATION ${OPENCV_3RDPARTY_STATIC_LIB_DIR}/libittnotify.a)

# add_library(native_with_opencv

#         # Sets the library as a shared library.
#         SHARED

#         # Provides a relative path to your source file(s).
#         ../ios/Classes/native_add.cpp
#         )

add_subdirectory(../ios/Classes/eigen)

include_directories(../ios/Classes/include)

file(GLOB SOURCE_FILES ../ios/Classes/src/*.cpp ../ios/Classes/src/*.cc ../ios/Classes/src/*.h)


add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})


target_link_libraries(native_with_opencv
        ${log-lib}
        core
        # note: You can import whatever other modules you like (e.g. dnn)
        tbb # note: need to be placed *after* "core"
        cpufeatures
        ittnotify
        tegra_hal # NOTE if still have error, check abiFilters, since tegra does *not* exist in x86.
        Threads::Threads
        -lz
        )
