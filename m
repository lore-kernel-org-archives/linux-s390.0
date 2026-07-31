Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE2445AE0
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512352; cv=none; b=rWNlZPtqfCH7CN+yt4RxtkY6z1rkGdtMul4KO4WuiPayywfC8pjrO+9CO2c9eNdAEH1f9mTcwoU+7386eyc1oroaMacDcSaw1jgzBSX7ghE+u9Dd7Ana2W103WliNt2PekUWqimXx6Hy/W0mUl1Lj0e3qm95ypQQr6SdFA2vAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512352; c=relaxed/simple;
	bh=dTGx3IqsObF83jNSIupLpRXl89Vu9QAmPxQm/sJHb/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWB4MnPtDCIboQPmDUM+mxIzzh88bqHECPAjEnCh8qbEC9THu2WoOi2Lv5wHdPLK8+2dY0fEYbDENo0SDPGvPCdGk8lM1uFAfedze7OtagBI8vc1xuo39ldnFf2FHHrsSHHBOYO/VCwFHd/cwUY1SCzTOog4DAYVOMP3/UDjGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rddIZedq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rddIZedq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmKMe1766354
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SFsK5NyAR+GFBLuvp
	+eYILVQOy3pP5rzDmOUzNxZ/gg=; b=rddIZedqRYRdNRJPHPtphXR7EpEtO9Yg1
	nVraygHdyb7Ru94VQvsUXCAHlbRg7NFXXSXMcX2+g8Dt/efKdNqVNIdYVQWN5Crf
	sZnFcsTmJjX6ERpaOEmZLl3uUTCGjYIt2gJGyF7qo+7axuK2wmRR/C8UiWLZ2ATD
	a0vx8Uhf+Ns8k6JE4TssMTXWe49TPneBuRqIlIVuId9MnafB+DwTMb3LWVImooXJ
	QtibSwGQooovvnvNaQJS5sE9xIUWaE+wCOjcJsQRnvslD2GhK9kVJfwoqNfDMzTs
	eKd+80NnnV5OQpXOJnSSVPKuoq314LrQrAT1OhXM9cxjjCtlHGuoQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y5u6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFQnt5005557
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqrn5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFd0Yx44499452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:39:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4A1B20040;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 970F42004B;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 09/17] s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()
Date: Fri, 31 Jul 2026 17:38:34 +0200
Message-ID: <20260731153842.1729627-10-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731153842.1729627-1-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ES--7x8I_NJh8HKU3CXacEC12y2uCIAv
X-Proofpoint-ORIG-GUID: ES--7x8I_NJh8HKU3CXacEC12y2uCIAv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX3Y9OOw/xyspV
 h7HoI2z8ndEWuw5q0eS5COrQahjz1Sg9nYuf3HoQ5P+1zwP8rmWBayCmIoisszYWka8hA9G+UIP
 uachL6b2Rsfs7gRN6eSKxu87w8CTbIg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6cc199 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=N88Q6yKB32gPlXi9WnIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX+uWr13jPmiwM
 i90UEySvARGEFQDVWm2w4G8bo5Fm9UiKkqeCq0AqkkXHZ86YYJCQMUoLboQ8eTDEWOUCWmqZPaz
 U77n6ubXt4tH28CFtVYxN9RVyG5yfMqZK/u25QKAxxIpOLCS280BRe7AVQXhtsJJ7c9ZOffuat8
 7CobuuwjMPtLivroAfHpmpxIaG83Z8nMHtg7ARzZU7JJueLaBXfS03XpO5Gq/ECUBFcPL5CXQ88
 857FUAiiZZwS4fYqYDCzNuVh+U6Sy9zWpThpGedyu4QxYwRWO512CQEUvG2Izx03CJcDsWSR2eP
 1TRV3It1lVCCFQl8S1Ky634ZmFgqWvmjKfSNWFvU4OsTXi/nxKuOJhiQj0G4dEH9Ua9AGX5HnT7
 vxpy3dE4WRUPQQnMC6sm7OqGyJb2iOSxk3zS3y9WXIZaXbtInGxf9wQSLleFp5ftVW9kgJX4aws
 cAc0pOlZmmrQjgXVs9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116

Add the channel program builder for WRITE_FULL_TRACK requests, used
by dasd_eckd_ese_format() (next patch) to format and write a set of
tracks atomically and avoid the format cycle on ESE devices.

The program is an ITCW with a TIDAW list. Per track it emits an eckd_r0
header, an eckd_count + data pair for every record (pad records before
and after the caller's data window use device->nulldata, records in the
window point into the bio payload), and a terminating 0xFF pseudo-count
with TIDAW_FLAGS_INSERT_CBC. The descriptors come from the per-device
fill_chunks pool so they can be freed in bulk in __dasd_cleanup_cqr().

Add inline helpers crosses_page() and reserve_nocross(), to keep each
descriptor within one page since TIDAW addressing must not cross a page
boundary.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 341 +++++++++++++++++++++++++++++++++
 1 file changed, 341 insertions(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 2c1e0b02a9b2..d47cbed46152 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -123,6 +123,14 @@ static int prepare_itcw(struct itcw *, unsigned int, unsigned int, int,
 			unsigned int, unsigned int);
 static int dasd_eckd_query_pprc_status(struct dasd_device *,
 				       struct dasd_pprc_data_sc4 *);
+static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_writefulltrack(struct dasd_device *,
+								  struct dasd_block *,
+								  struct request *,
+								  sector_t, sector_t,
+								  sector_t, sector_t,
+								  unsigned int, unsigned int,
+								  unsigned int, unsigned int,
+								  struct dasd_ccw_req *);
 
 /* initial attempt at a probe function. this can be simplified once
  * the other detection code is gone */
@@ -4741,6 +4749,339 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
 	return ERR_PTR(ret);
 }
 
+static __always_inline bool crosses_page(const void *addr, size_t len)
+{
+	return len && (offset_in_page(addr) + len > PAGE_SIZE);
+}
+
+static __always_inline void *reserve_nocross(char **p, size_t *space, size_t len)
+{
+	size_t pad = crosses_page(*p, len) ? PAGE_SIZE - offset_in_page(*p) : 0;
+	void *ret;
+
+	if (*space < pad + len)
+		return NULL;	/* out of space */
+
+	*p += pad;
+	*space -= pad;
+	ret = *p;
+	*p += len;
+	*space -= len;
+	return ret;
+}
+
+/*
+ * Helpers for dasd_eckd_build_cp_tpm_writefulltrack(): append the TIDAWs for
+ * one track-image element (R0 header, a count + data record, or the trailing
+ * pseudo track end count) to the itcw. Return the last TIDAW, or NULL on failure.
+ */
+static struct tidaw *add_track_r0(struct itcw *itcw, char **fill,
+				  size_t *fillsize, u32 cyl, u16 head)
+{
+	struct tidaw *tidaw;
+	struct eckd_r0 *r0;
+
+	r0 = reserve_nocross(fill, fillsize, sizeof(*r0));
+	if (WARN_ON_ONCE(!r0))
+		return NULL;
+	set_chr_t(r0, cyl, head, 0);
+	r0->count.dl = 8;
+	tidaw = itcw_add_tidaw(itcw, 0, r0, sizeof(*r0));
+	return IS_ERR_OR_NULL(tidaw) ? NULL : tidaw;
+}
+
+static struct tidaw *add_track_record(struct itcw *itcw, char **fill,
+				      size_t *fillsize, u32 cyl, u16 head,
+				      u8 rec, void *data, u32 dl)
+{
+	struct eckd_count *count;
+	struct tidaw *tidaw;
+
+	count = reserve_nocross(fill, fillsize, sizeof(*count));
+	if (WARN_ON_ONCE(!count))
+		return NULL;
+	set_chr_t(count, cyl, head, rec);
+	count->dl = dl;
+	tidaw = itcw_add_tidaw(itcw, 0, count, sizeof(*count));
+	if (IS_ERR_OR_NULL(tidaw))
+		return NULL;
+	tidaw = itcw_add_tidaw(itcw, 0, data, dl);
+	return IS_ERR_OR_NULL(tidaw) ? NULL : tidaw;
+}
+
+static struct tidaw *add_track_end(struct itcw *itcw, char **fill,
+				   size_t *fillsize)
+{
+	struct eckd_count *count;
+	struct tidaw *tidaw;
+
+	count = reserve_nocross(fill, fillsize, sizeof(*count));
+	if (WARN_ON_ONCE(!count))
+		return NULL;
+	count->cyl = 0xffff;
+	count->head = 0xffff;
+	count->dl = 0xffff;
+	count->record = 0xff;
+	count->kl = 0xff;
+	tidaw = itcw_add_tidaw(itcw, TIDAW_FLAGS_INSERT_CBC, count, sizeof(*count));
+	return IS_ERR_OR_NULL(tidaw) ? NULL : tidaw;
+}
+
+static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_writefulltrack(struct dasd_device *startdev,
+								  struct dasd_block *block,
+								  struct request *req,
+								  sector_t first_rec,
+								  sector_t last_rec,
+								  sector_t first_trk,
+								  sector_t last_trk,
+								  unsigned int first_offs,
+								  unsigned int last_offs,
+								  unsigned int blk_per_trk,
+								  unsigned int blksize,
+								  struct dasd_ccw_req *ocqr)
+{
+	struct dasd_eckd_private *private = block->base->private;
+	unsigned int seg_len, part_len, len_to_track_end;
+	unsigned int count, count_to_trk_end, offs;
+	unsigned int trkcount, ctidaw, tlf;
+	int itcw_op, rec_count, datasize;
+	struct tidaw *last_tidaw = NULL;
+	sector_t recid, trkid, curr_trk;
+	unsigned char cmd, new_track;
+	struct dasd_device *basedev;
+	size_t itcw_size, fillsize;
+	struct dasd_ccw_req *cqr;
+	struct req_iterator iter;
+	char *dst, *filldata;
+	unsigned long flags;
+	struct itcw *itcw;
+	struct bio_vec bv;
+	int ret = -EINVAL;
+	void *nullrecord;
+	u16 heads, head;
+	u32 cyl;
+	u8 rec;
+
+	basedev = block->base;
+	cmd = DASD_ECKD_CCW_WRITE_FULL_TRACK;
+	itcw_op = ITCW_OP_WRITE;
+
+	/*
+	 * trackbased I/O needs address all memory via TIDAWs,
+	 * not just for 64 bit addresses. This allows us to map
+	 * each segment directly to one tidaw.
+	 * In the case of write requests, additional tidaws may
+	 * be needed when a segment crosses a track boundary.
+	 * Per track we emit one R0 tidaw, two tidaws per record (count field
+	 * plus data - a record never crosses a track or page boundary, as
+	 * part_len is clamped to both blksize and the track end), and one track
+	 * end tidaw: 2 * blk_per_trk + 2.
+	 * Round the +2 up to blk_per_trk-independent headroom via 2 * (blk_per_trk + 2).
+	 */
+	trkcount = last_trk - first_trk + 1;
+	ctidaw = trkcount * 2 * (blk_per_trk + 2);
+
+	/*
+	 * build_cp (ocqr == NULL): the request owns its CCW program - block in
+	 * the pdu, ITCW in ccw_chunks. ese_format (ocqr != NULL): the failing
+	 * origin still owns its pdu, so take the replacement from ese_chunks.
+	 */
+	itcw_size = itcw_calc_size(0, ctidaw, 0);
+	if (ocqr)
+		cqr = dasd_fmalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev);
+	else
+		cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev,
+					   blk_mq_rq_to_pdu(req));
+	if (IS_ERR(cqr))
+		return cqr;
+	fillsize = trkcount * (sizeof(struct eckd_r0) +
+			       (sizeof(struct eckd_count) * (blk_per_trk + 2)));
+	/*
+	 * reserve_nocross() pads elements away from page boundaries and draws
+	 * that padding from fillsize; budget one element per page the buffer
+	 * may span so it never runs short.
+	 */
+	fillsize += (fillsize / PAGE_SIZE + 1) * sizeof(struct eckd_r0);
+	spin_lock_irqsave(&startdev->mem_lock, flags);
+	filldata  = dasd_alloc_chunk(&startdev->fill_chunks, fillsize);
+	spin_unlock_irqrestore(&startdev->mem_lock, flags);
+	if (!filldata) {
+		ret = -ENOMEM;
+		goto out_error;
+	}
+	memset(filldata, 0, fillsize);
+	cqr->filldata = filldata;
+
+	nullrecord = startdev->nulldata;
+
+	/* count + data for each record, plus r0 and the pseudo count */
+	tlf = blk_per_trk * (blksize + sizeof(struct eckd_count));
+	tlf += sizeof(struct eckd_r0) + sizeof(struct eckd_count);
+
+	itcw = itcw_init(cqr->data, itcw_size, itcw_op, 0, ctidaw, 0);
+	if (IS_ERR(itcw)) {
+		ret = -EINVAL;
+		goto out_error;
+	}
+	cqr->cpaddr = itcw_get_tcw(itcw);
+	datasize = trkcount * tlf;
+	if (prepare_itcw(itcw, first_trk, last_trk,
+			 cmd, basedev, startdev,
+			 0,
+			 trkcount, blksize,
+			 datasize,
+			 tlf,
+			 blk_per_trk) == -EAGAIN) {
+		/* Clock not in sync and XRC is enabled.
+		 * Try again later.
+		 */
+		ret = -EAGAIN;
+		goto out_error;
+	}
+	heads = private->rdc_data.trk_per_cyl;
+	/*
+	 * A tidaw can address 4k of memory, but must not cross page boundaries
+	 * We can let the block layer handle this by setting seg_boundary_mask
+	 * to page boundaries and max_segment_size to page size when setting up
+	 * the request queue.
+	 */
+	curr_trk = first_trk;
+	recid = first_rec;
+	trkid = recid;
+	offs = sector_div(trkid, blk_per_trk);
+	count = blk_per_trk;
+	len_to_track_end = count * blksize;
+	recid += count - first_offs;
+	new_track = 0;
+
+	/* the R0 header of the first track */
+	cyl = curr_trk / heads;
+	head = curr_trk % heads;
+	last_tidaw = add_track_r0(itcw, &filldata, &fillsize, cyl, head);
+	if (!last_tidaw)
+		goto out_error;
+
+	/* empty records before the first data record */
+	for (int i = 1; i <= first_offs; i++) {
+		len_to_track_end -= blksize;
+		last_tidaw = add_track_record(itcw, &filldata, &fillsize,
+					      cyl, head, i, nullrecord, blksize);
+		if (!last_tidaw)
+			goto out_error;
+	}
+
+	/* process data records */
+	rec = first_offs + 1;
+	rec_count = 0;
+	rq_for_each_segment(bv, req, iter) {
+		dst = bvec_virt(&bv);
+		seg_len = bv.bv_len;
+		while (seg_len) {
+			if (new_track) {
+				trkid = recid;
+				offs = sector_div(trkid, blk_per_trk);
+				count_to_trk_end = blk_per_trk - offs;
+				count = min((last_rec - recid + 1),
+					    (sector_t)count_to_trk_end);
+				/*
+				 * Size to the physical track end: a short last
+				 * track is padded in out_skip, so the track-end
+				 * marker must not be emitted early here.
+				 */
+				len_to_track_end = count_to_trk_end * blksize;
+				recid += count;
+				new_track = 0;
+				/* the R0 header of the next track */
+				cyl = curr_trk / heads;
+				head = curr_trk % heads;
+				last_tidaw = add_track_r0(itcw, &filldata,
+							  &fillsize, cyl, head);
+				if (!last_tidaw)
+					goto out_error;
+				rec = 1;
+			}
+			/*
+			 * One count + data record per block: a bvec segment can
+			 * be up to a page, so clamp to blksize - otherwise the
+			 * count field would describe one oversized record instead
+			 * of several blksize ones for sub-page block sizes.
+			 */
+			part_len = min(seg_len, len_to_track_end);
+			part_len = min(part_len, blksize);
+			seg_len -= part_len;
+			len_to_track_end -= part_len;
+			/*
+			 * This block ends the track; the next one starts a new
+			 * track. The track-end marker emitted below carries the
+			 * CBC flag.
+			 */
+			if (!len_to_track_end)
+				new_track = 1;
+
+			last_tidaw = add_track_record(itcw, &filldata, &fillsize,
+						      cyl, head, rec, dst, part_len);
+			if (!last_tidaw)
+				goto out_error;
+
+			if (new_track) {
+				/* add track end marker */
+				last_tidaw = add_track_end(itcw, &filldata,
+							   &fillsize);
+				if (!last_tidaw)
+					goto out_error;
+				curr_trk++;
+			}
+			rec++;
+			dst += part_len;
+			rec_count++;
+			if (rec_count >= (last_rec - first_rec + 1))
+				goto out_skip;
+		}
+	}
+
+out_skip:
+	new_track = 0;
+	/* empty records after the last data record */
+	for (int i = last_offs + 2; i <= blk_per_trk; i++) {
+		len_to_track_end -= blksize;
+		last_tidaw = add_track_record(itcw, &filldata, &fillsize,
+					      cyl, head, i, nullrecord, blksize);
+		if (!last_tidaw)
+			goto out_error;
+		new_track = 1;
+	}
+
+	/* add track end marker */
+	if (new_track) {
+		last_tidaw = add_track_end(itcw, &filldata, &fillsize);
+		if (!last_tidaw)
+			goto out_error;
+	}
+
+	last_tidaw->flags |= TIDAW_FLAGS_LAST;
+	last_tidaw->flags &= ~TIDAW_FLAGS_INSERT_CBC;
+	itcw_finalize(itcw);
+
+	if (blk_noretry_request(req) ||
+	    block->base->features & DASD_FEATURE_FAILFAST)
+		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
+	cqr->cpmode = 1;
+	cqr->startdev = startdev;
+	cqr->memdev = startdev;
+	cqr->block = block;
+	cqr->expires = startdev->default_expires * HZ;	/* default 5 minutes */
+	cqr->lpm = dasd_path_get_ppm(startdev);
+	cqr->retries = startdev->default_retries;
+	cqr->buildclk = get_tod_clock();
+	cqr->status = DASD_CQR_FILLED;
+
+	return cqr;
+out_error:
+	/* dasd_sfree_request frees from the right pool via cqr->mem_chunk */
+	dasd_sfree_request(cqr, startdev);
+	return ERR_PTR(ret);
+}
+
 static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 					       struct dasd_block *block,
 					       struct request *req)
-- 
2.53.0

