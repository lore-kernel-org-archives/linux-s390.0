Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A3434E4E
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582626; cv=none; b=ZmdawpzLa2QXijrJodLxH4w0C+WP5WsfgMx/+jGGMZirYWXrTbyvEgeOMbbmkU3w8ELVqObLM54KK9tqu9T+OpWYkDeSCueqIFjB4Z4sNuEyU064WgNepq5FZWKAeG3dY34lZq28pgwa9rq897S1Gr6T5EhVIivasZFpU0BmDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582626; c=relaxed/simple;
	bh=unteXj/7PJXvSewa2XB/uCeeI5DLQTosX7bbwuVCho8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEjk8DsZuZAhQPIwPXbnRHCMig01AE7M05CpZQCfW6N65YK1T0hrmj3Y+YTU/Jt07/9Wgaa0QS1AvO3r69g1AuhsykveaCsmYZP43UsC4au3cMo7bg5qYQVY6Z6WquZHI4qI6WE3kXSO/Rf+Wa1Ox0KNLm/SiLdDUc0oC2vzzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g3LDt1gb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g3LDt1gb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6711Vnqh3409241
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tw9t+I
	HbSiivUALaRwUizqLefC3CmLndlopmGmsQygc=; b=g3LDt1gb5RcC9obZgy++cr
	dKmQWOd5q663lq9m0zkv4CWFla0AQq1TWXQi1t8OWAJcLsAVFOTovoitO/AiwTPF
	OgHlupCTR55hBvpEw8tVE3bpkrdz0q+uPMwpTb5iSBgTG4QStaSp0ycHYAd9II05
	4AKnaEOQp3bmPAPLYHqBjY9f+posgYUNMjTkU2HOO4IH5EM+86ywr9KNmtEctY/M
	r4RTu+fAMsD5jVM9Iez0fsh/+G5ArOVBjWqlVIHjtZejp/hHiRDYWKM7QsAt+wVG
	601MkduQAMJnguxoONtd1k+8BzN37+rMpM7FMNx96wqP69ARsOgKMidIc0pfCrpQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fs8ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuHC3013846
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwkur1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAI2A50332082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D62192004B;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B561720043;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 15/18] s390/dasd: Detect ESE volumes from the on-disk format label
Date: Sat,  1 Aug 2026 13:10:05 +0200
Message-ID: <20260801111008.3391031-16-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX1OSAHKzptBpQ
 Vud/sOWK2AOJTs2C90L8vof20fPjRmWMg+0fO1L25LzHgvmvE3o7HgowJ5fxtXdxMnQyRAbn8gu
 xnjhpHO3OTbvGijrZ59HSM366L5Gx4L0YUN5gBWJ9bfFsMg+ZbhGtjozDGFyD4/7AqkrtfddpF4
 dSHCCoBlGumTxrrcF5xbXcXi74igvo3EncdhJ5IJEcdTMmFfuwDROCdH6vULxojaTynGkZFrRKc
 oTWxpcsQGNaLB7okm7vFAwvPFgKXhC5+WQlznz0/hMXkYHUnzg1uQ9UbHOQyDbf5UK3QJZ3v44O
 JuyAl5Rez3YbhdZ0nz3V/uE5dHY018SIXjzwKpUzyFZvpY3JIsPuYVLJi8UqhVutAn8wxj5v/lK
 N+3hMBaMyGQHKI/cGafHmU9xlH9SikwS/HgKnXKmDETTK/tDtYtbE5GoOo7EZry9LUduFnCEaAT
 hhbsiyr8keATajExL5w==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a6dd41f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=XCryhe0Ejjn_Du0XFGgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9x_T05WnwSzcH_e4GwZmBFBbDyDiKl9t
X-Proofpoint-ORIG-GUID: 9x_T05WnwSzcH_e4GwZmBFBbDyDiKl9t
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfXyMoKriX5F90B
 v9/GmjQCLWbiSkLAb1FTjjySYTQg6yCRuOuipxXxq0PHS9WytKKUJLE3oYWvytzcFBUI4yx4zfd
 fPSYmNh0G9iNHqKbacC7xPp+0DabHAU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010083

Read the format label from track 0 record 4 at device bring-up and cache
it. When a valid label is present, is_ese() is derived from it instead of
the hardware volume field.
A volume copied off ESE storage onto other hardware is thus still handled
as thin.
Without a label (older format) is_ese() falls back to the hardware field as
before.
The cache is refreshed after a format so is_ese() stays coherent without an
offline/online cycle.

The label F_ESE bit is stamped from the hardware capability rather than
is_ese(), and space release (quick format) is gated on the hardware
capability, so a copied label cannot enable it on non-ESE hardware.

The ese sysfs attribute, and with this lsdasd, shows the hardware
capability and not the internal handling. This is in line with the view
from storage server interface. To reflect the specific internal handling an
additional attribute on_demand_formatting is added to show that a device is
handled like an ESE device internally based on the disk label.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c |   6 +-
 drivers/s390/block/dasd_eckd.c   | 181 ++++++++++++++++++++++++++++---
 drivers/s390/block/dasd_eckd.h   |   7 ++
 drivers/s390/block/dasd_int.h    |   3 +
 4 files changed, 180 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 50301e545bbe..89f155e414fd 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -2479,9 +2479,10 @@ static ssize_t dasd_##_name##_show(struct device *dev,			\
 									\
 	return sysfs_emit(buf, "%d\n", val);			\
 }									\
-static DEVICE_ATTR(_name, 0444, dasd_##_name##_show, NULL);		\
+static DEVICE_ATTR(_name, 0444, dasd_##_name##_show, NULL);
 
-DASD_DEFINE_ATTR(ese, device->discipline->is_ese);
+DASD_DEFINE_ATTR(ese, device->discipline->ese_capable);
+DASD_DEFINE_ATTR(on_demand_formatting, device->discipline->on_demand_format);
 DASD_DEFINE_ATTR(extent_size, device->discipline->ext_size);
 DASD_DEFINE_ATTR(pool_id, device->discipline->ext_pool_id);
 DASD_DEFINE_ATTR(space_configured, device->discipline->space_configured);
@@ -2519,6 +2520,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_path_reset.attr,
 	&dev_attr_hpf.attr,
 	&dev_attr_ese.attr,
+	&dev_attr_on_demand_formatting.attr,
 	&dev_attr_fc_security.attr,
 	&dev_attr_copy_pair.attr,
 	&dev_attr_copy_role.attr,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index b09ea243a955..69a6a462e3e2 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1676,7 +1676,8 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	return rc;
 }
 
-static int dasd_eckd_is_ese(struct dasd_device *device)
+/* Hardware/volume ESE capability, from the Volume Storage Query. */
+static int dasd_eckd_ese_capable(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
@@ -1686,6 +1687,53 @@ static int dasd_eckd_is_ese(struct dasd_device *device)
 	return private->vsq.vol_info.ese;
 }
 
+/*
+ * Whether the volume is to be handled as ESE (thin). This reflects the state
+ * of the data, not the hardware: a volume copied off ESE storage onto other
+ * hardware still needs ESE handling. The on-disk format label is authoritative
+ * when present; without it (e.g. a volume formatted by an older driver) fall
+ * back to the hardware ESE field.
+ *
+ * Only the F_ESE flag gates this. An ESE volume is thin regardless of whether
+ * it was quick- or full-formatted (tracks are allocated on write, and discard
+ * re-thins a full one).
+ */
+static int dasd_eckd_is_ese(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private = device->private;
+
+	/* sysfs may read this during set_online before private is allocated */
+	if (!private)
+		return 0;
+
+	if (private->ese_label_valid)
+		return !!(private->ese_label.flags & DASD_ESE_LABEL_F_ESE);
+
+	return dasd_eckd_ese_capable(device);
+}
+
+/*
+ * Whether the volume is formatted on demand (thin), as opposed to fully
+ * formatted. This is the format mode, not the hardware ESE capability. When a
+ * label is present it is authoritative (F_QUICK). Without a label the mode is
+ * unknown, but an ESE volume is still handled on demand (NRF triggers the
+ * format), so fall back to the ESE state to stay consistent with the driver's
+ * behavior on older, label-less volumes.
+ */
+static int dasd_eckd_on_demand_format(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private = device->private;
+
+	/* sysfs may read this during set_online before private is allocated */
+	if (!private)
+		return 0;
+
+	if (private->ese_label_valid)
+		return !!(private->ese_label.flags & DASD_ESE_LABEL_F_QUICK);
+
+	return dasd_eckd_is_ese(device);
+}
+
 static int dasd_eckd_ext_pool_id(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
@@ -2105,6 +2153,69 @@ static bool dasd_eckd_pprc_enabled(struct dasd_device *device)
 	return private->rdc_data.facilities.PPRC_enabled;
 }
 
+/*
+ * Read the on-disk format label from track 0, record 4. On a formatted volume
+ * R4 holds the label as its record data; on an unformatted (fresh ESE) or
+ * label-less volume the read returns No Record Found, which is expected and
+ * leaves the cache invalid so is_ese() falls back to the hardware field.
+ */
+static void dasd_eckd_read_format_label(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private = device->private;
+	struct dasd_format_label *label;
+	struct DE_eckd_data *dedata;
+	struct LO_eckd_data *lodata;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+
+	private->ese_label_valid = false;
+
+	/* The label lives on the base volume; aliases have none of their own. */
+	if (private->uid.type == UA_BASE_PAV_ALIAS ||
+	    private->uid.type == UA_HYPER_PAV_ALIAS)
+		return;
+
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 3 /* DE + LO + READ */,
+				   sizeof(*dedata) + sizeof(*lodata) +
+				   sizeof(*label), device, NULL);
+	if (IS_ERR(cqr))
+		return;
+
+	dedata = cqr->data;
+	lodata = (struct LO_eckd_data *)(dedata + 1);
+	label = (struct dasd_format_label *)(lodata + 1);
+
+	ccw = cqr->cpaddr;
+	define_extent(ccw++, dedata, 0, 0, DASD_ECKD_CCW_READ, device, 0);
+	ccw[-1].flags |= CCW_FLAG_CC;
+	locate_record(ccw++, lodata, 0, 4, 1, DASD_ECKD_CCW_READ, device,
+		      sizeof(*label));
+	ccw[-1].flags |= CCW_FLAG_CC;
+	ccw->cmd_code = DASD_ECKD_CCW_READ;
+	ccw->count = sizeof(*label);
+	ccw->flags = CCW_FLAG_SLI;
+	ccw->cda = virt_to_dma32(label);
+
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
+	cqr->retries = 256;
+	cqr->expires = 10 * HZ;
+	cqr->buildclk = get_tod_clock();
+	cqr->status = DASD_CQR_FILLED;
+	/* R4 may be absent (unformatted) or larger than the label. */
+	set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
+	set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
+
+	if (!dasd_sleep_on(cqr) &&
+	    label->magic == DASD_ESE_LABEL_MAGIC &&
+	    label->version == DASD_ESE_LABEL_VERSION) {
+		private->ese_label = *label;
+		private->ese_label_valid = true;
+	}
+	dasd_sfree_request(cqr, device);
+}
+
 /*
  * Check device characteristics.
  * If the device is accessible using ECKD discipline, the device is enabled.
@@ -2161,10 +2272,6 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	device->path_interval = DASD_ECKD_PATH_INTERVAL;
 	device->aq_timeouts = DASD_RETRIES_MAX;
 
-	/* default ESE fulltrack write aggressiveness from the module parameter */
-	device->ft_bias = min_t(unsigned int, full_track_bias, DASD_FT_BIAS_MAX);
-	dasd_ft_bias_apply(device);
-
 	if (private->conf.gneq) {
 		value = 1;
 		for (i = 0; i < private->conf.gneq->timeout.value; i++)
@@ -2219,6 +2326,16 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	/* Read Volume Information */
 	dasd_eckd_read_vol_info(device);
 
+	/* Read the on-disk format label for ESE detection */
+	dasd_eckd_read_format_label(device);
+
+	/*
+	 * is_ese() now reflects the real ESE state (vsq + on-disk label), so
+	 * the adaptive heuristic can be derived correctly for this device.
+	 */
+	device->ft_bias = min_t(unsigned int, full_track_bias, DASD_FT_BIAS_MAX);
+	dasd_ft_bias_apply(device);
+
 	/* Read Extent Pool Information */
 	dasd_eckd_read_ext_pool_info(device);
 
@@ -2730,7 +2847,12 @@ static void dasd_eckd_fill_format_label(struct dasd_device *device, void *data,
 	memset(label, 0, blksize);
 	label->magic = DASD_ESE_LABEL_MAGIC;
 	label->version = DASD_ESE_LABEL_VERSION;
-	if (dasd_eckd_is_ese(device))
+	/*
+	 * F_ESE records the hardware capability at format time, not is_ese():
+	 * is_ese() is derived from the label, so using it here would let the
+	 * flag flip on repeated quick/full reformats.
+	 */
+	if (dasd_eckd_ese_capable(device))
 		label->flags |= DASD_ESE_LABEL_F_ESE;
 	if (private->ese_format_quick)
 		label->flags |= DASD_ESE_LABEL_F_QUICK;
@@ -2740,6 +2862,13 @@ static void dasd_eckd_fill_format_label(struct dasd_device *device, void *data,
 	label->format_tod = get_tod_clock();
 	strscpy(label->kernel_version, init_utsname()->release,
 		sizeof(label->kernel_version));
+
+	/*
+	 * Populate the cache directly from the bytes just computed instead of
+	 * synchronously reading them back from disk after the write lands.
+	 */
+	private->ese_label = *label;
+	private->ese_label_valid = true;
 }
 
 static struct dasd_ccw_req *
@@ -3224,23 +3353,35 @@ static int dasd_eckd_format_device(struct dasd_device *base,
 	struct dasd_eckd_private *private = base->private;
 	int rc;
 
-	/*
-	 * A full format (start_unit == 0) returns the device to a fully sparse
-	 * state, so restart the heuristic from ft1 without an offline cycle.
-	 */
-	if (fdata->start_unit == 0)
-		dasd_ft_bias_apply(base);
-
 	rc = dasd_eckd_format_process_data(base, fdata, enable_pav, 0, NULL,
 					   0, NULL);
+	if (fdata->start_unit != 0)
+		return rc;
+
+	if (rc) {
+		/*
+		 * The format failed, so the label cached speculatively during
+		 * CCW build may not match the disk; drop it so is_ese() falls
+		 * back to the hardware field until the next successful format
+		 * or bring-up.
+		 */
+		private->ese_label_valid = false;
+		return rc;
+	}
 
 	/*
 	 * The quick-format indicator was consumed by the label stamped into
 	 * track 0; clear it so a later format that is not preceded by a full
 	 * space release is recorded as a full format.
 	 */
-	if (fdata->start_unit == 0)
-		private->ese_format_quick = 0;
+	private->ese_format_quick = 0;
+
+	/*
+	 * A full format returns the device to a fully sparse state and has just
+	 * committed a fresh label; restart the heuristic from ft1 on the now
+	 * current is_ese state, without an offline cycle.
+	 */
+	dasd_ft_bias_apply(base);
 
 	return rc;
 }
@@ -4241,6 +4382,14 @@ static int dasd_eckd_release_space_trks(struct dasd_device *device,
 static int dasd_eckd_release_space(struct dasd_device *device,
 				   struct format_data_t *rdata)
 {
+	/*
+	 * Space release (and thus a quick format) requires real ESE hardware.
+	 * is_ese() may be true from a copied label on non-ESE hardware, so gate
+	 * on the hardware capability, not on is_ese().
+	 */
+	if (!dasd_eckd_ese_capable(device))
+		return -EOPNOTSUPP;
+
 	if (rdata->intensity & DASD_FMT_INT_ESE_FULL)
 		return dasd_eckd_release_space_full(device);
 	else if (rdata->intensity == 0)
@@ -7613,6 +7762,8 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.hpf_enabled = dasd_eckd_hpf_enabled,
 	.reset_path = dasd_eckd_reset_path,
 	.is_ese = dasd_eckd_is_ese,
+	.ese_capable = dasd_eckd_ese_capable,
+	.on_demand_format = dasd_eckd_on_demand_format,
 	.space_allocated = dasd_eckd_space_allocated,
 	.space_configured = dasd_eckd_space_configured,
 	.logical_capacity = dasd_eckd_logical_capacity,
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 92fd8ac92b79..30745f62402b 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -747,6 +747,13 @@ struct dasd_eckd_private {
 	 * the next format to mark the on-disk label as a quick (vs full) format.
 	 */
 	int ese_format_quick;
+	/*
+	 * Cached on-disk format label (R4), read at online and refreshed on
+	 * format. When valid, is_ese() is derived from it; otherwise it falls
+	 * back to the hardware ESE field (vsq.vol_info.ese).
+	 */
+	struct dasd_format_label ese_label;
+	bool ese_label_valid;
 };
 
 
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index c899073c19c8..f61af45deab0 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -401,6 +401,9 @@ struct dasd_discipline {
 	 * Extent Space Efficient (ESE) relevant functions
 	 */
 	int (*is_ese)(struct dasd_device *);
+	int (*ese_capable)(struct dasd_device *);
+	/* Whether the volume is formatted on demand (thin), from the label */
+	int (*on_demand_format)(struct dasd_device *);
 	/* Capacity */
 	int (*space_allocated)(struct dasd_device *);
 	int (*space_configured)(struct dasd_device *);
-- 
2.53.0

