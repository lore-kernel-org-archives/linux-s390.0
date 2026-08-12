Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09DE45D19D;
	Wed, 12 Aug 2026 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542775; cv=none; b=jFONDCPel5njzRA9PRE8ROJppnsrs0k4gVdaCWWPGh9Tv7cT3kAriqPUSB04uTUwCggX0xmDyf0Y20zJrK/7vKlQTD/9zcufsU5boERZpSX5cJfxkS/zgV/dDxLzmxwF39Xp3z0FB0a6OllWbFkugaWWbe0FLC1z67SO8Oc15uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542775; c=relaxed/simple;
	bh=uSSr9aM26NPb8yTNLHKWEBVxE9s/taV9zaqyCioODrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQBJ04BfgjWq7RgHYYgFwE/Ir0cqRKnuskzT1JWXip1Wcj+hsojOM3g0WELj9JGmLxBpNE68UFVSIqd05/EKIeMjs2y2/5cEn/OI1aAchX4oYLhlCs2mMftkdCJ1N2FFaH1/4G035uitrBojpmw1W9cn4W3+B+yizyPaWMu0xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UsI7JH7W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UsI7JH7W"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB48783215124;
	Wed, 12 Aug 2026 13:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=13XKeN
	VdIFA87mDKgYIPyKQRh+8Y2fx7Cg0fK4EwZ3s=; b=UsI7JH7Wy9qGCcC1rOhv5C
	EVegHfBNaHJBR3aVo1Ek3epBTmGYDYY0dTiEM9kgZywgbQqeHoCN26pvCV7RR36i
	dPTQX87mLpACyMHIv69V5Uu9qCdDC4crR2NtkgtYeBZTXPYQCDryj0RNqYxW1P0j
	PVBgfjlBOLUZlCIDDaDV8tSoXZ158YxTwgJGfy5CKjL4YFUr1o5hZJnVIHSnJ+u+
	SaXT4D7PaB+5qF9PhjWtxePfK0lYkF2PSZZ/FSbFrUpWiX2ulkdzgOgf7iJoBCGI
	HRCxmhZcNhnMWf5HavOWUBz3Y2DtCJ1o7ti5fAuBHrXcxEd0rZbCwIim6cLSxZqg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31wqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfd6E004194;
	Wed, 12 Aug 2026 13:52:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w6c4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqbTC42009074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB3720043;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD8A2004D;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:32 +0200
Subject: [PATCH v4 03/20] KVM: s390: vsie: Add vsie_interp_extf detection
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-3-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
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
 bh=uSSr9aM26NPb8yTNLHKWEBVxE9s/taV9zaqyCioODrU=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYs2duY7/Z0oOqPtXlCdathy59dzjZT+Xlz3JeZhq
 ctumegZHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEyk7gMjw9WpN7y5ex/wnuit
 WHeyw6fN+tuZR98tdq65158+4+rmsipGhpZS79xTe3bm24cuWcX1JT80rHpVr6++TdIcjrasl+n
 CHAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c7aaa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=aPtVb-VRJjWQdk5PnbsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ccq7ek6mh1FtV0xgrlcqJI99CMRfC0xt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX4MOhTpZvaol4
 scHgpFVUo1S6nqzrS8fc2HUIRgE3miwCoW4xtIUPF39d23fY+h2R6/2riO1XKfkfNfVjdXt5T5Y
 gMbQfxCETrsOBk0XjIaY1TyRuJaveC7JTOL1qGRhtmuIniCBNGgHAyItT9o35uuLyHBUma1lLHe
 fy8Ne3KciA1IPRib2/nBnbYlFQxxghFA4PoiOO2CwCdKJVuGDBxK8wGusEGP67pwFuqFRqfn6Tn
 4C8i+XAOA/sAMVaIMxdcLfq2/EuAs5VCosDoYii24MTDXdnES4bZ0mo8rWXLu7RMBcmK0XzDgeb
 zpfatk0eiS4qi24zjI5g2sD/kxaTdS7aSSijNajDaNpbKFQbT0bVK1zcD7Nxh+x/2VHC3bOCKei
 bPplvHikXdF3we7Kz4RHNtsY1mR3hEMZA5/UIsaps1Ky4kDs6K87g7F2OWtGiN66MH6LmtfpWos
 moEfDL9MhDZGBvizdIA==
X-Proofpoint-ORIG-GUID: Ccq7ek6mh1FtV0xgrlcqJI99CMRfC0xt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX3nNWowERalu9
 jFhIwUZaREDIp4p/sOdYIeSbxIjPjvcJcvgJIYZKlfP/S28TNHxUSBLhEcKaEr4uk+ZCj66duJB
 oGSO++ckXvdu70vxhj7ZwT8X8D5M7m0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

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
index b4182ca4435f..d0b0dd9e4f10 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -678,6 +678,7 @@ struct kvm_arch {
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
index 518a69c55e85..8bbd6e6290c0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3385,6 +3385,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
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

