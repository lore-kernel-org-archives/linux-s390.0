From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/11] KVM: s390: guestdbg: separate defines for per code
Date: Thu,  8 Sep 2016 14:00:18 +0200
Message-ID: <1473336023-15522-7-git-send-email-borntraeger@de.ibm.com>
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

Let's avoid working with the PER_EVENT* defines, used for control register
manipulation, when checking the u8 PER code. Introduce separate defines
based on the existing defines.

Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 31a0533..d1f8241 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -382,14 +382,20 @@ void kvm_s390_prepare_debug_exit(struct kvm_vcpu *vcpu)
 	vcpu->guest_debug &= ~KVM_GUESTDBG_EXIT_PENDING;
 }
 
+#define PER_CODE_MASK		(PER_EVENT_MASK >> 24)
+#define PER_CODE_BRANCH		(PER_EVENT_BRANCH >> 24)
+#define PER_CODE_IFETCH		(PER_EVENT_IFETCH >> 24)
+#define PER_CODE_STORE		(PER_EVENT_STORE >> 24)
+#define PER_CODE_STORE_REAL	(PER_EVENT_STORE_REAL >> 24)
+
 #define per_bp_event(code) \
-			(code & (PER_EVENT_IFETCH | PER_EVENT_BRANCH))
+			(code & (PER_CODE_IFETCH | PER_CODE_BRANCH))
 #define per_write_wp_event(code) \
-			(code & (PER_EVENT_STORE | PER_EVENT_STORE_REAL))
+			(code & (PER_CODE_STORE | PER_CODE_STORE_REAL))
 
 static int debug_exit_required(struct kvm_vcpu *vcpu)
 {
-	u32 perc = (vcpu->arch.sie_block->perc << 24);
+	u8 perc = vcpu->arch.sie_block->perc;
 	struct kvm_debug_exit_arch *debug_exit = &vcpu->run->debug.arch;
 	struct kvm_hw_wp_info_arch *wp_info = NULL;
 	struct kvm_hw_bp_info_arch *bp_info = NULL;
@@ -444,7 +450,7 @@ int kvm_s390_handle_per_ifetch_icpt(struct kvm_vcpu *vcpu)
 	const u8 ilen = kvm_s390_get_ilen(vcpu);
 	struct kvm_s390_pgm_info pgm_info = {
 		.code = PGM_PER,
-		.per_code = PER_EVENT_IFETCH >> 24,
+		.per_code = PER_CODE_IFETCH,
 		.per_address = __rewind_psw(vcpu->arch.sie_block->gpsw, ilen),
 	};
 
@@ -458,33 +464,33 @@ int kvm_s390_handle_per_ifetch_icpt(struct kvm_vcpu *vcpu)
 
 static void filter_guest_per_event(struct kvm_vcpu *vcpu)
 {
-	u32 perc = vcpu->arch.sie_block->perc << 24;
+	const u8 perc = vcpu->arch.sie_block->perc;
 	u64 peraddr = vcpu->arch.sie_block->peraddr;
 	u64 addr = vcpu->arch.sie_block->gpsw.addr;
 	u64 cr9 = vcpu->arch.sie_block->gcr[9];
 	u64 cr10 = vcpu->arch.sie_block->gcr[10];
 	u64 cr11 = vcpu->arch.sie_block->gcr[11];
 	/* filter all events, demanded by the guest */
-	u32 guest_perc = perc & cr9 & PER_EVENT_MASK;
+	u8 guest_perc = perc & (cr9 >> 24) & PER_CODE_MASK;
 
 	if (!guest_per_enabled(vcpu))
 		guest_perc = 0;
 
 	/* filter "successful-branching" events */
-	if (guest_perc & PER_EVENT_BRANCH &&
+	if (guest_perc & PER_CODE_BRANCH &&
 	    cr9 & PER_CONTROL_BRANCH_ADDRESS &&
 	    !in_addr_range(addr, cr10, cr11))
-		guest_perc &= ~PER_EVENT_BRANCH;
+		guest_perc &= ~PER_CODE_BRANCH;
 
 	/* filter "instruction-fetching" events */
-	if (guest_perc & PER_EVENT_IFETCH &&
+	if (guest_perc & PER_CODE_IFETCH &&
 	    !in_addr_range(peraddr, cr10, cr11))
-		guest_perc &= ~PER_EVENT_IFETCH;
+		guest_perc &= ~PER_CODE_IFETCH;
 
 	/* All other PER events will be given to the guest */
 	/* TODO: Check altered address/address space */
 
-	vcpu->arch.sie_block->perc = guest_perc >> 24;
+	vcpu->arch.sie_block->perc = guest_perc;
 
 	if (!guest_perc)
 		vcpu->arch.sie_block->iprcc &= ~PGM_PER;
-- 
2.5.5
