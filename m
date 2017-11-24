Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/12] s390: kvm: add SPDX identifiers to the remaining files
Date: Fri, 24 Nov 2017 15:00:33 +0100
Message-Id: <20171124140043.10062-3-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the arch/s390/kvm/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kvm/Makefile    | 1 +
 arch/s390/kvm/diag.c      | 1 +
 arch/s390/kvm/gaccess.h   | 1 +
 arch/s390/kvm/guestdbg.c  | 1 +
 arch/s390/kvm/intercept.c | 1 +
 arch/s390/kvm/interrupt.c | 1 +
 arch/s390/kvm/irq.h       | 1 +
 arch/s390/kvm/kvm-s390.c  | 1 +
 arch/s390/kvm/kvm-s390.h  | 1 +
 arch/s390/kvm/priv.c      | 1 +
 arch/s390/kvm/sigp.c      | 1 +
 arch/s390/kvm/vsie.c      | 1 +
 12 files changed, 12 insertions(+)

diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 6048b1c6e580..2c5a8190d5ce 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # Makefile for kernel virtual machines on s390
 #
 # Copyright IBM Corp. 2008
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index d93a2c0474bf..481e1fe6095f 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * handling diagnose instructions
  *
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index bec42b852246..443b7fa82d56 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * access guest memory
  *
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index bcbd86621d01..d6a1bead813c 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * kvm guest debug support
  *
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 8fe034beb623..fc76a91a7820 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * in-kernel handling for sie intercepts
  *
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fa557372d600..f37a34ea1601 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * handling kvm guest interrupts
  *
diff --git a/arch/s390/kvm/irq.h b/arch/s390/kvm/irq.h
index d98e4159643d..54a4a59cb4f9 100644
--- a/arch/s390/kvm/irq.h
+++ b/arch/s390/kvm/irq.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * s390 irqchip routines
  *
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 98ad8b9e0360..0d45e32dd868 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * hosting zSeries kernel virtual machines
  *
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 10d65dfbc306..9777924c4b5c 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * definition for kvm on s390
  *
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index c954ac49eee4..c9d962ac140b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * handling privileged instructions
  *
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 9d592ef4104b..d12ac5d6e8bb 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * handling interprocessor communication
  *
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index a311938b63b3..d2b7886da444 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * kvm nested virtualization support for s390x
  *
-- 
2.15.0
