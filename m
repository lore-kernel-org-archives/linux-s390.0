Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] KVM: s390: store DXC/VXC in fpc on DATA/Vector-processing exceptions
Date: Wed, 22 Aug 2018 11:53:10 +0200
Message-Id: <20180822095310.29145-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When DATA exceptions and vector-processing exceptions (program interrupts)
are injected, the DXC/VXC is also to be stored in the fpc, if AFP is
enabled in CR0.

This can happen inside KVM when reinjecting an interrupt during program
interrupt intercepts. These are triggered for example when debugging the
guest (concurrent PER events result in an intercept instead of an
injection of such interrupts).

Signed-off-by: David Hildenbrand <david@redhat.com>
---

Only compile-tested.

 arch/s390/include/asm/ctl_reg.h | 1 +
 arch/s390/kvm/interrupt.c       | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index 4600453536c2..88f3f14baee9 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -11,6 +11,7 @@
 #include <linux/const.h>
 
 #define CR0_CLOCK_COMPARATOR_SIGN	_BITUL(63 - 10)
+#define CR0_AFP_REGISTER_CONTROL	_BITUL(63 - 45)
 #define CR0_EMERGENCY_SIGNAL_SUBMASK	_BITUL(63 - 49)
 #define CR0_EXTERNAL_CALL_SUBMASK	_BITUL(63 - 50)
 #define CR0_CLOCK_COMPARATOR_SUBMASK	_BITUL(63 - 52)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fcb55b02990e..5b5754d8f460 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -765,6 +765,14 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 		break;
 	case PGM_VECTOR_PROCESSING:
 	case PGM_DATA:
+		if (vcpu->arch.sie_block->gcr[0] & CR0_AFP_REGISTER_CONTROL) {
+			/* make sure the new fpc will be lazily loaded */
+			save_fpu_regs();
+			/* the DXC/VXC cannot make the fpc invalid */
+			current->thread.fpu.fpc &= ~0xff00u;
+			current->thread.fpu.fpc |= (pgm_info.data_exc_code << 8)
+						   & 0xff00u;
+		}
 		rc = put_guest_lc(vcpu, pgm_info.data_exc_code,
 				  (u32 *)__LC_DATA_EXC_CODE);
 		break;
-- 
2.17.1
