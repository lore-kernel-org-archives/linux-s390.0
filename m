Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38513F8EB9;
	Mon, 27 Jul 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164594; cv=none; b=ISZLBS5ehBN9Ds9JkZr3Xe6gG4wptnBqCre33WTXgVSEf8tdIHYDUTDlbJhfOAbtLqhbLOCjetMm5P/cPGY40aCT1hOaLQ+4Me24aqmL3DTMIpMml9uUsUqNg72MPcImWc06I+0Z+nQ0TXjQ5tTMSsDQjoK6SzA5KS5dDieZGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164594; c=relaxed/simple;
	bh=KuIYyk2Vso4kQD/59T2pZyfAgPW6l0EX+f2FIY+N9PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMC1zerIA3M/sIz5opx/2MNKuzfg46lMSVdXIPhZ46W3g8Y7lfly3QkdGU9SF6KVtRKfEIHPTbnCTmfMYtHxFSeoDa3Xh1inQgDgnUJ0k7SReYZOahmdvIEo35QjKj0bUM5G32v/5yRuPwmKmBznaAVGGtsdy0tf1HQeMrlxrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fzeM0V+y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fzeM0V+y"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnTcD513836;
	Mon, 27 Jul 2026 15:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sGae2nFJGiwvehT1f
	2serzxfRNy4czkDadcY+MXhZX4=; b=fzeM0V+yiw2cBBtYSXH6VTtnm5jsLvTwI
	//qyaOz9tEyD3tJDiE0qs7q+pEyVRIIdJWL66bFHu9QnmgZud6MRGr/kDU6Lob0m
	lNjFBdCTN75gSFeGzzfBSL/GB3INObC1FzvPYIjalZBFAEEAtUvgCiFiM8RSLCaz
	ItiY4xUPGt1S3StO+p8zm7htkEhNRBlCYoXZWJA49jSHPMcr70TCVpbbe8upQpMg
	HsNY4/PVBkfMpvkbqKxLafCgJE9EWsy9nLC++rKHdOSG4aikBADTvZEXGlHJX50J
	WZTXuDHoHn3xussmHY/YiYyNDCV2oLp7U8FUw2kKV5Jj1FZ0lgyQA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc8mbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuMVQ030049;
	Mon, 27 Jul 2026 15:03:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjwue3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RF32Y736962674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:03:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F11E7200F7;
	Mon, 27 Jul 2026 15:03:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FB45200F4;
	Mon, 27 Jul 2026 15:03:00 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.1.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:03:00 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 06/10] KVM: s390: Fix overclearing ESCA in case of error
Date: Mon, 27 Jul 2026 17:02:50 +0200
Message-ID: <20260727150254.236021-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727150254.236021-1-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: arSr58hx8PPqdl0Zgaiq3ZqezIRa8i4F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX6NMH5OvBKVCn
 rSU9CzyJXe3RmPDvVqil3tHS5JMWG2TsEItaMZ9JVBvDbFDAR4bO6epOhT5PvjU75J4x10oLz5e
 0fPdLlw4A5yVSBUhcO23NyzoA1wYjsVq2ARqNIZMLGSaSrALK6jx1vjlvz0bY+9CPW5qJHDzKdC
 /q64Vl8xssblIuBRnJJyTe+sG+ApAiI/zIDW4lAKmkrxzNjsADEpkJN8EMeWmhKAfhe8Cxu7OZn
 ENUQUtTrxgS3rKr6MAtYazcAj3U8vHpBdt0eiOLXlUaMkr+esbY+XYoR80iMKqMYJtBfSexl1kB
 mRn4vlGaDNxuP9CBcAEn7i7vWzrsJOnBaURg7lVHoBtYcMg85m3xthipS5y+36jbqMQcpsntJh3
 t3kRK/4eBGC2SUekoe0HwE5Bt9JUwufDr8l8G0hhM5/uNn3wDDd1s8szxNMpQhCk91X6zODBOAV
 oe9lE/oHjx7o4sXoL6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX3+Wodgij9X/D
 IobnN8D4z+g0sezJ4rr+5hKA8myoqOSQW2iM5OmJOAdNuGy+g9cEz8t5Cg6SU5WHHhYfnDyyoHy
 3FZSChlkXL4O3NWWshUNys/3p8zyerU=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a67732d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=OniIQR2WiTFW0jQNa14A:9
X-Proofpoint-GUID: arSr58hx8PPqdl0Zgaiq3ZqezIRa8i4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270140

If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed. When destroying a vCPU, its
ESCA entry will be cleared. In the above scenario, the spurious
duplicate vCPU is destroyed, but the ESCA entry corresponding to the
original vCPU is cleared.

Fix by skipping clearing the ESCA entry if the vCPU creation was not
successful, i.e. if the pointer to the ESCA in the state description is
not set.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 arch/s390/kvm/kvm-s390.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9e3e6b0d72ad..2acdff130fa6 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -86,7 +86,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
 		return;
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9fccba261930..69c9027c42bf 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3461,7 +3461,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
 		return;
 
 	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-- 
2.55.0

