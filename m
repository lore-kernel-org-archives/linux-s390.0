Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF5187342;
	Mon, 15 Jul 2024 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042692; cv=none; b=kZx992fBG/JrDc8Czp4CVi3VkoOvs4XhuH3YNPGuFJDyWi8OEr+czIfvFdZ6c/0UihGzjWTdnkLDhBmGuRBXq/CzBBHm/Lt5hKVVUA3Nsl9tqGecuDbYrvzUMfJY6iZxpsZ8ZqgvpaDCJ59w+pBw+TB6YjoS6qhlOwRmD6Wll1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042692; c=relaxed/simple;
	bh=eS7bZlMDGgsgBey8LLxcemKWoEI5DxmaPY93q1zGB0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OygzYd3X6d6mOzY70CcS5xpi/h31vBCSWcU67JAdxNuusipykLsU6EoqhavbfL0Tv6D9nQGTHqrq4AtAf8t6GIlMdFiR9LtjyaB+AfKiaZ6TotWvDheRO7DM/t7A3659pe1jMNE4C2nr0jtddiOd2vQdsn1HRh5dLhBp/foau6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AjnmX2rb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AjnmX2rb"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FAQmVR022360;
	Mon, 15 Jul 2024 11:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	iAHUwOqYp48yZX/YESNbzkY7fiodDWGQVMke/yXQ1M8=; b=AjnmX2rb6vLlBtZA
	EcaDZ7LQ9ZdByqGDHjEHFadzhpiU9sCxruHz9ps2ahGCCNajVWu06AQUzV6Pax7M
	5kGrn9FpCCTgkAsKqpsIkBTTaynzhkwGuLAPaWvvKP+lS+jqtxsvv9M8TtnG6MCK
	l72w14AiFZzy1kI1LniqNP4lEvdvjIAcC1wQ60Ejf3Ymc9wioIa7oUA8OLOuGPwr
	eiFpdPkNInyaxAMNbnNQHMtQEa+IRWz9GVmOEnjnQcS+4saHlXZopPB+k2AWVVWj
	7MDHdA+kTpoNsucW6gvb+K4Jv2qbLGlEtcjS7yyXuAHWaqaOzzTb+ORQIoK5OV6n
	aETZOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d09mgdr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 11:24:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46F8dUuh030685;
	Mon, 15 Jul 2024 11:24:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c4a0esjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 11:24:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46FBOZgN33424116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 11:24:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3929420075;
	Mon, 15 Jul 2024 11:24:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29A4A2004D;
	Mon, 15 Jul 2024 11:24:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jul 2024 11:24:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id D634AE0A71; Mon, 15 Jul 2024 13:24:34 +0200 (CEST)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Carlos Lopez <clopez@suse.de>
Subject: [PATCH 2/2] s390/dasd: fix error checks in dasd_copy_pair_store()
Date: Mon, 15 Jul 2024 13:24:34 +0200
Message-Id: <20240715112434.2111291-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240715112434.2111291-1-sth@linux.ibm.com>
References: <20240715112434.2111291-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: po1aAGtzql5Jie-P0KDaca2sns9s1E4X
X-Proofpoint-ORIG-GUID: po1aAGtzql5Jie-P0KDaca2sns9s1E4X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150090

From: Carlos López <clopez@suse.de>

dasd_add_busid() can return an error via ERR_PTR() if an allocation
fails. However, two callsites in dasd_copy_pair_store() do not check
the result, potentially resulting in a NULL pointer dereference. Fix
this by checking the result with IS_ERR() and returning the error up
the stack.

Fixes: a91ff09d39f9b ("s390/dasd: add copy pair setup")
Signed-off-by: Carlos López <clopez@suse.de>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 0316c20823ee..6adaeb985dde 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -2248,13 +2248,19 @@ static ssize_t dasd_copy_pair_store(struct device *dev,
 
 	/* allocate primary devmap if needed */
 	prim_devmap = dasd_find_busid(prim_busid);
-	if (IS_ERR(prim_devmap))
+	if (IS_ERR(prim_devmap)) {
 		prim_devmap = dasd_add_busid(prim_busid, DASD_FEATURE_DEFAULT);
+		if (IS_ERR(prim_devmap))
+			return PTR_ERR(prim_devmap);
+	}
 
 	/* allocate secondary devmap if needed */
 	sec_devmap = dasd_find_busid(sec_busid);
-	if (IS_ERR(sec_devmap))
+	if (IS_ERR(sec_devmap)) {
 		sec_devmap = dasd_add_busid(sec_busid, DASD_FEATURE_DEFAULT);
+		if (IS_ERR(sec_devmap))
+			return PTR_ERR(sec_devmap);
+	}
 
 	/* setting copy relation is only allowed for offline secondary */
 	if (sec_devmap->device)
-- 
2.40.1

