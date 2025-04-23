Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5681F4615
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403354; cv=none; b=mUj1LnlUagtDNdQ64xrWx2zqwRNi8scr6P7Zi8DibOyulgMj0TeHzaVmJ+Mr86yJ7dfRp3D1vse7MF9V7egiYhXZKsNP4nqbcOBWhaQkZwLw6s/+5FpG1z8j9DsB6bPhJ4DOFEyvG9fZX8JG2LH8Qu3Y2A8NI7nSgm95Io1pwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403354; c=relaxed/simple;
	bh=PNEqngqRq7IWrydiwICfVuyVxVwwvzNlRUZOYVj5I6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxo9v12QmJPCmcEhoNzmULNs8TxQ0rbVvZsmuFTb/p2l6J92YPHhTOPAxnqQFf/CvBlVEw8wB2P3qPGA5/QAoQgnO5LubQWROEJBvxkR4w1OT4PmiX30y8pu20MwzuuRCMeLBQTXe6BvHMC+eKivfUaHsJ3rmcjGOxfkqc7OSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hsqg3r70; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hsqg3r70"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fiGA007071;
	Wed, 23 Apr 2025 10:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tpBkU+bod3j+TLA0i
	ogawmxb1n1lwupmkPVwNFEKNyE=; b=Hsqg3r70anUNpEhRRYt4nIv9xm+yxrFHC
	F0IUE2ZFT8OFSHB9/vRkRqeBr3JZxUbPtGDffR3kS8VUYNYSDfn/k74jW8Yxlgq/
	5M+SyQX7kSXSAibm1ABNrku5WulMyPDSjL9GfDBIAO1F4SMItehRyIWL/qHkK0DG
	O+nhX+mM5EFIxsx8Z/wqr6EZuCUVqoMui/oLDs+PPD7sVqdcPYb3JWuDD1OfkPow
	n+dknPwIfzc5O2x4q2CzTyULbCyfuImCCOGoUQPaeUVcTMbstquGtc9Zhp4PGIYn
	+xJl3L0ZZxXwGBtWaFEQpvf/f9mtPACqbKmduSDg/d1R9a19CvMRQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnstn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6WMoO005829;
	Wed, 23 Apr 2025 10:15:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxahjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFjn855640334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 959C52004F;
	Wed, 23 Apr 2025 10:15:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 037822004D;
	Wed, 23 Apr 2025 10:15:45 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:44 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 16/25] s390/zcrypt: Propagate xflags argument with cca_get_info()
Date: Wed, 23 Apr 2025 12:15:25 +0200
Message-ID: <20250423101535.143137-17-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423101535.143137-1-freude@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FSvBHbfnp-q-SMWwPgh3uQtjXm0nIkDq
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=6808bdd6 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=OHbkrU8AMn62nkaBgakA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfXx9HkecZa66Hr VWMKRtysvdIt6HzsTNHxgr8+kCd0wSydqoKvEXBX6TOXs2SwZ3afv1LW7EXi9HqpaKZmQj3HGWN alOjw9sM8TIk2cW12YIukrf9xENgI4+gJG+0ZXbbVaTx0p1nD/uP3cy37T2gILUqvNJ4Kb1Gdzu
 qL4t9SPF+uMQWSjJv8yA/UY78osCsUJkaSbHcDeCXEJzTJcPFCmfAdvBZAo7vQt9JMoasRPpiXG AUV56zOBWc07Os7FduHxfd99XghxDgHsvxG8NFHbDSl3wC3bASM+3+VA01rr2w+6e57rmPSGNJu qNQoe5MRv/G13Y1/OH+XpSV/PAx4UF1fBiAzn1f73WWEg3NMArZAs87TkTV/YSccE1GPwMX+Dz/
 VOa5X7ID9jirwygYgAc6JbsFWYEsTtypx5ut15o4IWx+nSh5M09PCpbUp0sAw3orkw6T+0bk
X-Proofpoint-ORIG-GUID: FSvBHbfnp-q-SMWwPgh3uQtjXm0nIkDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

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
index 33e4deafadd3..51f84af09170 100644
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

