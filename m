Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2232B10A;
	Mon, 10 Aug 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377264; cv=none; b=iAP/t6hJp+JyhdiLoo+D6HubUtovBdtaw+3nCuvfPqCxxFdCbvwXlpsbNDzUc4eZOW9nPTVMxh5DIALb4Lsgrdc20N8t4Y3Ebqz8KQq0YlX45JQ56pVfN3MZA2c0MdJQqv5k/5JWQWHcOVSmqteuvYURcL1d1rk6ucMMYNJ2FSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377264; c=relaxed/simple;
	bh=1hTaE7LUpVQSSUk1nqj+e28IIMlYpwyREVbd0strnCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIRITQmxJCuRpnoOlueJ3Zt/KdtTTmVoVtPdJLsiih6DbNkKEndMRtSIDsDJ5FHffTA6wqPBcrgzu6pIQ6DfuOIrNeojUVHN1Rcyz5g+yKhZfOEM1iBafHdcegm7UPhmYdy5pRcN0Nb/HYV2Do1NWNmeB9sE8HuDRunqJ27LbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GhKDnWP5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GhKDnWP5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWiaa2026095;
	Mon, 10 Aug 2026 15:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IT8PIo
	kFo4IviYFmrs+7XAhPbzvojeY5z7BbYIJXsm8=; b=GhKDnWP5RpwK5oo4M9o0TW
	i8yA0AM5AI5t+v8OGI09h2PYmQODnPXuNtgIS25s2X5anNK6/Toga9tUnboFiLyp
	KALtRQpdgDqD3rPZi/f7zfzFANuGKvOTsbmW3gL3wZELLrEhJT3tnABehTnrfsur
	qYOLreyXCII59aH2yCyZXjhl2LzakYTi67klFwCFnw2gCId3e+idI7ZXKlQN7QnH
	asqZXphzN2dKrfh1tlGOthCHuzNlixJilgEvh0E1nyFC/Tcs436efeLIndh8nxQp
	EBUXzvn9Fk3laexabQ6hIT6ahg0XlX5amQBUI8We989799SpcniqKCf4kceUxk1A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9gu9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgY2E024485;
	Mon, 10 Aug 2026 15:54:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespwjk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsE9f36765994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DB5720049;
	Mon, 10 Aug 2026 15:54:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 964F320040;
	Mon, 10 Aug 2026 15:54:13 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:13 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:53:51 +0200
Subject: [PATCH v2 03/20] KVM: s390: vsie: Add vsie_interp_extf detection
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-3-e8d59a2f2f70@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2416;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=1hTaE7LUpVQSSUk1nqj+e28IIMlYpwyREVbd0strnCg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVXxTXvZbN7I1PTWM/vDzheFKsud9V+6ebH95+Veks+
 fyboW5FRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABPR02NkmJM06+GLA5d2SPCw
 8PmXz/hcIirh0ZLNNXG+mKkTS3UJDyPDum8fbXekVinZWH7Z4Tyvd9XNCJabXusTGCe0nbV6mt/
 LAwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX/82wPhT5+y8f
 2P9H12u9K/EHjwKaMIQGQysPKvX4dmRTKAEkyo7ef5o+VOfYJ0PhJsnR/as5KAOXkkzGz6jG7bP
 KWm1mPBZ8t3+H5X9nAEwI2/jEzyjXuNsdnmfLd/9k1KV1gisENuGCqW07V4aXAqZbU2UN0a6G2K
 WX94Wrjhd7yve6wfXlJIWfB5cufBf322Lxgqe/ahlb51Oy7CLHOIp03fbjfBh2zDCL3wARpPpza
 GdRKTJSNW1Mvrosdbh+TQRcjOwCTeaH0MfcRQ72LJJadu4o/SAW/iUVTUu0/+Hlw12vG3U14MHZ
 mjpqXzw4hQhE2tPfRtWuYuDej6c2tlUDFv78yTF5GLa2kEKhEu80sJVSQRdqalfYM4oZlR5AMlq
 n3i9QAy6MeNiVY4QWO5IlHHfTxrJaQm1zrU42V3luzUIx9NEvOCqPoIK4r36GtJogd9VL4e+mgJ
 NuiuRCcskQujYdUrPQA==
X-Proofpoint-ORIG-GUID: a0PCgmonlbwoIWGXuYAw4f24LKv41vNw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX9GLN73LUKwfa
 XZdFtNBWhmJiSR/Me5m6P+Zd7DfkaT+z+NB6RogxiZaSnJparnE5JJUt/pijtcjfy0Fh/qNwFvQ
 V7SQslGLYBt0sqHyyLBXXchjFzutj+M=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a79f42b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=xNCkePpBwoOxHSHRLI0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: a0PCgmonlbwoIWGXuYAw4f24LKv41vNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100134

Add sensing of the VSIE Interpretation Extension Facility as
vsie_interp_extf from SCLP. This facility is introduced with IBM Z
gen17.
Along with the new facility add a KVM struct member use_ssca that we
enable when the vsie_interp_extf is available.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/include/asm/sclp.h     | 1 +
 arch/s390/kvm/kvm-s390.c         | 1 +
 drivers/s390/char/sclp_early.c   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c172f9b212d1..6617d1161c68 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -677,6 +677,7 @@ struct kvm_arch {
 	int use_pfmfi;
 	int use_skf;
 	int use_zpci_interp;
+	int use_ssca;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index f2d490558054..d790a5995103 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -102,6 +102,7 @@ struct sclp_info {
 	unsigned char has_dirq : 1;
 	unsigned char has_iplcc : 1;
 	unsigned char has_zpci_lsi : 1;
+	unsigned char has_vsie_interp_extf : 1;
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c679d8f83c0e..6f458e7b27e3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3380,6 +3380,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
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

