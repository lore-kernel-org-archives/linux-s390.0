From: Kyle McMartin <kyle@redhat.com>
Date: Mon, 20 May 2013 19:06:34 +0000
Subject: [PATCH] s390: link in devres.o if pci is enabled
Message-Id: <20130520190634.GF28729@redacted.bos.redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

kernel/irq/devres.o is only built by default if the arch is using
GENERIC_HARDIRQS, which s390 is not. As a result, drivers using
devm_request{,_threaded}_irq() fail to build on s390. While the utility
of those drivers on a mainframe is questionable, these interfaces
should be supported on s390 as well, since they don't fundamentally
require more than {request,free}_irq.

In the case of CONFIG_PCI, build and link kernel/irq/devres.o into the
kernel image.

Signed-off-by: Kyle McMartin <kyle@redhat.com>

--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -64,6 +64,8 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_cpum_cf.o
 obj-y				+= runtime_instr.o cache.o
 endif
 
+obj-$(CONFIG_PCI) += ../../../kernel/irq/devres.o
+
 # vdso
 obj-$(CONFIG_64BIT)		+= vdso64/
 obj-$(CONFIG_32BIT)		+= vdso32/
