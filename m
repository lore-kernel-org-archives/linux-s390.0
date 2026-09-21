Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5430E83F;
	Mon, 21 Sep 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001042; cv=none; b=VyIfY7YailK/R+WupnekZzC+hNIsYYW86Yjd9ouYTUs4CDXl8YqZW8E3iPOAiMI8wrwQXdFO5qnLWVLNbvf4RB1rxStBZp7BDS18EJa2thm4T1jOZyGmA4S6K8P1TVWov0qkYA2ahORGEGTsl/ArLpx9oOChzlzLF6lEDJlz4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001042; c=relaxed/simple;
	bh=VSZ2ellk7NyPAQ6OxqK76xkGzIwlbwrH3BFRe178qm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNTpxq5qXSg+FajlSpuUtbGiAf4acRplAPY1BhNtWbIxjO56ZRZ0Pn+udNzLxj/a85AmMF1GNONNzZYwjXTPKIMMB3/8Xa+vVAq5ukzZSCVthD3rzDKDEZUq3TOea5CfOZIxTud1Dc0dxTSIvYWESgE9L5vgfmZST3zK/SWT3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lSXy4vmV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lSXy4vmV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LE5hcn4059741;
	Mon, 21 Sep 2026 14:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jIB8eIIeWUi3bNzvA
	WynxfqZK63nKkecTH9uhX9vWvY=; b=lSXy4vmVNdrKBMNhyTX+gO6B21wJ3whzJ
	N/tIrQaGEIrj37S/m5AYk897Tjn+wlAOaybdzTUJCPKfE+3Z/I/3tuftYV7SZEz5
	Y496EhvVx3Fom+JBAeJVMJ4Zr9yn8VcRd+mbnSk5qjx9w9D5sEx72GNeYpKy1LGQ
	zdbIqQPJyF/lswWqgyR08u1QF/KTRGcncOfNva3X8sR/X/pqF8Hl6Wek2251hu3P
	63HOeu25+NRcusm+Prwm6I/QJViho72Z4B+U8BRtPT+/Qn5BsQkUcHDybBcKJcOI
	OWy5A0VLradzDMVqsYiJgMsctyDbNZhk1iFyVjyW/bLnOGFqgk1NA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1h2v4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 14:30:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEIrT11371085;
	Mon, 21 Sep 2026 14:30:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gnm45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 14:30:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LEUYgJ42598862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 14:30:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDF3920043;
	Mon, 21 Sep 2026 14:30:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC4A62004B;
	Mon, 21 Sep 2026 14:30:34 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 14:30:34 +0000 (GMT)
From: M Nikhil <nikh1092@linux.ibm.com>
To: linux-s390@vger.kernel.org, sashiko-reviews@lists.linux.dev
Cc: M Nikhil <nikh1092@linux.ibm.com>
Subject: [PATCH v12 1/2] zfcp: Replace sg-list with sg_table in zfcp_fsf_ct_els structure
Date: Mon, 21 Sep 2026 16:30:29 +0200
Message-ID: <20260921143030.356432-2-nikh1092@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921143030.356432-1-nikh1092@linux.ibm.com>
References: <20260921143030.356432-1-nikh1092@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9u_DCx2wZevfwRF-DdL9NjJBQCXesDfx
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab13f8f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=SPISVwao-ayoBmANS60A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfX2WIPHXr3t7Z/
 d48FF9EZEKgt5UVnbU0zUd9hKtkcrMzvSD4/aLy9cMFedUo51Pqitf/z3BWeWY7oc4/5+mT4eu3
 bxRGZrk9DY0ZlDvwfeOql2AaN5/OOl8=
X-Proofpoint-GUID: 9u_DCx2wZevfwRF-DdL9NjJBQCXesDfx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfX05mB4XPkL2Z+
 Zk3wHySDgbyDV+7OvjUNAC5Zf9IQV86KXjxxItsS7fnSMYIRLaVg/ZP8ZHHGWI7CGHzvVBIhaG6
 lbfwrf7PldfxEco51KQzIdaDK+sWC2t41w2V1RtbP+2KKzhnZdY+yvhVcSxgxXai9+HF+tV4S3N
 jQiAj+I/Yx4+HD+TspC32P3qPDOILlD6CldrHtIp3oRUpIIYa2JLW7uNpwxW1xkoHwOmV14lLH8
 IBfLOaJWvW/xc6v8f6y+Ry8GBhtQH7e66BVW3XsibOgMnMttm/c+RgvD4wzX5lC9MsCrZkfSLsf
 YmR4P16ZauBQVQtuJrvsMSgxG+iB0IdzZNSAnI7FmBcoodevB3VjxaWrIvBEHtBURdhqaS6ED3p
 XLFmeQQ03pKGyP+6ARg+AB71hU/Phg+fZAlmzp3Y9qcdI73xmwvw4rRVgsfvyF/SgHn09MY/qD3
 OnkYScJxEHhVWoHKE4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210205

The zfcp_fsf_ct_els data structure is updated to replace the sg_req and
sg_resp members, which are of type struct scatterlist, with request and
response sg_table instances.

These sg_table structure reference the corresponding scatterlists
(sg_req and sg_resp) maintained in struct zfcp_fc_req.

These changes allows to track the original and mapped scatterlist nents
once zfcp is converted to use DMA-API for mapping the sg lists.

Signed-off-by: M Nikhil <nikh1092@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reference-ID: SAN2402
---
 drivers/s390/scsi/zfcp_dbf.c | 16 ++++++++--------
 drivers/s390/scsi/zfcp_fc.c  | 36 ++++++++++++++++++++++++------------
 drivers/s390/scsi/zfcp_fsf.c |  6 ++++--
 drivers/s390/scsi/zfcp_fsf.h |  9 +++++----
 4 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 4217b74baa38..4232b1474a2f 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -581,9 +581,9 @@ void zfcp_dbf_san_req(char *tag, struct zfcp_fsf_req *fsf, u32 d_id)
 	if (unlikely(!debug_level_enabled(dbf->san, ZFCP_DBF_SAN_LEVEL)))
 		return;
 
-	length = (u16)zfcp_qdio_real_bytes(ct_els->req);
-	zfcp_dbf_san(tag, dbf, "san_req", ct_els->req, ZFCP_DBF_SAN_REQ,
-		     length, fsf->req_id, d_id, length);
+	length = (u16)zfcp_qdio_real_bytes(ct_els->sgt_req.sgl);
+	zfcp_dbf_san(tag, dbf, "san_req", ct_els->sgt_req.sgl,
+		     ZFCP_DBF_SAN_REQ, length, fsf->req_id, d_id, length);
 }
 
 static u16 zfcp_dbf_san_res_cap_len_if_gpn_ft(char *tag,
@@ -591,9 +591,9 @@ static u16 zfcp_dbf_san_res_cap_len_if_gpn_ft(char *tag,
 					      u16 len)
 {
 	struct zfcp_fsf_ct_els *ct_els = fsf->data;
-	struct fc_ct_hdr *reqh = sg_virt(ct_els->req);
+	struct fc_ct_hdr *reqh = sg_virt(ct_els->sgt_req.sgl);
 	struct fc_ns_gid_ft *reqn = (struct fc_ns_gid_ft *)(reqh + 1);
-	struct scatterlist *resp_entry = ct_els->resp;
+	struct scatterlist *resp_entry = ct_els->sgt_resp.sgl;
 	struct fc_ct_hdr *resph;
 	struct fc_gpn_ft_resp *acc;
 	int max_entries, x, last = 0;
@@ -662,9 +662,9 @@ void zfcp_dbf_san_res(char *tag, struct zfcp_fsf_req *fsf)
 	if (unlikely(!debug_level_enabled(dbf->san, ZFCP_DBF_SAN_LEVEL)))
 		return;
 
-	length = (u16)zfcp_qdio_real_bytes(ct_els->resp);
-	zfcp_dbf_san(tag, dbf, "san_res", ct_els->resp, ZFCP_DBF_SAN_RES,
-		     length, fsf->req_id, ct_els->d_id,
+	length = (u16)zfcp_qdio_real_bytes(ct_els->sgt_resp.sgl);
+	zfcp_dbf_san(tag, dbf, "san_res", ct_els->sgt_resp.sgl,
+		     ZFCP_DBF_SAN_RES, length, fsf->req_id, ct_els->d_id,
 		     zfcp_dbf_san_res_cap_len_if_gpn_ft(tag, fsf, length));
 }
 
diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 05d081297879..1fb6f2c3b607 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -393,10 +393,12 @@ static int zfcp_fc_ns_gid_pn_request(struct zfcp_port *port,
 	fc_req->ct_els.port = port;
 	fc_req->ct_els.handler = zfcp_fc_complete;
 	fc_req->ct_els.handler_data = &completion;
-	fc_req->ct_els.req = &fc_req->sg_req;
-	fc_req->ct_els.resp = &fc_req->sg_rsp;
+	fc_req->ct_els.sgt_req.sgl = &fc_req->sg_req;
+	fc_req->ct_els.sgt_resp.sgl = &fc_req->sg_rsp;
 	sg_init_one(&fc_req->sg_req, gid_pn_req, sizeof(*gid_pn_req));
 	sg_init_one(&fc_req->sg_rsp, gid_pn_rsp, sizeof(*gid_pn_rsp));
+	fc_req->ct_els.sgt_req.orig_nents = sg_nents(&fc_req->sg_req);
+	fc_req->ct_els.sgt_resp.orig_nents = sg_nents(&fc_req->sg_rsp);
 
 	zfcp_fc_ct_ns_init(&gid_pn_req->ct_hdr,
 			   FC_NS_GID_PN, ZFCP_FC_CT_SIZE_PAGE);
@@ -558,12 +560,14 @@ static int zfcp_fc_adisc(struct zfcp_port *port)
 		return -ENOMEM;
 
 	fc_req->ct_els.port = port;
-	fc_req->ct_els.req = &fc_req->sg_req;
-	fc_req->ct_els.resp = &fc_req->sg_rsp;
+	fc_req->ct_els.sgt_req.sgl = &fc_req->sg_req;
+	fc_req->ct_els.sgt_resp.sgl = &fc_req->sg_rsp;
 	sg_init_one(&fc_req->sg_req, &fc_req->u.adisc.req,
 		    sizeof(struct fc_els_adisc));
 	sg_init_one(&fc_req->sg_rsp, &fc_req->u.adisc.rsp,
 		    sizeof(struct fc_els_adisc));
+	fc_req->ct_els.sgt_req.orig_nents = sg_nents(&fc_req->sg_req);
+	fc_req->ct_els.sgt_resp.orig_nents = sg_nents(&fc_req->sg_rsp);
 
 	fc_req->ct_els.handler = zfcp_fc_adisc_handler;
 	fc_req->ct_els.handler_data = fc_req;
@@ -706,8 +710,10 @@ static int zfcp_fc_send_gpn_ft(struct zfcp_fc_req *fc_req,
 
 	ct_els->handler = zfcp_fc_complete;
 	ct_els->handler_data = &completion;
-	ct_els->req = &fc_req->sg_req;
-	ct_els->resp = &fc_req->sg_rsp;
+	ct_els->sgt_req.sgl = &fc_req->sg_req;
+	ct_els->sgt_resp.sgl = &fc_req->sg_rsp;
+	ct_els->sgt_req.orig_nents = sg_nents(&fc_req->sg_req);
+	ct_els->sgt_resp.orig_nents = sg_nents(&fc_req->sg_rsp);
 
 	ret = zfcp_fsf_send_ct(&adapter->gs->ds, ct_els, NULL,
 			       ZFCP_FC_CTELS_TMO);
@@ -865,8 +871,10 @@ static int zfcp_fc_gspn(struct zfcp_adapter *adapter,
 
 	ct_els->handler = zfcp_fc_complete;
 	ct_els->handler_data = &completion;
-	ct_els->req = &fc_req->sg_req;
-	ct_els->resp = &fc_req->sg_rsp;
+	ct_els->sgt_req.sgl = &fc_req->sg_req;
+	ct_els->sgt_resp.sgl = &fc_req->sg_rsp;
+	ct_els->sgt_req.orig_nents = sg_nents(&fc_req->sg_req);
+	ct_els->sgt_resp.orig_nents = sg_nents(&fc_req->sg_rsp);
 
 	ret = zfcp_fsf_send_ct(&adapter->gs->ds, ct_els, NULL,
 			       ZFCP_FC_CTELS_TMO);
@@ -924,8 +932,10 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
 
 	ct_els->handler = zfcp_fc_complete;
 	ct_els->handler_data = &completion;
-	ct_els->req = &fc_req->sg_req;
-	ct_els->resp = &fc_req->sg_rsp;
+	ct_els->sgt_req.sgl = &fc_req->sg_req;
+	ct_els->sgt_resp.sgl = &fc_req->sg_rsp;
+	ct_els->sgt_req.orig_nents = sg_nents(&fc_req->sg_req);
+	ct_els->sgt_resp.orig_nents = sg_nents(&fc_req->sg_rsp);
 
 	ret = zfcp_fsf_send_ct(&adapter->gs->ds, ct_els, NULL,
 			       ZFCP_FC_CTELS_TMO);
@@ -1090,8 +1100,10 @@ int zfcp_fc_exec_bsg_job(struct bsg_job *job)
 	if (!(atomic_read(&adapter->status) & ZFCP_STATUS_COMMON_OPEN))
 		return -EINVAL;
 
-	ct_els->req = job->request_payload.sg_list;
-	ct_els->resp = job->reply_payload.sg_list;
+	ct_els->sgt_req.sgl = job->request_payload.sg_list;
+	ct_els->sgt_resp.sgl = job->reply_payload.sg_list;
+	ct_els->sgt_req.orig_nents = sg_nents(ct_els->sgt_req.sgl);
+	ct_els->sgt_resp.orig_nents = sg_nents(ct_els->sgt_resp.sgl);
 	ct_els->handler_data = job;
 
 	switch (bsg_request->msgcode) {
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index d407f16e77ef..a3b99839da9e 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1242,7 +1242,8 @@ int zfcp_fsf_send_ct(struct zfcp_fc_wka_port *wka_port,
 	}
 
 	req->status |= ZFCP_STATUS_FSFREQ_CLEANUP;
-	ret = zfcp_fsf_setup_ct_els(req, ct->req, ct->resp, timeout);
+	ret = zfcp_fsf_setup_ct_els(req, ct->sgt_req.sgl, ct->sgt_resp.sgl,
+				    timeout);
 	if (ret)
 		goto failed_send;
 
@@ -1342,7 +1343,8 @@ int zfcp_fsf_send_els(struct zfcp_adapter *adapter, u32 d_id,
 	if (!zfcp_adapter_multi_buffer_active(adapter))
 		zfcp_qdio_sbal_limit(qdio, &req->qdio_req, 2);
 
-	ret = zfcp_fsf_setup_ct_els(req, els->req, els->resp, timeout);
+	ret = zfcp_fsf_setup_ct_els(req, els->sgt_req.sgl, els->sgt_resp.sgl,
+				    timeout);
 
 	if (ret)
 		goto failed_send;
diff --git a/drivers/s390/scsi/zfcp_fsf.h b/drivers/s390/scsi/zfcp_fsf.h
index 4b92e85ec71d..22e7fd933a78 100644
--- a/drivers/s390/scsi/zfcp_fsf.h
+++ b/drivers/s390/scsi/zfcp_fsf.h
@@ -487,8 +487,9 @@ struct zfcp_blk_drv_data {
 
 /**
  * struct zfcp_fsf_ct_els - zfcp data for ct or els request
- * @req: scatter-gather list for request, points to &zfcp_fc_req.sg_req or BSG
- * @resp: scatter-gather list for response, points to &zfcp_fc_req.sg_rsp or BSG
+ * @sgt_req: sg_table for request, its sgl points to &zfcp_fc_req.sg_req or BSG
+ * @sgt_resp: sg_table for response, its sgl points to &zfcp_fc_req.sg_resp
+ *            or BSG
  * @handler: handler function (called for response to the request)
  * @handler_data: data passed to handler function
  * @port: Optional pointer to port for zfcp internal ELS (only test link ADISC)
@@ -496,8 +497,8 @@ struct zfcp_blk_drv_data {
  * @d_id: Destination ID of either open WKA port for CT or of D_ID for ELS
  */
 struct zfcp_fsf_ct_els {
-	struct scatterlist *req;
-	struct scatterlist *resp;
+	struct sg_table sgt_req;
+	struct sg_table sgt_resp;
 	void (*handler)(void *);
 	void *handler_data;
 	struct zfcp_port *port;
-- 
2.53.0

