Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B133859A;
	Mon, 10 Aug 2026 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377275; cv=none; b=RKdA/x5gyY7xJW2UVkWG542ojhPhwcYhbxfIa1zz1MqE6/8QsRQZ31X/kv5JLL7OkcVIEAv3GJRx84iyhXqFRiZAaQyhpGXC5f+W0eG4g5HDn+oiu8dl1OO7Ypzr1c4DAUxZ9OfZuoa1Wjxm20FkBSPvo3/z38SQ3jC/rDFpcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377275; c=relaxed/simple;
	bh=XjRoL7ltg11Uz8L0RB1JmKlsHcGEy3eqG8znuPOUgo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VkaKmn+lwuUtSRS8ygqsHeIuZzphsrW61pAZTcAYShucqhIVEGM7yVgJKJ/eD/JsCnk6deXlkVjo3t2H5udKEhvl3lHDuCeLt0yvFYIplUYv6MEfqmZ5HTZhenuONkszwulY/VfSDr8jFevsfwfnCfUDYfCaiZK2jDYnbqO+u3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BNP3cJvD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BNP3cJvD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWq422026274;
	Mon, 10 Aug 2026 15:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SpfDHV
	qjPQaY6S5/d8WNG7cMy28bjX7JJcx8tQAElBs=; b=BNP3cJvDVwP4jVa23Wou+w
	ouS6iQDucxdopvlIxgDddHTxna4TFqLAOiSFSiO3TcMrMEdFwtjOxpTfM9tZPxEU
	PCVLI1d+LB2HWZvOro4SjU5bHMI0XeU4mLmlLCjEumbA1KVzcHC1ghC7LyCjPK8a
	8IbIxgNZUMDzDPhluoUo9RTgtFJLGAraNJzyxp4Bw3vhGUYwgvYg1mMvI/QylI8Y
	5hEi6SAsAsW3dyKq7FzyqE5wDa0xVMQ0VaPCgQn3TMAlp5+bF2BH/sGQbh1gF1F3
	1gP90t88kAqEg2Wd2+tQheMYwt8XDIiD1mrc3YFivxBdJ/nNf93KElD1yDTfYZsw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9guam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgdMW004257;
	Mon, 10 Aug 2026 15:54:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjne3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsPHj39584184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C64420049;
	Mon, 10 Aug 2026 15:54:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB7832004B;
	Mon, 10 Aug 2026 15:54:24 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:24 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:54:07 +0200
Subject: [PATCH v2 19/20] KVM: s390: vsie: Create minimal scb shadows for
 not running g3 blocks
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-19-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVX5S7v7/zuH4pZlf4pKc7Gtb3PnuwdeHG+Y7bOg2bv
 +28Z83C3FHKwiDGxSArpshSLW6dV9XXunTOQctrMHNYmUCGMHBxCsBEdnkwMkx9fzDDcu1zeYf5
 Mt0Lzr572lvw6jVXFlv7jruMIfmRtS8YGZ48EgpY4Zwzd/Zt3ciLN/789Y79vm6pa86rWIWus9q
 ntBkA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfXwG6xWc3NIdLj
 +EaxTI4rBIxAT0vRYsP6+fByQRjaRgh5l3VPonBJE7G9plOMZL+AeCA64jMEoZ5BclCCX2RW7fW
 vem26erboOsWSAJ8miyNav/zkZY7XdMZDJIbecPFoGRqt1JCvpzcwZWDZTTAS7iX3FitR/gL/Jo
 UV6ozkQ1m4jlYGSSuA5TzMqXtRF+eebQmufvfhfI0GV89IRlgeUb28qlRkZ/CL5ZUO6M9xNanoH
 zVLhoxbvrxaY8K+aXXpLEQK5Ua1GjIXXMBSzxRSd9ISZXLm4e2toYaQKVEmzeFluqQ964XcenBq
 3z+nMDkVlN0ghzVgQTg8zF0VpYuUajWdo2KPEkvS4d40f6IciOdOws3BEDrF5Qubv7FNN6TFKu+
 080x3l3fJoFX621owYanNVMVAgfkZMzFShxG9tXObmzIKetMnte4+gsnRon55QtoVuz0w5ETq9W
 vbDaGkppsXES99NOtzQ==
X-Proofpoint-ORIG-GUID: ftH9HSXkqUZRUntNLZ42xvfTEVyTHNq5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX5Yf+TNuXicHx
 lGBNYEn/ae4kzdYrUow15M2wCgbXgIlnfXbA4Lb8532/Xi4M8Fux9WfwF6y0u6i3S53CDcXEl+M
 HXxHxhvbEDJDn5z/ZflhJ9LOx9nTCJ0=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a79f436 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=o-mTpO_FGGOuZA_1EAsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ftH9HSXkqUZRUntNLZ42xvfTEVyTHNq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100134

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

