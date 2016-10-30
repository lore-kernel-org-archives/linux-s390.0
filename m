Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 6/9] s390: hotplug: make pci_hpc explicitly non-modular
Date: Sun, 30 Oct 2016 16:37:29 -0400
Message-ID: <20161030203732.26405-7-paul.gortmaker@windriver.com>
In-Reply-To: <20161030203732.26405-1-paul.gortmaker@windriver.com>
References: <20161030203732.26405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/hotplug/Kconfig:config HOTPLUG_PCI_S390
drivers/pci/hotplug/Kconfig:    bool "System z PCI Hotplug Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

We don't exchange module.h for init.h or export.h since the file
does not contain any initcalls or EXPORT of symbols.

Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/hotplug/s390_pci_hpc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index 50b8b7d54416..530d0e49f2ed 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -5,12 +5,13 @@
  *
  * Author(s):
  *   Jan Glauber <jang@linux.vnet.ibm.com>
+ *
+ * License: GPL
  */
 
 #define KMSG_COMPONENT "zpci"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
@@ -21,10 +22,6 @@
 #define SLOT_NAME_SIZE	10
 static LIST_HEAD(s390_hotplug_slot_list);
 
-MODULE_AUTHOR("Jan Glauber <jang@linux.vnet.ibm.com");
-MODULE_DESCRIPTION("Hot Plug PCI Controller for System z");
-MODULE_LICENSE("GPL");
-
 static int zpci_fn_configured(enum zpci_state state)
 {
 	return state == ZPCI_FN_STATE_CONFIGURED ||
-- 
2.10.1
