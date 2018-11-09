From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:03:03 +0100
Message-Id: <20181109190304.8573-16-kilobyte@angband.pl>
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 16/17] Kconfig: Update the prose for selection of compression algorithm
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

It was really obsolete, and some entries contradicted each other.

Let's not recommend ZSTD for kernel compression yet as it's available
only on x86, and some distros might not have the tool installed.
Proposing ZSTD for initrd is safer but let's test it first.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 init/Kconfig | 25 +++++++++++++------------
 usr/Kconfig  | 24 +++++++++++-------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 412ba93673fa..7c0180c41a3c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -153,26 +153,27 @@ choice
 	  version of this functionality (bzip2 only), for 2.4, was
 	  supplied by Christian Ludwig)
 
-	  High compression options are mostly useful for users, who
-	  are low on disk space (embedded systems), but for whom ram
-	  size matters less.
+	  High compression options tend to be more useful in most cases,
+	  as bootloaders are often egregiously slow to read the kernel
+	  from the disk/SD card/network/etc, overcoming any boot time
+	  savings you would get from faster decompression.
 
-	  If in doubt, select 'gzip'
+	  If in doubt, select 'xz'
 
 config KERNEL_GZIP
 	bool "Gzip"
 	depends on HAVE_KERNEL_GZIP
 	help
-	  The old and tried gzip compression. It provides a good balance
-	  between compression ratio and decompression speed.
+	  The old and tried gzip compression. You generally want it if
+	  some tool you use doesn't support more modern compressors.
 
 config KERNEL_LZMA
 	bool "LZMA"
 	depends on HAVE_KERNEL_LZMA
 	help
-	  This compression algorithm's ratio is best.  Decompression speed
-	  is between gzip and bzip2.  Compression is slowest.
-	  The kernel size is about 33% smaller with LZMA in comparison to gzip.
+	  An old version of xz, like it providing strong compression at slow
+	  speed. It lacks a header and support for filters or uncompressed
+	  blocks, thus it's usually better to pick xz.
 
 config KERNEL_XZ
 	bool "XZ"
@@ -193,9 +194,9 @@ config KERNEL_LZO
 	bool "LZO"
 	depends on HAVE_KERNEL_LZO
 	help
-	  Its compression ratio is the poorest among the choices. The kernel
-	  size is about 10% bigger than gzip; however its speed
-	  (both compression and decompression) is the fastest.
+	  Its compression ratio is pretty poor (but still better than
+	  LZ4). You want to pick ZSTD (similar speed but much better
+	  compression) or LZ4 (much better speed) instead.
 
 config KERNEL_LZ4
 	bool "LZ4"
diff --git a/usr/Kconfig b/usr/Kconfig
index 8d99edacabc9..f6e871585f05 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -131,17 +131,15 @@ config INITRAMFS_COMPRESSION_NONE
 	  on those architectures that support this. However, not compressing the
 	  initramfs may lead to slightly higher memory consumption during a
 	  short time at boot, while both the cpio image and the unpacked
-	  filesystem image will be present in memory simultaneously
+	  filesystem image will be present in memory simultaneously.
 
 config INITRAMFS_COMPRESSION_GZIP
 	bool "Gzip"
 	depends on RD_GZIP
 	help
-	  Use the old and well tested gzip compression algorithm. Gzip provides
-	  a good balance between compression ratio and decompression speed and
-	  has a reasonable compression speed. It is also more likely to be
-	  supported by your build system as the gzip tool is present by default
-	  on most distros.
+	  Use the old and well tested gzip compression algorithm. Gzip doesn't
+	  provide very good compression nor speed, but it's the safest choice,
+	  with wide support.
 
 config INITRAMFS_COMPRESSION_XZ
 	bool "XZ"
@@ -150,20 +148,20 @@ config INITRAMFS_COMPRESSION_XZ
 	  XZ uses the LZMA2 algorithm and has a large dictionary which may cause
 	  problems on memory constrained systems. The initramfs size is about
 	  30% smaller with XZ in comparison to gzip. Decompression speed is
-	  better than that of bzip2 but worse than gzip and LZO. Compression is
-	  slow.
+	  okayish but still slowest of all currently available algorithms.
+	  Compression is slow.
 
-	  If you choose this, keep in mind that you may need to install the xz
-	  tool to be able to compress the initram.
+	  Any modern distro provides xz in its default install, but on
+	  minimal build systems you might need to install xz-utils to be
+	  able to compress the initram.
 
 config INITRAMFS_COMPRESSION_LZO
 	bool "LZO"
 	depends on RD_LZO
 	help
 	  It's compression ratio is the second poorest amongst the choices. The
-	  kernel size is about 10% bigger than gzip. Despite that, it's
-	  decompression speed is the second fastest and it's compression speed
-	  is quite fast too.
+	  kernel size is about 10% bigger than gzip. Pick ZSTD instead, or LZ4
+	  if speed is paramount.
 
 	  If you choose this, keep in mind that you may need to install the lzop
 	  tool to be able to compress the initram.
-- 
2.19.1
