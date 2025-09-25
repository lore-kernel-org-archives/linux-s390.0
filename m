Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B632D5957;
	Thu, 25 Sep 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815239; cv=none; b=gjx+tBqUXqq7Pfqeff8JoFFGqeozPToP1hNZX8t9iAmBvr6jiU8pug4gHzJ6bbVwgSrSVKRBr41iApE89zkttJ/PR90pbtAeqvZ2hhEPhdxJde1K4JF02D3Bi6SETAoCweDot15Y46lKmFeZivDj0HM+Utn1USGAOwMXERvkyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815239; c=relaxed/simple;
	bh=za5bphBilPm/++ULRiGf/V2WWvL7GaIkBK6dluYoN6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5nJ1hmC3H5MRfJeuQyDzdhA5FQfN9AH3fPUtU+0UruareZqUanLfI618QENblvofIpkw/A5db2Zg6FCo1c38kjDDgT0P0MzRlT54wL92dU0h6mcZ4lgBC1J76uhnsPOJPEDlRPNvMplYjaBzJl/jywOqvyWpH9uRqoVikkhFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HBRZeIMr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HBRZeIMr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCK72w010200;
	Thu, 25 Sep 2025 15:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bl2ksS3iM22H/Rf7R
	uERZ7GijCiZ346PK8GXuHfExdM=; b=HBRZeIMrPL/nH7ymm4P1icPVzdg1x/ezr
	WKXhKDbJUxmHfmybrjP6P7kMGNb09JHSu6A1yYA6d4IyocY7UfcW8jd8T3BYtH/R
	nIdd0MR+Q1O0WVlohBZET9mj9V/n10f+94m77e9xzlCCERcZMqKKhbHcJoILn6tR
	fM1b29PvUVKWt75gQXII64lr7LFELwntdW2EAzyNJ8XhNF1tyApgJgNEocsST66a
	OcyTIe8n+/Iw8nYJL/rljfWG7H6hDMQsHBkrZNcMQFtF/Nilj6sjvxoD9WwGy3yF
	YXOHBUpqkKRWbNyqclb7SkE13U9LqHzwzqGHyqieA6TlXxYm9fTDA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jxm8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 15:47:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PDGAWe031186;
	Thu, 25 Sep 2025 15:47:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vdfpu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 15:47:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58PFl9hB51183918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 15:47:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C5892004D;
	Thu, 25 Sep 2025 15:47:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF43020043;
	Thu, 25 Sep 2025 15:47:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Sep 2025 15:47:08 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id AF883E0677; Thu, 25 Sep 2025 17:47:08 +0200 (CEST)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH 1/2] s390/dasd: Return BLK_STS_INVAL for EINVAL from do_dasd_request
Date: Thu, 25 Sep 2025 17:47:07 +0200
Message-ID: <20250925154708.644575-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925154708.644575-1-sth@linux.ibm.com>
References: <20250925154708.644575-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX7M1NwFnYky29
 RuKLntJFKM2PS0DKBrQXuGGivSIcljuTPRnimnXS4gJ9P2VIfpFl9vrzMHXs7BkZT9ViV/rXZBN
 cMfY9wc76JFuUteq8vi7F/fUADFQ6dXd3aRCMAYSDBDq+bPl72tiq/pSRJ8OOaydAvlp9Bl+hcg
 BHSe/T0mQ8BUbFVBpT0y5Z4pD2SWIymqyleykiieEviZZlTHv0p36NAmjQx+0eRLB4pL00bmgys
 gJhr3Gbsu3PoDqU5xqsyDOH6C6G8atoS6Sx9dLexV5Dah1XbFjFgwTy57qK9ZRqYhXFYEg9IJWo
 YdRGzmCH1SAJX6PuqdFUUpniyoB7tZJbBuavQDUQJTJvMclCi05oefHSpucSutiQbVw4+uTLYOM
 tp9BefHC
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d56403 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=5HYLi5Z2OpODttMnKXIA:9
X-Proofpoint-ORIG-GUID: lTzWubWa4PtRP2O-ob3uNNb16mVrzhzW
X-Proofpoint-GUID: lTzWubWa4PtRP2O-ob3uNNb16mVrzhzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

From: Jaehoon Kim <jhkim@linux.ibm.com>

Currently, if CCW request creation fails with -EINVAL, the DASD driver
returns BLK_STS_IOERR to the block layer.

This can happen, for example, when a user-space application such as QEMU
passes a misaligned buffer, but the original cause of the error is
masked as a generic I/O error.

This patch changes the behavior so that -EINVAL is returned as
BLK_STS_INVAL, allowing user space to properly detect alignment issues
instead of interpreting them as I/O errors.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Cc: stable@vger.kernel.org #6.11+
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 506a947d00a5..6224ba412623 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3114,12 +3114,14 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 		    PTR_ERR(cqr) == -ENOMEM ||
 		    PTR_ERR(cqr) == -EAGAIN) {
 			rc = BLK_STS_RESOURCE;
-			goto out;
+		} else if (PTR_ERR(cqr) == -EINVAL) {
+			rc = BLK_STS_INVAL;
+		} else {
+			DBF_DEV_EVENT(DBF_ERR, basedev,
+				      "CCW creation failed (rc=%ld) on request %p",
+				      PTR_ERR(cqr), req);
+			rc = BLK_STS_IOERR;
 		}
-		DBF_DEV_EVENT(DBF_ERR, basedev,
-			      "CCW creation failed (rc=%ld) on request %p",
-			      PTR_ERR(cqr), req);
-		rc = BLK_STS_IOERR;
 		goto out;
 	}
 	/*
-- 
2.48.1

