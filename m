From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:02:58 +0100
Message-Id: <20181109190304.8573-11-kilobyte@angband.pl>
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 11/17] Kconfig: Remove support for BZIP2-compressed initrd and kernel
Return-Path: <kilobyte@angband.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Cc: Adam Borowski <kilobyte@angband.pl>
List-ID: <linux-s390.vger.kernel.org>

In no case it's a rational choice anymore: it's much slower than newer
algorithms at similar compression strength, and takes lots of memory
as well.

Removal of compression algorithms for vmlinuz is completely safe (the
kernel gets compressed by this very Makefile), less so for initrd as
someone might have requested it in initramfs.conf -- but it's not an
option users tend to alter, and they'd use a better algorithm anyway.
Thus, user damage is possible but on par with removal of an ancient
filesystem.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 Makefile                   |  1 -
 init/Kconfig               | 17 ++---------------
 init/do_mounts_rd.c        |  1 -
 kernel/configs/tiny.config |  1 -
 usr/Kconfig                | 24 ------------------------
 5 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/Makefile b/Makefile
index 9fce8b91c15f..c812467bfe11 100644
--- a/Makefile
+++ b/Makefile
@@ -938,7 +938,6 @@ export mod_compress_cmd
 # This shall be used by the dracut(8) tool while creating an initramfs image.
 #
 INITRD_COMPRESS-y                  := gzip
-INITRD_COMPRESS-$(CONFIG_RD_BZIP2) := bzip2
 INITRD_COMPRESS-$(CONFIG_RD_LZMA)  := lzma
 INITRD_COMPRESS-$(CONFIG_RD_XZ)    := xz
 INITRD_COMPRESS-$(CONFIG_RD_LZO)   := lzo
diff --git a/init/Kconfig b/init/Kconfig
index ffa5ae4abc88..412ba93673fa 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -119,9 +119,6 @@ config BUILD_SALT
 config HAVE_KERNEL_GZIP
 	bool
 
-config HAVE_KERNEL_BZIP2
-	bool
-
 config HAVE_KERNEL_LZMA
 	bool
 
@@ -143,7 +140,7 @@ config HAVE_KERNEL_UNCOMPRESSED
 choice
 	prompt "Kernel compression mode"
 	default KERNEL_GZIP
-	depends on HAVE_KERNEL_GZIP || HAVE_KERNEL_BZIP2 || HAVE_KERNEL_LZMA || HAVE_KERNEL_XZ || HAVE_KERNEL_LZO || HAVE_KERNEL_LZ4 || HAVE_KERNEL_ZSTD || HAVE_KERNEL_UNCOMPRESSED
+	depends on HAVE_KERNEL_GZIP || HAVE_KERNEL_LZMA || HAVE_KERNEL_XZ || HAVE_KERNEL_LZO || HAVE_KERNEL_LZ4 || HAVE_KERNEL_ZSTD || HAVE_KERNEL_UNCOMPRESSED
 	help
 	  The linux kernel is a kind of self-extracting executable.
 	  Several compression algorithms are available, which differ
@@ -151,7 +148,7 @@ choice
 	  Compression speed is only relevant when building a kernel.
 	  Decompression speed is relevant at each boot.
 
-	  If you have any problems with bzip2 or lzma compressed
+	  If you have any problems with lzma compressed
 	  kernels, mail me (Alain Knaff) <alain@knaff.lu>. (An older
 	  version of this functionality (bzip2 only), for 2.4, was
 	  supplied by Christian Ludwig)
@@ -169,16 +166,6 @@ config KERNEL_GZIP
 	  The old and tried gzip compression. It provides a good balance
 	  between compression ratio and decompression speed.
 
-config KERNEL_BZIP2
-	bool "Bzip2"
-	depends on HAVE_KERNEL_BZIP2
-	help
-	  Its compression ratio and speed is intermediate.
-	  Decompression speed is slowest among the choices.  The kernel
-	  size is about 10% smaller with bzip2, in comparison to gzip.
-	  Bzip2 uses a large amount of memory. For modern kernels you
-	  will need at least 8MB RAM or more for booting.
-
 config KERNEL_LZMA
 	bool "LZMA"
 	depends on HAVE_KERNEL_LZMA
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 32fb049d18f9..5f26365ea8b1 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -48,7 +48,6 @@ static int __init crd_load(int in_fd, int out_fd, decompress_fn deco);
  *	cramfs
  *	squashfs
  *	gzip
- *	bzip2
  *	lzma
  *	xz
  *	lzo
diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
index 7fa0c4ae6394..c5480f87fae3 100644
--- a/kernel/configs/tiny.config
+++ b/kernel/configs/tiny.config
@@ -1,7 +1,6 @@
 # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_KERNEL_GZIP is not set
-# CONFIG_KERNEL_BZIP2 is not set
 # CONFIG_KERNEL_LZMA is not set
 CONFIG_KERNEL_XZ=y
 # CONFIG_KERNEL_LZO is not set
diff --git a/usr/Kconfig b/usr/Kconfig
index 5ff529b75ee1..05b6be569041 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -61,15 +61,6 @@ config RD_GZIP
 	  Support loading of a gzip encoded initial ramdisk or cpio buffer.
 	  If unsure, say Y.
 
-config RD_BZIP2
-	bool "Support initial ramdisk/ramfs compressed using bzip2"
-	default y
-	depends on BLK_DEV_INITRD
-	select DECOMPRESS_BZIP2
-	help
-	  Support loading of a bzip2 encoded initial ramdisk or cpio buffer
-	  If unsure, say N.
-
 config RD_LZMA
 	bool "Support initial ramdisk/ramfs compressed using LZMA"
 	default y
@@ -161,19 +152,6 @@ config INITRAMFS_COMPRESSION_GZIP
 	  supported by your build system as the gzip tool is present by default
 	  on most distros.
 
-config INITRAMFS_COMPRESSION_BZIP2
-	bool "Bzip2"
-	depends on RD_BZIP2
-	help
-	  It's compression ratio and speed is intermediate. Decompression speed
-	  is slowest among the choices. The initramfs size is about 10% smaller
-	  with bzip2, in comparison to gzip. Bzip2 uses a large amount of
-	  memory. For modern kernels you will need at least 8MB RAM or more for
-	  booting.
-
-	  If you choose this, keep in mind that you need to have the bzip2 tool
-	  available to be able to compress the initram.
-
 config INITRAMFS_COMPRESSION_LZMA
 	bool "LZMA"
 	depends on RD_LZMA
@@ -241,7 +219,6 @@ config INITRAMFS_COMPRESSION
 	string
 	default ""      if INITRAMFS_COMPRESSION_NONE
 	default ".gz"   if INITRAMFS_COMPRESSION_GZIP
-	default ".bz2"  if INITRAMFS_COMPRESSION_BZIP2
 	default ".lzma" if INITRAMFS_COMPRESSION_LZMA
 	default ".xz"   if INITRAMFS_COMPRESSION_XZ
 	default ".lzo"  if INITRAMFS_COMPRESSION_LZO
@@ -252,6 +229,5 @@ config INITRAMFS_COMPRESSION
 	default ".lzo"  if RD_LZO
 	default ".xz"   if RD_XZ
 	default ".lzma" if RD_LZMA
-	default ".bz2"  if RD_BZIP2
 	default ".zst"  if RD_ZSTD
 	default ""
-- 
2.19.1
