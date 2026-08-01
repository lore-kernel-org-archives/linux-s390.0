Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CC73B4EAC
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607243; cv=none; b=U/lTFdX0VyQkvyR13KKdXwkvCq8H8eufEx9VZq3Rwd1jeZwMgEDe2DcRHnmgldLAMffog1EZZDnNINC3Gam+m+BRHLM8jn+YOUQB0aT5Vt9hgCis1uMj82aLDxk6cm9czesENzOrhKqMBsEHOIJJWnkW6mYisEJRGCeuVfaCTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607243; c=relaxed/simple;
	bh=LzsPfivYtLgvEd/8D52g1AT1vH6p4yvg0XjeCB6mW0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJqqmubWqPCWgapSryM3zUxK3QJ3b1lrynBDt17vQvLxH+Im+o3llXSJ/VajpqwH8Qth4vwtQsxwImCruKlz/5uJDq6xwJcZmfJ80gVd2ESNuE2B1UbzDEshFwDWI2rME9RWbCZS6dV0zma6XK3Woe5O02oGkHMJM57xKlmnEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bN25E9g6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bN25E9g6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671FmhI8882935
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kzgY+kcFeGQMN581r
	Q0CkliWClYxRn0Q/J4syiKYFBc=; b=bN25E9g6PBYTzjieHkNYuWC5GB26n7B6p
	ukmyEFFUe1fPC8RapahOlVXptHlnL65eUGBw88IJtKYSblpJJ+vlujbs12MvvBXI
	8vRQWV3BwFmWyRvrNK9l/FvGe4KmDTvDNgypKf85XXBAnsct7Tbz2HDb/crSEBDK
	5qI5UGKM15xLuepvh07YLD5eTVSrC+u615R1s+uqQOnDjOTkPvd8a6z/U6DUCHUt
	XKw0NrtIM16sPox99e5PldicIE7jDWAuIm8Fv5UFtiuP/M86i3kWCHA4vLFbdWoF
	ioqqgUFCK3xK/4YTalm9wmSBAnwVvCKtmy0hR+p5qTs4LKP9ZEb4w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77ft5hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuGhs027685
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgvhhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0aGo45875564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F0112004B;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 876882004E;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 04/19] s390/dasd: Snapshot intrc before freeing the request block
Date: Sat,  1 Aug 2026 20:00:18 +0200
Message-ID: <20260801180033.3679412-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX25Ziwb1L8miN
 bM2e1MyQEKoFJlogjQRF8HUZMDRfT+5skm5E0p/OVmW0L3tmqgx3KJcNM4uHHTpJEnnGUukVJ78
 D7C7b4hsov/nLwJk97E/V6Kcf5vgM4FBkB7cUXnswa6VNd4b7miIQFcqtx/taABh2TnbxCmBZtW
 e0sIUqx6c6E0pZRZ0Vwu/pZU95rWSnOhuHsg55wUcVOWy5ZXfSoylzBWUiHGXFapwwPbM3Dz91h
 4JUYHTIv48SIisl6F4wqqZm6z+rgzEduIpLZTtjIDSA7WvFXTKsrOCskerth9NDyzuFKUTp9rn3
 nbuKvsyIu0m+qoTJgS6Ne2dsdzUOElekhK9+mbMbEhTNSfOShyFZ8JgjwYM0wEhFclmdkFeZmPz
 yW36gWXQFeuMO7O1CNdgD87Jjk2jIQTFdixmQ9qfIaifDdnYcveU9mW00Jb9exZz7pzvYFJO2bK
 CxIakuNfxXvNckjjz2g==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a6e3449 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=QORe2UURYKPq8wpwqioA:9
X-Proofpoint-GUID: cERe1xCTnbGJFii-sm5xxbezE4oe0OdP
X-Proofpoint-ORIG-GUID: cERe1xCTnbGJFii-sm5xxbezE4oe0OdP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXwzWhEXvsJWAK
 6b+BLmSrxSm0hiEaYZeq1eLWpUzpZ8a+BXTeW44wo8U+SIzQ3TaOVXl6Du6QcAUNrBugQ/bRVzT
 Oq/AYGYjoddG930egrCuhp2ws4aV5nc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

__dasd_cleanup_cqr() maps the completion result to a block status by
reading cqr->intrc, but only after discipline->free_cp() has returned the
request block to its memory pool (dasd_eckd_free_cp() ends in
dasd_sfree_request()). On SMP another CPU can reallocate that block and
overwrite cqr->intrc before it is read, completing the request with the
wrong error. proc_bytes is already snapshotted before free_cp() for the
same reason; do the same for intrc.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index e9f0722af104..8ade71a22376 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2699,17 +2699,23 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_req *cqr)
 	struct request *req;
 	blk_status_t error = BLK_STS_OK;
 	unsigned int proc_bytes;
-	int status;
+	int status, intrc;
 
 	req = (struct request *) cqr->callback_data;
 	dasd_profile_end(cqr->block, cqr, req);
 
+	/*
+	 * free_cp() returns the request block to its memory pool, so snapshot
+	 * everything still needed from cqr before calling it - another CPU can
+	 * reallocate and overwrite the block right after.
+	 */
 	proc_bytes = cqr->proc_bytes;
+	intrc = cqr->intrc;
 	status = cqr->block->base->discipline->free_cp(cqr, req);
 	if (status < 0)
 		error = errno_to_blk_status(status);
 	else if (status == 0) {
-		switch (cqr->intrc) {
+		switch (intrc) {
 		case -EPERM:
 			/*
 			 * DASD doesn't implement SCSI/NVMe reservations, but it
-- 
2.53.0

