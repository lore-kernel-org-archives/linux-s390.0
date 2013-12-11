From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 1/6] KVM: s390: diagnose call documentation
Date: Wed, 11 Dec 2013 19:57:44 +0100
Message-ID: <1386788269-20249-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Add some further documentation on the DIAGNOSE calls we support.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/hypercalls.txt |    3 ++
 Documentation/virtual/kvm/s390-diag.txt  |   80 ++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/virtual/kvm/s390-diag.txt

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index 022198e..d922d73 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -17,6 +17,9 @@ S390:
   S390 uses diagnose instruction as hypercall (0x500) along with hypercall
   number in R1.
 
+  For further information on the S390 diagnose call as supported by KVM,
+  refer to Documentation/virtual/kvm/s390-diag.txt.
+
  PowerPC:
   It uses R3-R10 and hypercall number in R11. R4-R11 are used as output registers.
   Return value is placed in R3.
diff --git a/Documentation/virtual/kvm/s390-diag.txt b/Documentation/virtual/kvm/s390-diag.txt
new file mode 100644
index 0000000..f1de4fb
--- /dev/null
+++ b/Documentation/virtual/kvm/s390-diag.txt
@@ -0,0 +1,80 @@
+The s390 DIAGNOSE call on KVM
+=============================
+
+KVM on s390 supports the DIAGNOSE call for making hypercalls, both for
+native hypercalls and for selected hypercalls found on other s390
+hypervisors.
+
+Note that bits are numbered as by the usual s390 convention (most significant
+bit on the left).
+
+
+General remarks
+---------------
+
+DIAGNOSE calls by the guest cause a mandatory intercept. This implies
+all supported DIAGNOSE calls need to be handled by either KVM or its
+userspace.
+
+All DIAGNOSE calls supported by KVM use the RS-a format:
+
+--------------------------------------
+|  '83'  | R1 | R3 | B2 |     D2     |
+--------------------------------------
+0        8    12   16   20           31
+
+The second-operand address (obtained by the base/displacement calculation)
+is not used to address data. Instead, bits 48-63 of this address specify
+the function code, and bits 0-47 are ignored.
+
+The supported DIAGNOSE function codes vary by the userspace used. For
+DIAGNOSE function codes not specific to KVM, please refer to the
+documentation for the s390 hypervisors defining them.
+
+
+DIAGNOSE function code 'X'500' - KVM virtio functions
+-----------------------------------------------------
+
+If the function code specifies 0x500, various virtio-related functions
+are performed.
+
+General register 1 contains the virtio subfunction code. Supported
+virtio subfunctions depend on KVM's userspace. Generally, userspace
+provides either s390-virtio (subcodes 0-2) or virtio-ccw (subcode 3).
+
+Upon completion of the DIAGNOSE instruction, general register 2 contains
+the function's return code, which is either a return code or a subcode
+specific value.
+
+Subcode 0 - s390-virtio notification and early console printk
+    Handled by userspace.
+
+Subcode 1 - s390-virtio reset
+    Handled by userspace.
+
+Subcode 2 - s390-virtio set status
+    Handled by userspace.
+
+Subcode 3 - virtio-ccw notification
+    Handled by either userspace or KVM (ioeventfd case).
+
+    General register 2 contains a subchannel-identification word denoting
+    the subchannel of the virtio-ccw proxy device to be notified.
+
+    General register 3 contains the number of the virtqueue to be notified.
+
+    General register 4 contains a 64bit identifier for KVM usage (the
+    kvm_io_bus cookie). If general register 4 does not contain a valid
+    identifier, it is ignored.
+
+    After completion of the DIAGNOSE call, general register 2 may contain
+    a 64bit identifier (in the kvm_io_bus cookie case).
+
+    See also the virtio standard for a discussion of this hypercall.
+
+
+DIAGNOSE function code 'X'501 - KVM breakpoint
+----------------------------------------------
+
+If the function code specifies 0x501, breakpoint functions may be performed.
+This function code is handled by userspace.
-- 
1.7.9.5
