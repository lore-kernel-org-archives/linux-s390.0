Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/12] s390: pci: add SPDX identifiers to the remaining files
Date: Fri, 24 Nov 2017 15:00:36 +0100
Message-Id: <20171124140043.10062-6-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the arch/s390/pci/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/pci/pci.c       | 1 +
 arch/s390/pci/pci_debug.c | 1 +
 arch/s390/pci/pci_dma.c   | 1 +
 arch/s390/pci/pci_insn.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 0fe649c0d542..4902fed221c0 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright IBM Corp. 2012
  *
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c2f786f0ea06..b482e95b6249 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright IBM Corp. 2012,2015
  *
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 0d300ee00f4e..f7aa5a77827e 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright IBM Corp. 2012
  *
diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 81b840bc6e4e..19bcb3b45a70 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * s390 specific pci instructions
  *
-- 
2.15.0
