Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96D4457C0
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149216; cv=none; b=hD0NDKhhqZynHXczsjzrQemL74JRf4Gy60CV+nb+Tb5sMtnpnjxaIFZ4gq4iypmDKkKlvR+IeQy75J3vTj3bNUjDzMrgYVQ3sT6i8UGm64eoVlKk3LkXBp6i+vrwKS8yw6Qx+jJkGFXzcodMDWPNU25wnL95zuivU7H1ndmXJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149216; c=relaxed/simple;
	bh=bsAXONtv3OV85AnsKyi6dq0CYXrLbHdSl30Xe14vlzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOqKrv9f8HiL1uPlP6QmWvsGVZ8C/J5s3FgS5IKdDrY/bn6U0FsfkJ7mmsxrA56BkQx5qzpkPnylduQCC2I84zMuxK3fASnujSfWa7W8hAEiaouT/tAqqwkxdPSrIk0ZuV5v9UVnREugdEwbTOQvWZgRfhW0uha+X7Xy6CBxXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cLsgGRxo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cLsgGRxo"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N77qtv1551682
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ojyzcgYmEtf3OfSs
	DRs3oVaGefm/5H6qRtJtThMI8w=; b=cLsgGRxo6s1dTDcOJnWHXeqgI4QM3lyZY
	YU51j9/2aYnAHid6w7xg9CjEclue5fmI8UWFRP2l+RiEUvewmEnk/bEJ6bcfYecZ
	aAhQTHuMlazRB1s1uxVzqWhMx0HjOb2EChNXejFsWap8XW5OJ36L3EbOIVVQzM1G
	QB9vxBLGGJ8i/raro6/ng+rMrnUjDpe72sdXfgg/M97OA9uudyErO9wzfx1VK3WO
	7udnt67zP/TMnPYTz1yxtsNPK+rOGx4aJv/aHyKecnuJDcvub/mXk0swUMJuJQxx
	9tgnd4cejIk317eepzgsGMV+huNGg5V8tP/t8XBHSiYfidQX7bNlQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqhd2v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N7HXfD2822854
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkftud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N7e7Ic49152298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 07:40:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09BE62004B;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBA252004E;
	Wed, 23 Sep 2026 07:40:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 07:40:06 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v7 1/5] s390/sclp: Make parsing of received event buffers more robust
Date: Wed, 23 Sep 2026 09:40:02 +0200
Message-ID: <20260923074006.3962077-2-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923074006.3962077-1-egorenar@linux.ibm.com>
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab3825c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=vSaj_4tFx2hm58w1KeIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX8pLV2WN8axxy
 u8hoFChsTg9JrfICq8fPOL8KbrLZ1KIedGuQVlq5/mSWxiMWffEQO8ZJNO+igdfQpHuWnvtKrtP
 ZcraQlDbjVgYsyLVxjQQJk71FlJLgj1krWTVjEfz0cBvz2/A23b93kJ9YEzH+nOamiTbZXPOSPv
 bBQ9UFXEgksp77YlHJqSk0+qmpX3ZdwKgCRtKQzX7kus171vjWQr0mEjYBvVNEnmQ9X5rjCce8W
 vZOGooMuHNthQNrDZkc1Vtx+MoQM0fWHEx3KvycNyhFAg2b8HGvQJkzzeCG0Kgon+qLaYfqBzeY
 qAVHVhHi9aU0UnJqi/n1seqXcty0O0vEQ5oYcz8f1yOZWrpJXcYN1aczDTkQbANSZbcsRxzj34S
 s948Vv1/91UEvzY+2SmVJ9J2UpBzQ4iMNRnsJV4pOlcdvFtDmCQWro6BYZB7OwwNSNt04c1qSFn
 FZIKZgYMq9A34rkqt1Q==
X-Proofpoint-ORIG-GUID: tuu1KHaSpE7lNW6mIw8qwyrRzoqEhWh2
X-Proofpoint-GUID: tuu1KHaSpE7lNW6mIw8qwyrRzoqEhWh2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX0AJf2SDVaaJx
 0n9EyHo0131geyH8iOUmVui6hKirghY+1fMvBTFDFaej0RK3rTInoKm/thJJyHYdzmLbQAGgO7V
 fUqVy/nocGuuE8EEQ4zvVzsCN3xlwP8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230030

Validate header fields of SCCB and event buffers to protect from potential
out-of-range memory accesses which might be caused by malformed hardware
responses.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Suggested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/char/sclp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 98e334724a62..5a4e4001dfa8 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -532,8 +532,7 @@ EXPORT_SYMBOL(sclp_add_request);
 
 /* Dispatch events found in request buffer to registered listeners. Return 0
  * if all events were dispatched, non-zero otherwise. */
-static int
-sclp_dispatch_evbufs(struct sccb_header *sccb)
+static int sclp_dispatch_evbufs(struct sccb_header *sccb)
 {
 	unsigned long flags;
 	struct evbuf_header *evbuf;
@@ -542,14 +541,25 @@ sclp_dispatch_evbufs(struct sccb_header *sccb)
 	int offset;
 	int rc;
 
+	/* Check for malformed hardware response */
+	if (sccb->length > PAGE_SIZE)
+		return -EINVAL;
+
 	spin_lock_irqsave(&sclp_lock, flags);
 	rc = 0;
 	for (offset = sizeof(struct sccb_header); offset < sccb->length;
 	     offset += evbuf->length) {
-		evbuf = (struct evbuf_header *) ((addr_t) sccb + offset);
 		/* Check for malformed hardware response */
-		if (evbuf->length == 0)
+		if (offset + sizeof(struct evbuf_header) > sccb->length) {
+			rc = -EINVAL;
 			break;
+		}
+		evbuf = (struct evbuf_header *) ((addr_t) sccb + offset);
+		if (evbuf->length < sizeof(*evbuf) ||
+		    offset + evbuf->length > sccb->length) {
+			rc = -EINVAL;
+			break;
+		}
 		/* Search for event handler */
 		reg = NULL;
 		list_for_each(l, &sclp_reg_list) {
-- 
2.53.0

