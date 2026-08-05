Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184A435A92;
	Wed,  5 Aug 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928597; cv=none; b=YY3PHeHgqeo9JNt9VfsG4mRRAXQbC01570B8ulGXyS8lqbLsSUhfMvvUqK792xvSUQ3ItR2ERHkjjS2G3L6Aq2WWc+d9a6+cV6hDZuMhGktojzpdm743jKUkq7s8zAYw7DIG6vV3sS2Mjhdnnummu5uMK/r97MiaCvLK0nI+RKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928597; c=relaxed/simple;
	bh=a12uugho/ZZ0aM6r5SfxDHW0gfk/6vPBUq02hOidIAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwBOylj1FRHku4AgTexXxnbC23Nz/CEOpANfhly7FLqA73YS8nuCWMRsLzwig2zAo71w5hmdd9tXmQCruS9rWHtQwPW6kR8GZJB+m6VDG1H6vCfgchdmjkK/ySUgxRUzIgwikr37PsVy7PgH7IEzlQ4YpcommzgpAGZTvY2QdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YvRlo5qS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YvRlo5qS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758ldAR3288377;
	Wed, 5 Aug 2026 11:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kMI1ph
	B4JGgEDFWID0l13lirKinFIBcbh7XOpXs9Vto=; b=YvRlo5qSAldy0soZ05Iu7t
	ME7ej7W4mNBfIKnvzK6J1cRiP9tOhnigHkZweh93VggR7NkzMa0YQXMJtL0iewZH
	ujXsz/YmDlso1hCWWV8rI3J2rmBH5XeVqBaX20KjEr6ix6Q786sLpuLf4pAilz6X
	N2PtKNBtuCHRv7pM4K2w0LzNYltXUnP6adXOn7v/WyyCFkeCaQB3FwRevFbVspyN
	WKG3d9EM/yExh5tIJP7bB6rtSFwvyZw+nkjg6rXlyuEcjHWJqLkCMXF2OzcmGOy3
	u5gY0yPHNkUyKV9IOWTg8TmMDTf5s41SgWISAcvKl7LwE+YGD0/QBHX9Bkpz9T4g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gab6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBEoj005762;
	Wed, 5 Aug 2026 11:16:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbge2cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGJK250463094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A09C82004D;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0F92004B;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 19/19] s390/dasd: Read cached unit address and LSS in the CCW build path
Date: Wed,  5 Aug 2026 13:16:12 +0200
Message-ID: <20260805111612.1285190-20-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX1aZpoEsr/aXP
 z1KPLIkTxBwhhkC5pkHnTlt31P55e2cmceEo8xE5sjBp/tiykzBw6kWDvMu4OFbUkHr4i0ouru+
 RuSJRDddQyhmLsNVWMh74slAuNduERkK24xx3umrNhteC9+MvlEzO9ZOkqqsQujpjG1+7zeUJuA
 FEpt8W17NcaI3qpYSOYsjy+RxYAI87/AfPtE5qFvtsWFtTWdEgiRpKY89IhUkp81ElQSjmCefl+
 J9zruJB1282ZVjQcvPUr32EbQ4sNOJLjXiW9iorIiKDSvWWQt1sxaPyMaP3SabPEM2H+dgcVjqY
 P7fp/nIncldvC21L706LIyy1ADB0ENntLk2ZraN+Q4x9soBlx/aQNQqlqAGz+3AGO5OplWTO/HJ
 GPLUVBfDPHnqRm34+5Qf5EfQeJYZADjyrOCqGsboLHam0q74ZlWo5hkqbOvPZNe8RWr9N0I8ycJ
 RJuqNl1ZQ+YUsvRR4Aw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a731b8a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=OPmwjG8nANrwyK2qht4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vWhVk19es2RHa--tNyAjOLz5crhkwLit
X-Proofpoint-ORIG-GUID: vWhVk19es2RHa--tNyAjOLz5crhkwLit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX3kVRD0NQcISJ
 Hx6O1/j3zfnimj6k9EcUcN+MkD+k3i9pB8dImcjM2uRmlniwqvVsaoyVwv9F/T9cyWVKZc6hxKC
 nbqQlcHRd4MuxrhGofo3iBOELhmf0HA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

The CCW build path (prefix_LRE, the full-track prefix and dso_ras) read the
base address and LSS straight from conf.ned. That buffer is freed and
reallocated by the reload worker (do_reload_device - dasd_eckd_read_conf -
dasd_eckd_clear_conf_data), so a configuration change concurrent with I/O
can free conf.ned while a request is being built.
Use-after-free reported by KASAN in prefix_LRE.

Read the cached copies instead.
The unit address is already kept in uid.real_unit_addr, and the LSS is now
cached in ned_lss. Both are refreshed under the ccwdev lock in
dasd_eckd_generate_uid whenever the configuration is (re)read.
Also fix for prepare for read subsystem data (prssd) users.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 26 ++++++++++++++++----------
 drivers/s390/block/dasd_eckd.h |  8 ++++++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 5c1f328b7c8d..fd23ac25a7da 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -589,8 +589,9 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 		return -EINVAL;
 	}
 	pfxdata->format = format;
-	pfxdata->base_address = basepriv->conf.ned->unit_addr;
-	pfxdata->base_lss = basepriv->conf.ned->ID;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	pfxdata->base_address = READ_ONCE(basepriv->ned_ua);
+	pfxdata->base_lss = READ_ONCE(basepriv->ned_lss);
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -807,6 +808,9 @@ static int dasd_eckd_generate_uid(struct dasd_device *device)
 		return -ENODEV;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	create_uid(&private->conf, &private->uid);
+	/* cache LSS and unit address for the lockless CCW-build path */
+	WRITE_ONCE(private->ned_lss, private->conf.ned->ID);
+	WRITE_ONCE(private->ned_ua, private->conf.ned->unit_addr);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	return 0;
 }
@@ -1632,8 +1636,8 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	prssdp = cqr->data;
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = PSF_SUBORDER_VSQ;	/* Volume Storage Query */
-	prssdp->lss = private->conf.ned->ID;
-	prssdp->volume = private->conf.ned->unit_addr;
+	prssdp->lss = READ_ONCE(private->ned_lss);
+	prssdp->volume = READ_ONCE(private->ned_ua);
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
@@ -4250,8 +4254,9 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	if (!req && features->feature[56] & 0x01 && !copy_relation)
 		ras_data->op_flags.guarantee_init = 1;
 
-	ras_data->lss = private->conf.ned->ID;
-	ras_data->dev_addr = private->conf.ned->unit_addr;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	ras_data->lss = READ_ONCE(private->ned_lss);
+	ras_data->dev_addr = READ_ONCE(private->ned_ua);
 	ras_data->nr_exts = nr_exts;
 
 	if (by_extent) {
@@ -4822,8 +4827,9 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata = &pfxdata->locate_record;
 
 	pfxdata->format = 1; /* PFX with LRE */
-	pfxdata->base_address = basepriv->conf.ned->unit_addr;
-	pfxdata->base_lss = basepriv->conf.ned->ID;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	pfxdata->base_address = READ_ONCE(basepriv->ned_ua);
+	pfxdata->base_lss = READ_ONCE(basepriv->ned_lss);
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -6905,8 +6911,8 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = PSF_SUBORDER_QHA;	/* query host access */
 	/* LSS and Volume that will be queried */
-	prssdp->lss = private->conf.ned->ID;
-	prssdp->volume = private->conf.ned->unit_addr;
+	prssdp->lss = READ_ONCE(private->ned_lss);
+	prssdp->volume = READ_ONCE(private->ned_ua);
 	/* all other bytes of prssdp must be zero */
 
 	ccw = cqr->cpaddr;
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 30745f62402b..8e6f09e9ca7e 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -736,6 +736,14 @@ struct dasd_eckd_private {
 
 	/* alias management */
 	struct dasd_uid uid;
+	/*
+	 * Cached copies of conf.ned->ID (the LSS) and conf.ned->unit_addr,
+	 * refreshed under ccwdev_lock. Kept outside uid because create_uid()
+	 * memsets uid before repopulating it, which would expose a transient
+	 * zero to the lockless CCW-build readers.
+	 */
+	__u8 ned_lss;
+	__u8 ned_ua;
 	struct alias_pav_group *pavgroup;
 	struct alias_lcu *lcu;
 	int count;
-- 
2.53.0

