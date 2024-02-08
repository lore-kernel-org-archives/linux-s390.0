Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1081AB9;
	Thu,  8 Feb 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410581; cv=none; b=dSwSzmMuKCoZn085ZlTTjBjo/RPWEiCV/g5JnihivFkNY4PeNpLi0aSsPqn+OsfUntHk1U8ncT3tnHn6caIpLwRA1Cjy/ws8zgk3YNe7kRutLyMctiilNxe49lA51f2tW2Gb/UdFqz5TEh/OEIMtdNKP304+bL7YnQba4gpA4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410581; c=relaxed/simple;
	bh=KZZR7ojerZubJOjrLdQQ2+LepF+XrDn9W6Smd6PhveQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkEGlZ2G/qGrEoYZicAEOR2xrq/c0CsIWlFRHh/d90/Avs0SIiQx3Ht3RwOfxjwWsiBio3eI5mfVpYGGdtC2nhZBSGiSksuj8Z5e9/so45h7r3H1aGGAQY8zJRUypboXif/+uwWz7MIf1iQukx5sFcS+hOY7qBu786SauXfMAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DKeHIY+H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DKeHIY+H"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418GcZN0028609;
	Thu, 8 Feb 2024 16:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=RDPGqPHXQVLY/XWpf9XFwriiLB+94baFdowzR9xxKIE=;
 b=DKeHIY+HsjUyJFNIN6HCm8T7dN7ExoqxDvTgi1tPQo2tilkq6BXW0WjzdE3bslHVjOJH
 +88FTtRJGC+dsLK07t8uxTMpqNDoXG+0hV8MPPe7a87eVKCAkCxugStwIFsAOObWp8Jo
 qvY/Gpv+yCn2q1UFaXrShcAaKvQotuktECfM/oR5QT0o75/XrK46U3saZHyWcBd0ng/l
 oHo0wUrdKdAk/I1kUbJsp6LTRQf3+fHEDDjMBDQYpejPDHWjV+v0wcooMt0C0iStw7Vt
 l2P1y19tr3r2z5h0DkngDwp59XwCPJYYCvC9vbsgYk2NQGyeyVEaKygyTR4V3LJs9B6k 4g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w52n8r38p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418FnXSE005421;
	Thu, 8 Feb 2024 16:42:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akwgtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418GgmZw25428710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 16:42:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91BBD2005A;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EB7420043;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 46BA2E1515; Thu,  8 Feb 2024 17:42:48 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 04/11] s390/dasd: Move allocation error message to DBF
Date: Thu,  8 Feb 2024 17:42:43 +0100
Message-Id: <20240208164248.540985-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208164248.540985-1-sth@linux.ibm.com>
References: <20240208164248.540985-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KEsdk7bpQwS3Jw2A_Du5AGwpv895mDo8
X-Proofpoint-ORIG-GUID: KEsdk7bpQwS3Jw2A_Du5AGwpv895mDo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080088

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
index a9aa2db3f4ab..79697301fd83 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3963,10 +3963,8 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
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

