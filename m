Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61586432BCA;
	Wed,  5 Aug 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928589; cv=none; b=CjOSq+RjfPNCh9LxuiJNFGqVOIE/XLlG4MzweH2xBcSQtxY3Yr+VpsmSukxlP0dzaCOnGCck9ls2V6gHOoCJL9y8UI3TH0VGrpHshb4+RWssu6lL/tvd9359VSLCVePItVIyA+zk4i1hLbjzOmiUtH4fAFxn+/zwCggICiv2kJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928589; c=relaxed/simple;
	bh=wIyedExe1pyyRydPxzOc84SFY3Np1UdmSJTH1GPHuaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BekPLqhfFBwUD+C0lhvO9wA/N21X5tpF0Tw+YQdATNhaaXM4t/dkcvENZ/WlrLumNfK8Dn/iowrp13N1IcRO0BY6sLDEIWDU4sZX64xP9zhK8thIPfDZw7SfZbcTrW2wFK9bQDN7SsS2RA6oWny1R+VZOiQqMFWzWcN3kKYE4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MwO99/Xo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MwO99/Xo"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758llZB3437977;
	Wed, 5 Aug 2026 11:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xAkSbN
	GW2ch2RshrfZ8DeSEHCakw6tnWwc4kMUB0Ap8=; b=MwO99/XoUu3DeXxHnTsnMq
	D+CMFCeeOQhSap67Wh3DoDq0y2FktAXk7CBCy095UGd4PVWbaCxAS0EinHXEKJHs
	q0F1IMWjBhb4cuTzKq5s4go5Uj9WlVGYlM09qoTpW7mT7yRavNGjWoyJIPqOU2/B
	3aqX3e1GMfDeUfy9L+CTHPOEj0P+zHFgjCYL8hDybYZUXy8QWKwyerBuqNL4GIZM
	8u073za4Qp5UbqOg1gAL8OC9ltWDtBHGXWrONB5ga7VHeuidokhvKnZxjSMHPqfk
	uC9uzekAFsaUxSNSYHGLL0PL8sFumh9c4HXrHC92WqJ90DKxYPF2HkOGZY9dDFjg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eut64j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfZNO006305;
	Wed, 5 Aug 2026 11:16:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k685f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGHmx49676724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 421AF2004F;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 259B42004B;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 04/19] s390/dasd: Snapshot intrc before freeing the request block
Date: Wed,  5 Aug 2026 13:15:57 +0200
Message-ID: <20260805111612.1285190-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805111612.1285190-1-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: anNSvy9D8ApuPR2i_l9Via0-V0SmqYpS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX/D1/Gc2ETwjv
 66au0DWy6k0fD86xDUy8XCgpHwryb+oew6lkueZkCpRGmXVrQFjTznrwMa+wcApACo+JH7c804A
 MZP4RXXoHNpI4RWGYVOhyQMc8of+nPg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXycdiq9/UoZbK
 puOFBpsD570yp5xowBmLqELg1twNjN1h2sGkAqMZmKeP5EzMvHE4gL0MaTfJdw7189VMlo3o/BU
 FPCEsYOZbE8mAI68m0Ygr1VzDjfN7+Zx1+a61j78e1a6EQbSv3Q+6/ehSlHJz4v9/yQMhk+eah/
 2xKEMYJQDgaOSajtOiXeXA7l/Ygh1V5zGaPFPW5OVOFPkoT2shv1cqMgmkgkmXHnkfITX0mlqsD
 /eRJmKKhf2Sz2UEUpRvIYFVVzmIK9Vr0UM6HjLWZruxujgmZuF1keDXNXtfI5nNGsNz6FrSOas8
 kRACLU8mEZ/Ru7GRKnbMMsMgfNEOVOMPHq2/aFLFLE7JE6sVIju0dXgouZi68zq0GgZoy7RFnal
 mI26REU5vtX5iIQJgQvp34ZFs0xl7ClQbRG3UGVpm5MR9eXr6pHPTueTVUMcSruwO1nLTn8aDJ6
 NS4hPGT+KEUbecj6IFg==
X-Proofpoint-GUID: anNSvy9D8ApuPR2i_l9Via0-V0SmqYpS
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a731b88 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=QORe2UURYKPq8wpwqioA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

__dasd_cleanup_cqr() maps the completion result to a block status by
reading cqr->intrc, but only after discipline->free_cp() has returned the
request block to its memory pool (dasd_eckd_free_cp() ends in
dasd_sfree_request()). On SMP another CPU can reallocate that block and
overwrite cqr->intrc before it is read, completing the request with the
wrong error. proc_bytes is already snapshotted before free_cp() for the
same reason; do the same for intrc.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 56ef38243f82..34b563917098 100644
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

