Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
Date: Tue, 8 Jan 2019 16:30:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Kconfig label updates
Message-ID: <20190108223024.GA147017@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

I want to update the PCI Kconfig labels so they're more consistent and
useful to users, something like the patch below.  IIUC, the items
below are all IBM-related; please correct me if not.

I'd also like to expand (or remove) "RPA" because Google doesn't find
anything about "IBM RPA", except Robotic Process Automation, which I
think must be something else.

Is there some text expansion of RPA that we could use that would be
meaningful to a user, i.e., something he/she might find on a nameplate
or in a user manual?

Ideally the PCI Kconfig labels would match the terms used in
arch/.../Kconfig, e.g.,

  config PPC_POWERNV
    bool "IBM PowerNV (Non-Virtualized) platform support"

  config PPC_PSERIES
    bool "IBM pSeries & new (POWER5-based) iSeries"

  config MARCH_Z900
    bool "IBM zSeries model z800 and z900"

  config MARCH_Z9_109
    bool "IBM System z9"

Bjorn


diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index e9f78eb390d2..1c1d145bfd84 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_POWERNV
-	tristate "PowerPC PowerNV PCI Hotplug driver"
+	tristate "IBM PowerNV PCI Hotplug driver"
 	depends on PPC_POWERNV && EEH
 	select OF_DYNAMIC
 	help
@@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_RPA
-	tristate "RPA PCI Hotplug driver"
+	tristate "IBM Power Systems RPA PCI Hotplug driver"
 	depends on PPC_PSERIES && EEH
 	help
 	  Say Y here if you have a RPA system that supports PCI Hotplug.
+	  This includes the earlier pSeries and iSeries.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rpaphp.
@@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_RPA_DLPAR
-	tristate "RPA Dynamic Logical Partitioning for I/O slots"
+	tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"
 	depends on HOTPLUG_PCI_RPA
 	help
 	  Say Y here if your system supports Dynamic Logical Partitioning
@@ -157,7 +158,7 @@ config HOTPLUG_PCI_SGI
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_S390
-	bool "System z PCI Hotplug Support"
+	bool "IBM System z PCI Hotplug Support"
 	depends on S390 && 64BIT
 	help
 	  Say Y here if you want to use the System z PCI Hotplug
