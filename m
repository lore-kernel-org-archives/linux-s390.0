From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:12 +0000
Subject: [GIT PULL 01/18] KVM: s390: clarify kvm related kernel message
Message-Id: <1550835749-26436-2-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

As suggested by our ID dept. here are some kernel message
updates.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7f4bc58..11b4be3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -432,7 +432,7 @@ int kvm_arch_init(void *opaque)
 	/* Register floating interrupt controller interface. */
 	rc = kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
 	if (rc) {
-		pr_err("Failed to register FLIC rc=%d\n", rc);
+		pr_err("A FLIC registration call failed with rc=%d\n", rc);
 		goto out_debug_unreg;
 	}
 	return 0;
@@ -4293,12 +4293,12 @@ static int __init kvm_s390_init(void)
 	int i;
 
 	if (!sclp.has_sief2) {
-		pr_info("SIE not available\n");
+		pr_info("SIE is not available\n");
 		return -ENODEV;
 	}
 
 	if (nested && hpage) {
-		pr_info("nested (vSIE) and hpage (huge page backing) can currently not be activated concurrently");
+		pr_info("A KVM host that supports nesting cannot back its KVM guests with huge pages\n");
 		return -EINVAL;
 	}
 
-- 
2.7.4
