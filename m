From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/11] KVM: s390: write external damage code on machine checks
Date: Thu,  8 Sep 2016 14:00:17 +0200
Message-ID: <1473336023-15522-6-git-send-email-borntraeger@de.ibm.com>
References: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's also write the external damage code already provided by
struct kvm_s390_mchk_info.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/asm-offsets.c | 1 +
 arch/s390/kvm/interrupt.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 1f95cc1..f3df9e0 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -125,6 +125,7 @@ int main(void)
 	OFFSET(__LC_STFL_FAC_LIST, lowcore, stfl_fac_list);
 	OFFSET(__LC_STFLE_FAC_LIST, lowcore, stfle_fac_list);
 	OFFSET(__LC_MCCK_CODE, lowcore, mcck_interruption_code);
+	OFFSET(__LC_EXT_DAMAGE_CODE, lowcore, external_damage_code);
 	OFFSET(__LC_MCCK_FAIL_STOR_ADDR, lowcore, failing_storage_address);
 	OFFSET(__LC_LAST_BREAK, lowcore, breaking_event_addr);
 	OFFSET(__LC_RST_OLD_PSW, lowcore, restart_old_psw);
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index c0ef625..353e0b7 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -460,6 +460,8 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 			     &vcpu->arch.sie_block->gcr, 128);
 
 	/* Extended interruption information */
+	rc |= put_guest_lc(vcpu, mchk->ext_damage_code,
+			   (u32 __user *) __LC_EXT_DAMAGE_CODE);
 	rc |= put_guest_lc(vcpu, mchk->failing_storage_address,
 			   (u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
 	rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA, &mchk->fixed_logout,
-- 
2.5.5
