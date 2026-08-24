Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FA42AF8D;
	Mon, 24 Aug 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582305; cv=none; b=FzQtXV9R6kpM+DirhxZ41iqYuMQ4zCBAI7w/NzfFFIhgMQQ1BuT3r1hItaIU7o31P0mVSmp+MmqsjOej2nTHT5rWbLtddlO2tK7BjYJi0m/SLg0tMKf15YfSY2wYh6M/ymvuKOxqugh8wY4jIzQQL05eGLuA8ooNQSPU2IU/Bg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582305; c=relaxed/simple;
	bh=xUX0Mnuq3a30Ge07NM6R/Iwa1MstGX806nZgKk3S6dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlVwZ/2z2NXtXW/Tzl7/SU1+hgLtM8i91jygKOGuwKBz25ZlnFEpMD460E6Sa2WYy1pyNQm4vvAmyfGTkIj8knPvOGZZSjW2xNdj05ct7cM2RvnSXfm6jDVJmOC8odJdXb/FtB/BK/Dkz1ZY29N6EtojEOKOk7ogRiXPKtP1A/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fVpKlOuR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fVpKlOuR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1e27826600;
	Mon, 24 Aug 2026 14:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ejCuPtERdMLogSNE3
	ao74U1ciEse4KXN+3ja9ReWVl0=; b=fVpKlOuRi9Wi8G7Om7taGstxOZ9JD2HjF
	5t7rsv5btTwOxqJARm6WkAuACHlPuDWoNa7izbnTOoDd7+Q15FKtK1aolHVAhuqe
	aSUaVeuvWHF/rYqxzP5RDxgozzLcJZDIKqheKS697o3H/sb0yd6qf+81gXBUi2AR
	M2Q9+gpeEcp9x1nbddhJN3skdQiId9c2DRgvblFDcwbB0RSsUSz8EPVw3eykYLnm
	HHQSqNb6KaZnOuR1Lxwlw8yZgHDMsR/qKjFMWAX8Z2MmNM+q15yrBei0e+QREJ1O
	wGpdRXxRtn6Taw1KGnsUMz6ee8Fhin6aTNL5iwFd87qtAhYMeJWZg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ea1ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQHRs009805;
	Mon, 24 Aug 2026 14:38:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxx9vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcG3e46661934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8B6B2004F;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B70CA20043;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 08/13] s390x: sclp: Use sclp_feat_check directly to read DIAG318 feature bit
Date: Mon, 24 Aug 2026 14:35:40 +0000
Message-ID: <20260824143740.291583-9-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c575d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=9Xh-GkoT5eCmbU3qKcIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX40+v6JEzR5uk
 OKA7Jb9aql6PGcBG3dyGSjkzNaAarXWdBhnegNKu8jACBkpymWMOAp4DtwfIvjL4pztxJaP+Wib
 IJyQNlNNLIoHt7ZL7UH9uUkNzPpSNYY=
X-Proofpoint-GUID: 22Ckl-LLxCc0Zc1jWCMuXimf6DCqsoNO
X-Proofpoint-ORIG-GUID: 22Ckl-LLxCc0Zc1jWCMuXimf6DCqsoNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX0WF4r72/kEz0
 XP0yU70lfL4/VyAebo0vOVVAReJ3IS23dyflgFHbdjAg7dxyyv4GWvJt2T2TT5ZuMFtoRUrx1L8
 msiNFnMfWpW2X25ccbYv+jp71++/gEErk/v2YbtQVJ9HlXs40JWolOWuip7Q446TmFg2N0GiTJO
 qfvAwpnz1hmpocdELq8FVKs3S7vwZDqg6UC7GLmr848isk+iyc/HBP5/woEUvikbPGv1hJmp5Yn
 SMblLYXtLrWGpcbhNZlt9PBD6ZYk2a0AM5SqyNoM3VBy81P/FPM4IORCFCkF+7O51Cq3qxBzt2m
 Nbxpea5NH0M1zX8HE25p/niApX+SE6x6zOeYa8s2mHLDiEBvISgOQN8EuzU7i7pWU34WL4J6C7/
 8/an0rFKyO5A62OKcSnKiX3ypfnIgKnhcmxGtmFtgZ9ZPkosaItg1YaRZDDfvHd6uS6DgPE0Xdp
 e5g/mca8S2hz0KptTKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

From: Christoph Schlameuss <schlameuss@linux.ibm.com>

The additional entry in struct ReadInfo is only used to set sclp_facilities
where we are aware where these bits actually are in _read_info. So it is
more readable to directly check the bit here.

While at it order feat checks by byte and bit.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sclp.c | 3 +--
 lib/s390x/sclp.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 1ffcf448..9d9fd3cb 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -157,8 +157,6 @@ void sclp_facilities_setup(void)
 	assert(read_info);
 
 	cpu = sclp_get_cpu_entries();
-	if (read_info->offset_cpu > 134)
-		sclp_facilities.has_diag318 = read_info->byte_134_diag318;
 	sclp_facilities.has_sop = sclp_feat_check(80, SCLP_FEAT_80_BIT_SOP);
 	sclp_facilities.has_gsls = sclp_feat_check(85, SCLP_FEAT_85_BIT_GSLS);
 	sclp_facilities.has_esop = sclp_feat_check(85, SCLP_FEAT_85_BIT_ESOP);
@@ -168,6 +166,7 @@ void sclp_facilities_setup(void)
 	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
 	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
 	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
+	sclp_facilities.has_diag318 = sclp_feat_check(134, SCLP_FEAT_134_BIT_DIAG318);
 
 	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
 		/*
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 42a2f2e9..87af429b 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -144,6 +144,7 @@ struct sclp_facilities {
 #define SCLP_FEAT_116_BIT_ESCA		4
 #define SCLP_FEAT_117_BIT_PFMFI		1
 #define SCLP_FEAT_117_BIT_IBS		2
+#define SCLP_FEAT_134_BIT_DIAG318	0
 
 typedef struct ReadInfo {
 	SCCBHeader h;
@@ -169,8 +170,6 @@ typedef struct ReadInfo {
 	uint8_t  _reserved5[124 - 122];     /* 122-123 */
 	uint32_t hmfai;
 	uint8_t reserved7[134 - 128];       /* 128-133 */
-	uint8_t byte_134_diag318 : 1;
-	uint8_t : 7;
 	/*
 	 * At the end of the ReadInfo, there are also the CPU entries (see
 	 * struct CPUEntry). When the Extended-Length SCCB (ELS) feature is
-- 
2.53.0

