From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 10 Jan 2019 15:41:44 +0000
Subject: [kvm-unit-tests PATCH v5 04/11] s390x: Switch to z/Arch and enable 64 bit addressing mode
Message-Id: <20190110154151.24233-5-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

LPAR and z/VM start in esam mode depending on the hardware (CZAM
facility and others affect this), so we need to switch to z/Arch and
set 64 bit addressing.

Under Qemu/KVM we already start out with both when being run with the
Qemu --kernel argument or we lack 64 bit when booting from disk
because of the initial psw specifying 31 bit for z/VM and lpar
compatibility.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 s390x/cstart64.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 385915e..6622633 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -11,6 +11,7 @@
  * under the terms of the GNU Library General Public License version 2.
  */
 #include <asm/asm-offsets.h>
+#include <asm/sigp.h>
 
 .section .init
 
@@ -20,9 +21,19 @@
  *
  * For KVM and TCG kernel boot we are in 64 bit z/Arch mode.
  * When booting from disk the initial short psw is in 31 bit mode.
+ * When running under LPAR or z/VM, we might start in 31 bit and esam mode.
  */
 	.globl start
 start:
+	/* Switch to z/Architecture mode and 64-bit */
+	slr     %r0, %r0		# Set cpuid to zero
+	lhi     %r1, 2			# mode 2 = esame
+	sigp    %r1, %r0, SIGP_SET_ARCHITECTURE
+	/* XOR all registers with themselves to clear them fully. */
+	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	xgr \i,\i
+	.endr
+	sam64				# Set addressing mode to 64 bit
 	/* setup stack */
 	larl	%r15, stackptr
 	/* setup initial PSW mask + control registers*/
-- 
2.14.3
