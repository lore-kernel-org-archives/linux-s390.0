Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EC433E80
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582626; cv=none; b=XrroIc5NTcoYtv5q2uF9Yim+EDeCwjxKV33SEK1y5DI1tFjEEmr/hr1/85u6kEU+6Qk0J2yBmzpacUsqXm5kT2JRWMj7bAFzYkhhUy6uWXRyd1c/sW9hC+pi7a1vdJuCHzE0bVfHFAI1PG0xH/Bafre7HU0gSkYmId0eMedjcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582626; c=relaxed/simple;
	bh=5GNU0ofg74Bg9aoBjx+zpyIAnJafEN04zXRY32n53EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwlRZwBwFkESfr+J+41fo0g32MInSoZScnGRlfNu6ICACZO4goHv30JTfZ4RjJq9EAbPbgO7IWFg2KhFOLO2NofjUE+IlUmbibxwGZmLU+KnAsjQXb3MJYQhUibf5PfOfzkeKsQg+BcI59tgB4IzqtclfhT/sLQf0osvU//9sZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QRbZFv0R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QRbZFv0R"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6711WZtv3410328
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Hp86l2
	Q/yx9jvkYFd0f3ZL9wLzqhLJsvEtwtB02L5bg=; b=QRbZFv0RdxdQzKCWuoJbLw
	RnBYI1DlS3IPc5u0owclfA88hdD/DTLxub5Z6rBgTxVDkawDhXwpZB922KrTJ7ma
	roh3m2LvHAFgpQ7pItpJkMSWkFqMa8MmwYFQYZBiR/QRn3lvyed7Nj2WI5oljfFW
	RVY8KLSbxPwaxVBpQBvrVITLXeBaQHiejR00ozL36O+NTS32SR9wBLtsqrFLZRI4
	8OgByMjwaiDTU1TSrXqbs4nEozLf9ZWRNSqkY+qhWXE4ITV3K57/JAE34VIYYEMl
	c3gryvLbQteev47QiKT91cjS3sLCoxnEhIdPQRZNIQ4KovnMu5VobHgc+KpOGaCQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fs8ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AfOKV015781
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkkqh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAJM130081466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4758A2004E;
	Sat,  1 Aug 2026 11:10:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DC9C2004B;
	Sat,  1 Aug 2026 11:10:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:19 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 18/18] s390/dasd: Read cached unit address and LSS in the CCW build path
Date: Sat,  1 Aug 2026 13:10:08 +0200
Message-ID: <20260801111008.3391031-19-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX1BNP7wpH8KOL
 MguUo8VHjbqtgRZyPqnVrcH8sJqj3dPc38I3fIWN/yYrbHUMXd/7YOJGqDcrd6+pAL1Se6SpxuE
 1a2y51eYZx87IiD0o+O9q1UnONktf6LJ5789KRut22t5H7OERNeb+cpyF+YF7oYoVBGn/mZ9wL1
 rxpPZtqQnC2VYH1c/dWsXVU2Kyqrf111WJZD0vCM/c/ea5U/Yp/cm9rVeW3imEWZpDfIzMr5slO
 RLdkkuiIv7nvbJVP0TdmAwB74Rf5DaTtMIfp0WyAsQigojb5AkDlrVvjr4MoykQVdj1iYaA6Zxi
 T2Epv51B3ryuJQs31Uhwd0Wg0+zQBgY8tj92X7NMRNTiMO4FZDa8xfYn4Us2dS1QQ2GyRSO3rGq
 81vsBL/2pri5+wRfTEsLipi/vdMgbObGwBnh/kkibWuzEIxWp2GdWD+657kJ18tTcKa2Evqix8w
 BI8IDKNOdyPOh4zcXFA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a6dd41f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=OPmwjG8nANrwyK2qht4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y74mc5zpqZRA7HWkt0jo46fsO7WE3NMe
X-Proofpoint-ORIG-GUID: Y74mc5zpqZRA7HWkt0jo46fsO7WE3NMe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX33D6wVnLqbc2
 z8D91FJoA0xmsL38Gtxi0RXqCZv/VyXxYIU4pqcIW4H2bbTg3jFrLnARGFvdkSlFvraQpjZudVy
 LIpeYucJlnvO2TY3bJjb6rxYJNvLABo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010083

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
index e088dd216bbb..d5be9aaf41ed 100644
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
@@ -4245,8 +4249,9 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	if (!req && features->feature[56] & 0x01 && !copy_relation)
 		ras_data->op_flags.guarantee_init = 1;
 
-	ras_data->lss = private->conf.ned->ID;
-	ras_data->dev_addr = private->conf.ned->unit_addr;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	ras_data->lss = private->ned_lss;
+	ras_data->dev_addr = private->ned_ua;
 	ras_data->nr_exts = nr_exts;
 
 	if (by_extent) {
@@ -4817,8 +4822,9 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata = &pfxdata->locate_record;
 
 	pfxdata->format = 1; /* PFX with LRE */
-	pfxdata->base_address = basepriv->conf.ned->unit_addr;
-	pfxdata->base_lss = basepriv->conf.ned->ID;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	pfxdata->base_address = basepriv->ned_ua;
+	pfxdata->base_lss = basepriv->ned_lss;
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -6899,8 +6905,8 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
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

