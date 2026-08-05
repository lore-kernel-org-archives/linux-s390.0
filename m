Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED33E6381
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922176; cv=none; b=ijtdGpBhB3I0dcXzEXQqOVR+9TP2EkknldfxJ6xzxsjpfcLt51e/lpbyPtbBHb5slrnGMpli+xZRW/LgM5ytKEHQc54YySaskrPLy9mFzQFoGWeUKhuHhB1HyhPnOzaQh924a8WkZGLn5/M0Iha3ciB3B5NZWIpztEXtUsDv5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922176; c=relaxed/simple;
	bh=PQpWgNofgT1yz3dTV3eCqUj/lttL+261UGJiQlUOK3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxLfCjbclZUjK+nye7yVsr9xZLcxgB+nnfHM1x7aeMfyRobi3bP2S41Ue1zvf+MH2oRCXFDHNeDjaYIbZGK2inuh83A5ioT0jiF85lJILq7/GW1OEwGngidnMUVZlPe9PqYF4/9y6EznNyWydlHNe9PEAARQ8zm3gCVTULdvp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ksrFpJQb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ksrFpJQb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lpDs1503366
	for <linux-s390@vger.kernel.org>; Wed, 5 Aug 2026 09:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bGltVHDcS2PIQj0zbrmIZWgN8cKJcdlSCSmoTvPOJ
	BA=; b=ksrFpJQbUrzQJD9g+Z+8GlYwO9j57U8ebb/AvuuMadb3alf7N95JgkNkn
	RDTf/zHFWCf6oRicV7V/cLqwq0EvcMGrgwLSCNOszNpkJTq53HvOEEv8vFYXZJCm
	qlermHG/DDdeUPbFHGqLs7rQeKtlyJmmYBmBsvIqitB8dCSTLKO4exlX6+y5FgRo
	/gpc3KoDbN+/JGXzKGpcnShy4mEVzG+9AwHLZLlvrnDflDGy1rtlSzvRB4LPGFgZ
	DmpWFRLchFBHuXkoOXhy0z/sLNllhV4+6CAhPJgJ3Rk+M8gfrPOKYbp9OfcvvkrU
	zauPcdiNb0SgZAbqstU7U48AU5hvQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqt8j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 09:29:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6759QGJ5020760
	for <linux-s390@vger.kernel.org>; Wed, 5 Aug 2026 09:29:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtynp9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 09:29:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6759TTJQ15729110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 09:29:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49B932004B;
	Wed,  5 Aug 2026 09:29:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E20E420043;
	Wed,  5 Aug 2026 09:29:28 +0000 (GMT)
Received: from ibm.com (unknown [9.111.168.36])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 09:29:28 +0000 (GMT)
From: Finn Callies <fcallies@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, fcallies@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v2 1/1] s390/ap: Fix MAPML computation
Date: Wed,  5 Aug 2026 11:29:28 +0200
Message-ID: <20260805092928.26932-1-fcallies@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UH2L_t_uc8fdiKim7f-mlQT7kt1Y-ANo
X-Proofpoint-ORIG-GUID: UH2L_t_uc8fdiKim7f-mlQT7kt1Y-ANo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3MyBTYWx0ZWRfX3fP/eAH2fyyU
 Fa6CKkokCxQ8wP8DHVJm/DnxVQzG9hXloG5LSYjDpFeqZc9T+LbL4a+Xk3t06XGQg7GGprgrdry
 Yo0+a+fNPQHzvPlEKmeqR9WUo6Qvcts=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a73027e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=XsSDpCfCu2uNGC10d4UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3MyBTYWx0ZWRfX88HXC0VAbh9+
 HA3AiQIZtEap3A+hYmH36IfY5nmG8aLmhIeJ8lWehjQ85iWwkyMfeHEf46tT0U7df5tVTFVj8Rw
 G+4XoXWFqVzzRBf+BkCiSom9Q5E1fRtSg5NMbxK9nnrZ+L2OHSHuHKE1xaeDYAS12UIs3EYuV+j
 jTn3rRhMHhJ3f1OKPAmTB8rn0zCkcI6EjUYHtIpYohJoAubKwV2hxgOOtZ/u0Agz4f9EuVRl3yv
 HN9Q0hdtkQBPRpb9n8HFcJmhkM0jkQ4WixCnZ6pBZjYTF2ECslGGcakM3u3COGq0q6kzmA3NNaJ
 d3Yzs/d8H8ipX99i4AHOWBLGqkSSp9MfCeuz22262Pn9K4Nta7fW0pD4Pj9zerXjxKDULE51lG7
 3MZmJBf0eDAjD8a837g3fksXuiETH70dbx2eFc0kfeQfkLGHuXYxH0hANEhAddKSRbRxuYtz/a0
 PFLp/ayXVdyK7fFC5Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050073

When the TAPQ subfunction of PQAP returns a value between 0 and 3 in the
ml field, the Principles of Operation states that the Maximum AP Message
Length (MAPML) must be 12 KB.

The previous code incorrectly calculated smaller sizes for ml values 1-2:
- ml=1: 4 KB instead of 12 KB
- ml=2: 8 KB instead of 12 KB

While no current hardware reports ml=1 or ml=2, this fix ensures correct
behavior for specification compliance and future-proofing.

The fix ensures all ml values 0-3 correctly use the 12 KB default, with
only values 4+ using the formula ml * 4096.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Finn Callies <fcallies@linux.ibm.com>
---
 drivers/s390/crypto/ap_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
index e827fbeb76fb..c86397f4ddcd 100644
--- a/drivers/s390/crypto/ap_card.c
+++ b/drivers/s390/crypto/ap_card.c
@@ -241,7 +241,7 @@ struct ap_card *ap_card_create(int id, struct ap_tapq_hwinfo hwinfo,
 	ac->ap_dev.device_type = comp_type;
 	ac->hwinfo = hwinfo;
 	ac->id = id;
-	ac->maxmsgsize = hwinfo.ml > 0 ?
+	ac->maxmsgsize = hwinfo.ml > 3 ?
 		hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : AP_DEFAULT_MAX_MSG_SIZE;
 
 	return ac;
-- 
Finn Callies <fcallies@linux.ibm.com>
Linux on Z - crypto

