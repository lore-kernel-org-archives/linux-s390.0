From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: inject PER i-fetch events on applicable icpts
Date: Tue,  5 Jul 2016 14:21:19 +0200
Message-ID: <1467721279-206526-2-git-send-email-borntraeger@de.ibm.com>
References: <1467721279-206526-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1467721279-206526-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

In case we have to emuluate an instruction or part of it (instruction,
partial instruction, operation exception), we have to inject a PER
instruction-fetching event for that instruction, if hardware told us to do
so.

In case we retry an instruction, we must not inject the PER event.

Please note that we don't filter the events properly yet, so guest
debugging will be visible for the guest.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c  | 17 +++++++++++++++++
 arch/s390/kvm/intercept.c | 17 ++++++++++++++---
 arch/s390/kvm/kvm-s390.h  |  3 +++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 1e0849e..31a0533 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -439,6 +439,23 @@ exit_required:
 #define guest_per_enabled(vcpu) \
 			     (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PER)
 
+int kvm_s390_handle_per_ifetch_icpt(struct kvm_vcpu *vcpu)
+{
+	const u8 ilen = kvm_s390_get_ilen(vcpu);
+	struct kvm_s390_pgm_info pgm_info = {
+		.code = PGM_PER,
+		.per_code = PER_EVENT_IFETCH >> 24,
+		.per_address = __rewind_psw(vcpu->arch.sie_block->gpsw, ilen),
+	};
+
+	/*
+	 * The PSW points to the next instruction, therefore the intercepted
+	 * instruction generated a PER i-fetch event. PER address therefore
+	 * points at the previous PSW address (could be an EXECUTE function).
+	 */
+	return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
+}
+
 static void filter_guest_per_event(struct kvm_vcpu *vcpu)
 {
 	u32 perc = vcpu->arch.sie_block->perc << 24;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 9359f65..850be47 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -364,6 +364,8 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
 
 int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 {
+	int rc, per_rc = 0;
+
 	if (kvm_is_ucontrol(vcpu->kvm))
 		return -EOPNOTSUPP;
 
@@ -372,7 +374,8 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 	case 0x18:
 		return handle_noop(vcpu);
 	case 0x04:
-		return handle_instruction(vcpu);
+		rc = handle_instruction(vcpu);
+		break;
 	case 0x08:
 		return handle_prog(vcpu);
 	case 0x14:
@@ -384,10 +387,18 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 	case 0x28:
 		return handle_stop(vcpu);
 	case 0x2c:
-		return handle_operexc(vcpu);
+		rc = handle_operexc(vcpu);
+		break;
 	case 0x38:
-		return handle_partial_execution(vcpu);
+		rc = handle_partial_execution(vcpu);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
+
+	/* process PER, also if the instrution is processed in user space */
+	if (vcpu->arch.sie_block->icptstatus & 0x02 &&
+	    (!rc || rc == -EOPNOTSUPP))
+		per_rc = kvm_s390_handle_per_ifetch_icpt(vcpu);
+	return per_rc ? per_rc : rc;
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 031f451..b843286 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -238,6 +238,8 @@ static inline void kvm_s390_forward_psw(struct kvm_vcpu *vcpu, int ilen)
 }
 static inline void kvm_s390_retry_instr(struct kvm_vcpu *vcpu)
 {
+	/* don't inject PER events if we re-execute the instruction */
+	vcpu->arch.sie_block->icptstatus &= ~0x02;
 	kvm_s390_rewind_psw(vcpu, kvm_s390_get_ilen(vcpu));
 }
 
@@ -377,6 +379,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 			    struct kvm_guest_debug *dbg);
 void kvm_s390_clear_bp_data(struct kvm_vcpu *vcpu);
 void kvm_s390_prepare_debug_exit(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_per_ifetch_icpt(struct kvm_vcpu *vcpu);
 void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu);
 
 /* support for Basic/Extended SCA handling */
-- 
2.5.5
