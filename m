Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B997356779
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582626; cv=none; b=KsUdDAZzWEEd5/BtIxUztsDtEYpFeN1yAtBecG/tstP1vkZywR3K1rEgvRR/xvKCfoxs++7gefZgiX7trxdjVVsDWZ816ntHWyqrLtIK94rfIuNXLlUMoJbbESfh6EmMJEWbIzqmqxNIhPZw1UibwR+H23HN2IvxluXFA7T3jso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582626; c=relaxed/simple;
	bh=tbtYdxOMT9J/Z22c9NQzrpOyu4j2uCR/+xg1riOKdD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8eIzf5ULzQuBWIAXtwUWRDQgWHaDD03/jaPMQErR+bgzN8fE3YbbF+g1wUpRVDDOgQc0kYCws0VceP93XxXKQxZX7uhXcgY6PtODYE0qY8Ws6IgsBHlOvrwE476GAyr19n4fw1Fs2DXtxQhKUnLsVqbFTcqEgkR5CYzTqEKItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N9ybtcst; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N9ybtcst"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6719Vf8k267127
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MWqXTW
	q2xkQ4RVoMuvWwVs/X/ILojOjky4j/6GK1y7U=; b=N9ybtcstnF49quFYOVBXsz
	UBS5ytuFIVTW5utnXzmH5SYwZAMaEmIosE+cbDWj1jD7J4AnJe0kSdYXLWiaH5C9
	XdpWBhr9xQM02w8bigab1cJUT8DEMXwdTyIV9NBKhc3Zvd23KnslYkrt4RIb7IcX
	jrQPQ7QKN2Co+Lv+w5InLX/HnopArXqqEu+SfqTPaE3s4lmqBaRV4zAM1CUbpuiN
	fB35+hLNcvUiCXWRQAS+gKHC4ZZsLsZCFi58JTmuEBprYuOrouzzhk/4c45yyXCH
	xo+M7nnoA7WPeltTSID4dPQzQjbncAKoL8pjbCaDpoR6OK+rTcZEOih1EIuYdlKg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eu9218-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuKwo015984
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pguh39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAIM650332078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFDA720040;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF6F2004B;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 14/18] s390/dasd: Stamp a format label into newly formatted volumes
Date: Sat,  1 Aug 2026 13:10:04 +0200
Message-ID: <20260801111008.3391031-15-sth@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _jpXS00jmFCKGtZJ6XvMfSna_QikmFix
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfXwXENjdYUU+yO
 +7MZUKlpMqDI5+RNhmhy0rQ3wlCPMRTc4mCbprWXpe5PBWyse1lVtYlyQpq5NDT2AgPT8doaig7
 FVLsQ2KBokAE3tkEEYa7DH2zKlerEXw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX5hnGKb/ETL2r
 Gbe+j3cDNSKzdi188O5lX/6DCF7EMxPLgoD7q3jjkw1dz0y/WxX+EK++5wwb+Txu0e0Ib8+zxHb
 lUWUCz/Qjo92IsjeYRH4eIVg57z9mEpfGMeN5qmbozV3Ada/8gJZLuobRDRERcl9ImD1QJNeHgl
 GqJKjoQZbdPeheX8Iqd2eCyWNM2IeboQ21ZxHi0pITesq92RaHCIRJLC2SHa0RVk5e+bYqxfigf
 nlD1CZNeQHVahLoQBQ26PgtdUpsttLkBKdu2rLR0ztJR576xWXtsQ3ZbOLdlR1BtLlnUlkiA+SQ
 tpZHMn1ECoNwKUt0z17mSgozHI2QBrsT38WL6W14zLPy1lN7fvRlBQ12WgpRP2aY0krB9F0TrlX
 VD0o0qs9U/OXDnGX3Qz6l/PLbGiCi138ascAmdn7kQB7HEcrXTqzLV8LBFGx7RA5HkP0PJ4MfL0
 eBU+rd6C6tixyt//xCQ==
X-Proofpoint-GUID: _jpXS00jmFCKGtZJ6XvMfSna_QikmFix
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a6dd41f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=yLuKiE5ZXbex2J97MEEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010083

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

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 81 +++++++++++++++++++++++++++++++---
 drivers/s390/block/dasd_eckd.h | 38 ++++++++++++++++
 2 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ac7f1c446d32..b09ea243a955 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/utsname.h>
 #include <linux/io.h>
 
 #include <asm/css_chars.h>
@@ -2719,6 +2720,28 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
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
+	strscpy(label->kernel_version, init_utsname()->release,
+		sizeof(label->kernel_version));
+}
+
 static struct dasd_ccw_req *
 dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 		       struct format_data_t *fdata, int enable_pav)
@@ -2737,6 +2760,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 	int r0_perm;
 	int nr_tracks;
 	int use_prefix;
+	int write_label;
 
 	if (enable_pav)
 		startdev = dasd_alias_get_start_dev(base);
@@ -2770,6 +2794,15 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 
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
@@ -2816,6 +2849,10 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* room for the label data that R4 carries in addition to its count */
+	if (write_label)
+		datasize += fdata->blksize;
+
 	fcp = dasd_fmalloc_request(DASD_ECKD_MAGIC, cplength, datasize, startdev);
 	if (IS_ERR(fcp))
 		return fcp;
@@ -2960,7 +2997,21 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
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
@@ -3170,6 +3221,9 @@ static int dasd_eckd_format_process_data(struct dasd_device *base,
 static int dasd_eckd_format_device(struct dasd_device *base,
 				   struct format_data_t *fdata, int enable_pav)
 {
+	struct dasd_eckd_private *private = base->private;
+	int rc;
+
 	/*
 	 * A full format (start_unit == 0) returns the device to a fully sparse
 	 * state, so restart the heuristic from ft1 without an offline cycle.
@@ -3177,8 +3231,18 @@ static int dasd_eckd_format_device(struct dasd_device *base,
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
@@ -4077,6 +4141,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 
 static int dasd_eckd_release_space_full(struct dasd_device *device)
 {
+	struct dasd_eckd_private *private;
 	struct dasd_ccw_req *cqr;
 	int rc;
 
@@ -4088,10 +4153,16 @@ static int dasd_eckd_release_space_full(struct dasd_device *device)
 
 	if (!rc) {
 		/*
-		 * Releasing all space (RAS) wipes every track and the device is fully
-		 * sparse again, so restart the heuristic from ft1.
+		 * Releasing all space (RAS) wipes every track and the device is
+		 * fully sparse again, so restart the heuristic from ft1.
 		 */
 		dasd_ft_bias_apply(device);
+		/*
+		 * A full release is what makes a subsequent format a quick
+		 * (thin) one; remember it so the format label records that.
+		 */
+		private = device->private;
+		private->ese_format_quick = 1;
 	}
 
 	dasd_sfree_request(cqr, cqr->memdev);
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 0fdb92fdddc8..92fd8ac92b79 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -159,6 +159,39 @@ struct eckd_r0 {
 #define DASD_EAV_CYL_HI_SHIFT	16	/* cylinder bits beyond the 16-bit cyl field */
 #define DASD_EAV_HEAD_HI_SHIFT	4	/* head occupies the low-order 4 bits of head */
 
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
+	__u8  kernel_version[64];	/* NUL terminated kernel release (uname -r) */
+	__u8  reserved[416];		/* pad the struct to 512 bytes */
+} __packed;
+
 struct ch_t {
 	__u16 cyl;
 	__u16 head;
@@ -709,6 +742,11 @@ struct dasd_eckd_private {
 
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

