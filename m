Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232317AbhBIPnu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 10:43:50 -0500
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 2/2] s390/kvm: VSIE: correctly handle MVPG when in VSIE
Date: Tue,  9 Feb 2021 16:43:02 +0100
Message-Id: <20210209154302.1033165-3-imbrenda@linux.ibm.com>
In-Reply-To: <20210209154302.1033165-1-imbrenda@linux.ibm.com>
References: <20210209154302.1033165-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

Correctly handle the MVPG instruction when issued by a VSIE guest.

Fixes: a3508fbe9dc6d ("KVM: s390: vsie: initial support for nested virtualization")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 93 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 7db022141db3..7dbb0d93c25f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -416,11 +416,6 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		memcpy((void *)((u64)scb_o + 0xc0),
 		       (void *)((u64)scb_s + 0xc0), 0xf0 - 0xc0);
 		break;
-	case ICPT_PARTEXEC:
-		/* MVPG only */
-		memcpy((void *)((u64)scb_o + 0xc0),
-		       (void *)((u64)scb_s + 0xc0), 0xd0 - 0xc0);
-		break;
 	}
 
 	if (scb_s->ihcpu != 0xffffU)
@@ -982,6 +977,90 @@ static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+static u64 vsie_get_register(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, u8 reg)
+{
+	reg &= 0xf;
+	switch (reg) {
+	case 15:
+		return vsie_page->scb_s.gg15;
+	case 14:
+		return vsie_page->scb_s.gg14;
+	default:
+		return vcpu->run->s.regs.gprs[reg];
+	}
+}
+
+static int vsie_handle_mvpg(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	unsigned long pei_dest, pei_src, src, dest, mask = PAGE_MASK;
+	u64 *pei_block = &vsie_page->scb_o->mcic;
+	int edat, rc_dest, rc_src;
+	union ctlreg0 cr0;
+
+	cr0.val = vcpu->arch.sie_block->gcr[0];
+	edat = cr0.edat && test_kvm_facility(vcpu->kvm, 8);
+	if (psw_bits(scb_s->gpsw).eaba == PSW_BITS_AMODE_24BIT)
+		mask = 0xfff000;
+	else if (psw_bits(scb_s->gpsw).eaba == PSW_BITS_AMODE_31BIT)
+		mask = 0x7ffff000;
+
+	dest = vsie_get_register(vcpu, vsie_page, scb_s->ipb >> 16) & mask;
+	src = vsie_get_register(vcpu, vsie_page, scb_s->ipb >> 20) & mask;
+
+	rc_dest = kvm_s390_shadow_fault(vcpu, vsie_page->gmap, dest, &pei_dest);
+	rc_src = kvm_s390_shadow_fault(vcpu, vsie_page->gmap, src, &pei_src);
+	/*
+	 * Either everything went well, or something non-critical went wrong
+	 * e.g. beause of a race. In either case, simply retry.
+	 */
+	if (rc_dest == -EAGAIN || rc_src == -EAGAIN || (!rc_dest && !rc_src)) {
+		retry_vsie_icpt(vsie_page);
+		return -EAGAIN;
+	}
+	/* Something more serious went wrong, propagate the error */
+	if (rc_dest < 0)
+		return rc_dest;
+	if (rc_src < 0)
+		return rc_src;
+
+	/* The only possible suppressing exception: just deliver it */
+	if (rc_dest == PGM_TRANSLATION_SPEC || rc_src == PGM_TRANSLATION_SPEC) {
+		clear_vsie_icpt(vsie_page);
+		rc_dest = kvm_s390_inject_program_int(vcpu, PGM_TRANSLATION_SPEC);
+		WARN_ON_ONCE(rc_dest);
+		return 1;
+	}
+
+	/*
+	 * Forward the PEI intercept to the guest if it was a page fault, or
+	 * also for segment and region table faults if EDAT applies.
+	 */
+	if (edat) {
+		rc_dest = rc_dest == PGM_ASCE_TYPE ? rc_dest : 0;
+		rc_src = rc_src == PGM_ASCE_TYPE ? rc_src : 0;
+	} else {
+		rc_dest = rc_dest != PGM_PAGE_TRANSLATION ? rc_dest : 0;
+		rc_src = rc_src != PGM_PAGE_TRANSLATION ? rc_src : 0;
+	}
+	if (!rc_dest && !rc_src) {
+		pei_block[0] = pei_dest;
+		pei_block[1] = pei_src;
+		return 1;
+	}
+
+	retry_vsie_icpt(vsie_page);
+
+	/*
+	 * The host has edat, and the guest does not, or it was an ASCE type
+	 * exception. The host needs to inject the appropriate DAT interrupts
+	 * into the guest.
+	 */
+	if (rc_dest)
+		return inject_fault(vcpu, rc_dest, dest, 1);
+	return inject_fault(vcpu, rc_src, src, 0);
+}
+
 /*
  * Run the vsie on a shadow scb and a shadow gmap, without any further
  * sanity checks, handling SIE faults.
@@ -1068,6 +1147,10 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		if ((scb_s->ipa & 0xf000) != 0xf000)
 			scb_s->ipa += 0x1000;
 		break;
+	case ICPT_PARTEXEC:
+		if (scb_s->ipa == 0xb254)
+			rc = vsie_handle_mvpg(vcpu, vsie_page);
+		break;
 	}
 	return rc;
 }
-- 
2.26.2
