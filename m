From: Michael Mueller <mimu@linux.ibm.com>
Date: Fri, 30 Nov 2018 14:32:15 +0000
Subject: [PATCH v4 10/10] KVM: s390: start using the GIB
Message-Id: <20181130143215.69496-11-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

By initializing the GIB, it will be used by the kvm host.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 Documentation/kmsg/s390/kvm | 12 ++++++++++++
 arch/s390/kvm/kvm-s390.c    | 10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/kmsg/s390/kvm b/Documentation/kmsg/s390/kvm
index 76ffe2012254..6908476a54f1 100644
--- a/Documentation/kmsg/s390/kvm
+++ b/Documentation/kmsg/s390/kvm
@@ -10,3 +10,15 @@
  * If this problem persists after a reload of the kvm kernel module, gather
  * Linux debug data and contact your support organization.
  */
+
+/*?
+ * Text: "Failed to initialize GIB rc=%d\n"
+ * Severity: Error
+ * Parameter:
+ *   @1: return code of the GIB initialization call
+ * Description:
+ * The initialization if the GIB (Guest Information Block) was not successful.
+ * User action:
+ * If this problem persists after a reload of the kvm kernel module, gather
+ * Linux debug data and contact your support organization.
+ */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2d10e175862c..5f068f3942da 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -428,16 +428,24 @@ int kvm_arch_init(void *opaque)
 		goto out_debug_unreg;
 	}
 
+	rc = kvm_s390_gib_init(GAL_ISC);
+	if (rc) {
+		pr_err("Failed to initialize GIB rc=%d\n", rc);
+		goto out_debug_unreg;
+	}
+
 	kvm_s390_cpu_feat_init();
 
 	/* Register floating interrupt controller interface. */
 	rc = kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
 	if (rc) {
 		pr_err("Failed to register FLIC rc=%d\n", rc);
-		goto out_debug_unreg;
+		goto out_gib_destroy;
 	}
 	return 0;
 
+out_gib_destroy:
+	kvm_s390_gib_destroy();
 out_debug_unreg:
 	debug_unregister(kvm_s390_dbf);
 	return rc;
-- 
2.13.4
