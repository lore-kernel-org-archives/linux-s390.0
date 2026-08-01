Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35B3BCD33
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607246; cv=none; b=tWYMuTRG71WNgNiTdwd4hxlZK8d63TCZHCb+yr3lD9oBWdA/fUBTRgQAdowkoapUBSXGdDv24eUYSfOEtCixkqVNgD4rEOvEQQA37cXGnKpMnuri3sow4wbtWx7af25LkHBh5NPwJ2/R+bLjHOGKjZdrwoTZwNHwXdgtBnk7MAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607246; c=relaxed/simple;
	bh=02nonn8Wni0jVgVUkegwo6Rrrd1eaV665+uByZQgmHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4OXDjlVGXuekXpfj2CL+77a2R5pBLIdYUSOnRSy0xQXYsF1Pa9P06M8uDGJe/n+uNARhZ7SZI7UMYLn/AAB26lJCrX1ogNgftAIMLIuyYC17itjxnd/D261ZU3Lv4zwda9qSJEBEhKsIFrVtLOBJlYaONjAQIOnfL6xhqpCtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B90iLv8e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B90iLv8e"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671FlefH936555
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K/xzeK
	cpTi45WxIGjO92PI7XeI0wqGGducJnJbCymZg=; b=B90iLv8erepvhV41iDkBrN
	icVm0ws1msX8Y1WPLV3s/OPOmTdOseh53xF+UmWme6pEaWmD8QHeMmH359AesRqc
	NNjgo2f3XbenV3TtZC1YxDqTCXK/SIvlxyZa4GrAp/et6Te08Ze5HpVC3y17ZRG2
	RkbkjlW8SYHkuwIydM4tLs2JjNxVx8RI0MhRYRhEHQeNzJ2sJWe0cWeLuByvMOxb
	Qr3MKJVFN8P1pB9LCREcvN4yQRwMMzNa1cgfCiUyatkc/H8B5I+tLNi9zWtbvmgk
	8vDEyzKYJ2inMQaKode9V1CLqi0ROfMGc+cW2q3RLUjCT4klL15UJb82j6puFlrA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3j3br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuIvn014474
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkmr9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0c0Q12845460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C26492004F;
	Sat,  1 Aug 2026 18:00:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA98F20043;
	Sat,  1 Aug 2026 18:00:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:38 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 19/19] s390/dasd: Read cached unit address and LSS in the CCW build path
Date: Sat,  1 Aug 2026 20:00:33 +0200
Message-ID: <20260801180033.3679412-20-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a6e344b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=OPmwjG8nANrwyK2qht4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2n4Yb5dD2-wpQdsOQZU1_JqQoaLYk8NY
X-Proofpoint-GUID: 2n4Yb5dD2-wpQdsOQZU1_JqQoaLYk8NY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXxDj5/bxCqxGO
 x9ZmoPNdZm056kl3jWwoku95k+X2pagkXDMRCSPNb8NgKdKZC48eVpZAHULT4Gtaj2QFqbnThfr
 zHXBbbE7a8pWr7hAd+WU3Nz41Fy6NrU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXyW7otkbj0P4o
 D1gGDNXp8QaBLhSTHNXpJRvKnj6DNxImOsUPiWh4iBTScQqY39lehWAhlIGpljB8tFvcLXe47jo
 C2dFtmrVIEtffoeU0TNJjzhc4pa5BJKOaFHI9nHiQcDFyT+5N+26/4Z41YhO+GpC9Q7xsfLM3hW
 fOjtnHu/pi6S+qIiQQPH/UewbVrLAPXdXhm+8yA7ZWBak3OlNGUu4cOTq5DAL5HLLx14HgtHh1y
 Eu94s1tkFmbE6HHsi7/PnXEPumkTVo0Vx92sWw94i1Fhv+JB4wvVLO8I/U34GhboHLxwzi+6bHs
 44Z3aXToCu4vo3YA+cZIOxZvrIzSXqELxZC/aiesnlb+M4idMUt1xgxd4/PrENG1n6Fp5Bm0M9X
 jYqK0trQab8W0pO0pIyp6CC6yqI7WajIeeULFoBoTmxfAYPqTzt1WVAhoE+4HazaSr+0bORv7Im
 LZaZlkzfNClk+UbGIEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010143

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
index c634876b9807..ad58feb531b9 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -588,8 +588,9 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
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
@@ -806,6 +807,9 @@ static int dasd_eckd_generate_uid(struct dasd_device *device)
 		return -ENODEV;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	create_uid(&private->conf, &private->uid);
+	/* cache LSS and unit address for the lockless CCW-build path */
+	WRITE_ONCE(private->ned_lss, private->conf.ned->ID);
+	WRITE_ONCE(private->ned_ua, private->conf.ned->unit_addr);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	return 0;
 }
@@ -1631,8 +1635,8 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	prssdp = cqr->data;
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = PSF_SUBORDER_VSQ;	/* Volume Storage Query */
-	prssdp->lss = private->conf.ned->ID;
-	prssdp->volume = private->conf.ned->unit_addr;
+	prssdp->lss = READ_ONCE(private->ned_lss);
+	prssdp->volume = READ_ONCE(private->ned_ua);
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
@@ -4247,8 +4251,9 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	if (!req && features->feature[56] & 0x01 && !copy_relation)
 		ras_data->op_flags.guarantee_init = 1;
 
-	ras_data->lss = private->conf.ned->ID;
-	ras_data->dev_addr = private->conf.ned->unit_addr;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	ras_data->lss = READ_ONCE(private->ned_lss);
+	ras_data->dev_addr = READ_ONCE(private->ned_ua);
 	ras_data->nr_exts = nr_exts;
 
 	if (by_extent) {
@@ -4819,8 +4824,9 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata = &pfxdata->locate_record;
 
 	pfxdata->format = 1; /* PFX with LRE */
-	pfxdata->base_address = basepriv->conf.ned->unit_addr;
-	pfxdata->base_lss = basepriv->conf.ned->ID;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	pfxdata->base_address = READ_ONCE(basepriv->ned_ua);
+	pfxdata->base_lss = READ_ONCE(basepriv->ned_lss);
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -6901,8 +6907,8 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
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

