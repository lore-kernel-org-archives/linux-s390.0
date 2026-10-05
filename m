Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212B37F732
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200425; cv=none; b=IE7zMIj0SVJerC2LoIbT1t5AgstpBw24KSEjHGDheuthg//IEDufyr57a3xzleTee7CVZbjmv2ps2riBwP64UDezVl/86EZDb/zNK0/zoGsIeYSjcV8BbY+k+6/d3o6//iFh0VgyJktkNTnILoOya5Bh50Fb1WVkexnTgBkJEYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200425; c=relaxed/simple;
	bh=lx9NY2eoUPGbuUq6OjM0VBoHpW7po4j5ENp+ub0OQEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UE4NkFfOcuGwRzkmBiEmZMmTOPWUQkfcEi3yTeWN9hvTN1CQeYhS0m4OV7ixwMFqzdG1azTjcJyXkFE36pOOL2Ort/xdB5FK5R8rxIuRtkazSHuGqT6ZjZ1+3wBnky/jMYI/bMvwYiRe3uCXeEEQdOJMSnPpw7CThBcxtLnsXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X9dM9N4e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X9dM9N4e"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZVRs526376
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 11:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9/5B3w8LV/ZSBnKvJPYdVEgX6lnzo+Cd28E+C+siv
	ms=; b=X9dM9N4elO5Ph2Cg1b/Qgp70e6LgdXVPJD9JXDeqO8bNNTqSotBMYKgVL
	D9X/gobLZ9Q2yO7TFZEwR8BbrjxmV3RLLAiSM9mLq3ERasSxIaMm6B7DE3kgLj+X
	9ULw5gJtF2rEB/kYXDrfGJ0JfWSmbAGkvUPthTDw2f5l8TM79/cxaPRGGVwBIFaH
	xQQ21mjS6Wh7OV08Jp/VLBZq3uCranzUjrGXRQCoE0SiXDLdclly7EjB7pfZ1zgn
	2OZedrtI6oBcL4XiJmOVkOuMmzquBZj6jyfRMmy5jsq4//vzSPTArS018ij6Eq7r
	9rf3U8fkvKBf2VbacwtsBBTnI6lHw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv15qh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 11:40:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BWVRl2824110
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 11:40:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jn852-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 11:40:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695BeIDL46072234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 11:40:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B435E20043;
	Mon,  5 Oct 2026 11:40:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 939342004E;
	Mon,  5 Oct 2026 11:40:18 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.167.168])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 11:40:18 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 0/2] Fix minor LLM findings in zcrypt dd
Date: Mon,  5 Oct 2026 13:40:16 +0200
Message-ID: <20261005114018.62489-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pgrrWdyMoreP3oTC6oxnHaEWO6OTVKaI
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac38ca7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=808YJrEDm0Q5m3IRJhUA:9 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: pgrrWdyMoreP3oTC6oxnHaEWO6OTVKaI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX6iqf32czGjWr
 9NXHYYT/iU/EM/il7wzvdUHoKFxmK5poQikZTSdsfQbjF4be0JZuXnhVndVIGt85Tj05PqXJGpD
 q7ZWdurxoIcX4aDSl+Z7ZnW6CJkygNmnsADTWNARQG682MKPb1NEvZ0EB7kwKLGCdGjij6S06bu
 Xh4ttpXgK2ZGOzv4JiZFodE+r6wVzVJboBmmMvM1zNb4JDaqvboJB8XSlDmt0GYWG2/MP93F1yq
 qDsHyn2zOb/LjSp+wW0tC8Q7Se68puoOZfQNLD8LQW2RKmPMek5EX5W762OAFMhvYZe+7NBSNxr
 7+FnJP7jNKfSj08GRk3QCWmTECYhGwXs7NmrF+MMZyTCncS75/ZHtJvQVMhbsQbOYKA4IC+qebL
 1MGEM7B5PPDqF0lzeBd/KvrrAARoFfSPyYThQ0cEU3tBgOdaskwJvMBJMaZED6Eofbmy/XyzrUY
 RHUYYq4/+m8loaY2ybg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX5GS+UbnR5w9c
 4itumIncI9MhJRIhi1PQj69iGqCOUIR7FXsZ0v5KunyqORvenZ4iLaF+dy0DEVhehFmLulJThCy
 HVxD54trEX5munQDEetky1PiGTQxjXA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050045

Fix some minor LLM findings related to the zcrypt device driver.

Changelog:
v1: Two patches:
    - The first patch fixes a gap related to speculative execution
      with the domain index.
    - The second patch fixes a length/pointer check with parsing the
      FQ reply from a CCA card.

Harald Freudenberger (2):
  s390/zcrypt: Guard domain index uses against speculative bypass
  s390/zcrypt: Fix out-of-bounds ptr advance in
    cca_query_crypto_facility()

 drivers/s390/crypto/zcrypt_api.c     | 10 ++++++++--
 drivers/s390/crypto/zcrypt_ccamisc.c | 22 ++++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

--
2.43.0

