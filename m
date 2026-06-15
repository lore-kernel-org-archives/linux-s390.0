Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855403F410D;
	Mon, 15 Jun 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527380; cv=none; b=gEMy128MQnHTvr1UQWHITxKVF0JTBwl7fW4KK90t6tvXG+uUsPhnNmwNGmsC02vQo9Ni1XRtSufKncwU0JXppgiprBszYkpi/D8HVifuPsrq8lyE0JpPT7dktbnduUSqFn1cfEGtt1IYbS4TM1XSmdvemrtBfIVI9yu7yWS2ziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527380; c=relaxed/simple;
	bh=rN7yoU6Dsp326Iu51U2EivW47R9+PNrnHGvTliXM95U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBwWNr0PX0kpjrN16NctPDYZdzNk0J6B22YisR39AAK6THIm4E0s+kp5yKOP87R+wzIeRiOOqDquSVnvvUNhXX/eFSCYbywuzrJBFL6QCE3isN8k57VWARXm35MYfpjeTogOtvpVVzDpK109RHIfFgdiDfF1KR/WHHCU7QAqChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ftGlqGWp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ftGlqGWp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAo0gT2255362;
	Mon, 15 Jun 2026 12:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WRRU+wSj7wbfr2yHD
	af02A8OxQBbust9UqbPBs7uXNI=; b=ftGlqGWpgZxvX4sE5IEyTlzzFKX5RIqBa
	S9SSJlQKwdt59JIoeP0TwV9dystC5bNPF+rFL2YXU3+n9ASA+9BFF59ldFf/40+i
	PK+Gv1DZIiQiUZXcRtQapw/acrN53OB+VRRCWWRVdIWRPJ9pDVajcsOmCB1gxJS2
	91Sww3z5K6wXIYBKeP3rK6xGDC1jr/LGRTYLWVP/W3V6VBCQg8QftUr0KIz8J97z
	D0XinZgK0N7mjGHzipFlLBKCWyWPJtP0E8B8oMWBeOSw5TlW3+V+SITobZOLX6/c
	k46u8jBQvPBcdQdueYQJJ7SP7+MHA4zQW8glSjzRnCdi0ZTf5oX5A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h80kua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYbW5003701;
	Mon, 15 Jun 2026 12:42:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7xxaua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgoaS37748998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B3572004B;
	Mon, 15 Jun 2026 12:42:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6F3A20067;
	Mon, 15 Jun 2026 12:42:49 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:49 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 12/17] s390/sclp: Detect ASTFLEIE 2 facility
Date: Mon, 15 Jun 2026 14:42:38 +0200
Message-ID: <20260615124243.187614-13-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX5z9U/G/+B6tj
 f3DlMKHzoEhBpuTeElgKxvgD70pDa6/FBdFrfeSSZmdBs9XjJmjDxS198qAaUsl/HfRWPfULVRj
 GxnZEkMXNijcA6maBzjxz6mCgpHaYlM=
X-Proofpoint-ORIG-GUID: aANmKS0kvmAJ7oyvaa4FME_MccValfAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX1is7cFq+sSK1
 UuJE+T+MSqZ7dU/Rleuvl2Vj+SS50AAY6ZAJRqVCso9J66HJ3KFn/zAgRfBf1nZuOb/nDWmHHRy
 pK47uS+JYF70TB9dEoyuwC4aB6TxdsqBEGlstmmLB/auzUt/sXHYlB0jjdr3PgjartD6oPY6CHN
 ussnz3kMCj0cYEt17kIjnytwwS2hXokOka2DYf1fGM1hiE5mgu0hDjHRjNM/oCQiXOTIggXoAu9
 rJJTBW2QgnBFpELlY0k0gW+5tHUbkAk6NUZC7ESgrBj0PkB8De9jZVZ2cCfsuqnpqjwzpGmghHK
 BYA59I0NXLigsmZuuB9z4AMNI4sSOQiH4F/lDs+wO1TezacyOcM0rxDQoSNilpf3AqRKMkafh0e
 dvKQ2Gz9w9hiLx+Qb0EtZhAomyAoVfrIrlWk1a456h9YHAveofs6tpbZv6xO0yeAaIj+wRzCx/4
 pUANx7LElSt+FIi6tJA==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a2ff351 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=txTkv-xiYvDc7-xnE9QA:9
X-Proofpoint-GUID: aANmKS0kvmAJ7oyvaa4FME_MccValfAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Detect alternate STFLE interpretive execution facility 2.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260612-vsie-alter-stfle-fac-v4-2-74f0e1559929@linux.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 0f184dbdbe5e..0f21501d3e86 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -104,6 +104,7 @@ struct sclp_info {
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
+	unsigned char has_astfleie2 : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 6bf501ad8ff0..22dd797e6229 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -61,8 +61,10 @@ static void __init sclp_early_facilities_detect(void)
 		sclp.has_sipl = !!(sccb->cbl & 0x4000);
 		sclp.has_sipl_eckd = !!(sccb->cbl & 0x2000);
 	}
-	if (sccb->cpuoff > 139)
+	if (sccb->cpuoff > 139) {
 		sclp.has_diag324 = !!(sccb->byte_139 & 0x80);
+		sclp.has_astfleie2 = !!(sccb->byte_139 & 0x40);
+	}
 	sclp.rnmax = sccb->rnmax ? sccb->rnmax : sccb->rnmax2;
 	sclp.rzm = sccb->rnsize ? sccb->rnsize : sccb->rnsize2;
 	sclp.rzm <<= 20;
-- 
2.54.0

