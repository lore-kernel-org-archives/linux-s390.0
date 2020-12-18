Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725908AbgLROTB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Dec 2020 09:19:01 -0500
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 4/4] s390/kvm: VSIE: correctly handle MVPG when in VSIE
Date: Fri, 18 Dec 2020 15:18:11 +0100
Message-Id: <20201218141811.310267-5-imbrenda@linux.ibm.com>
In-Reply-To: <20201218141811.310267-1-imbrenda@linux.ibm.com>
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

Correctly handle the MVPG instruction when issued by a VSIE guest.

Fixes: a3508fbe9dc6d ("KVM: s390: vsie: initial support for nested virtualization")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index ada49583e530..6c3069868acd 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -977,6 +977,75 @@ static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
+	unsigned long r1, r2, mask = PAGE_MASK;
+	int rc;
+
+	if (psw_bits(scb_s->gpsw).eaba == PSW_BITS_AMODE_24BIT)
+		mask = 0xfff000;
+	else if (psw_bits(scb_s->gpsw).eaba == PSW_BITS_AMODE_31BIT)
+		mask = 0x7ffff000;
+
+	r1 = vsie_get_register(vcpu, vsie_page, scb_s->ipb >> 20) & mask;
+	r2 = vsie_get_register(vcpu, vsie_page, scb_s->ipb >> 16) & mask;
+	rc = kvm_s390_vsie_mvpg_check(vcpu, r1, r2, &vsie_page->scb_o->mcic);
+
+	/*
+	 * Guest translation was not successful. The host needs to forward
+	 * the intercept to the guest and let the guest fix its page tables.
+	 * The guest needs then to retry the instruction.
+	 */
+	if (rc == -ENOENT)
+		return 1;
+
+	retry_vsie_icpt(vsie_page);
+
+	/*
+	 * Guest translation was not successful. The page tables of the guest
+	 * are broken. Try again and let the hardware deliver the fault.
+	 */
+	if (rc == -EFAULT)
+		return 0;
+
+	/*
+	 * Guest translation was successful. The host needs to fix up its
+	 * page tables and retry the instruction in the nested guest.
+	 * In case of failure, the instruction will intercept again, and
+	 * a different path will be taken.
+	 */
+	if (!rc) {
+		kvm_s390_shadow_fault(vcpu, vsie_page->gmap, r2);
+		kvm_s390_shadow_fault(vcpu, vsie_page->gmap, r1);
+		return 0;
+	}
+
+	/*
+	 * An exception happened during guest translation, it needs to be
+	 * delivered to the guest. This can happen if the host has EDAT1
+	 * enabled and the guest has not, or for other causes. The guest
+	 * needs to process the exception and return to the nested guest.
+	 */
+	if (rc > 0)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
+
+	return 1;
+}
+
 /*
  * Run the vsie on a shadow scb and a shadow gmap, without any further
  * sanity checks, handling SIE faults.
@@ -1063,6 +1132,10 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
