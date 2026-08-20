Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65AB377AAB
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241011; cv=none; b=hS7+u05zAi/jD69P7Ccsoz4t1CH2M2BNDhGjHg23s1H3WD33l4x8RJqTL4Su6PAhrkq/ee/Ly3fwP+jMr6bHnuKUGcxD5QB06zW3g91DRw5jkEt4QMZlPPVEOc+uAuBDdlvBKTif+ZZkprItVhaMhcQ6E/uk3xXn07Cet90OOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241011; c=relaxed/simple;
	bh=QRPwHDwjCK3Vbtub1ReIjGJH/uYLPTOGolrW39ZDdrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBFvMPA8D2bJRVg4kqzpz0MJrnj89JqUlje91B1CHao32gyvi5fh5gO4XRP9QHPI7i7ERvxTIyS/9DAkxngqDp6xW2E3kok4l1YMj8PS5HZL7awcOC+zpBzC9Dnrjv515n42LJmh6fE6+w6n8wn3H/kJxnBCAYYZfJ4WZUA5CXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YfTiMhHq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YfTiMhHq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KEVUhI872618
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4r0pTzEqaOWi5H46R
	t8VlXQ0m4oIJeoBdnLKWjVXcaI=; b=YfTiMhHqPbQ2kdCEpIrZuoXz0bixnUoN2
	W3gvINMNdNeeO0yKtB098djXr7N68auBRmMNUBcPgaojOXsGar/7Z77rDRKch2k4
	fCOMEAKslcgPO8OBtT4uVQyeMBUQPFOxcr5W4pWOK84LJFtzE5FjspkEB8YBqMKr
	H1nCdr/uFutoAHj4rbx3WGN0h/ocY44f09H0EWculVNgP3kI0tLxWHLTDyVLK8hw
	Q55pjspErQGWrMUMmQd7NygyRtcbDKMaLWYigDkOqcc3O0H9tQz8dV3908SOxTK/
	ptoBCc1Me3JgSeUt87hcFcVvuH6UIr3bd6ZvmK9pmXOTKwzVhhOxw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0bc9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KFfYMx002475
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqfjpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KFo4eI41419148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 15:50:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FA9920040;
	Thu, 20 Aug 2026 15:50:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0091D2004B;
	Thu, 20 Aug 2026 15:50:03 +0000 (GMT)
Received: from ibm.com (unknown [9.224.91.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 15:50:03 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Subject: [PATCH v2 1/1] s390/zcrypt: Validate length in reply before using it
Date: Thu, 20 Aug 2026 17:50:03 +0200
Message-ID: <20260820155003.945837-2-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820155003.945837-1-dengler@linux.ibm.com>
References: <20260820155003.945837-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HD1gSbcvhZpl1ARQ-qhoS1LOc0m95aI3
X-Proofpoint-GUID: HD1gSbcvhZpl1ARQ-qhoS1LOc0m95aI3
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a872230 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=_SsTBdzez2EMuKIi--UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExNyBTYWx0ZWRfXzDLntwd5g33F
 2IG59TsLS5/outtRFiVavKdCIhztWMFVGQfE60m+TP5yUOStFzuFseH209VDN9aPPw5wgS7h0pJ
 6L6oQfQgsGCHujgQZrjMkDYOLWlbtsE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExNyBTYWx0ZWRfX13s0DuFV/G9e
 15bnotGYNzfnYcZpJkYOPl4+Xe+znKQjkHT0LPDdfnM/Lg+eOjN8uNwqRsUWiPnH854ms672Ibh
 ixQZcUVY5Ts8aNQmjrbuu3Zh32ma8b55ev5Nvr7d3UxIA2lIYkXH+NT3NQKOAA6mMqUN/bmd/Fz
 WgZoXfIqMljMn08+zQ92J19qYTibuBE5Yh2Ce0M9drHyiwo4NIVH/cVCr7riNlMXHvqhf9/y2oP
 MgAGY4ycD+LLh1Ep5cTB0s84wNKXwx80Twpba7oPyKgubIJ4nery2Xqw23RkrhKBjSBrzArgtPL
 q1hCG0MUk+MpJp96c2Bu2gi7R2aspkOjqZr8VS1fShi+TULHw7jiMRJ6a1mZQZBD1nJXZ+KxDVD
 ItcOBeODIdNT/c4y11HRDpKXSTxWiY0DbmLecn5fdCcr9R3ol1bWyuZ+Z+KRXEjS/r2oCcQxo8i
 BjQYHOx8O3bH0uXuFCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200117

The length information in the reply is used to copy the key token to
the target buffer. An invalid information in t->len of the reply may
cause an over-read of the target buffer and also a over-write of the
target buffer. To prevent that, check t->len before using it.

As the available space in destination and source buffer is always
larger than the valid length value in the parameter block in the
reply, compare t->len with this (already validated) length
information. As a side effect, this check also prevents buffer
over-read and over-write.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index d4ce6352b5b2..19909bf43dc9 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1158,8 +1158,21 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 
 	/* do not check the key here, it may be incomplete */
 
-	/* copy the vlsc key token back */
+	/*
+	 * Copy the vlsc key token back.
+	 * The available space in the destination (key_token) and the source
+	 * (t) buffer is always larger as the valid range of prepparm->kb.len.
+	 * Validate t->len by comparing it with the length information in the
+	 * param block of the request (prepparm->kb.len)
+	 * The value range of prepparm->kb.len has been checked above.
+	 */
 	t = (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
+	if (t->len != prepparm->kb.len - 3 * sizeof(uint16_t)) {
+		ZCRYPT_DBF_ERR("%s reply with invalid key_token length %u\n",
+			       __func__, t->len);
+		rc = -EIO;
+		goto out;
+	}
 	memcpy(key_token, t, t->len);
 	*key_token_size = t->len;
 
-- 
2.55.0

