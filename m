Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CC3F44D3;
	Mon, 15 Jun 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527381; cv=none; b=MK3evV0R5v7K3SvFeANJdVA2MSQxP5k88lDJO+JsrQ1qwvGjQORLlkYyco18Wz+kagXXkiKo03eDscsemJKiGZM0MG4jAyqeWQ3pykChrUGNUnqDNSdpCVDQjXr+NxpUVa2BTjAQofMNLFuqO333jnh0K46v8hcLHrI1tHvj9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527381; c=relaxed/simple;
	bh=xACm6oJXpz7EAfQrjt4a0PzeZuF7aKmHh8aTnvkNGP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KViA+D/hlbt0dYa922Ue1PR+l/BEzcdgFPaeNfcm5Ul6DedWCPBcWCyrh7lz96GMKHvm5ADjJeQ2ubIFdTz+lk7YgXtRT4UFWNl6LeCxYY7xSBHaJjNBV4zsHuWKwyRMqZoNxzS2FkuPOjCoSkhgiT5xNUJRKS9QzlVfNCwy/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fsYfI17x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fsYfI17x"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAnvhl2208572;
	Mon, 15 Jun 2026 12:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NIiB8L2WNne0zpiUq
	SNh5dRXJWlztg/FL+EJ83XcPpY=; b=fsYfI17xngb+WsuCne24IdbNmd/O6fB7Z
	F4+VihJ+G+72zhCR5AhBnQoUp+wwKCoRXenfd01UbX9yU9SOfFavUybtkoaMSwMp
	QsiOVLKwwDcigEo4xEstJStPBlqjLEIuv8bmfq7QcTgkYT1fZQRZhuGnv2y39ne9
	iV70Qd8KYSZOnjGrF2tuSpb923f9QGe8e5+bE7padRMGgd47w7ASlbycqc4VrRKK
	P56GF5yJtqgO52Bp3Xvbgu4mWumHIiBsMKtJODEELNecjJCNqpGpl6j6oqhQhdwE
	cPYUOV98/wFIZuNh04Hp/UtjyRIttIx6jC7F1ZpXlq68CYy30MJWw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm0g7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYatZ003688;
	Mon, 15 Jun 2026 12:42:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7xxauc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgpon59638266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D44320043;
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 058F520040;
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:50 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 14/17] KVM: s390: vsie: Implement ASTFLEIE facility 2
Date: Mon, 15 Jun 2026 14:42:40 +0200
Message-ID: <20260615124243.187614-15-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX3st2RVeqsYi7
 s8uOqofFGBxnFd5Ih8wtSAdJ0oavOsP86uY1lyZKwag799YxI2OEXpeEcFSkzxQbGjVPM1Inp+Z
 tq2Y4jwm6Mz3+hjJMjlC5cxF2ctg/hk=
X-Proofpoint-GUID: TEaktr-p68AIT70rixvP_UcU1_OTw85d
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2ff352 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=F8FVqei25e47uhyEDlAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXwHLzhCWiF6OC
 k5Ou8kDRF1B29IOJ5fkAjU68EUfubqFZJ/6HIJpoBv5zyPJpp9DReg9uS1xPP501pXu2hXwhbwY
 x1iUCaxT2uTQFb5SUtxZBvk2pe8us3eNLboVIMep7FHOU9xgH0TXcVZtPT21W9fAIwi9po4gu6n
 4jB4KVdUzm3V3ujzWW/YUMeA5nhvAdnCzKiHpQqzTPikXcolK7gIx+P0vDYSpHqFEi63yL/986Q
 v4844bOkMJG8o0aokXwV4mPA4JpZY8WcoZsFQnmwlclikR/J/QjJIsv3Js4edYyM6sUBdl8TkNX
 wVn+AJMEXhpBa/SEXkr0rAJoqfxgt4QhSKN7s33pbRxb9UnZiZKvNt+mYsTNnQ1c2yWdjsIY1Sf
 WdJL8XZvKMyz801kD8odY3xwAvvcFnDEqA9t8I535qyLDitRcOHQPeLtHGubbN0aDfwbJtMoe0c
 kQ1YgqrTd795fET+KkQ==
X-Proofpoint-ORIG-GUID: TEaktr-p68AIT70rixvP_UcU1_OTw85d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Implement shadowing of format-2 facility list when running in VSIE.

ASTFLEIE2 is available since IBM z16.
To function G1 has to run this KVM code and G1 and G2 have to run QEMU
with ASTFLEIE2 support.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
[imbrenda@linux.ibm.com: Fix typo in comment]
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260612-vsie-alter-stfle-fac-v4-4-74f0e1559929@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 12 +++++++++++
 arch/s390/kvm/kvm-s390.c         |  2 ++
 arch/s390/kvm/vsie.c             | 34 ++++++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8a4f4a39f7a2..aa4c4685f95c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -504,6 +504,18 @@ struct kvm_s390_cpu_model {
 	struct kvm_s390_vm_cpu_uv_feat uv_feat_guest;
 };
 
+#define S390_ARCH_FAC_FORMAT_2 2
+struct kvm_s390_flcb2 {
+	union {
+		struct {
+			u8 reserved0[7];
+			u8 length;
+		};
+		u64 header_val;
+	};
+	u64 facilities[S390_ARCH_FAC_LIST_SIZE_U64];
+};
+
 typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
 
 struct kvm_s390_crypto {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7334c160d019..de28ee1f7882 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -465,6 +465,8 @@ static void __init kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_IBS);
 	if (sclp.has_kss)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
+	if (sclp.has_astfleie2)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
 	/*
 	 * KVM_S390_VM_CPU_FEAT_SKEY: Wrong shadow of PTE.I bits will make
 	 * all skey handling functions read/set the skey from the PGSTE
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c7dcdd460dd1..eea24562e7db 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -65,9 +65,9 @@ struct vsie_page {
 	gpa_t scb_gpa;				/* 0x0258 */
 	/* the shadow gmap in use by the vsie_page */
 	struct gmap_cache gmap_cache;		/* 0x0260 */
-	__u8 reserved[0x0700 - 0x0278];		/* 0x0278 */
-	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
-	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
+	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
+	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
+	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x07f8 */
 };
 
 static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
@@ -1020,6 +1020,28 @@ static int handle_stfle_0(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	return 0;
 }
 
+static int handle_stfle_2(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, u32 fac_list_origin)
+{
+	struct kvm_s390_flcb2 *flcb_s = (struct kvm_s390_flcb2 *)vsie_page->fac;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	u64 len;
+
+	if (read_guest_real(vcpu, fac_list_origin, &len, sizeof(len)))
+		return set_validity_icpt(scb_s, 0x1090U);
+
+	/* discard reserved bits */
+	len = (len & U8_MAX);
+	flcb_s->header_val = len;
+	len += 1;
+
+	if (read_guest_real(vcpu, fac_list_origin + offsetof(struct kvm_s390_flcb2, facilities),
+			    &flcb_s->facilities, len * sizeof(u64)))
+		return set_validity_icpt(scb_s, 0x1090U);
+
+	scb_s->fac = (u32)virt_to_phys(&vsie_page->fac) | S390_ARCH_FAC_FORMAT_2;
+	return 0;
+}
+
 /*
  * Try to shadow + enable the guest 2 provided facility list.
  * Retry instruction execution if enabled for and provided by guest 2.
@@ -1034,6 +1056,8 @@ static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	int format_mask, format;
 	u32 origin;
 
+	/* assert no overflow with maximum len */
+	BUILD_BUG_ON(sizeof(vsie_page->fac) < ((S390_ARCH_FAC_LIST_SIZE_U64 + 1) * sizeof(u64)));
 	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct vsie_page, fac), 8));
 
 	if (fac && test_kvm_facility(vcpu->kvm, 7)) {
@@ -1049,9 +1073,11 @@ static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		case 0:
 			return handle_stfle_0(vcpu, vsie_page, origin);
 		case 1:
+			return set_validity_icpt(&vsie_page->scb_s, 0x1330U);
 		case 2:
+			return handle_stfle_2(vcpu, vsie_page, origin);
 		case 3:
-			unreachable();
+			return set_validity_icpt(&vsie_page->scb_s, 0x1330U);
 		}
 	}
 	return 0;
-- 
2.54.0

