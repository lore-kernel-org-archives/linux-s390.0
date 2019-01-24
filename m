From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v6 13/13] KVM: s390: start using the GIB
Date: Thu, 24 Jan 2019 13:59:39 +0100
Message-ID: <20190124125939.130763-14-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

By initializing the GIB, it will be used by the kvm host.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0e6ba4d17207..dcf6d62b4e80 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -435,8 +435,15 @@ int kvm_arch_init(void *opaque)
 		pr_err("Failed to register FLIC rc=%d\n", rc);
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
2.13.4
