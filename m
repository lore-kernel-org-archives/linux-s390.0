Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFEF849C
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501818; cv=none; b=Tf2aJsFHbZDgnkyxRa6tMReTBH67eTdsbKrooIuALyoLlJV0llCx9GJtUwzsm6GNFInarsSW0reQdH9qhNKmO4Xt54AeuGWb6K9lvRGacNkmLrcJfn6NcKbO5KaU6FxQVKVANPQ7w/EHG3zACqzNpwzH1vyTm3H6OxwscUuEzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501818; c=relaxed/simple;
	bh=A0gyzOOhk+bgrOGuEwMbgJ/zGlY4YGR3HGFJd2g4+I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hljSutsTMvy99mfC3qJt7E7rX/Ec8n61BF4XFYUwtfSwREcQKYECBTHnJ9VPPeIMsAHWP2A8U6Yu2YGCwDVeBVDfd1wUkNVdrsJz3uD0nFL6SoMS/xqUc5O0ks8neXyc4bN+amoEpTNt/6f+NbmVOw2dvpflKquGtJuswUwFSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W7FnoPdn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W7FnoPdn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O9EOFh028668;
	Thu, 24 Apr 2025 13:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aQjx34VEKwQb+H6YV
	XdW4RNiD6VRM/lkgr0DTajD4ZA=; b=W7FnoPdni9q1qnFD5Z2OzCkPzSsD15vZ5
	is/W+6NeeaM/024m+pOOS4V8vixFXiG+E1iz+0yfPcHp2+z1bZC49/9PSh4mtzEe
	UtmAB6AkZpaDPUvE9ltszJLp0E6bwdywj51ijjNRNW6y/x9FxIJGe6EkkSqiiLNp
	5Vlwgsl4JiJqOkw++htnf+Rl+UHVmGcC3ITDPxoyHvC4b2aW90HJbCeWofG1nPOS
	i1l0VSLNVg0ziSij2kA+5S9meWS0EKXciTxR6Esbz24Sh+6UgdCNuL6dE9daCt9M
	9w5iODuMNZanZT5dB7qJ3JN3HFWF/SaVJs7G+p2KJNpBzvZ5AX3IA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678aabu9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBD5N4005861;
	Thu, 24 Apr 2025 13:36:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxgd48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaSAn56557946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2F2720040;
	Thu, 24 Apr 2025 13:36:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 930C720043;
	Thu, 24 Apr 2025 13:36:27 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:27 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 16/25] s390/zcrypt: Propagate xflags argument with cca_get_info()
Date: Thu, 24 Apr 2025 15:36:10 +0200
Message-ID: <20250424133619.16495-17-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfXwQeEdwpiPJUu nvBMlPgE0/dQBybzmFPCeBoENN0SUuknkzTFah1tgS6G4ISaScRQ/i0Ilbp/3BnlZCd13vpIedh pxpjTaJCUYsUTgh+clnvC5/zHLhp264trJzU8FTCiMs/m/WwwzKMXGqBSJRgSS9L/1+qa5qWFUE
 A1KaBZr9xs1hAUoevgeJ60sptF4IQqsglW0ONFyM74oT+RysSJ6GytntuOvKEKnCc83fP8Dvfxw jNeGz6G7w2+/ajxwLJ+rWBuI+B+BqxRGIoGPtCPWolGozOeNCNMB/2x9k8hUztJVc8Dwze6ytj3 v+1i6eSYKCyGV6+Mnbo4zQQhJGSOwheFDR6rrjlx2Huy518ZGhNl1BPrPy4ScxBZgNOjwaOarsq
 FdgT08dcMcvj8vnpt7+bkR4zHFTswnhchRpF5dJ1rt0SXUFEERSBAXFjeBsoeTmp4mLSK6IC
X-Proofpoint-ORIG-GUID: mBcDoungUhWn9XP1d2QFRkxyZNh-Qv7_
X-Proofpoint-GUID: mBcDoungUhWn9XP1d2QFRkxyZNh-Qv7_
X-Authority-Analysis: v=2.4 cv=KejSsRYD c=1 sm=1 tr=0 ts=680a3e76 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=OHbkrU8AMn62nkaBgakA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

Propagate the xflags argument from the cca_get_info()
caller down to the lower level functions for proper
memory allocation hints.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 6 +++---
 drivers/s390/crypto/zcrypt_ccamisc.h | 2 +-
 drivers/s390/crypto/zcrypt_cex4.c    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index e44e115ca77b..c61d7cbc31e8 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1635,14 +1635,13 @@ EXPORT_SYMBOL(cca_query_crypto_facility);
  * Fetch cca_info values about a CCA queue via
  * query_crypto_facility from adapter.
  */
-int cca_get_info(u16 cardnr, u16 domain, struct cca_info *ci)
+int cca_get_info(u16 cardnr, u16 domain, struct cca_info *ci, u32 xflags)
 {
 	void *mem;
 	int rc, found = 0;
 	size_t rlen, vlen;
 	u8 *rarray, *varray;
 	struct zcrypt_device_status_ext devstat;
-	u32 xflags = 0;
 
 	memset(ci, 0, sizeof(*ci));
 
@@ -1721,6 +1720,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	int i, card, dom, curmatch, oldmatch;
 	struct cca_info ci;
 	u32 _nr_apqns = 0;
+	u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1749,7 +1749,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		if (domain != 0xFFFF && dom != domain)
 			continue;
 		/* get cca info on this apqn */
-		if (cca_get_info(card, dom, &ci))
+		if (cca_get_info(card, dom, &ci, xflags))
 			continue;
 		/* current master key needs to be valid */
 		if (mktype == AES_MK_SET && ci.cur_aes_mk_state != '2')
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index ca41a675dd3b..38d69aceefe6 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -255,7 +255,7 @@ struct cca_info {
 /*
  * Fetch cca information about an CCA queue.
  */
-int cca_get_info(u16 card, u16 dom, struct cca_info *ci);
+int cca_get_info(u16 card, u16 dom, struct cca_info *ci, u32 xflags);
 
 int zcrypt_ccamisc_init(void);
 void zcrypt_ccamisc_exit(void);
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index ecf1fcc6315e..84cbcbab2741 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -85,7 +85,7 @@ static ssize_t cca_serialnr_show(struct device *dev,
 	memset(&ci, 0, sizeof(ci));
 
 	if (ap_domain_index >= 0)
-		cca_get_info(ac->id, ap_domain_index, &ci);
+		cca_get_info(ac->id, ap_domain_index, &ci, 0);
 
 	return sysfs_emit(buf, "%s\n", ci.serial);
 }
@@ -119,7 +119,7 @@ static ssize_t cca_mkvps_show(struct device *dev,
 
 	cca_get_info(AP_QID_CARD(zq->queue->qid),
 		     AP_QID_QUEUE(zq->queue->qid),
-		     &ci);
+		     &ci, 0);
 
 	if (ci.new_aes_mk_state >= '1' && ci.new_aes_mk_state <= '3')
 		n += sysfs_emit_at(buf, n, "AES NEW: %s 0x%016llx\n",
-- 
2.43.0

