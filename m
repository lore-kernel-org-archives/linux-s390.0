Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AB521203
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577620; cv=none; b=IyjWhKxNuv8KCvxuLfqnGp2MF1jVR99rGvLzhSWeH12KNNpg49vXsbsordLgsBExj1oBYu5bDzu0ObqvBiW4j3VWjvAJGSx21cPOgrFrIZMlO0CQbDMMt2u/THa1dUOd3H0gOF54ZoJNAcbJetTP3IMWVODz9VaWrDESMuOObco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577620; c=relaxed/simple;
	bh=DlxXYjqA1WxKkdy4Ua1c25yArF6gBcVAUhJfPTgsK28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akh5uagiCsN75MH8k2yyJxBeGeonj677QY3Mmf6C+S7JPWqDTBCeUxSUjaGbA/Y9aplJgYJ550ZFQucOdvgpVKgltSi3yHMxb2CxGuWAYUpVK9D+AFcmIwiYQw8HNdJ7tAzhNx83vJidkCEovi6yIygoDc9sWE7ei4dovD0Lwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C4C5mYru; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C4C5mYru"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1eca4057249
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=shVSFu8iE5rxD2PXZcakQ+i+BE4uj9swGhEChYjEp
	U4=; b=C4C5mYruOywIZmeJ4qXyX7l8xOjgCPf50O1TTkaWAZN/A2HZYhelqWsA2
	902YIylV+yN9/cbNfo4JHp2gQxvBbnUXrESlLWDpGqENLfuMoLp3wruG1xyxd3Qj
	W1Z+N6OMBH0zCbWTvmC+Gf8ifKZsJfRMxSVDZjq3wKMeSjWEXj0UHJkvS8GSYzre
	UEWiinFRviOOuUQGv6VE4SQIEsZFj7BMZ+jlIFy5Xphh5ROQ7WTmYlTyBZ1lG1XN
	cPG8zyox+EylSWq5wPuIvu//CuemXO9LOs9BzlOBJmFCIVvQsbfLyY1sxnG3j/3d
	UCMgoqpA2GsgM3x+M0AzLqaK0sw9A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hwqwc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:53:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFe5Dk2599784
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:53:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d7w9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:53:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GGrVCi50528626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 16:53:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6F3620043;
	Wed, 16 Sep 2026 16:53:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C32DA20040;
	Wed, 16 Sep 2026 16:53:30 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 16:53:30 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH] s390/debug: Reject NULL debug info in debug_dump()
Date: Wed, 16 Sep 2026 18:53:30 +0200
Message-ID: <20260916165330.2309909-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyNiBTYWx0ZWRfX1VpFP5VeWYsN
 o0Akjg1COiK3VBAbDAAg6O2vaKKWL1037gmY3PQ15otMIDDpluNN/qomK+ofVIs4qiYu9VNRCDS
 awe7GUuCMeuf/G0MjGzFnBH45uDRiRVIKikArGUG/jgpm5JhJHYl8RMcWSkq3vdN0qzvpy9qPu/
 85VT/nlOtKOAw32TK3RGCr2F6hiwF4kG9wWIFhPB8FL7WsxSpm/vD4ajAxlRQ/w0JXBaXnvNARB
 brBflZ1NJnzP1SCJoOARKRLwc7XPswrnNNYRrVdZ5XspJeb3fzMFZbk2R3lE+QI8e5HeVYaBkjD
 R+g62/ycr6R31m6X6k9y88+Hbib/Ceyx4t5fTWIkqLBZg+faOfpYGlGGn1/cRDL6bc6/cxMB09X
 atN6qV3u+f9G3DrEsp8o09NuM3sf1YbDLJ9+ZP6xzvuYv2pa76m5O1O0uMu7P2krKIBD17Js23r
 fe6oOcqq172vkpFXBtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIyNiBTYWx0ZWRfX/nF7umuTiVvA
 f8UppX7QTHBK8LZwAc9byaC3CvyLO3px9UeMsTcMFT2CHrIDlzujwWD/IfQUryw/kgF35UxbP69
 dM4VAZF73UCJ0IMbogSkRRDY4NeEHlc=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aaac98f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=f5iO84m0z7rEuJ1daokA:9
X-Proofpoint-ORIG-GUID: ZqnprQKeVgPs-XMBf8ZbAbvKXmTD6Qrz
X-Proofpoint-GUID: ZqnprQKeVgPs-XMBf8ZbAbvKXmTD6Qrz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160226

debug_dump() passes id on to debug_info_copy(), which dereferences
in->name unchecked. debug_unregister(), debug_set_size() and
debug_register_view() guard against a NULL id but debug_dump() does not.
Nothing reaches this today, but add the check for consistency.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260910110147.96E851F000FF@smtp.kernel.org/
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/kernel/debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index b5bf8284dbfc..354ce78fc0cf 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -823,6 +823,9 @@ ssize_t debug_dump(debug_info_t *id, struct debug_view *view,
 	file_private_info_t *p_info;
 	size_t size, offset = 0;
 
+	if (!id)
+		return -EINVAL;
+
 	/* Need space for '\0' byte */
 	if (buf_size < 1)
 		return 0;
-- 
2.55.0

