From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/8] s390/kvm: Provide a way to prevent reentering SIE
Date: Fri, 17 May 2013 14:41:35 +0200
Message-ID: <1368794498-2051-6-git-send-email-borntraeger@de.ibm.com>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Lets provide functions to prevent KVM from reentering SIE and
to kick cpus out of SIE. We cannot use the common kvm_vcpu_kick code,
since we need to kick out guests in places that hold architecture
specific locks (e.g. pgste lock) which might be necessary on the
other cpus - so no waiting possible.

So lets provide a bit in a private field of the sie control block
that acts as a gate keeper, after we claimed we are in SIE.
Please note that we do not reuse prog0c, since we want to access
that bit without atomic ops.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  5 ++++-
 arch/s390/kernel/asm-offsets.c   |  1 +
 arch/s390/kernel/entry64.S       |  4 +++-
 arch/s390/kvm/kvm-s390.c         | 28 ++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h         |  4 ++++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 962b92e..9a809f9 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -71,7 +71,10 @@ struct kvm_s390_sie_block {
 	__u8	reserved08[4];		/* 0x0008 */
 #define PROG_IN_SIE (1<<0)
 	__u32	prog0c;			/* 0x000c */
-	__u8	reserved10[24];		/* 0x0010 */
+	__u8	reserved10[16];		/* 0x0010 */
+#define PROG_BLOCK_SIE 0x00000001
+	atomic_t prog20;		/* 0x0020 */
+	__u8	reserved24[4];		/* 0x0024 */
 	__u64	cputm;			/* 0x0028 */
 	__u64	ckc;			/* 0x0030 */
 	__u64	epoch;			/* 0x0038 */
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 6456bbe..78db633 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -163,6 +163,7 @@ int main(void)
 	DEFINE(__THREAD_trap_tdb, offsetof(struct task_struct, thread.trap_tdb));
 	DEFINE(__GMAP_ASCE, offsetof(struct gmap, asce));
 	DEFINE(__SIE_PROG0C, offsetof(struct kvm_s390_sie_block, prog0c));
+	DEFINE(__SIE_PROG20, offsetof(struct kvm_s390_sie_block, prog20));
 #endif /* CONFIG_32BIT */
 	return 0;
 }
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index c2e81b4..c7daeef 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -958,7 +958,9 @@ sie_loop:
 	lctlg	%c1,%c1,__GMAP_ASCE(%r14)	# load primary asce
 sie_gmap:
 	lg	%r14,__SF_EMPTY(%r15)		# get control block pointer
-	oi	__SIE_PROG0C+3(%r14),1		# we are in SIE now
+	oi	__SIE_PROG0C+3(%r14),1		# we are going into SIE now
+	tm	__SIE_PROG20+3(%r14),1		# last exit...
+	jnz	sie_done
 	LPP	__SF_EMPTY(%r15)		# set guest id
 	sie	0(%r14)
 sie_done:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c1c7c68..ef4ef21 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -454,6 +454,34 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+void s390_vcpu_block(struct kvm_vcpu *vcpu)
+{
+	atomic_set_mask(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
+}
+
+void s390_vcpu_unblock(struct kvm_vcpu *vcpu)
+{
+	atomic_clear_mask(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
+}
+
+/*
+ * Kick a guest cpu out of SIE and wait until SIE is not running.
+ * If the CPU is not running (e.g. waiting as idle) the function will
+ * return immediately. */
+void exit_sie(struct kvm_vcpu *vcpu)
+{
+	atomic_set_mask(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
+	while (vcpu->arch.sie_block->prog0c & PROG_IN_SIE)
+		cpu_relax();
+}
+
+/* Kick a guest cpu out of SIE and prevent SIE-reentry */
+void exit_sie_sync(struct kvm_vcpu *vcpu)
+{
+	s390_vcpu_block(vcpu);
+	exit_sie(vcpu);
+}
+
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	/* kvm common code refers to this, but never calls it */
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index efc14f6..7a8abfd 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -133,6 +133,10 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 /* implemented in kvm-s390.c */
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu,
 				 unsigned long addr);
+void s390_vcpu_block(struct kvm_vcpu *vcpu);
+void s390_vcpu_unblock(struct kvm_vcpu *vcpu);
+void exit_sie(struct kvm_vcpu *vcpu);
+void exit_sie_sync(struct kvm_vcpu *vcpu);
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 
-- 
1.8.1.4
