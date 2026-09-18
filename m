Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44444FE2F9;
	Fri, 18 Sep 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744181; cv=none; b=JnrgBDc8NmDRJTTHDlnvZdqRWxST+29zvD2Ug65hy9nWTv57349e6r1V0Rg/9h8Afa3TKcXcXrCXVv8Dln9cleUKkttcPDCNpLrSW7/fSmME2Qn00g2I77w2vit/9GuPIYmLL0P5K8hWNDS8MMqRCQZWO4tZYqgjRrjmAQNUQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744181; c=relaxed/simple;
	bh=1fxDDyDR6lkckQEZkjVHQ11O472FldbpAT5pBY5mcjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VvxK16L5dPMjBbJG476xQ+lAzSg5sqQUMfcHyks7irtCGBL5Ixl5tLDJOrB704oX/6b/X44KZ4ny1deH6tFvNgB4seuqIVCD9sigkB0yi0mnAshvBjuJMeBqmZOElI2ni8X0q5RUvgkKSyzF5xIiZoxRZE5Z5yt6lFX6/xA3Ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fXNAtirJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fXNAtirJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVWGp3708576;
	Fri, 18 Sep 2026 15:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KHBJxu
	yYcBVBWbJ2bQe3LZR3w/sswf1inmbakA65f4s=; b=fXNAtirJz8UeANa1UsJhmK
	awhtFyVtXk/IiJ/NpgIrRd7Rmd3BMhhT+PNbWwZNmGfTYz5lmmiXHHrMziO1AtUW
	yNTfDNnOjwvZ3nKTsdiTbOzqflbYz9Enk4KCNt7z2YcTAMdsmp6VMPF6gwiIIY58
	0026mbgJTN9kjGMAy7dOF60qCL8WyrhJKyw+rMvUxjsAx6QHlzmz6JiE0kNHJTL6
	s90DOmqy4zbBu33zyB8ENxKKbESjUXkY0YHcOZTo5XPJfbJ24B6bWV+Clozk2Lz6
	PdYk/d1wA7ndvOa1qGtxidO4VDbaVJSFlL8r+phowqG1HamDGN/DXW0ann6Rht5g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqrspx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDOF8d739719;
	Fri, 18 Sep 2026 15:09:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q8m9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9PbQ28574104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5172620040;
	Fri, 18 Sep 2026 15:09:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D27722004B;
	Fri, 18 Sep 2026 15:09:24 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:24 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:20 +0200
Subject: [PATCH v7 03/21] KVM: s390: vsie: Add vsie_interp_extf detection
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-3-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=1fxDDyDR6lkckQEZkjVHQ11O472FldbpAT5pBY5mcjM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxRP1+wuuvfZpm8tr3OpkU31xB+mCzwvb1JruOQfs
 MZlw7LfHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEykegXD/+Rnx78+XWK6oGzx
 gUkJumeLiyQeTk/vOdP0qCTkxG4zJzVGhn0LeTfrZa5TaXpvsuLtzV7HqW9efnO59+qc5b8ZBsa
 WJZwA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX4krvatPUwdzT
 4QB5t72oaJtKHULqd471AteAqJEQsJYssrl4TNU1mvN3UBAsmYMG6MZwqRtSELTYGEtcnGG9bA2
 X2rYHLCzGjS0YV7mJaQ/GHsN1hexl0042ihlIZjcvS77j3Hkvn+LHVnS4wTVCSkQXZsejcH57F0
 ulaAq7swi+h1hdYkM3YAu9n5YJ3XdXbBCWe6lhEYpp0z4kF9SK85WtBhkPhFEZKqpUZLQx6aKH1
 CxwrRqa2sJy1LqXT3YbipkWvMQW++1w+451cSNoBGXnBahAgiVBiEcGyRVXXS+AkBWm3oiEtWov
 pagQCsBpawfwMLbUEymkH6P0YKq4uIXX9h2QhxP28xZGCBGYwLFbTVOW3SRSLjRQr0F36aEj0Ry
 2DGYRcnvv5pL3g1WRnGx6Q8XXpVjMvVRZOuW0L76Y2l1igFeU+WoLwUq4NMH81LEvUKawZdPkCT
 uIqUAmzmyAwsca6wpAg==
X-Proofpoint-GUID: lQ1Du4OA7lPLEUCTRR1Up37spONI6D4X
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aad542a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=aPtVb-VRJjWQdk5PnbsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n6Ar91Fr2cJFDTEMjYpDoxaEz_FTHR8d
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX/V07Z6rpGV6m
 kAJ9ENPpS21vD1ph4k7huiGq3bpYEVcB3M72376bzRHqqu/u+CUzwr/KHZdqgWBSEu0F1pgPABf
 cErRIZ5MJmRi3DpELIgouRWWL2AuaKI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

Add sensing of the VSIE Interpretation Extension Facility as
vsie_interp_extf from SCLP. This facility is introduced with IBM Z
gen17.
Along with the new facility add a KVM struct member use_ssca that we
enable when the vsie_interp_extf is available.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h | 1 +
 arch/s390/include/asm/sclp.h          | 1 +
 arch/s390/kvm/s390/s390.c             | 1 +
 drivers/s390/char/sclp_early.c        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index cd692f8fb764..6fdac144ca3a 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -623,6 +623,7 @@ struct kvm_arch {
 	int use_pfmfi;
 	int use_skf;
 	int use_zpci_interp;
+	int use_ssca;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 44066550b9b1..9e960c09ce0b 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -105,6 +105,7 @@ struct sclp_info {
 	unsigned char has_dirq : 1;
 	unsigned char has_iplcc : 1;
 	unsigned char has_zpci_lsi : 1;
+	unsigned char has_vsie_interp_extf : 1;
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 5c73f43782a7..a58c330b9e7c 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3359,6 +3359,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
+	kvm->arch.use_ssca = sclp.has_vsie_interp_extf;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	if (use_gisa)
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 22dd797e6229..40e6e346ee08 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -56,6 +56,7 @@ static void __init sclp_early_facilities_detect(void)
 		sclp.has_diag318 = !!(sccb->byte_134 & 0x80);
 		sclp.has_diag320 = !!(sccb->byte_134 & 0x04);
 		sclp.has_iplcc = !!(sccb->byte_134 & 0x02);
+		sclp.has_vsie_interp_extf = !!(sccb->byte_134 & 0x01);
 	}
 	if (sccb->cpuoff > 137) {
 		sclp.has_sipl = !!(sccb->cbl & 0x4000);

-- 
2.55.0

