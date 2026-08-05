Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D302433026;
	Wed,  5 Aug 2026 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928593; cv=none; b=EPoi97xRJkSEo+nzQS6OLOFRubrhuTYPwpNeabX73Fe7MfLTVMz7OaPy4JLXKF9UPtJtLnjwY15R3HC15T58CzMkYRRjiGQCUheUWZQfPTWWiN6GEc2O9URbQsm0MYa8VTrlzRMVK473Cqz7arEdn/nkXXkAlvBRE8J3+hFDAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928593; c=relaxed/simple;
	bh=gnYkNrJal64zaczuxDFjkEWV63B/lDgeLn3N4/BeVKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAj5V9yp4oMndlOw6zjHV6W+aN4QKti6odFhP0EB2toYh4E1Qggq+XtAlDql41Bt1G09yonr+YfRdAh74bOKodq0eGSKEpFmk6MvH10e1H8GCpNbmphkoJN1RSrTm5TGKnWMko4Qp8rsDiMksgpHcyXX7AQ/dF/fJGWSAxI60zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SRKEpSDM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SRKEpSDM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lY893354340;
	Wed, 5 Aug 2026 11:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oOrr7k
	m9JH/vMQzM4Bf9s7g1l6ThuvFsCaK78Jid310=; b=SRKEpSDMPVwnBo788Lbiut
	Pk+2wu+RsmO8PAkCLXsxye7GktDl6xUWBFXgarPoV8qd3tHt52GvL2gz3TN/Q8e4
	YO0H4uqBYG8lgBJ2xmNSl6SHlO1FvyNgfFl9LM5QC4JGUvR7esnJhuM4Odb3PioK
	enADojRnyl8ncH+brqHZT1UOEM9IfwCZhX+nyQefmAXo4H4jTZQ0a1BVOEOdY4j5
	4px/FwRwfQVec8KyH7IAfxI1fOBO12FQyzg1fYvS9/DB4EtFfxgzi00ZMboMzflX
	jHXCFZXwRxWspe38qkO4BUF0WPpmSRtpubKtjAFYswi4Q89LZIuUhZwyZfOlScWQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42prj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBG2N020875;
	Wed, 5 Aug 2026 11:16:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6bt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGGGY14614820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0E4020043;
	Wed,  5 Aug 2026 11:16:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFA4C2004D;
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
Subject: [PATCH 01/19] s390/dasd: Do not complete a failed ESE read as successful
Date: Wed,  5 Aug 2026 13:15:54 +0200
Message-ID: <20260805111612.1285190-2-sth@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731b89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1SqTnHJJj3MAIbOAUaAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: T7QCIj3sHG5_R93_LiZirUFHq7TmnP-a
X-Proofpoint-GUID: T7QCIj3sHG5_R93_LiZirUFHq7TmnP-a
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX21zmCcrJpybf
 VuJGiDQ6gZXRlkNruC4cKB6f0ceP0/aiu4TPqUx4gJ+DIOc/2yhCALj980YSSSScD7uw2M68zZk
 rN8BpXld0sIkHmJdvBT1g+o0KpUzdpQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX2v+Xh4i6r5BL
 +xWSo48L3RuPfLP555hl7G2o5UeJn35E22V1lqGM26YLLTBrPp70LiHM5Ibp0DTKIqXx8ygCgWp
 WAK3kn2v/Hje+ZmsIadroihlZkP2dZPf32pgYsr/sNgSTQ83s26nt5iVBczqKeXXBbXrw9ZkZIz
 7LOQTQ/dJzueYWAZVAUGFNM3y9GC0dwynOuIuNvJGuEQFnEluI5iaYR6ZG772zyFIt7jC6gwVau
 5XMC/7fPWyYDjiwQrlHUNJo0JmmfQLdBYaNs7b1XKWa5UZGKVSer8bqFuMc11/GfvkTICBVsZuS
 eCwwJZmuDo9U0JJ8FfH1JEhP1UGAJv4ezhFmsSYISrx3qTEzgxdm4j+h384lgdDT8EsEhYpU+B1
 bpF3pEJtdE4R6J8DHhvDDJ1oA9mEgY7Sal+Sx9gxQL0vlCqUvjzlyrvVVzdA0VODDYcA33XtgW5
 ZFAL5/DuX+teVmt4LIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

dasd_int_handler() completes an NRF read of an unallocated ESE track by
calling ese_read() and unconditionally marking the request
DASD_CQR_SUCCESS. dasd_eckd_ese_read() can return an error before it has
zeroed the destination buffer: a failed sense-data parse or a current
track outside the requested range both return early, leaving the
destination pages untouched. The request is still completed successfully,
so the block layer is handed stale / uninitialized memory instead of
zeros.

Check the ese_read() return value and fail the request through the normal
error path instead of forcing DASD_CQR_SUCCESS.

Fixes: 5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned devices")
Cc: stable@vger.kernel.org
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d8d912a3b3fe..56ef38243f82 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1698,8 +1698,10 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 			return;
 		}
 		if (rq_data_dir(req) == READ) {
-			device->discipline->ese_read(cqr, irb);
-			cqr->status = DASD_CQR_SUCCESS;
+			if (device->discipline->ese_read(cqr, irb))
+				cqr->status = DASD_CQR_ERROR;
+			else
+				cqr->status = DASD_CQR_SUCCESS;
 			cqr->stopclk = now;
 			dasd_device_clear_timer(device);
 			dasd_schedule_device_bh(device);
-- 
2.53.0

