# ec-perf-survey

### Finding which data files correspond to which data set

Here is the corresponding table for each data set. Just find the version in the name of the file, and find it in the table to have the configuration corresponding. 

| Nom           | CPU/GPU | Numéro de Version | Configuration                                 |
|---------------|---------|-------------------|-----------------------------------------------|
| gemm, fdtd-2d | CPU     | v1                | Tile-Size = 8x8x8                             |
|               | CPU     | v2                | tile-size = 16x16x16                          |
|               | CPU     | v3                | tile-size = 32x32x32                          |
|               | CPU     | v4                | tile-size = 64x64x64                          |
|               | CPU     | v5                | tile-size = 128x128x128                       |
| gemm          | CPU     | v6                | tile-size = 8x8x8, intra-tiling = 16x16x16    |
|               | CPU     | v7                | tile-size = 16x16x16, intra-tiling = 32x32x32 |
|               | CPU     | v8                | tile-size = 32x32x32, intra-tiling = 32x32x32 |
|               | CPU     | v9                | tile-size = 8x128x8, intra-tiling = 16x2x16   |
| gemm          | GPU     | v10               | tile-size = 8x8x8, block-size = 8x8           |
|               | GPU     | v11               | tile-size = 16x16x16, block-size = 8x8        |
|               | GPU     | v12               | tile-size = 32x32x32, block-size = 8x8        |
|               | GPU     | v13               | tile-size = 64x64x64, block-size = 8x8        |
|               | GPU     | v14               | tile-size = 128x128x128, block-size = 8x8     |
|               | GPU     | v15               | tile-size = 16x16x16, block-size = 16x16      |
|               | GPU     | v16               | tile-size = 32x32x32, block-size = 16x16      |
|               | GPU     | v17               | tile-size = 64x64x64, block-size = 16x16      |
|               | GPU     | v18               | tile-size = 128x128x128, block-size = 16x16   |
|               | GPU     | v19               | tile-size = 32x32x32, block-size = 32x32      |
|               | GPU     | v20               | tile-size = 64x64x64, block-size = 32x32      |
|               | GPU     | v21               | tile-size = 128x128x128, block-size = 32x32   |