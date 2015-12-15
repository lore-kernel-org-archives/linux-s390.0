From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/4] KVM: s390: consider system MHA for guest storage
Date: Tue, 15 Dec 2015 20:23:46 +0100
Message-ID: <1450207426-17222-5-git-send-email-borntraeger@de.ibm.com>
References: <1450207426-17222-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1450207426-17222-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Guenther Hutzl <hutzl@linux.vnet.ibm.com>

Verify that the guest maximum storage address is below the MHA (maximum
host address) value allowed on the host.

Acked-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
[adopt to match recent limit,size changes]

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c       | 6 +++++-
 drivers/s390/char/sclp_early.c | 8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8aa5e55..940e9ff 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1184,7 +1184,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		kvm->arch.gmap = NULL;
 		kvm->arch.mem_limit = KVM_S390_NO_MEM_LIMIT;
 	} else {
-		kvm->arch.mem_limit = TASK_MAX_SIZE;
+		if (sclp.hamax == U64_MAX)
+			kvm->arch.mem_limit = TASK_MAX_SIZE;
+		else
+			kvm->arch.mem_limit = min_t(unsigned long, TASK_MAX_SIZE,
+						    sclp.hamax + 1);
 		kvm->arch.gmap = gmap_alloc(current->mm, kvm->arch.mem_limit - 1);
 		if (!kvm->arch.gmap)
 			goto out_err;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index e0a1f4e..6804354 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -40,7 +40,8 @@ struct read_info_sccb {
 	u8	fac85;			/* 85 */
 	u8	_pad_86[91 - 86];	/* 86-90 */
 	u8	flags;			/* 91 */
-	u8	_pad_92[100 - 92];	/* 92-99 */
+	u8	_pad_92[99 - 92];	/* 92-98 */
+	u8	hamaxpow;		/* 99 */
 	u32	rnsize2;		/* 100-103 */
 	u64	rnmax2;			/* 104-111 */
 	u8	_pad_112[116 - 112];	/* 112-115 */
@@ -120,6 +121,11 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 	sclp.rzm <<= 20;
 	sclp.ibc = sccb->ibc;
 
+	if (sccb->hamaxpow && sccb->hamaxpow < 64)
+		sclp.hamax = (1UL << sccb->hamaxpow) - 1;
+	else
+		sclp.hamax = U64_MAX;
+
 	if (!sccb->hcpua) {
 		if (MACHINE_IS_VM)
 			sclp.max_cores = 64;
-- 
2.3.0
