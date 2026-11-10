Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310254;
	b=1VPuswj+/0CY3s2/IUX7B+ZT1ZGk8RNePIoL7YbX7BoaBYoavvA7rWQbSnmfz0A9ag7b
	 z7YPKPH3p1u2+sQwv9N60p0Pg9Fk5KLPGFy6mb1s5nGwNV081wyXJ44yuD3IqNDQQXzy3
	 975rb4CnLJGJLYGphOXgyuwX3qN8ad5bS21WdLaPAVa/BlIMqEmuEgCB0EWNrWPi39kmD
	 ad4Qmuv1XotM3QYIOuHZEs+g3+OYmKwGj7DR0StMJzRu/8Zyx1SZoEffayU6AjXINAwAZ
	 DBNcz4GDCzWGlsMldlnP9CioWJEpOBRBCrrIhACHLoqX0kDmQLIDCpHn+nWheJem5FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KjLYP1gnCKstdjQ74nVQKta0bQqMIvupf8VKiiT+elM=;
	b=QubUfryiN+8XenWY2b45YtKNtZkbMIEankvrnFpH6MJ5hQsefEfvowpcBExnlA5HaIkY
	 KeCpaMH8z2vFaldd5hT+DBXU17sifojD4QUKfOHV4ESZRWGaOe7yOitB//T65V5ab4g9O
	 om3T4HqM50a6R4h1efgpkMDZHqESVvHITsHyDJx0VrpHWVLmIwaLgwij6V1VL9QyEeDOc
	 4P8g+JgzZd0NFZoM33aqwsHNvqJ72lAv1bEcfVj1+k7VbLSOWNDURqsYNCeSnAUfMXwSO
	 CU6pMYIuJnVMCbKRZ7PWKXmMldHbrfBeyVZyi9GKkALU7uYO+J9l+BvHBzIwrpxkWYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dq9ATEh+;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D5606A32E
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B07D5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dq9ATEh+
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEJYn2179791
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KjLYP1gnCKstdjQ74
	nVQKta0bQqMIvupf8VKiiT+elM=; b=Dq9ATEh+sQTRQ98k3GQKr7GB2LVAbBt0T
	KgQROvTBlVcJFT7slCigAWMCv1dvXuUl3SyskhVth8Dvb2lqzJVpZI6b678jzW45
	/U0wMdFMsxGryAGY5uUHnC5+dB4AuKujcPgDSAe32q7bZvhEEgWr2pNpols6HLMy
	GWFbiddExwevsOpQXD7I5Rn7553uOw3XntB+GrRuIpdYz4s0Il9IlEFHBZ7PlEHs
	/FggIh/dSC6hzjErSVLoew7mP3LiWrvd7IHXK7wIIpTGojq01Qtc0YhJj366qmoQ
	F3cv/AqiFDjtey3jzaha5OckBXTBgLio7bxNEz14fh3VbYWB3UDgA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuuwht-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABJtWh561524
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg62q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABUmD737617988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:30:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A7D92004B;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0093620049;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:30:47 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v8 2/5] s390/sclp: Introduce macro sclp_gds_for_each()
Date: Tue, 10 Nov 2026 12:30:44 +0100
Message-ID: <20261110113047.238367-3-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110113047.238367-1-egorenar@linux.ibm.com>
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX5uJobYI+AeiC
 b5UaLbpDOQW59Q+hWP3PrPpSyUfvSbGnGYQrNy5RhHlqQnMyWgHqWqE+E8yqWUpRunOmeEdTk52
 Sk2+uae8K7x9cceqoHlMpujzMnDF9LI=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af3006c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=F2fggvlhTXQ8_NH1qZ0A:9
X-Proofpoint-GUID: Qsh4MJz-vCQGX8an4ptI7iXXXMXQtHIl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX7EoUyZc+9vuB
 UxBN67VedWwrXfRSsiWMoqVWsku9psxe5rXjb8UduSWh+8YxnfZtJfRNCkKIF9pHD8ZerrufL5O
 QdjKB5gK10RFLM2Au6zrSzwGFeRshyaryqvaxjJcrdrErg/LaWNGhZM3qVQ8wbhz/b128Q2L08O
 5SbFUUvpVr905hC3qCrt3Hc6LCWLSD/pV94g3LkgsAjHZD0bsGuLTS7XpPN6cdrRUWWHHsvbSkF
 5zxDTcCPhEdM0iDyuEKf0zUKMqfuhqjZ1ArcISdUSxRvzkE/eKGbRpbLL7hXV76qC4Xu7zIU4ZH
 SeOHs7RBPgbc/nNuPokv1CCWJAr2yqO+UpiQ8SqK+lwnxq7BiF77JK/aVN4nqKF703sqSamIKhP
 Db2Fdr5tolhDpncrow22ex9DnkNkJpTR7FN9GhU81ghvmjW1L9TXCCA5Yui3PnIDdOsd8X9bnU1
 GM5OdghfmPWs6yb2fTw==
X-Proofpoint-ORIG-GUID: Qsh4MJz-vCQGX8an4ptI7iXXXMXQtHIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

sclp_find_gds_{sub}vector() does not deal well with malformed event buffers
consisting of GDS {sub}vectors. This can result in an infinite loop or
an out-of-bounds memory read. Therefore, abort with NULL if
* the next GDS header would exceed the given end boundary
* the length in a GDS header contains an invalid value.
  A valid length value in a GDS header should be at least as large
  as the size of the corresponding GDS header (2 or 4 bytes)
  but also not lead to exceeding the given end boundary.

Use the new macro in sclp_find_gds_{sub}vector() to iterate over entries
of a GDS {sub}vector in a safe manner bailing out on the first invalid
entry.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Suggested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Fixes: 30c2df51173e ("[S390] sclp: event buffer dissection")
---
 drivers/s390/char/sclp.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index b91d31f8e0ef..67cae44f501e 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -359,25 +359,35 @@ sclp_ascebc_str(char *str, int nr)
 	(machine_is_vm()) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
 }
 
-static inline struct gds_vector *
-sclp_find_gds_vector(void *start, void *end, u16 id)
+/* Loop over all GDS {sub}vectors in a safe manner. */
+#define sclp_gds_for_each(v, n, start, end)	\
+	for ((n) = (void *)(end) - (void *)(start), (v) = (typeof(v))(start);	\
+	     (n) >= sizeof(*(v)) && (v)->length >= sizeof(*(v)) && (v)->length <= (n);	\
+	     (n) -= (v)->length, (v) = (void *)(v) + (v)->length)
+
+static inline struct gds_vector *sclp_find_gds_vector(void *start,
+						      void *end, u16 id)
 {
 	struct gds_vector *v;
+	int n;
 
-	for (v = start; (void *) v < end; v = (void *) v + v->length)
+	sclp_gds_for_each(v, n, start, end) {
 		if (v->gds_id == id)
 			return v;
+	}
 	return NULL;
 }
 
-static inline struct gds_subvector *
-sclp_find_gds_subvector(void *start, void *end, u8 key)
+static inline struct gds_subvector *sclp_find_gds_subvector(void *start,
+							    void *end, u8 key)
 {
 	struct gds_subvector *sv;
+	int n;
 
-	for (sv = start; (void *) sv < end; sv = (void *) sv + sv->length)
+	sclp_gds_for_each(sv, n, start, end) {
 		if (sv->key == key)
 			return sv;
+	}
 	return NULL;
 }
 
-- 
2.53.0

