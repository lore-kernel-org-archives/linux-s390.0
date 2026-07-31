Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE84446E9
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512355; cv=none; b=iVftDmIY9T+4YU7kHOBREmpIz4k6MGvmdIokOVLumyBJl1Yx+EZA3+H0xqU/R/TTqF9Ym4g37XZrNho7Wrx9Zu9KMj2YPbXu7yAkcFRzRbgX9l7lNyFnBIVO+UtTlj5gSNxFMI6fdtzKuhPORuu1ple6URQN8BFLqBk/YnNMRgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512355; c=relaxed/simple;
	bh=8wDcTsHFyXRRx+IfXxTL8IeTII9oY9pUM9vOFAToOrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU5GDpXAmQNAh+DjQ47CXsdMgCclld5aIXEgHKzJE3/+/xA8Ade9fvu5WiWnhUU+qx+G7baBxhWZCxsFAVZSusGz/HIlTczWCO8+rMlQsxrSa8zPbIWXp4EGU2WudO4ZOxtpu755z5NL+rekPJ/Y+vo9+icoamNbCpzzA9GHpEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kYbb0+2O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kYbb0+2O"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBllnw1672836
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=32fDhU
	+b4U40WIuHlfAwJXa9Z2uM76Bu3/YZVUh1ZjQ=; b=kYbb0+2OUw1xsKXjPHf2Sg
	9sXOn7vFfUuIe1YUQpgR5sShxXgN2TyBub5kiVAa51e9ZfQZyUNYZCJFcN547cd9
	Jalvh74Ot3fvme4bU3IX+zZrnHFog6MJgrA+2lSIqLITLKj27W3M/GyTT7TaPy/0
	II+xJvWcV23Os8l7yzwqYCbSwnYCoPqlCXoZzLzWw2QlP55Wur0Y48s+wJFF+Qis
	7o8g5QbN1iXbyfxBkE8ded3LPuaHKCFN7LNYrgow94vE5RM2mA3NUXN3MlkX1HrT
	FweXnKNNVMQ3MEaz1ifFpXNcYxJl+5LY3jVy0QCZ+iKXo7LMHnPrsZ1OCAa5Hriw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p4qak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFQcCH006659
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwgm6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFd1e128639498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:39:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C00FB20040;
	Fri, 31 Jul 2026 15:39:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1BA72004F;
	Fri, 31 Jul 2026 15:39:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:39:01 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 17/17] s390/dasd: Read cached unit address and LSS in the CCW build path
Date: Fri, 31 Jul 2026 17:38:42 +0200
Message-ID: <20260731153842.1729627-18-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731153842.1729627-1-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfXwI6FVfG17Z1h
 d5dGwUjNSYX9fYErMRaA+fUhCy/G+YF6Z9StXtJHIUeA3a5Pkj70mlYsFVyEYwTbtdG8QoRuzaV
 3P+0ZQqQNVPccs5bum6Rluu3YQFcYak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX0/BxVmBarkRq
 qrQKCewkolFNdhdxmR0BY5osXEKQLbS2OrqGyBNq1grHG9q6TkTAiuNyYGtCZ9k9j2chCqYGHSD
 uhM1epWqhdUxmSU52IV68xtRkqn/eXcD8TC8+g0nI6QQpTXxbNvsElH/fJHYvVqKjTFHafHfhQu
 0F85YblI4Bidd3qdbUHuQvSS3Uggocx4UK44ssaOrqVGE3lk5Y3uSU/sUmrDIsirEQ0szWjGQwT
 9v3/sMxL401Fcg4HQA0LoOg8Jxvr1ZT0bSSkOsMeJFDZmjmskINu8fgFCVoVXJXWSMlNjsVKZX5
 wGUW0SdVckBLZy85VNZMpy4+3EEJCI+pYgtu51XK+fiQpozTmGcRotmneKY8FoBJYp3kKr6RQIF
 3FgyOIuo8IILrgYQsANfEkY7yl/o/8IZnArYVMUlFMyI4EXHOLOFNto87KTwLTKLfvizABbyJ0c
 o5Y9fLarKwektmQcEUw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6cc19a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=OPmwjG8nANrwyK2qht4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MREsweovRpo5i4C9D6hVIjFt24BQbuxT
X-Proofpoint-ORIG-GUID: MREsweovRpo5i4C9D6hVIjFt24BQbuxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116

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
index 2f8839c066f3..5cfbf34fa019 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -588,8 +588,9 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 		return -EINVAL;
 	}
 	pfxdata->format = format;
-	pfxdata->base_address = basepriv->conf.ned->unit_addr;
-	pfxdata->base_lss = basepriv->conf.ned->ID;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	pfxdata->base_address = basepriv->ned_ua;
+	pfxdata->base_lss = basepriv->ned_lss;
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -806,6 +807,9 @@ static int dasd_eckd_generate_uid(struct dasd_device *device)
 		return -ENODEV;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	create_uid(&private->conf, &private->uid);
+	/* cache LSS and unit address for the lockless CCW-build path */
+	private->ned_lss = private->conf.ned->ID;
+	private->ned_ua = private->conf.ned->unit_addr;
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	return 0;
 }
@@ -1631,8 +1635,8 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	prssdp = cqr->data;
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = PSF_SUBORDER_VSQ;	/* Volume Storage Query */
-	prssdp->lss = private->conf.ned->ID;
-	prssdp->volume = private->conf.ned->unit_addr;
+	prssdp->lss = private->ned_lss;
+	prssdp->volume = private->ned_ua;
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
@@ -4232,8 +4236,9 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	if (!req && features->feature[56] & 0x01 && !copy_relation)
 		ras_data->op_flags.guarantee_init = 1;
 
-	ras_data->lss = private->conf.ned->ID;
-	ras_data->dev_addr = private->conf.ned->unit_addr;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	ras_data->lss = private->ned_lss;
+	ras_data->dev_addr = private->ned_ua;
 	ras_data->nr_exts = nr_exts;
 
 	if (by_extent) {
@@ -4804,8 +4809,9 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata = &pfxdata->locate_record;
 
 	pfxdata->format = 1; /* PFX with LRE */
-	pfxdata->base_address = basepriv->conf.ned->unit_addr;
-	pfxdata->base_lss = basepriv->conf.ned->ID;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	pfxdata->base_address = basepriv->ned_ua;
+	pfxdata->base_lss = basepriv->ned_lss;
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -6886,8 +6892,8 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = PSF_SUBORDER_QHA;	/* query host access */
 	/* LSS and Volume that will be queried */
-	prssdp->lss = private->conf.ned->ID;
-	prssdp->volume = private->conf.ned->unit_addr;
+	prssdp->lss = private->ned_lss;
+	prssdp->volume = private->ned_ua;
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

