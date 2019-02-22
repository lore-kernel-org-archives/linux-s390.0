From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:26 +0000
Subject: [GIT PULL 15/18] KVM: s390: start using the GIB
Message-Id: <1550835749-26436-16-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

By initializing the GIB, it will be used by the kvm host.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20190131085247.13826-15-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0099fbd..2e47c72 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -435,8 +435,15 @@ int kvm_arch_init(void *opaque)
 		pr_err("A FLIC registration call failed with rc=%d\n", rc);
 		goto out_debug_unreg;
 	}
+
+	rc = kvm_s390_gib_init(GAL_ISC);
+	if (rc)
+		goto out_gib_destroy;
+
 	return 0;
 
+out_gib_destroy:
+	kvm_s390_gib_destroy();
 out_debug_unreg:
 	debug_unregister(kvm_s390_dbf);
 	return rc;
-- 
2.7.4
