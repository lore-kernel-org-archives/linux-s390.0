Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18675432BDE;
	Wed,  5 Aug 2026 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928598; cv=none; b=kJmPwtdChTyl5jWqjeNrjFYBa+6GpESm+hme34iqmbBHocDUw2Zn0t9YXIyWCs9w7o7Mzmkubw2bEwsV/R77OrDnONDi16tG5Kc9aOnCIfBQjkADVJpZ6Tc2DNzlNHkuNISjfK6VgzY4HgsgL56vzJ9Liq5BhvSzwcneEqZErdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928598; c=relaxed/simple;
	bh=Zl/8aPhmVJROGLlaLhx3w5WPLDKqw/ckbOPTcodcUUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shbodjCaflpO3wXYoYhYcVCcVsBdjGYxRE3DAurVkNZU5Gagnz7gxvcyFlduK4o3b0PAMGXNKXOY9rV4GBzCsxC4zgUihF4ibB4cB3FOSI5WjniCeZg/rdQ3Tho8c1hSV50bH2BRS2B7NUM4Zq2UiukcKmu1NLLDrykExVgOQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JYi1IeFm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JYi1IeFm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lXLZ3387207;
	Wed, 5 Aug 2026 11:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YYlP5J
	k6BwhQohMsQ47zZurt7A/hl5PWey7vlJpxhKc=; b=JYi1IeFmnCaYksfMbDAWb+
	Z1Ru9hEK3matFSpHeRgmbx0cCH65kIm6lAcQJmujssifluG7rf0RlAgzoz/hYmM2
	OgZrMIZwvPinQl+vygiuSVVVnrcgJKncAHHoJ+B3V3Ldehg/jQmbqhJ5EiKiDgg4
	xhe8BqavkSu+J8KLt6s1TBOLN5W7lkWRhmJRZSbUQXdULo9wJOqsXMupC8JrLtP5
	1T7E+TewhVNck8akXCtkXMTQ/n8TA9IqWt/hKJ/W36LNe3AtFEmeE+/+x2JnKG29
	38bfLiDeDJvyMURIEBf7SXVrsKwJJuiJO/BXf9eLQc177cVua26/7uK6mQsTmfmw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52q21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfmEG006377;
	Wed, 5 Aug 2026 11:16:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k685q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGJFG43581908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F67420043;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19D672004D;
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
Subject: [PATCH 16/19] s390/dasd: Detect ESE volumes from the on-disk format label
Date: Wed,  5 Aug 2026 13:16:09 +0200
Message-ID: <20260805111612.1285190-17-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXwhPXHViYtJZJ
 rrvPeKAiaVCur/5Gq2dVfonuyr7YlzmBmDRleMbts866RudHNqBAKus+H1bRAOR5Q87nRm79aHb
 t0dYNRwaJoEpTBfi/vVi5N0UjcTAkJ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4muCTleJ1LV8
 U96e84A3gzUF9z+r7SGKoVkhL7E7QgZdNsAQxZqHQkuUcT7EPpl+60iZQ1ea/qa49u7Coy4IbjF
 6cERzlMjD+jGG7MDKExMMCkOWluVfoN4TSJje9lRa2vXnv8UIM2QLrgu7sgXUmLq7qVw5oMtttE
 HGDCSDA6/N/lYRC4a0zucODwYRvh3wEIXokpKPMC4iOALtQwsz1EXBWIdrwQmKGJxjh7WX1Dgjn
 96LiVI2ZeWns4pZtre8KtljvVP+3Lmr91kRxQW6RuGmSAOSp/w2Q3cdxfmLhPADmvuWz+hXXWH5
 /HMgD4WwoCBZRVUSee16cPeHuVsNVKqsczHtaJrmcD24Q7mgjntMJWNP4uqr5SsdWp4vE4jVlto
 FVbFByyXCFuQk2Q7qd97c8eqfZXcqN1BL1bmIgZv8BZI/XRULyH82LLdwB0KlIkT7YYwr3Va3x2
 KGAvy9CIHgeNeb4Gwbw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a731b8a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_CgVIJRZcvbIkyxbzCkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JHUAz8W3ZxqmnJrfEthwAAtzVrajO-LZ
X-Proofpoint-GUID: JHUAz8W3ZxqmnJrfEthwAAtzVrajO-LZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

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
 drivers/s390/block/dasd_eckd.c   | 174 ++++++++++++++++++++++++++++---
 drivers/s390/block/dasd_eckd.h   |   7 ++
 drivers/s390/block/dasd_int.h    |   3 +
 4 files changed, 175 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index f6aab94b7be6..d07d384a004f 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -2482,9 +2482,10 @@ static ssize_t dasd_##_name##_show(struct device *dev,			\
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
@@ -2522,6 +2523,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_path_reset.attr,
 	&dev_attr_hpf.attr,
 	&dev_attr_ese.attr,
+	&dev_attr_on_demand_formatting.attr,
 	&dev_attr_fc_security.attr,
 	&dev_attr_copy_pair.attr,
 	&dev_attr_copy_role.attr,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 25a9055b97a2..d5854ed0076e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1677,7 +1677,8 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	return rc;
 }
 
-static int dasd_eckd_is_ese(struct dasd_device *device)
+/* Hardware/volume ESE capability, from the Volume Storage Query. */
+static int dasd_eckd_ese_capable(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
@@ -1687,6 +1688,53 @@ static int dasd_eckd_is_ese(struct dasd_device *device)
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
@@ -2106,6 +2154,69 @@ static bool dasd_eckd_pprc_enabled(struct dasd_device *device)
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
@@ -2216,9 +2327,12 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	/* Read Volume Information */
 	dasd_eckd_read_vol_info(device);
 
+	/* Read the on-disk format label for ESE detection */
+	dasd_eckd_read_format_label(device);
+
 	/*
-	 * is_ese() now reflects the hardware ESE state, so derive the default
-	 * fulltrack write bias from the module parameter.
+	 * is_ese() now reflects the real ESE state (vsq + on-disk label), so
+	 * the adaptive heuristic can be derived correctly for this device.
 	 */
 	device->ft_bias = min_t(unsigned int, full_track_bias, DASD_FT_BIAS_MAX);
 	dasd_ft_bias_apply(device);
@@ -2734,7 +2848,12 @@ static void dasd_eckd_fill_format_label(struct dasd_device *device, void *data,
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
@@ -2744,6 +2863,13 @@ static void dasd_eckd_fill_format_label(struct dasd_device *device, void *data,
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
@@ -3228,23 +3354,35 @@ static int dasd_eckd_format_device(struct dasd_device *base,
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
@@ -4249,6 +4387,14 @@ static int dasd_eckd_release_space_trks(struct dasd_device *device,
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
@@ -7622,6 +7768,8 @@ static struct dasd_discipline dasd_eckd_discipline = {
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
index 59cce4e7dbc1..8c73850f7947 100644
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

