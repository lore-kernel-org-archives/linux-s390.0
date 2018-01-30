Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] PCI: Add SPDX GPL-2.0+ to replace implicit GPL v2 or later
 statement
From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 29 Jan 2018 18:40:52 -0600
Message-ID: <20180130004051.15416.78620.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130003559.15416.18047.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130003559.15416.18047.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

7441b0627e22 ("s390/pci: PCI hotplug support via SCLP") added
s390_pci_hpc.c, which included this license information:

  +MODULE_LICENSE("GPL");

Based on "git show 7441b0627e22:include/linux/module.h", that "GPL" string
means "GPL v2 or later":

   *      "GPL"                           [GNU Public License v2 or later]

0729dcf24832 ("s390: hotplug: make pci_hpc explicitly non-modular")
subsequently replaced the MODULE_LICENSE() with a "License: GPL" comment.

Add SPDX GPL-2.0+ and remove the "License: GPL" comment, relying on the
assertion in b24413180f56 ("License cleanup: add SPDX GPL-2.0 license
identifier to files with no license") that the SPDX identifier may be used
instead of the full boilerplate text.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/s390_pci_hpc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index 530d0e49f2ed..ffdc2977395d 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * PCI Hot Plug Controller Driver for System z
  *
@@ -5,8 +6,6 @@
  *
  * Author(s):
  *   Jan Glauber <jang@linux.vnet.ibm.com>
- *
- * License: GPL
  */
 
 #define KMSG_COMPONENT "zpci"
