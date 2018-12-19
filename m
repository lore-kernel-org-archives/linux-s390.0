From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 15/15] KVM: s390: start using the GIB
Date: Wed, 19 Dec 2018 20:17:56 +0100
Message-ID: <20181219191756.57973-16-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

By initializing the GIB, it will be used by the kvm host.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2d10e175862c..777c8a87d81c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -428,16 +428,22 @@ int kvm_arch_init(void *opaque)
 		goto out_debug_unreg;
 	}
 
+	rc = kvm_s390_gib_init(GAL_ISC);
+	if (rc)
+		goto out_debug_unreg;
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
