SOURCE   = spwd.c
TARGET   = spwd

GCC      = gcc
GCCFLAGS = -O2

.PHONY: default clean

default: $(TARGET)

$(TARGET): $(SOURCE)
	$(GCC) $(GCCFLAGS) -o $(TARGET) $(SOURCE)

clean:
	rm -f spwd
