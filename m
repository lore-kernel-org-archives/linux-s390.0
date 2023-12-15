Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8136AEA;
	Fri, 15 Dec 2023 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHtWfF9T"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEkrn6022216;
	Fri, 15 Dec 2023 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZaRCtM3TEtQv27k3zYafCj7W025DJess/ym1q85zgXw=;
 b=sHtWfF9TBpFc5ADHd2sz0K+tASB3kXAtOp70pvW6PZaBeGVEfWMpT+8wyTxuiHBOC3ve
 UGBx6h4RA0SUx6ep3pGq5i0xJEPqFhtfC+ATxEGyWH0CVNHIfLIbRxD7H9FmarIK4/tn
 cJjb8Zu0QPAvBlq+4fi9NuyToQfj4CR3CtvAmbLAxb4jOrRTRj26klzQqB/Vo2dUK3OD
 LKwXjI44+5hnJeZJG+u4swhcRfWr5ZNXMbSDkE9vOFWoOLOCjZ3hShFfkL1jI7gzjHyi
 ckTXQapvoagooVZTa3ggDSmm07eTD/nbXoIcJpEnwRF77Swbz/ZdGfjZ/SNUYNkkerud hQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0p155q7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFDNkHo028248;
	Fri, 15 Dec 2023 15:28:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2y090q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFSAEd45089160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6E872004B;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D625420040;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 98394E12F1; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 04/10] s390/dasd: Move allocation error message to DBF
Date: Fri, 15 Dec 2023 16:28:04 +0100
Message-Id: <20231215152809.882602-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215152809.882602-1-sth@linux.ibm.com>
References: <20231215152809.882602-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a8j17C_kO6Gn0dWyH-whSLqpfXqf5Lb4
X-Proofpoint-GUID: a8j17C_kO6Gn0dWyH-whSLqpfXqf5Lb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150105

From: Jan Höppner <hoeppner@linux.ibm.com>

All error messages for a failling dasd_smalloc_request() call are logged
via DBF, except one. There is no value in logging this particular
allocation failure via dev_err(). Move the message to DBF, too, to be
in line with the rest.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 2e084fd8e520..60e666b7ca05 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3969,10 +3969,8 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 				   NULL);
 
 	if (IS_ERR(cqr)) {
-		/* internal error 13 - Allocating the RDC request failed*/
-		dev_err(&device->cdev->dev,
-			 "An error occurred in the DASD device driver, "
-			 "reason=%s\n", "13");
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+				"Could not allocate RDC request");
 		return cqr;
 	}
 
-- 
2.40.1

