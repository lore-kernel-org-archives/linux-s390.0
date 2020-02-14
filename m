Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728002AbgBNW11 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:27 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 21/42] KVM: s390: protvirt: handle secure guest prefix pages
Date: Fri, 14 Feb 2020 17:26:37 -0500
Message-Id: <20200214222658.12946-22-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

The SPX instruction is handled by the ultravisor. We do get a
notification intercept, though. Let us update our internal view.

In addition to that, when the guest prefix page is not secure, an
intercept 112 (0x70) is indicated. Let us make the prefix pages
secure again.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/intercept.c        | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index aa945b101fff..0ea82152d2f7 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -225,6 +225,7 @@ struct kvm_s390_sie_block {
 #define ICPT_INT_ENABLE	0x64
 #define ICPT_PV_INSTR	0x68
 #define ICPT_PV_NOTIFY	0x6c
+#define ICPT_PV_PREF	0x70
 	__u8	icptcode;		/* 0x0050 */
 	__u8	icptstatus;		/* 0x0051 */
 	__u16	ihcpu;			/* 0x0052 */
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index db3dd5ee0b7a..6c9db886381c 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -451,6 +451,15 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
 	return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 }
 
+static int handle_pv_spx(struct kvm_vcpu *vcpu)
+{
+	u32 pref = *(u32 *)vcpu->arch.sie_block->sidad;
+
+	kvm_s390_set_prefix(vcpu, pref);
+	trace_kvm_s390_handle_prefix(vcpu, 1, pref);
+	return 0;
+}
+
 static int handle_pv_sclp(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
@@ -477,6 +486,8 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
 
 static int handle_pv_notification(struct kvm_vcpu *vcpu)
 {
+	if (vcpu->arch.sie_block->ipa == 0xb210)
+		return handle_pv_spx(vcpu);
 	if (vcpu->arch.sie_block->ipa == 0xb220)
 		return handle_pv_sclp(vcpu);
 
@@ -534,6 +545,13 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 	case ICPT_PV_NOTIFY:
 		rc = handle_pv_notification(vcpu);
 		break;
+	case ICPT_PV_PREF:
+		rc = 0;
+		gmap_convert_to_secure(vcpu->arch.gmap,
+				       kvm_s390_get_prefix(vcpu));
+		gmap_convert_to_secure(vcpu->arch.gmap,
+				       kvm_s390_get_prefix(vcpu) + PAGE_SIZE);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.25.0
