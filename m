Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5E426D3F
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753580; cv=none; b=fioGEYuE9i7f3O7W0tdndi3JYjhcgO4sKDBT2JQZjzJLB8gVL3f1fRFyBX1gLE6eLPjVUQccz5FX7boxzWhzZk9mJRGgnG+k31APjXlai7m27Ivz/XFXp8PVd7HW6cvLDJ6B67KBYa12Ly8jefFAfjKPsTJnZLkjYzXJynZh1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753580; c=relaxed/simple;
	bh=LGMrbV2qQuYG2runN/CiFdp3byK+nf0zw1NEc2u+HAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBk6P2TX0EzMMtcFJ5QKXa2pXm3hjfSiTKZOYVKC4y6v04qLJltrXDW/H2r9qBjBy9LGszKVzVB5pwCKezG9JtQzpNOyOcB6rGr6KTJlNIksukaKTyjn7tgTyQPSH+rZcWtdWorPXKs0fORPSy+1GOb8PKeT23M3sAcTtW41zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qXztJnpP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qXztJnpP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1Y6E4184973
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JZSXAIk3wxrQWsB2U
	MKbNbGHK3SFXPYN8hMxamnA7TQ=; b=qXztJnpPEKGY2/LlvnEM1zu9CA0pL6i1S
	ebRwrqFCzSrNLJ8s2D/Rn7HKytHjae/xfnNbVwXllKJlzZxbYpqVqns9JNV7Q3JI
	YAqCTPTgg5UyyFva8PhPDrlg2ofTG0/1hp0nVKg0Fx+HJ0qi+6hU2trA6TBN5bf7
	K/HiDfygi7P2xOuaJoPJnxIjV8EQCM7e5ZMuMcu9ZTQmZAAk/ecRdCH/IZyVkdQl
	5ZhCL63YW3Enw7S8UFbh0sIW6XHPln1pGllS6KCVSxlLjXzedbOpaxwt9DrqHAcy
	cnMGQ95T5ih3URsz3uVakoDs7rPLUvRX/0TTmAPhsjhODCKPAI9tA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g739475gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEBLsA024316
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qajb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QECr5R38994232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 14:12:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90BAE20043;
	Wed, 26 Aug 2026 14:12:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CACE52004E;
	Wed, 26 Aug 2026 14:12:52 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.62])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 14:12:52 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 1/1] s390/crypto: Fix out-of-bounds access in zcrypt message type handlers
Date: Wed, 26 Aug 2026 16:12:52 +0200
Message-ID: <20260826141252.113706-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826141252.113706-1-freude@linux.ibm.com>
References: <20260826141252.113706-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 02rQwMhx8sF0jhNJp78ngopHT-t0EvxA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExNiBTYWx0ZWRfX5wXJ2asX2weY
 sfJyk4wm5r3pHUTVoBc/3Fd+G5tW5tw+x7hhQ63ioGLkedivvIu7QArX1r43WIecxiVxzHxj6ox
 1Kir8JvZ0vx9elnl5iUBbFKhlfOtK7lwjXgngKhLdcvFmuvJ2Gha4yFltqi/IVKhruKBhbFCEAR
 L7p52c6qeCMThSFbI8DUxv1JCFOx7ndpH7Y4ZR3gg6Y42V3VqdJwkiEWazsO+SnziHQLk6NUp6T
 KAyMzPfKjPsaBVvVSLYF9rx+elzn3se0gfa3H3WYTvFfhB0SH2m+cTFXFSOg6SculWjpWmSq9bc
 v3mAjQtT8ORM5ckPKtZ3objAXFYLMVWSjv/mqhNyl6rtzagix3nO/WVa1Eo+aY5r+XPL/msvf5u
 6boix4St5f6Nb+trrRYcn6wX0hgwpLYeO7iCVNe3kbkogj0JxkbZCTOaqg7SBodmCkQA8HfT3El
 XCQUjsEQpUckPRClEKg==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8ef46a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ZuJpXxxAQfOW_Gpd4GQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExNiBTYWx0ZWRfX2qZV0aoeyL0d
 O3WhW/x+JGi6xWQpNK7sERQpcCwEjoGLcaAWXha5YtNvvrbL+2kFVGoucj2W1Rhtd4zZVEr4JiL
 RfrDiXond6kjL4P9/6WjBkHZM4DfWfQ=
X-Proofpoint-ORIG-GUID: 02rQwMhx8sF0jhNJp78ngopHT-t0EvxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260116

Add length validation before accessing reply message structures in
zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11(), and
zcrypt_msgtype50_receive() to prevent out-of-bounds reads and
potential kernel memory disclosure.

The handlers now verify that reply->len is sufficient before accessing
structure fields like cprb_ver_id. When validation fails, only the
message type field is overwritten with an error code, preventing
attackers from mixing user-controlled request data with short hardware
responses to bypass validation and leak kernel memory.

Fixes: 3b6245fd303f ("s390/zcrypt: Separate msgtype implementation from card modules.")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_msgtype50.c | 3 ++-
 drivers/s390/crypto/zcrypt_msgtype6.c  | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index 3c5fc97f7399..1f2b08ce3200 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -424,7 +424,8 @@ static void zcrypt_msgtype50_receive(struct ap_queue *aq,
 
 	t80h = reply->msg;
 
-	if (t80h->type != TYPE80_RSP_CODE) {
+	if (reply->len < sizeof(struct type80_hdr) ||
+	    t80h->type != TYPE80_RSP_CODE) {
 		if (reply->len < sizeof(error_reply))
 			memcpy(msg->msg, &error_reply, sizeof(error_reply));
 		else
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 5af3e20ad114..100e5ef3cbd8 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -943,7 +943,8 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 
 	t86r = reply->msg;
 
-	if (t86r->hdr.type != TYPE86_RSP_CODE ||
+	if (reply->len < sizeof(struct type86x_reply) ||
+	    t86r->hdr.type != TYPE86_RSP_CODE ||
 	    t86r->cprbx.cprb_ver_id != 0x02) {
 		if (reply->len < sizeof(error_reply))
 			memcpy(msg->msg, &error_reply, sizeof(error_reply));
@@ -1032,7 +1033,8 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 
 	t86r = reply->msg;
 
-	if (t86r->hdr.type != TYPE86_RSP_CODE ||
+	if (reply->len < sizeof(struct type86_ep11_reply) ||
+	    t86r->hdr.type != TYPE86_RSP_CODE ||
 	    t86r->cprbx.cprb_ver_id != 0x04) {
 		if (reply->len < sizeof(error_reply))
 			memcpy(msg->msg, &error_reply, sizeof(error_reply));
-- 
2.43.0

