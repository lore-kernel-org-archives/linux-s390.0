From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: don't use current->thread.fpu.* when accessing registers
Date: Thu, 25 Aug 2016 17:53:57 +0200
Message-ID: <1472140437-66482-2-git-send-email-borntraeger@de.ibm.com>
References: <1472140437-66482-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1472140437-66482-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, 4.7@tuxmaker.boeblingen.de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

As the meaning of these variables and pointers seems to change more
frequently, let's directly access our save area, instead of going via
current->thread.

Right now, this is broken for set/get_fpu. They simply overwrite the
host registers, as the pointers to the current save area were turned
into the static host save area.

Cc: stable@vger.kernel.org # 4.7
Fixes: 3f6813b9a5e0 ("s390/fpu: allocate 'struct fpu' with the task_struct")
Reported-by: Hao QingFeng <haoqf@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f142215..607ec91 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2231,9 +2231,10 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 		return -EINVAL;
 	current->thread.fpu.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
-		convert_fp_to_vx(current->thread.fpu.vxrs, (freg_t *)fpu->fprs);
+		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
+				 (freg_t *) fpu->fprs);
 	else
-		memcpy(current->thread.fpu.fprs, &fpu->fprs, sizeof(fpu->fprs));
+		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
 	return 0;
 }
 
@@ -2242,9 +2243,10 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	/* make sure we have the latest values */
 	save_fpu_regs();
 	if (MACHINE_HAS_VX)
-		convert_vx_to_fp((freg_t *)fpu->fprs, current->thread.fpu.vxrs);
+		convert_vx_to_fp((freg_t *) fpu->fprs,
+				 (__vector128 *) vcpu->run->s.regs.vrs);
 	else
-		memcpy(fpu->fprs, current->thread.fpu.fprs, sizeof(fpu->fprs));
+		memcpy(fpu->fprs, vcpu->run->s.regs.fprs, sizeof(fpu->fprs));
 	fpu->fpc = current->thread.fpu.fpc;
 	return 0;
 }
-- 
2.5.5
