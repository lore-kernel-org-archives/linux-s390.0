From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 01 Feb 2018 18:41:30 +0000
Subject: [PATCH v2 3/3] s390/setup : enable display support for KVM guest
Message-Id: <1bab9ed1fe5be2ae0b559adec37012c70bec0950.1517508744.git.alifm@linux.vnet.ibm.com>
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com, schwidefsky@de.ibm.com, alifm@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The S390 architecture does not support any graphics hardware,
but with the latest support for Virtio GPU in Linux and Virtio
GPU emulation in QEMU, it's possible to enable graphics for
S390 using the Virtio GPU device.

To enable display we need to enable the Linux Virtual Terminal (VT)
layer for S390. But the VT subsystem initializes quite early
at boot so we need a dummy console driver till the Virtio GPU
driver is initialized and we can run the framebuffer console.

The framebuffer console over a Virtio GPU device can be run
in combination with the serial SCLP console (default on S390).
The SCLP console can still be accessed by management applications
(eg: via Libvirt's virsh console).

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/setup.c      | 2 ++
 drivers/tty/Kconfig           | 2 +-
 drivers/video/console/Kconfig | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 793da97..0c1070c 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -220,6 +220,8 @@ static void __init conmode_default(void)
 		SET_CONSOLE_SCLP;
 #endif
 	}
+	if (IS_ENABLED(CONFIG_VT) && IS_ENABLED(CONFIG_DUMMY_CONSOLE))
+		conswitchp = &dummy_con;
 }
 
 #ifdef CONFIG_CRASH_DUMP
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index cc2b4d9..8481007 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -11,7 +11,7 @@ if TTY
 
 config VT
 	bool "Virtual terminal" if EXPERT
-	depends on !S390 && !UML
+	depends on !UML
 	select INPUT
 	default y
 	---help---
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fb..8ba2565 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
2.7.4
