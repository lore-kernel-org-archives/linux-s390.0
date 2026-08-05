Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E89434E51;
	Wed,  5 Aug 2026 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928591; cv=none; b=Zx4+78BAYbYVnMFwp184Lk0UVYfbJZKadvogOrqktI6F6klv0O7wrwv+5hwf8lBM0Ow+K84YIlK1hRINuuZ+8Qcu88i7Hf7+bK0YvnL4Z7NC7lyYeKP9lxYPXU6STk3NUC1Gq2qYtQFDiRleVChYoUsnSb/ENZTyerbHUth3HLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928591; c=relaxed/simple;
	bh=2Cy1EGx6iYkQYdsK/PCNkierRJsx0oG/QxtTrEzYHMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBa4eeH7D8KZQpwZPSjB67lMrx8f5IWdpCQ+RS278Qm35OsrzAorVylRQrh+OvfiBTQLUVgZ+rZa/swUnZu74VdvXpknw1J++phnzABXC1abE/pVNSW0fGwe5XDI0e1B8tXYJzQ/VUyIHhXHKvTpriGTQ0BWUm2C6GWBcyuTr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DoU7r88F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DoU7r88F"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758m6WY1504476;
	Wed, 5 Aug 2026 11:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=chvKDX
	/ZCbChaAJ2TCmhInNUdxj7IXzKQoC/xVByzSQ=; b=DoU7r88FV5Uway453MdbLW
	KcjWaoL99WJL1ElA89/6sw3dd2YUpeUx3ZP35Zf1EtgElu1EMnnlOMY9SFOC3xI2
	M3VSwpNtpdoJn9yuGnShWOp1TOvXeBwsZCHmX+8RYSj3p+z18fvn3QXgv575o4hy
	YYzFDB5NaLM06SfDns0vXu6gozycE5NpLBe4QV5D1ZlmWLJSfFuOYIaE0QmlzLq0
	RU2ciGbn6TD8mV1aVy6BP4yPi6P4MS3VIh2RTFz49b/k7a9F3J0V8/EoaN2SnS02
	B0WAyb+q0vCRwHPi2IKbeQ5jCntfPH9jmgeGFLTP0nAX3LfpjgnxgY0++Ek5uspg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqtm71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBE21012703;
	Wed, 5 Aug 2026 11:16:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyp0uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGHo749676720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2C4E2004D;
	Wed,  5 Aug 2026 11:16:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D487B2004B;
	Wed,  5 Aug 2026 11:16:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:16 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 02/19] s390/dasd: Propagate partial completion length across ERP recovery
Date: Wed,  5 Aug 2026 13:15:55 +0200
Message-ID: <20260805111612.1285190-3-sth@linux.ibm.com>
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
X-Proofpoint-GUID: CzZynM31Nlf_XIS0_ttdT4ZQlgI5MLSi
X-Proofpoint-ORIG-GUID: CzZynM31Nlf_XIS0_ttdT4ZQlgI5MLSi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXzqYDrQbtewWk
 prX3f3QKGXOC1aIUcx5xabliy+MNfGQZWNcaj70drI4JVpOKqteDJ9awPxmLokvVdZ3Y8WF7zLO
 haaUojyghBfK+lno3fTZUDtcHeYn99M=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a731b88 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=01JC27pNfGPOVEZEpjYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXzkmeJU9QntUq
 QAipNLUEiFLsd8qBSio3b+TlHM9tNA8Sk9SE5tP8siSFc3lIlZoPV7qawNwuDyx+I73v20FKPd5
 4PlHNmmM+McLEieV3j+ob0buHfNnFrbldYEZspXb50HYaJ/GutQP2/Y5iYYNWFiSRHu2lNFYSOF
 KUBviwSwmP0uMYlTmk279Kn4Kb6x9anl64O4SD70pG9PvMqIcl+foCE5bMVHmHMwW0N5H0u2RDo
 De5RKGrUhheNl2UB0gWQbfX2+WHnKLSSPfqOC1PIvj3XNnJAjhoKceYOC1qITMLVZbLvIsTTLEs
 xn83IeWi9j88/xXF7jSGwmGkW86fcNF9yJu3NYsNMziPz9WFvpXJ9KKbZZ4lnp2HN0B67Hgt5Lg
 2khFjuksK4TqAo4H+RUpfSK2dQvdagRTXPvpbSONVQtjnDoFqAs983tQX4dnW4OTG7DaXHgmD2g
 vBTCb+Jc6F7B98ktlJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

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

