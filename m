Return-Path: <linux-kernel-owner+w=401wt.eu-S1763387AbXEQGhH@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.22-rc1-mm1 - s390 vs. md
Date: Wed, 16 May 2007 23:36:56 -0700
Message-ID: <0C7297FA1D2D244A9C7F6959C0BF1E5201DEA0F1@azsmsx413.amr.corp.intel.com>
From: "Williams, Dan J" <dan.j.williams@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Williams, Dan J" <dan.j.williams@intel.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


> From: Williams, Dan J
> On a closer look, it seems async_tx should be its own directory like
crypto...
> I'll post the incremental changes to the md-accel git tree for review.
> 
Here is a copy of the patch added to the md-accel series
(git://lost.foo-projects.org/~dwillia2/git/iop md-accel-linus).  This
along with some other code re-factoring makes async_tx mimic the
organization of crypto, and should resolve the S390 clash.

---

async_tx: add the Kconfig infrastructure for async_tx

From: Dan Williams <dan.j.williams@intel.com>

async_tx is similar to crypto in that there is an api component and a
drivers component.

* Add 'source "async_tx/Kconfig"' to the per architecture Kconfig files,
  for each architecture that sources drivers/md/Kconfig (which appears
to be
  all of them).
* Add 'select' statements for the subsystems that use async_tx
(md-raid4,5)

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 arch/alpha/Kconfig     |    1 +
 arch/arm/Kconfig       |    2 ++
 arch/arm26/Kconfig     |    2 ++
 arch/avr32/Kconfig     |    2 ++
 arch/blackfin/Kconfig  |    2 ++
 arch/cris/Kconfig      |    2 ++
 arch/frv/Kconfig       |    2 ++
 arch/h8300/Kconfig     |    2 ++
 arch/i386/Kconfig      |    2 ++
 arch/ia64/Kconfig      |    2 ++
 arch/m32r/Kconfig      |    2 ++
 arch/m68k/Kconfig      |    2 ++
 arch/m68knommu/Kconfig |    2 ++
 arch/mips/Kconfig      |    2 ++
 arch/parisc/Kconfig    |    2 ++
 arch/powerpc/Kconfig   |    2 ++
 arch/ppc/Kconfig       |    2 ++
 arch/s390/Kconfig      |    2 ++
 arch/sh/Kconfig        |    2 ++
 arch/sh64/Kconfig      |    2 ++
 arch/sparc/Kconfig     |    2 ++
 arch/sparc64/Kconfig   |    2 ++
 arch/um/Kconfig        |    2 ++
 arch/v850/Kconfig      |    2 ++
 arch/x86_64/Kconfig    |    2 ++
 arch/xtensa/Kconfig    |    2 ++
 async_tx/Kconfig       |   27 +++++++++++++++++++++++++++
 drivers/md/Kconfig     |    3 +++
 28 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 770f717..1fb0075 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -650,3 +650,4 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
+source "async_tx/Kconfig"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f2809c..dd49b2a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1048,3 +1048,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/arm26/Kconfig b/arch/arm26/Kconfig
index 20688bc..bc8b99d 100644
--- a/arch/arm26/Kconfig
+++ b/arch/arm26/Kconfig
@@ -248,3 +248,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index 3ec7658..5f16cc6 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -213,3 +213,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index 1a49305..648043a 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -987,3 +987,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 4b41248..f902242 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -205,3 +205,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 114738a..6aa888b 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -390,3 +390,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 618dbad..95e33df 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -227,3 +227,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index c2d54b8..2776164 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1236,6 +1236,8 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
+source "async_tx/Kconfig"
+
 #
 # Use the generic interrupt handling code in kernel/irq/:
 #
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index de1bff6..929e59b 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -552,6 +552,8 @@ source "fs/Kconfig"
 
 source "lib/Kconfig"
 
+source "async_tx/Kconfig"
+
 #
 # Use the generic interrupt handling code in kernel/irq/:
 #
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index c3bb8a7..35c6c08 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -412,3 +412,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index b8536c7..1421427 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -677,3 +677,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
index 823f737..9cf83cf 100644
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -683,3 +683,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0f09412..581040c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1963,3 +1963,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 3d73545..afc4bad 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -276,3 +276,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 56d3c0d..65f6c55 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -887,6 +887,8 @@ source "arch/powerpc/sysdev/qe_lib/Kconfig"
 
 source "lib/Kconfig"
 
+source "async_tx/Kconfig"
+
 menu "Instrumentation Support"
 	depends on EXPERIMENTAL
 
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index ccce2a4..e249d9a 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1458,3 +1458,5 @@ source "arch/ppc/Kconfig.debug"
 source "security/Kconfig"
 
 source "crypto/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 098c62c..25d86af 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -556,3 +556,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 038179e..6f99b0e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -728,3 +728,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/sh64/Kconfig b/arch/sh64/Kconfig
index ff65420..32f032a 100644
--- a/arch/sh64/Kconfig
+++ b/arch/sh64/Kconfig
@@ -292,6 +292,8 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
+source "async_tx/Kconfig"
+
 #
 # Use the generic interrupt handling code in kernel/irq/:
 #
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index bd992c0..a782692 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -315,3 +315,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 831781c..16a9175 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -447,3 +447,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c504312..220d7de 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -325,6 +325,8 @@ source "drivers/scsi/Kconfig"
 
 source "drivers/md/Kconfig"
 
+source "async_tx/Kconfig"
+
 if BROKEN
 	source "drivers/mtd/Kconfig"
 endif
diff --git a/arch/v850/Kconfig b/arch/v850/Kconfig
index 5f54c12..bdee041 100644
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -347,4 +347,6 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
+source "async_tx/Kconfig"
+
 
########################################################################
#####
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 145bb82..2b8b637 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -784,3 +784,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "async_tx/Kconfig"
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7fbb44b..b18d15f 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -259,4 +259,6 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
+source "async_tx/Kconfig"
+
 
diff --git a/async_tx/Kconfig b/async_tx/Kconfig
new file mode 100644
index 0000000..4a6801e
--- /dev/null
+++ b/async_tx/Kconfig
@@ -0,0 +1,27 @@
+menuconfig ASYNC_CORE
+	tristate "Asynchronous Bulk Memory Transfers/Transforms"
+	default n
+	---help---
+	  This enables the async_tx interface layer for dma (offload)
engines.
+	  Subsystems coded to this api will use offload engines for bulk
memory
+	  operations (e.g. memcpy, memset, xor...).  When an offload
engine is not
+	  available the interface will implicitly fall back to a
software
+	  implementation of the operation.
+
+	  If unsure, say N
+
+if ASYNC_CORE
+
+config ASYNC_MEMCPY
+	default m
+	tristate "async_memcpy support"
+
+config ASYNC_XOR
+	default m
+	tristate "async_xor support"
+
+config ASYNC_MEMSET
+	default m
+	tristate "async_memset support"
+
+endif
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 7df934d..9fa1555 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -109,6 +109,9 @@ config MD_RAID10
 config MD_RAID456
 	tristate "RAID-4/RAID-5/RAID-6 mode"
 	depends on BLK_DEV_MD
+	select ASYNC_CORE
+	select ASYNC_MEMCPY
+	select ASYNC_XOR
 	---help---
 	  A RAID-5 set of N drives with a capacity of C MB per drive
provides
 	  the capacity of C * (N - 1) MB, and protects against a failure
