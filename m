From: Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Thu, 02 Aug 2018 09:57:02 +0000
Subject: Re: [PATCH 3/5] Makefile: Rename ZFCPDUMP_PART_* macros
Message-Id: <20180802095702.GC5361@linux.ibm.com>
In-Reply-To: <498c08ec-2f63-a600-3511-4cbb4e87d3f3@redhat.com>
References: <498c08ec-2f63-a600-3511-4cbb4e87d3f3@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 25, 2018 at 01:36:13PM +0200, Philipp Rudo wrote:
> The file system dumper no longer exists. So there is no need in keeping
> 'PART' to distinguish between the file system and the partition dumper.
> Adjust the macro name to the usage in zipl by removing 'PART'.
> 
> While at it also adjust the file names the macros stand for.
> 
> Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
> ---
>  .gitignore        |  2 +-
>  common.mak        |  6 +++---
>  zfcpdump/Makefile | 10 +++++-----
>  zipl/src/Makefile |  4 ++--
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 41feaf6b..6741256b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -76,7 +76,7 @@ zdsfs/zdsfs
>  zdump/zgetdump
>  zfcpdump/cpioinit
>  zfcpdump/zfcpdump_part
> -zfcpdump/zfcpdump_part.rd
> +zfcpdump/zfcpdump-initrd
>  ziomon/ziomon_mgr
>  ziomon/ziomon_util
>  ziomon/ziomon_zfcpdd
> diff --git a/common.mak b/common.mak
> index 9bd613fb..986ff303 100644
> --- a/common.mak
> +++ b/common.mak
> @@ -182,9 +182,9 @@ GROUP		= $(shell id -gn)
>  export INSTALLDIR BINDIR LIBDIR MANDIR OWNER GROUP
>  
>  # Special defines for zfcpdump
> -ZFCPDUMP_PART_IMAGE	= zfcpdump_part.image
> -ZFCPDUMP_PART_RD	= zfcpdump_part.rd
> -export ZFCPDUMP_DIR ZFCPDUMP_PART_IMAGE ZFCPDUMP_PART_RD
> +ZFCPDUMP_IMAGE	= zfcpdump-image
> +ZFCPDUMP_INITRD	= zfcpdump-initrd
> +export ZFCPDUMP_DIR ZFCPDUMP_IMAGE ZFCPDUMP_INITRD
>  
>  CFLAGS		?= $(DEFAULT_CFLAGS) $(OPT_FLAGS)
>  HOSTCFLAGS	?= $(DEFAULT_CFLAGS) $(OPT_FLAGS)
> diff --git a/zfcpdump/Makefile b/zfcpdump/Makefile
> index 5fcb0739..1d9cce53 100644
> --- a/zfcpdump/Makefile
> +++ b/zfcpdump/Makefile
> @@ -20,7 +20,7 @@ check_dep:
>  		"HAVE_LIBC_STATIC=0", \
>  		"-static")
>  
> -all: check_dep $(ZFCPDUMP_PART_RD)
> +all: check_dep $(ZFCPDUMP_INITRD)
>  
>  cpioinit: cpioinit.c
>  	$(HOSTCC) $(HOSTCFLAGS) -o $@ $^
> @@ -29,17 +29,17 @@ zfcpdump_part: zfcpdump.o zfcpdump_part.o
>  	$(LINK) $(ALL_LDFLAGS) $^ -static -o $@
>  	$(STRIP) -s $@
>  
> -$(ZFCPDUMP_PART_RD): cpioinit zfcpdump_part
> +$(ZFCPDUMP_INITRD): cpioinit zfcpdump_part
>  	$(CPIOINIT) zfcpdump_part > $@.tmp
>  	$(GZIP) -f $@.tmp
> -	$(MV) $@.tmp.gz $(ZFCPDUMP_PART_RD)
> +	$(MV) $@.tmp.gz $(ZFCPDUMP_INITRD)
>  
>  install: all
> -	$(INSTALL) -m 611 $(ZFCPDUMP_PART_RD) $(DESTDIR)$(ZFCPDUMP_DIR)
> +	$(INSTALL) -m 611 $(ZFCPDUMP_INITRD) $(DESTDIR)$(ZFCPDUMP_DIR)
>  
>  endif
>  
>  clean:
> -	rm -f *.o *.gz *.tmp *~ zfcpdump_part cpioinit $(ZFCPDUMP_PART_RD)
> +	rm -f *.o *.gz *.tmp *~ zfcpdump_part cpioinit $(ZFCPDUMP_INITRD)
>  
>  .PHONY: all clean install check_dep
> diff --git a/zipl/src/Makefile b/zipl/src/Makefile
> index f8c36dc2..b9018b4b 100644
> --- a/zipl/src/Makefile
> +++ b/zipl/src/Makefile
> @@ -3,8 +3,8 @@ include ../../common.mak
>  
>  ALL_CPPFLAGS += -I../include -I../boot \
>  	    -DZFCPDUMP_DIR=$(ZFCPDUMP_DIR) \
> -	    -DZFCPDUMP_PART_IMAGE=$(ZFCPDUMP_PART_IMAGE) \
> -	    -DZFCPDUMP_PART_RD=$(ZFCPDUMP_PART_RD) \
> +	    -DZFCPDUMP_PART_IMAGE=$(ZFCPDUMP_IMAGE) \
> +	    -DZFCPDUMP_PART_RD=$(ZFCPDUMP_INITRD) \
>  	    -D_FILE_OFFSET_BITS=64 $(NO_PIE_CFLAGS)
>  ALL_LDFLAGS += -Wl,-z,noexecstack $(NO_PIE_LDFLAGS)
>  

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
