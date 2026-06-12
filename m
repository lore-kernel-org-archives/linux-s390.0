Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA623B9D81;
	Fri, 12 Jun 2026 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267002; cv=none; b=dZE7tHpKsswDYB0FDiztlE2ovtIsaBAss9kEvsMZV6xkYu359RiTdosoKu0wXDLvKBUWSV+muir+Qm4eTPoPtwDCLIwyTmAAUdhTV+GPup7CecI1sjcWVMQELawCMtz9dlg8frJkEjELrCUmAAD43FrgsHy964s29xnNIlzKTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267002; c=relaxed/simple;
	bh=5knGSLdcy1yN1LdHvUSOPsaHUgYlh7c1cnGwmlJ2vJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTMb9fr4CtzeeFCrEClnQd/OpsEC96x5YKXNk++cnQaXFNilzGuAU4QO/klNT6Jtv9yiCunwvdXiPxbkRooKOOygEA5L8PR/IH6wCiEfLuoji+MAn0SvRE7ik8FpxHy1gghmRAPEkLaQkiPNcI36zT6IH91PQwAVV8p9YRaoTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aUwhwfOl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aUwhwfOl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C0TmUx4148991;
	Fri, 12 Jun 2026 12:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wB8L9V
	Z2HgQ2lsYNv35i/uq3Fjo0FfwiabUHvVtQrfI=; b=aUwhwfOlaD32BBLugbLSxa
	U8p8kPLIdhW0wrbu9K8kBXdaEaE+TbEriI3ZUgxIDbU3/3YVHstMIfIT4EDJXTr1
	s0ZdojOcIIAs63Lyka7TlhVC3gBn7vMVu+H7XN4sA3djclRDOKPRIra7WdFY8Prf
	cDDcoO1N7hlofbmcYYio/6ZHOcUmyoq1fV1Yuhjn3qQFx51mGaWQyip/1zR3Uqrk
	EVc8H552oEoZ68zmlLAAgxsr30uNJ6ihgQuBT75Gt+s655sW6jfB9r+l25CrK+Gp
	23/+LAwkiRaqG08wGQGvJrvSBkPpplsa4gjjtLGlyGqCjOz+1PdHZTIVyQcMeboA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c8w0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:23:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CCJrBn006699;
	Fri, 12 Jun 2026 12:23:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08qs58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:23:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CCNFoD50332092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 12:23:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64EAB20049;
	Fri, 12 Jun 2026 12:23:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C89D320040;
	Fri, 12 Jun 2026 12:23:14 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.8.71])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 12:23:14 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 12 Jun 2026 14:23:04 +0200
Subject: [PATCH v4 4/4] KVM: s390: vsie: Implement ASTFLEIE facility 2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-vsie-alter-stfle-fac-v4-4-74f0e1559929@linux.ibm.com>
References: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
In-Reply-To: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4360;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=lNtgdSRZ2Bbvm4k3JfKEXTrh2ambbf+mtvDu0rG1aPw=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnav/QZlT8/nTNzUtI98Wvp/w9+VaxPMLgx5Zh+obrFH
 psX2z60d5SyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCRuDxGhqPFV6OUZ2bE7u5i
 fGNeJ3ZxR1CS7MWTT1T3yl/2lKkO7WNkOH2e9X6coPC/X1NZ12Qf3ZhvcHP1s/+Z6TrtSYnPFvb
 zsAMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfX2K9ObS3/uj+E
 BRjMZyo5PsUPQU6mTvQvgM/rgzdUXanLITox41J4t3ytKRbo5di93Yov5HRmZi+Ew3ypBCjDYeG
 07SvNfv8bzylUG4WDy7cDMoKdc8qJo0=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2bfa38 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oCcITnp3sdYY3cQSDY6ovTCK2Kn8oLUI
X-Proofpoint-ORIG-GUID: oCcITnp3sdYY3cQSDY6ovTCK2Kn8oLUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfX6LpH4/R9PXx5
 qPu2KG8zyZdifpsuzogi/rfTNd21RZ6qHB2BfSnvObC1eLH90pFQ14NgyO7uTEW7Ojkp0+1I2Wj
 8QYfF7IOjC51IZfLtvuJj8UkCy6ggeKulo9bgkkywycDbBLcY7smwMr70jjSEWc8/o7sm+xfcLN
 rZp0rdpdGVIBycEynrDBybT8GB2D7tgISPsKf8PR/tWEtPLcYFST+BHeHzFBe3GIPJEBZSknP41
 3Y3Gi8A5/fovP1GnyDXJ3umZHGRH02jWumG/1yYbGvLAViDnl1OOC9MsNhw7PXuP3sTZc2Mki47
 ba7hhhdtxUraB1qqDjyPoPWi16yfeGPxTXnoIm1S4d/OxxJ8nQWYXZbuY2tHzKPPYYl7mOscrY8
 T1UPYtWDYhCCsHDOETG+iwMLoXFjaPV4YllQBT9CplZgPtUY5g3uN2EbIb1cREjcDlX+ebi5880
 dJFC72bMiTT3Ebk3HmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120111

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Implement shadowing of format-2 facility list when running in VSIE.

ASTFLEIE2 is available since IBM z16.
To function G1 has to run this KVM code and G1 and G2 have to run QEMU
with ASTFLEIE2 support.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 12 ++++++++++++
 arch/s390/kvm/kvm-s390.c         |  2 ++
 arch/s390/kvm/vsie.c             | 34 ++++++++++++++++++++++++++++++----
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
index c7dcdd460dd1..9abc2c657d69 100644
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

