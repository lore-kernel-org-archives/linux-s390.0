Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1504418D7
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628314; cv=none; b=AeoDgtmhED7Z8ZzI3+e8MlMaesq9bNX3xSSKP7E/svy1nS4cOEeSsNb0P/pZlVGbF8ZRzE6mixNEaoOLIjH2zes8Hj9rxmMozV/0DJWVng2jL6eh+o5O8DThnT2k8TXcn1d0Js8kupRIbKSDvQJ0ltoBrPkyJ5aXsQ+9zI5usZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628314; c=relaxed/simple;
	bh=VoR3VDq5qSzcaezvK/B870le/PlqYb7DEFYxt0qQie0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mW8eGWBiVoJ2qPOFbj5xrN97N3JruZVEQNzPULIP8qClF19GoFV7shWGEjO6WaDALRJU9mnIS3vebY+SgWmnAB46nwitYOnUKw2Ku3AvnVPfdrcM2uYQxYA4UpjvhVS0NkAEchF7iXVOUCcJScQYeeQZaWDFIjjcZBNrB9B+6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aL546v/J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aL546v/J"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H61w5d1560247
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LX84xj4+OMdqDCtD8
	vjVDXBLYjbjmH1MEc+KqsNpFbI=; b=aL546v/J0vg2+HozTuwybsP0fsP00AJF2
	NcNTLVn+npAk4vzsgCyArzGS8N0hrA5h97pSb+Uzs6+Ao1B/UfiUyPx6+PwjHMWY
	IZ1IcOuSTscfVsbG1LTAlLl6gNAsRawOPzMsmGcv6UhXbtNhxvUs0kxbJEDaadvG
	uhNLZXf1jXaGhGvB4Oy4UkiP4LI4wWuSv6JAGYyb+9Lp22I+4rqKcpTCEEsGRC2q
	SN6S3rCY3Z2hczItMI7DT+YVyBvhMEIqTI4MbHmF5qRiBpu3py4awsWgoqNP9OMP
	OX/kiXhPZTDYpeu4tjPJAfFZdP7GUZwgIYaqtoHxfQjA++vy1jFSQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j0q62-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H655oA2660573
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjh6yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H6wOUJ30146950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 06:58:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA4F420043;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE5B2004D;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 2/4] s390/sclp_tty: Make use of sclp_gds_for_each()
Date: Thu, 17 Sep 2026 08:58:22 +0200
Message-ID: <20260917065824.2858737-3-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917065824.2858737-1-egorenar@linux.ibm.com>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfX0NxkLp+YZFjJ
 Rj/rd3I62ZkjKGIuLgc3ZdQoL1Clrj2BAhmeo8Vp7O9qYWc3Q+1/gR7ILnQWdgzSWtSgyepCqSi
 6hlmd6eRft8Q6+9h/S4o5lIKh0SvA6sPlGpAyvnMK7q7gZdhBl4RoxhnrDazDfWMIl++7tFHq9I
 Vibjvwd0A6cpgon5uADcumr730yPSAEzv6i/ip1MN1LTJaKUdcJiCwn3uI6mD9zYFjoQ/XlBYSN
 dMmvqhDPj51zK44uy/G3C7qHL6C+eQJqam2w/Fr4ZJP3zVHmWE6CkxZq6mogCX0l9r4KGgOPrvt
 7QsGGMe1gOjeXxlHsOl0fEyQ0IByqv5LfPCri0XuJy/IjxbG5gpestgUsqrjxBT9WOctYXjVj5C
 qy6EOPJatyHvqlmhf/6uvbDNutQj4ouQLmTEZkIUeD4mU50wKjR6c0LIlU9cN54mN3ztd9THf3p
 N2ot8p5IZAIK6ZwJZEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfX5nW/wULlPeBq
 mpPZrNKLxutTRdT0tcr7ACuirNClJjNh32TjEC79qWXcuxnid5FlUKBLS2PMV0J+b9m/qzyKoNA
 halGWcDejDLeL9lqUePmfBRwGDbbHfA=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aab8f96 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=_o8mVxKuoft2pY_LRgEA:9
X-Proofpoint-ORIG-GUID: 0dHm66rT2kdCDhFkjMonXWAlaQ3blHBl
X-Proofpoint-GUID: 0dHm66rT2kdCDhFkjMonXWAlaQ3blHBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170086

Replace manual and error-prone iteration over entries of a GDS {sub}vector
with sclp_gds_for_each() which deals with erroneous entries in GDS
{sub}vectors more safely.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Fixes: 30c2df51173e ("[S390] sclp: event buffer dissection")
---
 drivers/s390/char/sclp_tty.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 0a92d08830e7..4353890bbf8a 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -418,38 +418,38 @@ static void sclp_get_input(struct gds_subvector *sv)
 
 static inline void sclp_eval_selfdeftextmsg(struct gds_subvector *sv)
 {
-	void *end;
-
-	end = (void *) sv + sv->length;
-	for (sv = sv + 1; (void *) sv < end; sv = (void *) sv + sv->length)
+	void *start = sv + 1;
+	void *end = (void *) sv + sv->length;
+	int n;
+	sclp_gds_for_each(sv, n, start, end) {
 		if (sv->key == 0x30)
 			sclp_get_input(sv);
+	}
 }
 
 static inline void sclp_eval_textcmd(struct gds_vector *v)
 {
+	void *start = v + 1;
+	void *end = (void *) v + v->length;
 	struct gds_subvector *sv;
-	void *end;
-
-	end = (void *) v + v->length;
-	for (sv = (struct gds_subvector *) (v + 1);
-	     (void *) sv < end; sv = (void *) sv + sv->length)
+	int n;
+	sclp_gds_for_each(sv, n, start, end) {
 		if (sv->key == GDS_KEY_SELFDEFTEXTMSG)
 			sclp_eval_selfdeftextmsg(sv);
-
+	}
 }
 
 static inline void sclp_eval_cpmsu(struct gds_vector *v)
 {
-	void *end;
-
-	end = (void *) v + v->length;
-	for (v = v + 1; (void *) v < end; v = (void *) v + v->length)
+	void *start = v + 1;
+	void *end = (void *) v + v->length;
+	int n;
+	sclp_gds_for_each(v, n, start, end) {
 		if (v->gds_id == GDS_ID_TEXTCMD)
 			sclp_eval_textcmd(v);
+	}
 }
 
-
 static inline void sclp_eval_mdsmu(struct gds_vector *v)
 {
 	v = sclp_find_gds_vector(v + 1, (void *) v + v->length, GDS_ID_CPMSU);
-- 
2.53.0

