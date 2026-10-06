Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761248A8A7
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298712; cv=none; b=hcPInn1h54znbPxmi50Jrn4uQd2yIFDo3oqdFTfXWl32tpg8rUGnu5hiK5oEkBDeLldll2naCjbjwkPO2SdRtOG7jzH8w+fPU9v05tZTEV7xe28o43mqz0BJHnOmZlopn+ZhzHPRk78p9MAur+UMxRmXR/cZcpVUVVQ7Kn47Unc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298712; c=relaxed/simple;
	bh=u31Xm6uvKZT0EettGEkWjVeaMwX0HzkEek9yh3FFpeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imAvxMtuqrdUIAJPWs/2S5ej7utO/+jSSJWdIEyLzOFgeVXZ6iS2S3iEax/h6LwfYTKW8F5/Lg+rKD5PgrNOOrKlH8BH2qTseTX+6I5M47NFErB//7tLkrntXXgxdDwBcV5PJ/PV5Ir3r+pfusP0tleJ3anPqBxV8Pcsza6c0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qwszSIuT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qwszSIuT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZW9A2778114
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Q7vVNs9n53o7iXr6qsKQb+r82fzUAWf2rVG/F+BDT
	5A=; b=qwszSIuT1meSP+yHZAqSdcoOB1FnJyfEXgW2NzjTxerIqab3PmUOAEp8r
	ARAtAJI7IjxBXOmUc5aSm3P0bXCT6VC9EB78IPKIhlWEYJn+XJ5zPyIkcZtWVwDj
	NUPCeVk5XK+t4ynXKTgkwNsIlBdIP7g+zCsblkIhoJuy0tuZCE0ChOFR26MI4Wx8
	+iiu6iB3Wsm33VhTv1PrsulvyYul4yUjoeUcfvOpuCuL4zuymC7Wi89cRbkBrCFz
	ibh2ODLw/7SVfNPMB96hWxEi2cjiEARu1XG68VZMCBQkySih8GpWhgNWrKqa8TLw
	zZDTdAwprWP47U79Tb0LWigOg+X8g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fyv31-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:58:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHUCm424975
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:58:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqya55m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:58:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696EwOOB48628098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:58:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DDF72004B;
	Tue,  6 Oct 2026 14:58:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDC8420049;
	Tue,  6 Oct 2026 14:58:23 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:58:23 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2] s390/ap: Support new APMLM field with PQAP/TAPQ instruction
Date: Tue,  6 Oct 2026 16:58:23 +0200
Message-ID: <20261006145823.8421-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac50c95 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=9dvGAY6gNLD2BIB7gb4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1OCBTYWx0ZWRfX48m4B0nFBwir
 KyaUUkoEdKyl79h+cZ6osOLW5D4bkcclBMNBGbaUC0bfHUfGH4Na4rPF012MxQ+E/xxOptgkYhG
 bG+xU6zvmIxrt6gB1TUOblhVw2ODmukwzhK8sVh9Vjf1RVdHiRvnJFT8hF86FIEE8w6MKorwuLB
 VktGN8ax3+gL+vp6YWtv3MDzTs24WkxL3Gn3enuBw0Fr9pasPqrSW4g+6MD1Q6uWRVzc+cHRcCu
 VerqCr6bdJKjFOKHchoFHJjrfDtL80dXOW2OE44gcKXLum9iyjhXmPZYfCzLKVSzJXywZw8qxw4
 X4el7TfBgw8EN3n4GZwN0HP/puQhwQEOd6HatKCGNklcH8S7E/Hj8oNkKWbzo4bBpLggCOs96WK
 rV/N7jjv/Ulhidp0vp053SDsxvWAoxkR1UvdstSWHGaNQ3Ky8b4K1y7IWRp+SNZOeP19P+XvQl1
 WXdjwtq27uZCXlUtiPg==
X-Proofpoint-GUID: GMhb515IqqLPE3vj9_ZP1PYnHBAn7crv
X-Proofpoint-ORIG-GUID: GMhb515IqqLPE3vj9_ZP1PYnHBAn7crv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1OCBTYWx0ZWRfX8MbYP4gL7Jqa
 S8rkcou6A9cRSqG0Ao8timzQxRaKwwPP5EjJa+skIdXLBiKTbD2wHDaOzzch2yg/WomvUes9mb9
 HF8BWxqLs9nwhJ86pTTBS98C/q6PgFA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060058

There is a new field APMLM (AP message limit multiplier) defined
within the GR2 register on successful invocation of the TAPQ
subfunction for the PQAP instruction.

So the new formula to calculate the AP max message limit is now:

  if ml field <= 3
    AP max message limit is 12KB
  else
    AP max message limit = apml * (apmlm + 1) * 4KB

Also adapt the HWINFO mask to have this new apmlm field shine
through this bit filter mask.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/include/asm/ap.h    | 4 ++--
 drivers/s390/crypto/ap_bus.h  | 2 +-
 drivers/s390/crypto/ap_card.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index c91b6ace199d..01d575c35887 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -123,8 +123,8 @@ struct ap_tapq_hwinfo {
 			unsigned int	   : 14;
 			unsigned int at	   :  8; /* ap type */
 			unsigned int nd	   :  8; /* nr of domains */
-			unsigned int	   :  4;
-			unsigned int ml	   :  4; /* apxl ml */
+			unsigned int mlm   :  4; /* AP msg limit multiplier */
+			unsigned int ml	   :  4; /* AP msg limit */
 			unsigned int	   :  3;
 			unsigned int qd	   :  5; /* queue depth */
 		};
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index fb4d678336e4..34f9dcd96bc7 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -181,7 +181,7 @@ struct ap_card {
 	bool chkstop;			/* checkstop state */
 };
 
-#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFF0F1FUL
+#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFFFF1FUL
 #define ASSOC_IDX_INVALID 0x10000
 
 #define to_ap_card(x) container_of((x), struct ap_card, ap_dev.device)
diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
index c86397f4ddcd..e9a8180f08c2 100644
--- a/drivers/s390/crypto/ap_card.c
+++ b/drivers/s390/crypto/ap_card.c
@@ -242,7 +242,8 @@ struct ap_card *ap_card_create(int id, struct ap_tapq_hwinfo hwinfo,
 	ac->hwinfo = hwinfo;
 	ac->id = id;
 	ac->maxmsgsize = hwinfo.ml > 3 ?
-		hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : AP_DEFAULT_MAX_MSG_SIZE;
+		hwinfo.ml * (hwinfo.mlm + 1) * AP_TAPQ_ML_FIELD_CHUNK_SIZE :
+		AP_DEFAULT_MAX_MSG_SIZE;
 
 	return ac;
 }
-- 
2.43.0

