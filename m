Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1C2E612E
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292898; cv=none; b=LjcEZ0TsHWhDthk+GS27/P1CMrftdKiJ5e/BJFETDLTNXyNLGwY/w3HDZVU4CpDSwjM5LoOU6JoTrjpjUtQ/L+5Rsvg4vffod2o2aWkgPBCCtMIKP1JZntS3U9h0P9knNre64rSL3L5CY49lKctIJwYqFJrKxj//M+kT9fx8+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292898; c=relaxed/simple;
	bh=PyR5qbTd8PFP3/55IsWoUO30zTGYdvwaoGl4wrLdZac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oEwQzJXNgSNiicrtOHvZHTf6XjUm2LAVsYUhjHxQFmad/21yQOQBNyw87bX4GuXTGvVQdbGMUtRtH9oB6TcflRpP384/Siehk398+lwNzTuo+yJRh6LGcUHeoWtD2oFH0hFuOD1/49fYs2Z57fkHCM9VDFFyXnwBTmjWcPRuvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QnWYR61V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QnWYR61V"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BZoPY3616593
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 13:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=UKXg7n74o0r9eISxwmzhOowthpkFfBLFw+cDgTpF3
	3M=; b=QnWYR61VgcmG/Y//4g8+M7fV3JqejhaknKfcIpapZCAPPia1mq34o61CJ
	n0u9q3YJma4uRmd02UaVTizaH3yvftF9O03IwSQ6DJEV7dqbUsbt4yknf36cmq3O
	rgNvdT9dHEZ0GmOh3CiA2qRR5nVvhs7hqE30Hemm8O9pca+8RtIYkQNs/wo4uO2H
	OVIiYOZkAGonmThP4ifV8p3WmbyLqMLAZ+aWBdijDl2zFmeFqK58ZqrC/KEirhAn
	Izpoh00EEypfruNp1iVE/k3jFpcuwC/ywgVY32ONY/b3aXqZO+EDqTW7bqmrtYRJ
	E1R6U2k3IGG2C2LJHWSKnihxAZk6g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv75nw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 13:21:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696BWWiN227915
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 13:21:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pt7vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 13:21:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696DLRKh25362746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 13:21:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7CED2004B;
	Tue,  6 Oct 2026 13:21:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D9D720040;
	Tue,  6 Oct 2026 13:21:27 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.234])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 13:21:27 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1] s390/ap: Support new APMLM field with PQAP/TAPQ instruction
Date: Tue,  6 Oct 2026 15:21:27 +0200
Message-ID: <20261006132127.6251-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aPT3b6ipf-c9f6KP3WM4a7F6ORXYTwqc
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac4f5e0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VL-pioXpu86RE13vmqYA:9
X-Proofpoint-GUID: aPT3b6ipf-c9f6KP3WM4a7F6ORXYTwqc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX5CnMD8sEC2WN
 EKDg+J+786Z88TzdYQyEAOiPB2SrnPi5NvFpNl3g2AofZvvSEr+Dnpc8mc/6N8L6B711bPZpuvx
 EGr/XbYDbPp+OfGD2hopi+qigWU90E1YJJ4UfdDUtLsgm1IKynumIgdBB9ROZjiKyJR8tXxvUW8
 /iISQxVo7Ct6frZUagjHZc2pFWk44GJOxmX6AfjDan2BvUvtkjDbZaZUazsfYyWXwyufMdPaxNN
 Lu/1MZjtqbbWDYGN7wWTJHyRFiZ37fwT7AhiOvGGz4Ai2Xt7JzjDcjzJO5MBXxScJa53+jQFzmB
 xAE4vwO+c2ygZyPk9cur+4xo/fNDSgYjoHiXEdzmUMGJD1SI+3UnZvm8VqOR1LLtIKbkCYo7J71
 z2ylq9PwjplIavbf+GRRgHLx6sJRFAfLIgeqbB6vK9i7l4KtoIAU5v02QvDEqMiDSqtMDHJlp5o
 rsPHY4NYC/dZE62aqIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfXyWpAXf6uLDoj
 Ly1Wf4Umb2pvv2knRner1N0phYuZWrsPBjmLyGnjSbyvP0gud5z6nL+fgJK9yydQ946RWGEt5te
 R/YPXhvO+ClJdtP8siO6WRhJ09IN92I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060052

There is a new field APMLM (AP message limit multiplier) defined
within the GR2 register on successful invocation of the TAPQ
subfunction for the PQAP instruction.

So the new formula to calculate the AP max message limit is now:

  if ml field <= 3
    AP max message limit is 12KB
  else
    AP max message limit = apml * (apmlm + 1) * 4KB

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/include/asm/ap.h    | 4 ++--
 drivers/s390/crypto/ap_card.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

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

