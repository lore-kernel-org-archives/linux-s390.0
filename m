From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/18] KVM: s390: irq delivery should not rely on icptcode
Date: Fri, 12 Feb 2016 14:22:53 +0100
Message-ID: <1455283382-62999-10-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Program irq injection during program irq intercepts is the last candidates
that injects nullifying irqs and relies on delivery to do the right thing.

As we should not rely on the icptcode during any delivery (because that
value will not be migrated), let's add a flag, telling prog IRQ delivery
to not rewind the PSW in case of nullifying prog IRQs.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 2 ++
 arch/s390/kvm/interrupt.c | 2 +-
 include/uapi/linux/kvm.h  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 6b4e5b5..2e6b54e 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -140,6 +140,8 @@ static int inject_prog_on_prog_intercept(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_pgm_info pgm_info = {
 		.code = vcpu->arch.sie_block->iprcc,
+		/* the PSW has already been rewound */
+		.flags = KVM_S390_PGM_FLAGS_NO_REWIND,
 	};
 
 	switch (vcpu->arch.sie_block->iprcc & ~PGM_PER) {
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index e594a78..87e2d1a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -665,7 +665,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 				   (u8 *) __LC_PER_ACCESS_ID);
 	}
 
-	if (nullifying && vcpu->arch.sie_block->icptcode == ICPT_INST)
+	if (nullifying && !(pgm_info.flags & KVM_S390_PGM_FLAGS_NO_REWIND))
 		kvm_s390_rewind_psw(vcpu, ilen);
 
 	/* bit 1+2 of the target are the ilc, so we can directly use ilen */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4e20a40..a2fe0ac 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -545,6 +545,7 @@ struct kvm_s390_pgm_info {
 #define KVM_S390_PGM_FLAGS_ILC_0	0x02
 #define KVM_S390_PGM_FLAGS_ILC_1	0x04
 #define KVM_S390_PGM_FLAGS_ILC_MASK	0x06
+#define KVM_S390_PGM_FLAGS_NO_REWIND	0x08
 	__u8 flags;
 	__u8 pad[2];
 };
-- 
2.3.0
