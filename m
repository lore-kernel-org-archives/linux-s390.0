From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/12] KVM: s390: guestdbg: filter PER i-fetch on EXECUTE properly
Date: Wed,  1 Feb 2017 12:38:12 +0100
Message-ID: <1485949094-138708-11-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

When we get a PER i-fetch event on an EXECUTE or EXECUTE RELATIVE LONG
instruction, because the executed instruction generated a PER i-fetch
event, then the PER address points at the EXECUTE function, not the
fetched one.

Therefore, when filtering PER events, we have to take care of the
really fetched instruction, which we can only get by reading in guest
virtual memory.

For icpt code 4 and 56, we directly have additional information about an
EXECUTE instruction at hand. For icpt code 8, we always have to read
in guest virtual memory.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[small fixes]
---
 arch/s390/kvm/guestdbg.c  | 98 ++++++++++++++++++++++++++++++++++++++++++-----
 arch/s390/kvm/intercept.c |  4 +-
 arch/s390/kvm/kvm-s390.h  |  2 +-
 3 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index a207783..23d9a4e 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -436,6 +436,64 @@ static int debug_exit_required(struct kvm_vcpu *vcpu, u8 perc,
 	return 1;
 }
 
+static int per_fetched_addr(struct kvm_vcpu *vcpu, unsigned long *addr)
+{
+	u8 exec_ilen = 0;
+	u16 opcode[3];
+	int rc;
+
+	if (vcpu->arch.sie_block->icptcode == ICPT_PROGI) {
+		/* PER address references the fetched or the execute instr */
+		*addr = vcpu->arch.sie_block->peraddr;
+		/*
+		 * Manually detect if we have an EXECUTE instruction. As
+		 * instructions are always 2 byte aligned we can read the
+		 * first two bytes unconditionally
+		 */
+		rc = read_guest_instr(vcpu, *addr, &opcode, 2);
+		if (rc)
+			return rc;
+		if (opcode[0] >> 8 == 0x44)
+			exec_ilen = 4;
+		if ((opcode[0] & 0xff0f) == 0xc600)
+			exec_ilen = 6;
+	} else {
+		/* instr was suppressed, calculate the responsible instr */
+		*addr = __rewind_psw(vcpu->arch.sie_block->gpsw,
+				     kvm_s390_get_ilen(vcpu));
+		if (vcpu->arch.sie_block->icptstatus & 0x01) {
+			exec_ilen = (vcpu->arch.sie_block->icptstatus & 0x60) >> 4;
+			if (!exec_ilen)
+				exec_ilen = 4;
+		}
+	}
+
+	if (exec_ilen) {
+		/* read the complete EXECUTE instr to detect the fetched addr */
+		rc = read_guest_instr(vcpu, *addr, &opcode, exec_ilen);
+		if (rc)
+			return rc;
+		if (exec_ilen == 6) {
+			/* EXECUTE RELATIVE LONG - RIL-b format */
+			s32 rl = *((s32 *) (opcode + 1));
+
+			/* rl is a _signed_ 32 bit value specifying halfwords */
+			*addr += (u64)(s64) rl * 2;
+		} else {
+			/* EXECUTE - RX-a format */
+			u32 base = (opcode[1] & 0xf000) >> 12;
+			u32 disp = opcode[1] & 0x0fff;
+			u32 index = opcode[0] & 0x000f;
+
+			*addr = base ? vcpu->run->s.regs.gprs[base] : 0;
+			*addr += index ? vcpu->run->s.regs.gprs[index] : 0;
+			*addr += disp;
+		}
+		*addr = kvm_s390_logical_to_effective(vcpu, *addr);
+	}
+	return 0;
+}
+
 #define guest_per_enabled(vcpu) \
 			     (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PER)
 
@@ -449,6 +507,8 @@ int kvm_s390_handle_per_ifetch_icpt(struct kvm_vcpu *vcpu)
 		.per_code = PER_CODE_IFETCH,
 		.per_address = __rewind_psw(vcpu->arch.sie_block->gpsw, ilen),
 	};
+	unsigned long fetched_addr;
+	int rc;
 
 	/*
 	 * The PSW points to the next instruction, therefore the intercepted
@@ -465,21 +525,29 @@ int kvm_s390_handle_per_ifetch_icpt(struct kvm_vcpu *vcpu)
 	    !(vcpu->arch.sie_block->gcr[9] & PER_EVENT_IFETCH))
 		return 0;
 
-	if (in_addr_range(pgm_info.per_address, cr10, cr11))
+	rc = per_fetched_addr(vcpu, &fetched_addr);
+	if (rc < 0)
+		return rc;
+	if (rc)
+		/* instruction-fetching exceptions */
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+
+	if (in_addr_range(fetched_addr, cr10, cr11))
 		return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
 	return 0;
 }
 
-static void filter_guest_per_event(struct kvm_vcpu *vcpu)
+static int filter_guest_per_event(struct kvm_vcpu *vcpu)
 {
 	const u8 perc = vcpu->arch.sie_block->perc;
-	u64 peraddr = vcpu->arch.sie_block->peraddr;
 	u64 addr = vcpu->arch.sie_block->gpsw.addr;
 	u64 cr9 = vcpu->arch.sie_block->gcr[9];
 	u64 cr10 = vcpu->arch.sie_block->gcr[10];
 	u64 cr11 = vcpu->arch.sie_block->gcr[11];
 	/* filter all events, demanded by the guest */
 	u8 guest_perc = perc & (cr9 >> 24) & PER_CODE_MASK;
+	unsigned long fetched_addr;
+	int rc;
 
 	if (!guest_per_enabled(vcpu))
 		guest_perc = 0;
@@ -491,9 +559,17 @@ static void filter_guest_per_event(struct kvm_vcpu *vcpu)
 		guest_perc &= ~PER_CODE_BRANCH;
 
 	/* filter "instruction-fetching" events */
-	if (guest_perc & PER_CODE_IFETCH &&
-	    !in_addr_range(peraddr, cr10, cr11))
-		guest_perc &= ~PER_CODE_IFETCH;
+	if (guest_perc & PER_CODE_IFETCH) {
+		rc = per_fetched_addr(vcpu, &fetched_addr);
+		if (rc < 0)
+			return rc;
+		/*
+		 * Don't inject an irq on exceptions. This would make handling
+		 * on icpt code 8 very complex (as PSW was already rewound).
+		 */
+		if (rc || !in_addr_range(fetched_addr, cr10, cr11))
+			guest_perc &= ~PER_CODE_IFETCH;
+	}
 
 	/* All other PER events will be given to the guest */
 	/* TODO: Check altered address/address space */
@@ -502,6 +578,7 @@ static void filter_guest_per_event(struct kvm_vcpu *vcpu)
 
 	if (!guest_perc)
 		vcpu->arch.sie_block->iprcc &= ~PGM_PER;
+	return 0;
 }
 
 #define pssec(vcpu) (vcpu->arch.sie_block->gcr[1] & _ASCE_SPACE_SWITCH)
@@ -509,15 +586,17 @@ static void filter_guest_per_event(struct kvm_vcpu *vcpu)
 #define old_ssec(vcpu) ((vcpu->arch.sie_block->tecmc >> 31) & 0x1)
 #define old_as_is_home(vcpu) !(vcpu->arch.sie_block->tecmc & 0xffff)
 
-void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu)
+int kvm_s390_handle_per_event(struct kvm_vcpu *vcpu)
 {
-	int new_as;
+	int rc, new_as;
 
 	if (debug_exit_required(vcpu, vcpu->arch.sie_block->perc,
 				vcpu->arch.sie_block->peraddr))
 		vcpu->guest_debug |= KVM_GUESTDBG_EXIT_PENDING;
 
-	filter_guest_per_event(vcpu);
+	rc = filter_guest_per_event(vcpu);
+	if (rc)
+		return rc;
 
 	/*
 	 * Only RP, SAC, SACF, PT, PTI, PR, PC instructions can trigger
@@ -546,4 +625,5 @@ void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu)
 		    (pssec(vcpu) || old_ssec(vcpu)))
 			vcpu->arch.sie_block->iprcc = PGM_SPACE_SWITCH;
 	}
+	return 0;
 }
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 7a27eeb..8b13f70 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -238,7 +238,9 @@ static int handle_prog(struct kvm_vcpu *vcpu)
 	vcpu->stat.exit_program_interruption++;
 
 	if (guestdbg_enabled(vcpu) && per_event(vcpu)) {
-		kvm_s390_handle_per_event(vcpu);
+		rc = kvm_s390_handle_per_event(vcpu);
+		if (rc)
+			return rc;
 		/* the interrupt might have been filtered out completely */
 		if (vcpu->arch.sie_block->iprcc == 0)
 			return 0;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 22a0a7c..af9fa91 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -377,7 +377,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 void kvm_s390_clear_bp_data(struct kvm_vcpu *vcpu);
 void kvm_s390_prepare_debug_exit(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_per_ifetch_icpt(struct kvm_vcpu *vcpu);
-void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_per_event(struct kvm_vcpu *vcpu);
 
 /* support for Basic/Extended SCA handling */
 static inline union ipte_control *kvm_s390_get_ipte_control(struct kvm *kvm)
-- 
2.7.4
