From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Mar 2018 19:28:56 +0000
Subject: [GIT PULL 08/10] s390/setup: enable display support for KVM guest
Message-Id: <20180314192858.172855-9-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <e23b61f4f599ba23881727a1e8880e9d60cc6a48.1519315352.git.alifm@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/setup.c      | 2 ++
 drivers/tty/Kconfig           | 2 +-
 drivers/video/console/Kconfig | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index a6a91f01a17a..f98a0f362876 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -221,6 +221,8 @@ static void __init conmode_default(void)
 		SET_CONSOLE_SCLP;
 #endif
 	}
+	if (IS_ENABLED(CONFIG_VT) && IS_ENABLED(CONFIG_DUMMY_CONSOLE))
+		conswitchp = &dummy_con;
 }
 
 #ifdef CONFIG_CRASH_DUMP
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index b811442c5ce6..5ca53facc2c8 100644
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
index 9485857228ea..b9c2c916247e 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM && !S390
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
2.14.3
