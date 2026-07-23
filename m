Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A7747D955
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814482; cv=none; b=RegqZXhUhoqynf5DdpZI+/Atf1ABnfKYAHhBeV9dyvb5LP8AhkYLnaOWSWIwGPzSH5No2W9zRCNMjgIEx6T/aQyjxUvZBMkiSHiCLSXxTcS6j7nIARD5wGGeac3AVlC/KIwRPUAEfR71vYP//nukYcJQg8ebphqacALHfYJZyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814482; c=relaxed/simple;
	bh=RqaYaWlPLMotHxZ3mXHTNSmM8gK3rkp2b6438IJOWbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiE42kjIwUCxCa23y8NzPjJLAtTAyYOxZJgP/A6gCoTrz4xYXkcGDX74zANpnDkVYscb0R8Xu7BlmZDMsanRMs5W3/++Fh8viM+IduwV8IQ8UCXU0I+JQrF/9zH40N92Cp/hMlhUkOaWDurzgB9hTTrrICmyee1/GXZ6OOf3Xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VU9X2amc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VU9X2amc"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBcw43106066
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lgjQPAJBkDUlypAQt
	F4s0IN00K+2i12S5cy6VZ1Sd54=; b=VU9X2amcu7JQB8zMLAhJ/PSJGctv9/qU5
	dVVEWfp+cNfUvvtWOQk0g0s1CCdRvXuO/m4vY3v+nOFottAMeJpOvJEQp6dsTJ2+
	WL67ergxMPeEOTyDWsSJDIG2XyAXQBxXapgqijSKHaYQYdufM7P3GWKKmLz/5v1w
	2/RLBVAnCgZAO25eyvZ/IAU68ik78c96vUAvmp79J6SLIaSu1IDd1nQkaRShwvW4
	UxQ0WEmWtXgLiAdrEs7fUHvWXbru97+ihEKBab+sBaXpHFwM2Upwm+PvX3rBblQ3
	o7U4hXa5CbUoY7xJqLeTT2DizIduLeD5bMvvZEeTL93HSW+TcepmQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7917tx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYbVm025850
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4duk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDlnvn50528576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFF912004B;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C173520043;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 09/13] s390/dasd: Stamp a format label into newly formatted volumes
Date: Thu, 23 Jul 2026 15:47:39 +0200
Message-ID: <20260723134743.672413-10-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723134743.672413-1-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y2NtX1F9m888CM4oFWfIWhGk7nLi8LHp
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a621b8a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=yLuKiE5ZXbex2J97MEEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX95EhB+UC67Wd
 Xd8balQG3gam7fpkBhs/ionYAf5rvMY3amZIuG87xP4xreMX/d9aj5a1Jb7d5N78DvNHVYu/GdR
 oqYD409UiFPZhQ4N/UC/8rR/5aXnpIE=
X-Proofpoint-GUID: Y2NtX1F9m888CM4oFWfIWhGk7nLi8LHp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX9p/lxI+YJb3Z
 wOiRHZgVPZO+2J7WoJnKuTR8OuSlTucRePT+34caRbud9vvOousR5NsMv5dKluTx49m8kBDC3n/
 FxLW++BxHFv9IyJEs0FLMrX10xOuQ8iruniWhs81bWD4kVt9l29rZ1rYrOpU46BlenTdOuCReV7
 lMRVdIlKTTH6fzr3pvoVMGVA/aJCfQUCQYIKQaO8vM3yHZvjLnrQGSPV5a4C1F8tEuO7uty2zYL
 h85q+bWGumetCXK3/rulOqGUMspq2N9ryhbKJAM+vrqca9FJ97lOeHhF3mCuBSyrBABZ0WIK/ID
 W4eqFfTTFiIt3jaUPE1S2MjbxqJtyn68k+P6duIG7deNSSAjnrrDwkmwagd22/Wh3i5sR57HlOW
 MM7+KYkbjLRJR7GWi+7uhJu4yKJ7mFirgIBtSGhdz01PpCkQbqu5ZyJ7RF5yDwKefqntcLEhit6
 pWOMcE6GxVg/dLyNcpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

When a CDL volume is formatted, write a small on-disk label so the format
can later be recognised by the kernel. The next patch will use this for
ESE detection.

The label records a magic, a version, whether the volume is ESE, and
whether it was formatted quick (space released, thin) or full.

It lives in track 0, head 0, record 4 (the first non-special CDL record).
R4 is written by the same channel program that formats track 0
- its WRITE_CKD transfers count + the label data instead of count-only -
so label and track format reach the disk atomically; a valid magic then
marks a completed format without a separate, racy write.

Quick vs full is derived from a full space release (RAS) preceding the
format: dasd_eckd_release_space_full() sets a per-device flag the next
format consumes. Non-ESE volumes and formats without a preceding full
release are recorded as full.

struct dasd_format_label is exactly 512 bytes (the smallest block size)
so it fits one record; larger blocks zero-pad the rest.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 87 ++++++++++++++++++++++++++++++----
 drivers/s390/block/dasd_eckd.h | 39 +++++++++++++++
 2 files changed, 118 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 439c18a39f60..79f039d709eb 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2689,6 +2689,28 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
 	return cqr;
 }
 
+/* Fill the format label into a R4 record buffer, zero-padded to blksize. */
+static void dasd_eckd_fill_format_label(struct dasd_device *device, void *data,
+					unsigned int blksize)
+{
+	struct dasd_eckd_private *private = device->private;
+	struct dasd_format_label *label = data;
+
+	memset(label, 0, blksize);
+	label->magic = DASD_ESE_LABEL_MAGIC;
+	label->version = DASD_ESE_LABEL_VERSION;
+	if (dasd_eckd_is_ese(device))
+		label->flags |= DASD_ESE_LABEL_F_ESE;
+	if (private->ese_format_quick)
+		label->flags |= DASD_ESE_LABEL_F_QUICK;
+	else
+		label->flags |= DASD_ESE_LABEL_F_FULL;
+	label->blksize = blksize;
+	label->format_tod = get_tod_clock();
+	strscpy(label->driver_ver, DASD_ESE_LABEL_DRIVER,
+		sizeof(label->driver_ver));
+}
+
 static struct dasd_ccw_req *
 dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 		       struct format_data_t *fdata, int enable_pav)
@@ -2707,6 +2729,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 	int r0_perm;
 	int nr_tracks;
 	int use_prefix;
+	int write_label;
 
 	if (enable_pav)
 		startdev = dasd_alias_get_start_dev(base);
@@ -2740,6 +2763,15 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 
 	use_prefix = base_priv->features.feature[8] & 0x01;
 
+	/*
+	 * Stamp the format label into R4 of the very first track. Only for CDL
+	 * (R4 is the first non-special record there), only when this request
+	 * covers track 0, only for the record-writing format intensities (not
+	 * track invalidation), and only if the track actually has an R4.
+	 */
+	write_label = (intensity & 0x08) && !((intensity & ~0x08) & 0x04) &&
+		      fdata->start_unit == 0 && rpt > 3;
+
 	switch (intensity) {
 	case 0x00:	/* Normal format */
 	case 0x08:	/* Normal format, use cdl. */
@@ -2786,6 +2818,10 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* room for the label data that R4 carries in addition to its count */
+	if (write_label)
+		datasize += fdata->blksize;
+
 	fcp = dasd_fmalloc_request(DASD_ECKD_MAGIC, cplength, datasize, startdev);
 	if (IS_ERR(fcp))
 		return fcp;
@@ -2930,7 +2966,21 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 					ccw->cmd_code =
 						DASD_ECKD_CCW_WRITE_CKD_MT;
 				ccw->flags = CCW_FLAG_SLI;
-				ccw->count = 8;
+				if (write_label && address.cyl == 0 &&
+				    address.head == 0 && i == 3) {
+					/*
+					 * R4 carries the label as its record
+					 * data; it follows ect contiguously so
+					 * the CCW transfers count + data.
+					 */
+					dasd_eckd_fill_format_label(base,
+								    data,
+								    fdata->blksize);
+					data += fdata->blksize;
+					ccw->count = 8 + fdata->blksize;
+				} else {
+					ccw->count = 8;
+				}
 				ccw->cda = virt_to_dma32(ect);
 				ccw++;
 			}
@@ -3140,6 +3190,9 @@ static int dasd_eckd_format_process_data(struct dasd_device *base,
 static int dasd_eckd_format_device(struct dasd_device *base,
 				   struct format_data_t *fdata, int enable_pav)
 {
+	struct dasd_eckd_private *private = base->private;
+	int rc;
+
 	/*
 	 * A full format (start_unit == 0) returns the device to a fully sparse
 	 * state, so restart the heuristic from ft1 without an offline cycle.
@@ -3147,8 +3200,18 @@ static int dasd_eckd_format_device(struct dasd_device *base,
 	if (fdata->start_unit == 0)
 		dasd_ft_bias_apply(base);
 
-	return dasd_eckd_format_process_data(base, fdata, enable_pav, 0, NULL,
-					     0, NULL);
+	rc = dasd_eckd_format_process_data(base, fdata, enable_pav, 0, NULL,
+					   0, NULL);
+
+	/*
+	 * The quick-format indicator was consumed by the label stamped into
+	 * track 0; clear it so a later format that is not preceded by a full
+	 * space release is recorded as a full format.
+	 */
+	if (fdata->start_unit == 0)
+		private->ese_format_quick = 0;
+
+	return rc;
 }
 
 static bool test_and_set_format_track(sector_t start, sector_t end,
@@ -4043,6 +4106,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 
 static int dasd_eckd_release_space_full(struct dasd_device *device)
 {
+	struct dasd_eckd_private *private;
 	struct dasd_ccw_req *cqr;
 	int rc;
 
@@ -4052,12 +4116,19 @@ static int dasd_eckd_release_space_full(struct dasd_device *device)
 
 	rc = dasd_sleep_on_interruptible(cqr);
 
-	/*
-	 * Releasing all space (RAS) wipes every track and the device is fully
-	 * sparse again, so restart the heuristic from ft1.
-	 */
-	if (!rc)
+	if (!rc) {
+		/*
+		 * Releasing all space (RAS) wipes every track and the device is
+		 * fully sparse again, so restart the heuristic from ft1.
+		 */
 		dasd_ft_bias_apply(device);
+		/*
+		 * A full release is what makes a subsequent format a quick
+		 * (thin) one; remember it so the format label records that.
+		 */
+		private = device->private;
+		private->ese_format_quick = 1;
+	}
 
 	dasd_sfree_request(cqr, cqr->memdev);
 
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 184266102f60..2ae5ad98023e 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -151,6 +151,40 @@ struct eckd_r0 {
 	__u8 data[8];
 } __packed;
 
+/*
+ * On-disk DASD format label.
+ *
+ * Written into track 0, head 0, record 4 (R4 - the first non-special CDL
+ * record) as part of the same channel program that formats track 0, so it is
+ * stored atomically with the track: either both the track format and the label
+ * make it to disk or neither does. Its presence with a valid magic therefore
+ * marks a completed format and can be used for format detection.
+ *
+ * The structure is exactly the smallest supported block size (512 bytes) so it
+ * always fits into a single record.
+ * For larger block sizes the rest of the record is zero padded.
+ * The magic together with the version is used to recognise a valid label.
+ */
+#define DASD_ESE_LABEL_MAGIC	0xC4C1E2C4C6D4E3F1ULL	/* EBCDIC "DASDFMT1" */
+#define DASD_ESE_LABEL_VERSION	1
+#define DASD_ESE_LABEL_DRIVER	"linux-dasd"
+
+/* dasd_format_label.flags */
+#define DASD_ESE_LABEL_F_ESE	0x00000001	/* volume is extent space efficient */
+#define DASD_ESE_LABEL_F_QUICK	0x00000002	/* quick (space released) format */
+#define DASD_ESE_LABEL_F_FULL	0x00000004	/* full format */
+
+struct dasd_format_label {
+	__u64 magic;			/* DASD_ESE_LABEL_MAGIC */
+	__u32 version;			/* DASD_ESE_LABEL_VERSION */
+	__u32 flags;			/* DASD_ESE_LABEL_F_* */
+	__u32 blksize;			/* block size the volume was formatted with */
+	__u32 reserved0;
+	__u64 format_tod;		/* TOD clock at format time */
+	__u8  driver_ver[16];		/* NUL terminated driver version string */
+	__u8  reserved[464];		/* pad the struct to 512 bytes */
+} __packed;
+
 struct ch_t {
 	__u16 cyl;
 	__u16 head;
@@ -701,6 +735,11 @@ struct dasd_eckd_private {
 
 	u32 fcx_max_data;
 	char suc_reason;
+	/*
+	 * Set when the whole volume's space was released (full RAS); consumed by
+	 * the next format to mark the on-disk label as a quick (vs full) format.
+	 */
+	int ese_format_quick;
 };
 
 
-- 
2.53.0

