From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/12] KVM: s390: expose no-DAT to guest and migration support
Date: Wed, 30 Aug 2017 09:54:09 +0200
Message-ID: <1504079650-82735-5-git-send-email-borntraeger@de.ibm.com>
References: <1504079650-82735-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1504079650-82735-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

The STFLE bit 147 indicates whether the ESSA no-DAT operation code is
valid, the bit is not normally provided to the host; the host is
instead provided with an SCLP bit that indicates whether guests can
support the feature.

This patch:
* enables the STFLE bit in the guest if the corresponding SCLP bit is
  present in the host.
* adds support for migrating the no-DAT bit in the PGSTEs
* fixes the software interpretation of the ESSA instruction that is
  used when migrating, both for the new operation code and for the old
  "set stable", as per specifications.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/page-states.h | 2 +-
 arch/s390/kvm/kvm-s390.c            | 8 ++++++--
 arch/s390/kvm/priv.c                | 6 +++++-
 arch/s390/mm/pgtable.c              | 6 +++++-
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/page-states.h b/arch/s390/include/asm/page-states.h
index ca21b28..22b0f49 100644
--- a/arch/s390/include/asm/page-states.h
+++ b/arch/s390/include/asm/page-states.h
@@ -15,6 +15,6 @@
 #define ESSA_SET_STABLE_IF_RESIDENT	6
 #define ESSA_SET_STABLE_NODAT		7
 
-#define ESSA_MAX	ESSA_SET_STABLE_IF_RESIDENT
+#define ESSA_MAX	ESSA_SET_STABLE_NODAT
 
 #endif
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e65b763..84c069a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1574,7 +1574,7 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 		if (r < 0)
 			pgstev = 0;
 		/* save the value */
-		res[i++] = (pgstev >> 24) & 0x3;
+		res[i++] = (pgstev >> 24) & 0x43;
 		/*
 		 * if the next bit is too far away, stop.
 		 * if we reached the previous "next", find the next one
@@ -1652,7 +1652,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 
 		pgstev = bits[i];
 		pgstev = pgstev << 24;
-		mask &= _PGSTE_GPS_USAGE_MASK;
+		mask &= _PGSTE_GPS_USAGE_MASK | _PGSTE_GPS_NODAT;
 		set_pgste_bits(kvm->mm, hva, mask, pgstev);
 	}
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
@@ -1929,6 +1929,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	set_kvm_facility(kvm->arch.model.fac_mask, 74);
 	set_kvm_facility(kvm->arch.model.fac_list, 74);
+	if (MACHINE_HAS_TLB_GUEST) {
+		set_kvm_facility(kvm->arch.model.fac_mask, 147);
+		set_kvm_facility(kvm->arch.model.fac_list, 147);
+	}
 
 	kvm->arch.model.cpuid = kvm_s390_get_initial_cpuid();
 	kvm->arch.model.ibc = sclp.ibc & 0x0fff;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 8a1dac7..91dc4a8 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -988,6 +988,8 @@ static inline int do_essa(struct kvm_vcpu *vcpu, const int orc)
 		if (pgstev & _PGSTE_GPS_ZERO)
 			res |= 1;
 	}
+	if (pgstev & _PGSTE_GPS_NODAT)
+		res |= 0x20;
 	vcpu->run->s.regs.gprs[r1] = res;
 	/*
 	 * It is possible that all the normal 511 slots were full, in which case
@@ -1027,7 +1029,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 	/* Check for invalid operation request code */
 	orc = (vcpu->arch.sie_block->ipb & 0xf0000000) >> 28;
-	if (orc > ESSA_MAX)
+	/* ORCs 0-6 are always valid */
+	if (orc > (test_kvm_facility(vcpu->kvm, 147) ? ESSA_SET_STABLE_NODAT
+						: ESSA_SET_STABLE_IF_RESIDENT))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	if (likely(!vcpu->kvm->arch.migration_state)) {
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 8d018c7..459716d 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -919,7 +919,7 @@ int pgste_perform_essa(struct mm_struct *mm, unsigned long hva, int orc,
 	case ESSA_GET_STATE:
 		break;
 	case ESSA_SET_STABLE:
-		pgstev &= ~_PGSTE_GPS_USAGE_MASK;
+		pgstev &= ~(_PGSTE_GPS_USAGE_MASK | _PGSTE_GPS_NODAT);
 		pgstev |= _PGSTE_GPS_USAGE_STABLE;
 		break;
 	case ESSA_SET_UNUSED:
@@ -965,6 +965,10 @@ int pgste_perform_essa(struct mm_struct *mm, unsigned long hva, int orc,
 			pgstev |= _PGSTE_GPS_USAGE_STABLE;
 		}
 		break;
+	case ESSA_SET_STABLE_NODAT:
+		pgstev &= ~_PGSTE_GPS_USAGE_MASK;
+		pgstev |= _PGSTE_GPS_USAGE_STABLE | _PGSTE_GPS_NODAT;
+		break;
 	default:
 		/* we should never get here! */
 		break;
-- 
2.7.4
