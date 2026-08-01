Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5069E37FF53
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582623; cv=none; b=VCBrZ0RSF15Qk++ib07GUMwBZEjp+JskrPg2hQBRbJl4k8rkU0CDxl7iO34FtVSd2caoIib3YUDBZB5rHrZU1h9Y8NwhlKBzYHG8ULmR0AWPEMoK7U9i5KkkGkYpfLg6mn/PpiXVkpvU6NROeHWT+weOg0vX98HtEY/nBN+sapE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582623; c=relaxed/simple;
	bh=2Cy1EGx6iYkQYdsK/PCNkierRJsx0oG/QxtTrEzYHMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukHeweJW9HOK1Jsic9YNubMQfVkZx/cIyivf5e66z/nxS43ta9Hn4wZuWbJGmQwVts2vZJnKQVKLTWliu1El0FtGnn7J7iYkm6kSZbcwMrZzK+IPML3d3pIlY6SP/5OBCIJAdkwt5zlB6m+Fhm6JPVxXVgBNwhy4/evceam3szM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nLAQb/td; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nLAQb/td"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6712jap73616143
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=chvKDX
	/ZCbChaAJ2TCmhInNUdxj7IXzKQoC/xVByzSQ=; b=nLAQb/tdBN2GX1L9n6D6zY
	D8yO/tEErnHgYkkN5YGY3Bd0UeaZzp/U4Og+UYGnGOu/HL0kAwmChp9+UY/HqNVJ
	TFgVwKcL/BzAnGgLq1nPrcPTQ4ct0B37rftp/Qsl3FjET4EPMvWBwpovtmkhQhg7
	X+5CDaqYHOLZnpkAi6yHerULBwkdbfnbyObKenfuZpkfY46wANoUQd3OJYlRF8Zz
	uqCjeEY/+voSLInm6leA692rb2CeVlPeu962gdsNoh4E0Qzp6QSPmFD08PEOo9h1
	y6L+jrm4/TkozquI2UCclv1Uz7gRr8KTtpga5oaoRr3iE/G4tTx/PfzbrlNmJfTQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3h4f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuKwm015984
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pguh2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAGC332702832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D56A220040;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBA8E2004B;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 02/18] s390/dasd: Propagate partial completion length across ERP recovery
Date: Sat,  1 Aug 2026 13:09:52 +0200
Message-ID: <20260801111008.3391031-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801111008.3391031-1-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a6dd41d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=01JC27pNfGPOVEZEpjYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ya5BJNdgcgwiQnaxfU8Ruf_DuO8cqRJW
X-Proofpoint-GUID: ya5BJNdgcgwiQnaxfU8Ruf_DuO8cqRJW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX5ku+It4vgOLc
 cP/JgKeTu2/YUYva2u4cbvyLBtLKGTSQ5F3lSVCyWTaApwuodXVTZRnpZK7ZR6xaOd+joKEozIy
 Xz/SmpgZl7LumK86NfKAsVLIPHL+jRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX5hk3rudw3jiJ
 Dq6xor3Q2thnmeSNMayYOoOhmoqbVZQSjTTdonGxEBcIwUgpDWrzlRqfVTGX/Oz+xJLfHAASFWO
 56JDGLzobLFcUSGeI6FlDeOzDTZLuUho32nL7P1QIC4KxRFJIGYGaXcm+rn+a+vEq1faTQIRvrR
 iP4eB3i77QgiQczaXCc1k9bqrIJyxnYAASoU7Z3IOulowO/9fGr5PCRd8zES4+mmGGxWmpg2GA3
 MdBiiB62ixm5gyY3E6z9sBJljtGquLDxyMUNuWkCYp7JWxJn1hLXNP7RrxdrufU/7bUbLWpEuU+
 Bo+B/+Tz05vGp/JFprGgwHOpYVIaeB2aIuBkOfnVmKEzFOB9GTWHKdJMqgzGgxChF3rct8eLBgZ
 hOlDhM9FE+uIKAGsQgHNwIBy4Ajv9Rk3jLP8OESKWhfG5LKl5gar0TkAbZ+gRNROg5NIXwrOTWX
 TRYv+qCRg+NzsUCxk2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010083

dasd_default_erp_postaction() copies the timing and device state from
the finished ERP request back to the original request but drops
proc_bytes. A request that was partially completed, an ESE read of a
not-yet-allocated track returns fewer bytes than requested, and then
recovered through the ERP chain loses its partial-completion length.
__dasd_cleanup_cqr() then sees proc_bytes == 0 and completes the whole
request instead of requeueing the remainder, silently returning zeroed
data for the part that was never read.

Carry proc_bytes over to the original request like the other
per-request state.

Fixes: 5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned devices")
Cc: stable@vger.kernel.org
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_erp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index 89d7516b9ec8..468f0b2cc342 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -123,6 +123,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	int success;
 	unsigned long startclk, stopclk;
 	struct dasd_device *startdev;
+	unsigned int proc_bytes;
 
 	BUG_ON(cqr->refers == NULL || cqr->function == NULL);
 
@@ -130,6 +131,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	startclk = cqr->startclk;
 	stopclk = cqr->stopclk;
 	startdev = cqr->startdev;
+	proc_bytes = cqr->proc_bytes;
 
 	/* free all ERPs - but NOT the original cqr */
 	while (cqr->refers != NULL) {
@@ -147,6 +149,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	cqr->startclk = startclk;
 	cqr->stopclk = stopclk;
 	cqr->startdev = startdev;
+	cqr->proc_bytes = proc_bytes;
 	if (success)
 		cqr->status = DASD_CQR_DONE;
 	else {
-- 
2.53.0

