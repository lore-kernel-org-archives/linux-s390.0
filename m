From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Dec 2018 09:24:51 +0000
Subject: [GIT PULL 2/2] KVM: s390: fix kmsg component kvm-s390
Message-Id: <20181219092451.37052-3-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

Relocate #define statement for kvm related kernel messages
before the include of printk to become effective.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d8d8e07881577..530b4175f56db 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -11,6 +11,9 @@
  *               Jason J. Herne <jjherne@us.ibm.com>
  */
 
+#define KMSG_COMPONENT "kvm-s390"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/fs.h>
@@ -44,10 +47,6 @@
 #include "kvm-s390.h"
 #include "gaccess.h"
 
-#define KMSG_COMPONENT "kvm-s390"
-#undef pr_fmt
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
-
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 #include "trace-s390.h"
-- 
2.19.1
