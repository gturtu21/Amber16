# Amber16

ubuntu18_baseimage is a simple ubuntu18 image where all needed dependencies for Amber16 are installed as described in reference manual:
https://ambermd.org/doc12/Amber16.pdf

The second image will need the following files and a valid Amber16 license to work:
- AmberTools17.tar.bz2 (it can be download free of charge);
- Amber16.tar.bz2 (it needs a valid license to be downloaded).

The first image can be build as follows:
```
docker build -tag ubuntu18_foramber16 .
```

```
docker build -tag ubuntu18_withamber16 .
```

It can take up to 20 minutes to build the second image.
