From: Michael Mueller <mimu@linux.ibm.com>
Date: Thu, 25 Oct 2018 12:37:51 +0000
Subject: [PATCH 10/10] KVM: s390: start using the GIB
Message-Id: <20181025123751.48809-11-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

By initializing the GIB, it will we used by the kvm host.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d1f1550c95b4..1f42f27fc627 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -425,6 +425,7 @@ int kvm_arch_init(void *opaque)
 		return -ENOMEM;
 	}
 
+	kvm_s390_gib_init(GAL_ISC);
 	kvm_s390_cpu_feat_init();
 
 	/* Register floating interrupt controller interface. */
-- 
2.17.0
