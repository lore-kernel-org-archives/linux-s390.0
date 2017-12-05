From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/4] KVM: s390: add SPDX identifiers to the remaining files
Date: Tue,  5 Dec 2017 09:33:18 +0100
Message-ID: <20171205083321.102933-2-borntraeger@de.ibm.com>
References: <20171205083321.102933-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171205083321.102933-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
Message-Id: <20171124140043.10062-3-gregkh@linuxfoundation.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
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
index 6048b1c..2c5a819 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # Makefile for kernel virtual machines on s390
 #
 # Copyright IBM Corp. 2008
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index d93a2c0..481e1fe 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * handling diagnose instructions
  *
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index bec42b8..443b7fa 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * access guest memory
  *
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index bcbd866..d6a1bea 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * kvm guest debug support
  *
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 8fe034b..fc76a91 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * in-kernel handling for sie intercepts
  *
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fa55737..f37a34e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * handling kvm guest interrupts
  *
diff --git a/arch/s390/kvm/irq.h b/arch/s390/kvm/irq.h
index d98e415..54a4a59 100644
--- a/arch/s390/kvm/irq.h
+++ b/arch/s390/kvm/irq.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * s390 irqchip routines
  *
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 98ad8b9..0d45e32 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * hosting zSeries kernel virtual machines
  *
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 10d65df..9777924 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * definition for kvm on s390
  *
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index c954ac4..c9d962a 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * handling privileged instructions
  *
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 9d592ef..d12ac5d 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * handling interprocessor communication
  *
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index a311938..d2b7886 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * kvm nested virtualization support for s390x
  *
-- 
2.9.4
