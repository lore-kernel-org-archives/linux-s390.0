Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1872271479
	for <linux-s390@vger.kernel.org>; Wed, 28 May 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748421043; cv=none; b=cXwEOz9yNb/lg1fzoK973RlqN9AX4SFnyCEljG/9TsJ4V2nOa2jlpS1Z2UNY24EFWe4Pi8TdOLNxAnKJ/qnAl0scXSA44VzMGS7UBo/g94mcODcBLU1eYcT3kVBKemAk1nJbF8VX1Xo2C6VffvLHxzQ3kcl5uUb23lPsTCj11Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748421043; c=relaxed/simple;
	bh=E7HwsxmxYCMKIDC0A47Q+GeruRcygPm/MZSMPiD9S2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AF+zp3TQdq15PO7lfoDazLJolHHta9Ybn/dJB0R350v4lJUwFKfTEXNpEg/m2wPAhhXjeg2qmnXbSVTjfEzPgICkUsssVIs0YO1LGvPulmj0AV/B+CFZxXJunPPbFAhE659DSIkv8yTRTUvvGPZSrW9yP4AAOosuM9FYzhCS2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PwX+ahyu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PwX+ahyu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S3Hm6Y004453;
	Wed, 28 May 2025 08:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BUM9nbLsosYpJYoUraRHbJILzJuUwgD9O3wU9iAxP
	70=; b=PwX+ahyup7NMxKsNyoJC+TJ/CQK+xH+FLmbT3DC/rwvsGsY+JZptbZU4p
	X8Oh+x02sel9nCtlvE3BKZ4qolpEiJOqNLdDmm92C+uXS2AqEEmDL//07VncKMOI
	ltnfhGl6yPGmR2swge2CjKp7fVzO963JSHZsNSqdOQfPGAVH+G9nUXtqz/3jc0Xx
	1haaTqBs1YVleEm/bH4R/ND8bfedJWyiN3DjC+2Dprtdv+/JAkTtkkUiamFwbROz
	R8WAb5A2L0KBRudJG/DBkrTM3Y5TXHpyr3sZD5D5kSJfm1ocJfvgVvHwDAEAB4j/
	/kmsSzDcFthtztam2NDNxReQfR1Yw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsjbndn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 08:30:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54S62E8I016212;
	Wed, 28 May 2025 08:30:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46uru0psgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 08:30:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54S8UX9N51642722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 08:30:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E77CD20043;
	Wed, 28 May 2025 08:30:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E08E20040;
	Wed, 28 May 2025 08:30:32 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.111.83.224])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 May 2025 08:30:32 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        thuth@redhat.com
Cc: linux390-list@tuxmaker.boeblingen.de.ibm.com, dengler@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v4] s390/crypto: Select crypto engine in Kconfig when PAES is chosen
Date: Wed, 28 May 2025 10:30:32 +0200
Message-ID: <20250528083032.224430-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qspe3Uyd c=1 sm=1 tr=0 ts=6836c9ae cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=6H6loCcm9Z6ljKak2KQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA2OCBTYWx0ZWRfX2BAbJ8leBUMh CbLaFiAUyKj5pzT9rNFgNS/nxU0RxUn15fG832scuUBZGapP1FLQGhIEXAoXqee4lPVNo7RIzDx hk8Y2xOf2CRAGPAYcom9ONxzuSOq5s+DRt9nLJTtiXinJ35KoSVtAhEgPwU7sYDJdxrbA6mSrh4
 gxUDHwo5k02gAwEB+TfCxgL0dV1k5xJBnFHXuuGWBrpvhKeGHHPtA76aMeg2t7cDTAISNC8v84y mkYURUDL5hnN6+9zVcWNmN3MLe6hcMBzapYVuTFtEVO+jRtB0CtD82uAyeXvcRChQJqmna6L6ME lHTTK6V0Kn7Wbx17d2Tr+Gzcpu0HWYDLL1UWFK2i2aLLnk6pjVD2PpVOrnTJAlMglRo+9tr1zcH
 oRkA1iw6qLaQL0p+VHYSpZUpmPLujDa1GkQxzaJSqyc5TgUOAm/nn0qs4XwXvr+1F7bmXAMZ
X-Proofpoint-ORIG-GUID: cVAtMSwgaAo4exflyJzIUkAuxkDTxzhG
X-Proofpoint-GUID: cVAtMSwgaAo4exflyJzIUkAuxkDTxzhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_04,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 spamscore=0
 mlxlogscore=748 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280068

The s390 PAES crypto algorithm has a dependency to the
crypto engine. So enable the crypto engine via
SELECT CRYPTO_ENGINE in drivers/crypto/Kconfig when
CRYPTO_PAES_S390 is chosen.

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Reported-by: Thomas Huth <thuth@redhat.com>
Closes: https://lore.kernel.org/linux-s390/f958f869-8da3-48d9-a118-f3cf9a9ea75c@redhat.com/
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 47082782008a..226fdaaa2efa 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -180,6 +180,7 @@ config CRYPTO_PAES_S390
 	depends on PKEY
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
+	select CRYPTO_ENGINE
 	help
 	  This is the s390 hardware accelerated implementation of the
 	  AES cipher algorithms for use with protected key.
-- 
2.43.0

