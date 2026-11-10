Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310254;
	b=wwhMVJStHJ3qkyMRRiwxlkqlBlf5GiU7wQshdJ63We6UDi5XooRBkqQ7l83Izx3VpxPk
	 pMCl9Mu9/fHpo7lfq1RqaGkgXS8dJEqctdkqVk/m17ZX42NXqJjBqBWalUmxvppPe+qkn
	 yvMLimOJJAP9v3/gQCfUE4cegwOL05S6VZ/4h7ale5SwD8vES7xcEL4qSKcJ5VEVk4pYP
	 bgzbTEk/zH7DeQmIMX1PIq2kU524dPa73ugr2WIhcIjxGO6d/Xaa1I6IcNtowvgR6u8Qa
	 pbPYKGTmBBOEj3gfWFbrESfqXvyuYcfsjqcZroEjOSwn3JNZ4sUgtNM5uM6bkTT1wPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Xyz7hYYjl6OEXrP00GFZm7I4Fr4WqVgfcPtFvuzUGf4=;
	b=bpeVgamCPhq3KFA6OnXPB8uyF/gXHH7udxWwJSIzD+6CSJnZqukO0PoRWnbYT0XJmx1A
	 6Nd3IG+IikIcusKD9TH4BAJk3pO++dZu5rQu1itow1C/U568yuXdBB09jvek7tdMcJnqy
	 nzx4n/ww/2/AKQkuXArbFHOkDWyOM13e1PRjRTz61PFTiZ03w9/kHJwgXvn0GTMmDCYwA
	 2R/uoQAF2q2B6ncdnLlwqL2u2D1h6D3nayY/BQCwtzj8aXxJbD0476Pp/AmGQiUkNrTz5
	 Hjd/9jYAuBmtuht+RchMxbXorLsbHpGXSI4gcgw8XtYmipIwuywD0cWQTnVj/m+Aqsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g2Dk1L5y;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA9606A337
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8AA9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g2Dk1L5y
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEB6c2177863
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xyz7hYYjl6OEXrP00
	GFZm7I4Fr4WqVgfcPtFvuzUGf4=; b=g2Dk1L5yak4A4bB+6TpoFH0vExNA3QU/T
	bn+vCV23zl+PkkzLKNUq7kpq/U6WECdghT/EeYiPEZd7taS+MMinD+uwSKVxJb+5
	t6Wqxi5MQlvkFKQKsvAMOJwZgmFFeFldcFKaienZUg3Gi4TOwnjw/gyrV2dw5ouv
	JQ748GhQszmCs+dBZ5p/oY8n+mXMds+89f5CCi6/UlWeOzxT3j8ReXKK4lN6h+U1
	1BarkqRzKmhLKDFppwWr6M6uaabGxIVca0+Xeo8m1RVj94u6iJHp6NrAsuzlFdGz
	BjaQ+KtZHl/aUy3MBB7gjVCFoCTwsMVV/mOIr7NJ8lq0whhl9YsuQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6vjh9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABK3xT1771140
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthp7yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABUmCG37880128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:30:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3913520040;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E71D2004D;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v8 3/5] s390/sclp_tty: Make use of sclp_gds_for_each()
Date: Tue, 10 Nov 2026 12:30:45 +0100
Message-ID: <20261110113047.238367-4-egorenar@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX0oFccgevJA5w
 dX0SDoB8SdtmvZkXowKSXk7BOBAW/lHkGKDt7DxMZ/AWAdXPy8n81kcSsophVL0tMqhKz2dLtd9
 h/s7PsqaNFpPGQWi7XuRQMFLxPKksJw=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af3006d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Rw-E5omhhRtl92cmDEAA:9
X-Proofpoint-ORIG-GUID: vpWcSw3wSt8oWeJk21RmBg492eu4v6Bi
X-Proofpoint-GUID: vpWcSw3wSt8oWeJk21RmBg492eu4v6Bi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX1+wcoMdZryKb
 A3kyMCXBIOrcbHvkhkofhjP4m8gjYhAigRCBt3HQeCLX01RHtcgkmnX9UMcoGW5yNyMQZ9vBrzj
 qLKMMbQFQZGUMPqNcZ9NDRzYpcAFAs9OJ5uQ6N4PjpCyyn/JcEgVx0K7wDdXDDTZ1s+PXyesfdN
 BivzuI46pFXRB3IvMsATIoRyQvzCB5idyGFwpE7WbNDTI4dP6L2dW5G6hROIlTe0k8TkyfLnKK4
 VDvLTtUPz14gSpmCDTOxVntdq7d4EJBhoTx1x1cbYO2YkuszWimJzAlYf9nYTQz2znJMiOeZ/1v
 RcU8dFcIfyKITbQ2fw8vLYvER4ivdrY3neOjSsWhvUYKHQ/lmPRXNkNzlL7Q2BgXKXu2ABrvONK
 uDZHIqz5uFLJa7F3Ya4ka8miX+UXZ4vkmH/Dhc0riuEgnCSHqkPWUYdqxqTWQWh9Kx/5zW/tAhf
 mtXTdMJppQVfLoKRIuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100044

Replace manual and error-prone iteration over entries of a GDS {sub}vector
with sclp_gds_for_each() which deals with erroneous entries in GDS
{sub}vectors more safely.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Fixes: 30c2df51173e ("[S390] sclp: event buffer dissection")
---
 drivers/s390/char/sclp_tty.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 0a92d08830e7..2c9a227e5258 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -418,38 +418,35 @@ static void sclp_get_input(struct gds_subvector *sv)
 
 static inline void sclp_eval_selfdeftextmsg(struct gds_subvector *sv)
 {
-	void *end;
+	int n;
 
-	end = (void *) sv + sv->length;
-	for (sv = sv + 1; (void *) sv < end; sv = (void *) sv + sv->length)
+	sclp_gds_for_each(sv, n, sv + 1, (void *)sv + sv->length) {
 		if (sv->key == 0x30)
 			sclp_get_input(sv);
+	}
 }
 
 static inline void sclp_eval_textcmd(struct gds_vector *v)
 {
 	struct gds_subvector *sv;
-	void *end;
+	int n;
 
-	end = (void *) v + v->length;
-	for (sv = (struct gds_subvector *) (v + 1);
-	     (void *) sv < end; sv = (void *) sv + sv->length)
+	sclp_gds_for_each(sv, n, v + 1, (void *)v + v->length) {
 		if (sv->key == GDS_KEY_SELFDEFTEXTMSG)
 			sclp_eval_selfdeftextmsg(sv);
-
+	}
 }
 
 static inline void sclp_eval_cpmsu(struct gds_vector *v)
 {
-	void *end;
+	int n;
 
-	end = (void *) v + v->length;
-	for (v = v + 1; (void *) v < end; v = (void *) v + v->length)
+	sclp_gds_for_each(v, n, v + 1, (void *)v + v->length) {
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

