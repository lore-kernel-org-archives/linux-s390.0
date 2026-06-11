Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4023AE6F3;
	Thu, 11 Jun 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193299; cv=none; b=HJJZ/2J/aGV7BeJ35x52hfLkef4HGcC2LH95ZVP2MxxLOynhizSaiiXQEeF17R5hewd2LU5GzB1R51cmXOVDLYhdiIzCA95JcKav55Z+KL/C7+CaAKqYFTCZCd9x7NOCGXYtQTU9HyGyyk7D5IQhWK2FGVuHUX7EeZbwZL08oRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193299; c=relaxed/simple;
	bh=vxqISdFxtg0Sm4ibwG8+KJWqZWfnFtnMk0add8vluX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SbaPxwFSZkJlrRE4ovGykwxSgsSkJNlmvYPC8nElv52Dk4nQOD2pmODH4n4/s4CxW8z1LZN+RuM6CXekpX54wnersSN6TVIrZa/1hkKXUh3TM8KBXwTwCZ8JjjYzD9vng4q/8dPU4WkR9ngZ7CxNfLoswGSdAue2EG9SZlU7AHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e00cjty6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e00cjty6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BAvLlv1742344;
	Thu, 11 Jun 2026 15:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G2CEyj
	JIxy8SlXQ6vu12NYtdN4MiMi6otvpked9XlAw=; b=e00cjty6YT9i7CWCFlcT/S
	MV7eQFdxILywxrroWiv8/7TXvk+3ClvYy4k4LODiyzL8K0Okqyy/9BLo8I5aOuGP
	WeWpNpkddwJima4Ax5cIGHr5Xh5lx/NY99N4/plFUENM6J6nPzxfWKrj5kCxhc0d
	eYR3P/3ZNFyQ0ZmwCypBLMLrTBivq9viY2n7luoC6eDUCcq7hwtoHXvrtxSPB0jh
	mFPC41HMFnf8t03kxZue2BKRwkFFksz7Lemt/6ZK7Ry85nXww2uzqoWm+/poCt3c
	QMsyoaitVSYRyN5ajC+OSoylbBuh/nr6iOFJP/y1EnQe1Icu7iOn+8dZZVN+x48g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bmhp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BFnorm022557;
	Thu, 11 Jun 2026 15:54:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09kv1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BFsqkI30146876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:54:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3D0320043;
	Thu, 11 Jun 2026 15:54:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53B8C20040;
	Thu, 11 Jun 2026 15:54:52 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.87.150.222])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:54:52 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 11 Jun 2026 17:54:34 +0200
Subject: [PATCH v3 4/4] KVM: s390: vsie: Implement ASTFLEIE facility 2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-vsie-alter-stfle-fac-v3-4-b1a35efedaba@linux.ibm.com>
References: <20260611-vsie-alter-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com>
In-Reply-To: <20260611-vsie-alter-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4290;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=o/Ue80IWbtL7ROLxZuUMQMnP57MflFG2QlNcoFU8U5g=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlatzy5CzvmeXKF/TF66+D5MNBKqXPuZo6aG27ab4/4X
 mo7/vlMRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABN5uoDhn34CY+1t5r+cPFNm
 sAv7TNH/eNw48f2aHZ5vah5ZS+1VXMfIsN7n4Vf/1zvmSm/493qZwuWr26b5aK/mOPNvxs7pHxv
 VW3kA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2ada51 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfX22jYeTVnjMoG
 Jg1Ck6+cb8PzsZh5PWV710Mb4NtX2aPiB6CIOCiIN6j16RXCojTK6C2V46JLzI/+c5NBxB2kpSe
 tumCSvGr2kTKNvM4mZaVHezb+NIGLblIbi9EpyiVRQpJBsl4gn9cREQOSnYBemyY4oqsW8HGFfw
 LQRB/VcdI8FX+le/NpWKwDUc7VSkOZzH5wovLO0/FYBWGBpo9UnH+LHmVyppRXiwP+ePwcMOYXS
 r+PY1n40iAPmSVfYrvXo/bsLx0D9HXEHU5uC3t8bXx6pmnpVvNMpx7qbc12MCzLlkwTAf/Vtecq
 zgiN+J8LKMYKsveC2Ot/NzrrWcE0a7GlP1r+N261uI/rvhbtHG9zhtF5e+xl/JbaETb6E/dgRTR
 R1IrJTftDy4DVUWFFe9+BsIkSJoiNGuTo0nHnKiOl8/bDBLmrjusOtBrzVZiB/BatQoDFt1USyC
 4nHh8ECQbJTpgfOiOlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfXxOyzgIrUWylL
 th08Ew37Sh2vSYh43ZgQVKwGBKnIW0G1crLqaRM7HjnQP7BX0QLUSsWaLJA5Uo5sqFqIDqO/iWo
 pJRnli4CZ+3PbQdRSAABcUIHQH1cPw0=
X-Proofpoint-ORIG-GUID: yAfjhVynta7UgPF4LvgN6tHMRxoXxpW8
X-Proofpoint-GUID: yAfjhVynta7UgPF4LvgN6tHMRxoXxpW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110157

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Implement shadowing of format-2 facility list when running in VSIE.

ASTFLEIE2 is available since IBM z16.
To function G1 has to run this KVM code and G1 and G2 have to run QEMU
with ASTFLEIE2 support.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  7 +++++++
 arch/s390/kvm/kvm-s390.c         |  2 ++
 arch/s390/kvm/vsie.c             | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8a4f4a39f7a2..a4a7972ce79c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -504,6 +504,13 @@ struct kvm_s390_cpu_model {
 	struct kvm_s390_vm_cpu_uv_feat uv_feat_guest;
 };
 
+#define S390_ARCH_FAC_FORMAT_2 2
+struct kvm_s390_flcb2 {
+	u8	reserved0[7];
+	u8	length;
+	u64	facilities[S390_ARCH_FAC_LIST_SIZE_U64];
+};
+
 typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
 
 struct kvm_s390_crypto {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2a57ea095b48..cb623fc41127 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -460,6 +460,8 @@ static void __init kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_IBS);
 	if (sclp.has_kss)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
+	if (sclp.has_astfleie2)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
 	/*
 	 * KVM_S390_VM_CPU_FEAT_SKEY: Wrong shadow of PTE.I bits will make
 	 * all skey handling functions read/set the skey from the PGSTE
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c7dcdd460dd1..9a9a6d8b8ffc 100644
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
+	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x0800 */
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
+	flcb_s->length = len;
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

