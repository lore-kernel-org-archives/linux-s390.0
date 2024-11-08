Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86E194A68;
	Fri,  8 Nov 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076422; cv=none; b=d/ozMBKS9qUU9xPOjWtRszjkyl87kInS5LDTsx9PIQKiN3PFFo7/4ZpPfME+TN7N+HYXd+d+y9lsRgtwp70lgTjopi73d3v12v0DT1EJUAxSADPXyWUpPqTAp4jGp4Dn5gocEL5Poy4oxCckHXlFdFh8OpfdeWiH4OwZBJ5YiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076422; c=relaxed/simple;
	bh=DgTWwZ2mNStTI1LlTm5Yaupcq6Bs+qLt78UhqjkxwX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+eJyHD0Ho9euil1NYpzYSXMqyuahfaGLcAc4A0CFQZOjxaioP8jmoOk7gVYo23p0BxKsKuNkTIfAKHm+ZgOYLz9kzGBN2i+GFv1+BAWCHcfOkzAAjYOzWHKN1csPTQmvHL7de2Q6Pr5CedwoSbAjNKM09iRzP7ibRDEzwf4xGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ksWz0feM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ksWz0feM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8E9lNx021272;
	Fri, 8 Nov 2024 14:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WCd7aHrfMc5xKyjYZ
	XAq9jNFvVa0uYQv31fMx4B4EnM=; b=ksWz0feMq1b+vTTUgJI/bS7Dfs6nxDiod
	eeQkdYnPFHjNYvFqIk1AEqud1lmdPLrxxSDAkzy8pQ1C9EQQFoscw3UU6uBFvmwT
	BuxsbPhEC525zExm/lkzfTNCjHxktbXNZiIjWncK+oliQl6vEBgq2sWveFx/UBll
	A3aZ6Ko9zCW947MGduUEE0gF7RRqUAw22dKlJ89dRplNExArn5PDOi2u5vAai+m3
	jJvgu7mXZYaMqFMEUz9v21upxj/QG8fNvzhufjy/s1DOpSQtnq0XITAvIxvu3GOm
	KxjTjglp/NoIK85ixmsuDNRLf/BeIM40b1mmOW2FKN3XCaU+H9n5A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sm5q04pb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 14:33:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8DBJow023983;
	Fri, 8 Nov 2024 13:39:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxt0ac0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 13:39:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A8DdEu530081692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 13:39:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44EDE20043;
	Fri,  8 Nov 2024 13:39:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 352DE20040;
	Fri,  8 Nov 2024 13:39:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Nov 2024 13:39:14 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id ED1F4E075A; Fri, 08 Nov 2024 14:39:13 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>, Yu Jiaoliang <yujiaoliang@vivo.com>
Subject: [PATCH 2/2] s390/dasd: Fix typo in comment
Date: Fri,  8 Nov 2024 14:39:13 +0100
Message-ID: <20241108133913.3068782-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108133913.3068782-1-sth@linux.ibm.com>
References: <20241108133913.3068782-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EWOD3Ec-XyPD2A07T76W1g3jkHhY-kHu
X-Proofpoint-GUID: EWOD3Ec-XyPD2A07T76W1g3jkHhY-kHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=421 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411080118

From: Yu Jiaoliang <yujiaoliang@vivo.com>

Fix typo in comment:
requeust->request,
Removve->Remove,
notthing->nothing.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c        | 2 +-
 drivers/s390/block/dasd_devmap.c | 2 +-
 drivers/s390/block/dasd_eckd.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 42a4a996defb..3ed642f4f00d 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2117,7 +2117,7 @@ int dasd_flush_device_queue(struct dasd_device *device)
 		case DASD_CQR_IN_IO:
 			rc = device->discipline->term_IO(cqr);
 			if (rc) {
-				/* unable to terminate requeust */
+				/* unable to terminate request */
 				dev_err(&device->cdev->dev,
 					"Flushing the DASD request queue failed\n");
 				/* stop flush processing */
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 6adaeb985dde..71d8fb86139d 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -855,7 +855,7 @@ dasd_delete_device(struct dasd_device *device)
 	dev_set_drvdata(&device->cdev->dev, NULL);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 
-	/* Removve copy relation */
+	/* Remove copy relation */
 	dasd_devmap_delete_copy_relation_device(device);
 	/*
 	 * Drop ref_count by 3, one for the devmap reference, one for
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 90b106408992..1ebe589b5185 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2405,7 +2405,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 	}
 
 	if (count_area != NULL && count_area->kl == 0) {
-		/* we found notthing violating our disk layout */
+		/* we found nothing violating our disk layout */
 		if (dasd_check_blocksize(count_area->dl) == 0)
 			block->bp_block = count_area->dl;
 	}
-- 
2.45.2

