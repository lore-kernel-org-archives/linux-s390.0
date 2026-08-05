Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F529434E35;
	Wed,  5 Aug 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928597; cv=none; b=VtIClgKweUBhpHdBQCxE2JeDQuM+GyZ132warzHPBEeypZuQmNb8z9A04MVM+L00bPFy3//PUnzArW7DhlJzUfN2IfYrSPSrHrcat4nHTSUjn7p0oIAPXIGacBfD9QNoQmob47+gQ2wna4SlFZ/mQf8A+adEmuyKueQhRtHUIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928597; c=relaxed/simple;
	bh=HHGva5O7TMAjhgP9xu40mNAx3OzZjQmt3hFXuOyV8ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLeMCBN6kbTwM2Ta7WzNY4VRdATdoyCK/G4L6CS2IAUgoDxW4YmJn6vHLM5+Olb6OL4/nuBwzbh71FAMOQljOvCUe8ctcyjcRF3PeXh1a961EdAiEip1t6tNgy0+9blSBmCVRKnsFeaxTYEUlcEPaqNsMETD5boJBqgBz4sceks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pbuVn9HC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pbuVn9HC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758loLU3288816;
	Wed, 5 Aug 2026 11:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bQ+TBs
	U23Z+bRc9SLGCAvBHjb/xJdNEVHNjMRycFB80=; b=pbuVn9HCa72GZ538K7OBnF
	sh5ZxyQpJxBET6lOKYOhNKq72j9Zw7Vr8Hdvvs5BChFjjzTC9yNxg4QyTln9FsGb
	PARoYnfFuQ/53vnPGyppczRET/cWLh2OiOrqdv80jHv7MhEdnDx17GrkuJ08+a5e
	lYFuSW7FXGeLLi6jnliXXxcYo+5+LEEvNlwOo9YJ4zzuQXVmQTPIy3flGCCp2YxR
	71tbvNC/nBQp8sixwEEv0XiFTjBGwG0EIpbGPbIdXZHaRDbRJdEHHoCsgArcIlq7
	W1G5Zc5YuPnVKvGSGVvMgZwHR3MfDndAEpgGIgxtKLs/YCcgHYNMqcXaeB1T6ukw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67htg7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBKKO005785;
	Wed, 5 Aug 2026 11:16:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbge2cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGJtG43581906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 151D72004F;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E48D12004E;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 15/19] s390/dasd: Stamp a format label into newly formatted volumes
Date: Wed,  5 Aug 2026 13:16:08 +0200
Message-ID: <20260805111612.1285190-16-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX1ANshK0nmvs4
 93AZluliyE3fi1wDpdt0fnybmocbMJAt7oVijYlGMiMI6wyDPAsNrJU/DowUi1YfDSlG4OuqBNv
 9ydLz7nA5T5zWUgBrtYkFlJcPBDP+Xw=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a731b8b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=yLuKiE5ZXbex2J97MEEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4W3cK+LOCI6g
 BcnxnZWR8C3qGRAfyc9uH8c7aQZ0rVw1f8XuLb0PW7LfRD2Wg43Zdqx9aB4gr7vESQ7f0xJIBdd
 yK1yI54JnUOHgqEQ+bvtcgBg++pckIG+HkkWQI6vzzhAbmY+7IT0y2MnlmvRdEpogtGaZot4iYU
 mlaBjgkYWIWYQig+EkLqTik6QG0dkMp3WvCvp/LmpExBDEWmtaxoXobVLinWDzDx3F6oEzMbula
 jiwrw1tEnZi7bj39ob0dwYkqHqotF6eJZ5oUZJGEtn0jxrWo6ASxULJ28JrqvJvl2NVTL+dKrOM
 GTc0EFtS50bkNBKOHZudG0V6Km2pveOfU8/pz2V3SNuae0bOiTG4vY6XQBg/TC54EIXQfIFNnMU
 KEeZkek9S64RPrVIqZRE8Uk1LZJ7FoAcReTzrDRxi+gnBauWlii1kfeyF9SMPYJk1GdYx09kdc2
 l80V3Q0sy/d4dcR0yyg==
X-Proofpoint-ORIG-GUID: nmoSQ0AAr8Wh4V0mqklkTwwLyEb9lsR2
X-Proofpoint-GUID: nmoSQ0AAr8Wh4V0mqklkTwwLyEb9lsR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

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
index 62c03c4787c8..25a9055b97a2 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/utsname.h>
 #include <linux/io.h>
 #include <linux/overflow.h>
 
@@ -2723,6 +2724,28 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
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
@@ -2741,6 +2764,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 	int r0_perm;
 	int nr_tracks;
 	int use_prefix;
+	int write_label;
 
 	if (enable_pav)
 		startdev = dasd_alias_get_start_dev(base);
@@ -2774,6 +2798,15 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 
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
@@ -2820,6 +2853,10 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* room for the label data that R4 carries in addition to its count */
+	if (write_label)
+		datasize += fdata->blksize;
+
 	fcp = dasd_fmalloc_request(DASD_ECKD_MAGIC, cplength, datasize, startdev);
 	if (IS_ERR(fcp))
 		return fcp;
@@ -2964,7 +3001,21 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
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
@@ -3174,6 +3225,9 @@ static int dasd_eckd_format_process_data(struct dasd_device *base,
 static int dasd_eckd_format_device(struct dasd_device *base,
 				   struct format_data_t *fdata, int enable_pav)
 {
+	struct dasd_eckd_private *private = base->private;
+	int rc;
+
 	/*
 	 * A full format (start_unit == 0) returns the device to a fully sparse
 	 * state, so restart the heuristic from ft1 without an offline cycle.
@@ -3181,8 +3235,18 @@ static int dasd_eckd_format_device(struct dasd_device *base,
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
@@ -4085,6 +4149,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 
 static int dasd_eckd_release_space_full(struct dasd_device *device)
 {
+	struct dasd_eckd_private *private;
 	struct dasd_ccw_req *cqr;
 	int rc;
 
@@ -4096,10 +4161,16 @@ static int dasd_eckd_release_space_full(struct dasd_device *device)
 
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

