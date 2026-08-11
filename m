Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6834446EE;
	Tue, 11 Aug 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455432; cv=none; b=Y6fCoi/FubpoIZxrTekpRN5iKHT8YDKL9JlhGYpDJMO9oiR66+/PNHufnxwYlajpa0MgXs1cJgc4OdcPWkFXmSiKzqhdUcZMmJ/0WKeJOa6yuno5AmpX9C51N4RC+RjMYJdT5joJUsZcysUatQhM1xF9zuVNhzUf4oAiRyG+N/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455432; c=relaxed/simple;
	bh=XjRoL7ltg11Uz8L0RB1JmKlsHcGEy3eqG8znuPOUgo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/OPFzj8aLrhNoKAW5BN+Spjc5njFfBTaevFpyhYpox1vJP5MWEzTwb+vISYfUnvLKZUrV8TYY52fCAPJggoEqH9V5VbzZsCxcrPP0gfhIr4THO1o558PtPhyPvsnvMH+trkqWGfbkAgr3BlK8DKcHrTTNOLJrn5mOLlDd9ejb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=euWeDX0o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="euWeDX0o"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXIWa451627;
	Tue, 11 Aug 2026 13:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SpfDHV
	qjPQaY6S5/d8WNG7cMy28bjX7JJcx8tQAElBs=; b=euWeDX0oCqvontVCGJb3dO
	t0Dbopaf7MaABPHFMligUZx0LOaV1UN6jMQ3m4uU4sVcrlqh7nPG48ra+YOib8XI
	2/I/jyyCW9L53zf5c9AUfl7khtnwZPrIP3Hof0MsOd0h5hoo1WPOdBMsKTl//w7X
	B6sb5Jjlh2A4QKOd4PKOBd3bdZg97X7kFMEw2B3Qf0DM2vIwXNTMyhfXfJr2NcH3
	mbfZQQAQ1OH4lhNG/gpyQKFDkNUgMjcmTo2NlUzxqPK9nE7bNmc1hUp8vc8jZQPI
	lQ9IR5YXG0mSS8kSFzHdFzfhjRDKejsU5d+M+IUyTfecg0Fd4hqWRgs2cCINftug
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2vgkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQGAb030164;
	Tue, 11 Aug 2026 13:36:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h10uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDafHT35914036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96CA82004B;
	Tue, 11 Aug 2026 13:36:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0155E20043;
	Tue, 11 Aug 2026 13:36:41 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:40 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:34 +0200
Subject: [PATCH v3 19/20] KVM: s390: vsie: Create minimal scb shadows for
 not running g3 blocks
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-19-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4171;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=XjRoL7ltg11Uz8L0RB1JmKlsHcGEy3eqG8znuPOUgo0=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqtHT/ggu+PNbXPDePq2pakWhP9TTFx+3uNXz5W/Vd
 ru5ym5pHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEwk8iXD/+CkGzvmvfti6xO6
 akcYR6rmhSOlGuVznx4PnnuneIGwqBgjw8zpE9I3bNuT96/e80HVtzNVVwVbiraWrGLccszvNn/
 7fH4A
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b256e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=o-mTpO_FGGOuZA_1EAsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H9Bm9f-i1xnHkSJXBiddoBWyLVRnHGJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX2Z8X2EZ1+vf5
 DR1/Yv3Tl7gK8hfeXzhW5NTa03HlZnQGKIqP164ohPnoddMRnLMO2zRANYt6gRuRvmAeZCHptPq
 6ZYMffKDiR12YBLk+zLWOD/hG8upZF412PxERMPySpFeOmU+JjaTmIdNpXyp+pjroqV8Q0vyV4J
 Toa6o6hYiiBFW/5raFp0r+ULAT9b9pQFWRDoG1mjj4zlWv5v0LUCY6gbHn+pcAgPcjaW7cFBvu/
 ozz5A5vD8FRF5vdLj997rT0Iu7NKwUopJgm5v2qXYOBUbGXkvax5WJn9Fa2hmCU4nqIqBwf8NUp
 D8zXP5yCuzJKapELn7vVfBvTeSQB2kjnbVYgrfVs3+zGnD6w42R+pV5jfxUVp24NV6USEyTizG1
 YlwUCxpYJey41Cid2EjcqcpU2S5t5Xv/wmIcb4GCxlMUkTTs2QYYmh/TFRSXw47gCEfvndtyP/1
 m+lBE3SN8wdMF6sM+8w==
X-Proofpoint-ORIG-GUID: H9Bm9f-i1xnHkSJXBiddoBWyLVRnHGJe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX4Lil6F5ILlAo
 ndSTSScns1ev6D4Q+Z6VGec6IDJdo9JcSZ7IhmD3zPn7gN1C47o4HqhKLsNu060719XOBfyngza
 IDg/vNvwkx0qThwDSw75EFVJ+qpzjEQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110113

Instead of creating a full shadow for vSIE control blocks only create a
minimal shadow for SIGP purposes for currently not running guest-3
control blocks. This reduces the overhead to shadow the whole guest-3
configuration.
The minimal shadow only contains the information needed for SIGPI and
SRSI. The shadow will still be recreated fully when a vSIE is entered
with that SCB later.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 54 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 8640435c9d5f..1184527dea48 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -364,8 +364,7 @@ static void update_intervention_requests(struct vsie_page *vsie_page)
 static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
-	int newflags, cpuflags = atomic_read(&scb_o->cpuflags);
+	int newflags, cpuflags = atomic_read(&vsie_page->scb_o->cpuflags);
 
 	/* we don't allow ESA/390 guests unless explicitly enabled */
 	if (!(cpuflags & CPUSTAT_ZARCH) && !vcpu->kvm->arch.allow_vsie_esamode)
@@ -708,6 +707,39 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_o->ihcpu = scb_s->ihcpu;
 }
 
+static int shadow_scb_minimal(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	int rc;
+
+	/* make sure we don't have any leftovers when reusing the scb */
+	scb_s->icptcode = 0;
+	scb_s->eca = 0;
+	scb_s->ecb = 0;
+	scb_s->ecb2 = 0;
+	scb_s->ecb3 = 0;
+	scb_s->ecd = 0;
+	scb_s->fac = 0;
+	scb_s->fpf = 0;
+
+	rc = prepare_cpuflags(vcpu, vsie_page);
+	if (rc)
+		return rc;
+
+	scb_s->icpua = scb_o->icpua;
+	scb_s->ecb2 |= scb_o->ecb2 & ECB2_ESCA;
+
+	if (vsie_page->vsie_sca) {
+		scb_s->eca |= scb_o->eca & ECA_SIGPI;
+		scb_s->ecb |= scb_o->ecb & ECB_SRSI;
+		write_scao(scb_s, virt_to_phys(&vsie_page->vsie_sca->ssca));
+		scb_s->osda = virt_to_phys(scb_o);
+	}
+
+	return 0;
+}
+
 /*
  * Setup the shadow scb by copying and checking the relevant parts of the g2
  * provided scb.
@@ -727,17 +759,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	unsigned long new_mso = 0;
 	int rc;
 
-	/* make sure we don't have any leftovers when reusing the scb */
-	scb_s->icptcode = 0;
-	scb_s->eca = 0;
-	scb_s->ecb = 0;
-	scb_s->ecb2 = 0;
-	scb_s->ecb3 = 0;
-	scb_s->ecd = 0;
-	scb_s->fac = 0;
-	scb_s->fpf = 0;
-
-	rc = prepare_cpuflags(vcpu, vsie_page);
+	rc = shadow_scb_minimal(vcpu, vsie_page);
 	if (rc)
 		goto out;
 
@@ -767,8 +789,6 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_KSS))
 		scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
-	scb_s->icpua = scb_o->icpua;
-
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
 		new_prefix &= GUEST_PREFIX_MASK_ESA;
 	else
@@ -2137,7 +2157,7 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 		__set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
 	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
 
-	/* pin and make shadow for ALL scb in the sca */
+	/* pin and make minimal shadow for ALL scb in the sca */
 	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
 	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);
@@ -2163,7 +2183,7 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 				rc = PTR_ERR(vsie_page_n);
 			if (rc)
 				goto err;
-			rc = shadow_scb(vcpu, vsie_page_n);
+			rc = shadow_scb_minimal(vcpu, vsie_page_n);
 			vsie_sca_update(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
 			put_vsie_page(vsie_page_n);
 			if (rc)

-- 
2.55.0

