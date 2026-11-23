Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429430;
	b=TAmsJXOFMR486KJ+GK4nPu3D7zdI8x0eS1SckcYq3K/IUpRGQnLEapmQZG/T3K14QGof
	 zom5G3Gk234Q4Z7mpxoXUswdfp4obmKhT4Za/7lF/VFowlIRZddt6M21bEp3FFopW4FXV
	 9yjlwa92EwKacMKOCHUAQ49ALPdx7uQonMCIGE9YvlAK4K2sUBPKfeOT0ZGPc4Urlz96c
	 DbXYFzTodnpywIpEwJLXGm38SEMITxteU+8gy2hKgMAiF8mSVaCTt7sAwleNU6RWhhhw3
	 r8TN202ECejN0yMfR2yuV1oDcy30Dp+SLw81sJWDFxG7TpM+GC5wnqnhf/B8sNa89TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429430;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t85BHruVi1jjhAfB4NRV2nlcvFymlCCtLpHf+WppX78=;
	b=W+Uwaqv//uiNMnO8k/Ev8z6oF07AfzxHa29CU5yRGf2WFtW5ZMHQuhvs2/rR4jArlQaA
	 I5ii1c6Voq/1HimiD7CssA4xnDJ1JUlzElyDXNaSHdoAZRHw+kogce2RWcIpLZuZjjhqk
	 /VoejuTxzxmELGDs8FmFqIgh+E7+cOCiDXxJe5hl7oSHhvqJ6L9ZeFwPwMxNcH1BWlI2N
	 9iyg6d6zyiqhTLoq44g1tUSNmsZ1heQ6g3U8j7ufHA8rGowRoKEtd4UcPafPoPiJOCM1y
	 DLf+KOQ+AvB2rXImAZFvsBtmQlhT7SyOFG+VIQtdOmrSbDk+A0Er4GD/oC0Eq91bb6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X7IlFPUQ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D265606A335;
	Mon, 23 Nov 2026 10:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D265606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X7IlFPUQ
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9Yonp3252383;
	Mon, 23 Nov 2026 10:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t85BHruVi1jjhAfB4
	NRV2nlcvFymlCCtLpHf+WppX78=; b=X7IlFPUQgJwtTiluTEMXuPOOmZi6xI7NY
	e6Q5KNg9B9TF6VC8ayoD6ebuareCGBByslwTGJshIpmLAEquFfuVXgRLMuVHDhuk
	2QGyzp/5L98+Cvlmksh0F/xUaXvz6/LdPiX2rF7Lp/FCxka9bx/KH9bB+eHh1Kyf
	MwotU5W8iaofik++l1A54hfbLS9m5TmhHCmh4qDKahtmXvd9WAHSjNW9c7C3eenS
	HTtDBWh4ZQ6/xkbB3pPdQMRNarQawfXlmiIDKp83keMCBTdXPvb6RANjEjcCVK1L
	Fk+xBQOZTF6gVBhcIKOywXQvHGBIOPJjlBWvXcq/DmKcc0esaXndA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g12a6j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9JFtk1708379;
	Mon, 23 Nov 2026 10:23:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3raye0n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANANP8t52166980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 10:23:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DDAC20040;
	Mon, 23 Nov 2026 10:23:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B7DA2004E;
	Mon, 23 Nov 2026 10:23:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 10:23:24 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/2] s390/cert_store: Allocate keyring with link restriction
Date: Mon, 23 Nov 2026 11:23:23 +0100
Message-ID: <20261123102324.483917-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123102324.483917-1-hca@linux.ibm.com>
References: <20261123102324.483917-1-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: VwR8f9ZOeDcIGWBT0D0ts_rjTEb9J7WE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfX9dcY1LHqc4wZ
 4Og9EpuzyxPcTM1V5M7OQ/0G77Y4rZ8kM7aKKNmdyO+1OOkRhpvok2K5hj8bgdG3oGhLTlqP4I6
 ea8MQw2pwlYYkVqDTcBZjAi1OUamngI=
X-Proofpoint-GUID: VwR8f9ZOeDcIGWBT0D0ts_rjTEb9J7WE
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b041423 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ttQ9gIaDJJb6dlU9oSQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfX8UWVmGDCA/Py
 1H/fcZjZy9g9R+s9S6yeNjBz7Y85M9GaA7PQiMCp+VPtq2ai44XMuyPgSmnjsFnXZqFsj2d1wzf
 Bhv6zq5ls8VNPkISH17BHayTZ4MJyuNmP5XvMR6VLusB4JMwlblcCFlGC9OkASG123FgRuqjNhM
 Zy83YoxaO7yujD3DOoXOM5LvxWrbotGf7vuCCcMZUvTVQFmKHhPkfZhXvRk/e+Ii6DQtu+uEh8K
 yw5/UvnEUtebedhXa04kU/1ZI/LhsNfXW/RsWqDI7V0z0Tokxy37Q6E20hqKYA+/uEiZKmb2srt
 YOKNKgow3E98Ewe3jTOZ4bJFzEdd0O7N7yBkR+mgcktIDzwNLJD9gNShlRPUucQ+r20UPiqsOct
 UfGRR1xhsuz+Q4kxGs6FkOnss1uW0ILV18dAq3e2DxIg5k2/xGh5Xffec4anivhkvko/zOlVaCM
 yX/lSarazcbT7tn0HtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230040

From: Anastasia Eskova <anastasia.eskova@ibm.com>

The keyring is linked into the user session keyring on allocation, but
keyring_restrict() is only called after all certificates were added.
Until then a possessor of the keyring can link arbitrary keys into it.
If keyring_restrict() fails, the error is only logged and the keyring
stays writable.

Allocate the keyring with a restriction which rejects all links, create
the certificate keys with KEY_ALLOC_BYPASS_RESTRICTION and drop the late
keyring_restrict() call.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Anastasia Eskova <anastasia.eskova@ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index e3cc9389a50a..6f5c63cd907f 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -409,6 +409,7 @@ static void cleanup_cs_keys(void)
 
 static struct key *create_cs_keyring(void)
 {
+	struct key_restriction *restriction;
 	struct key *cs_keyring, *us_keyring;
 
 	/* Cleanup previous cs_keyring and all associated keys if any. */
@@ -416,13 +417,21 @@ static struct key *create_cs_keyring(void)
 	us_keyring = get_user_session_keyring();
 	if (IS_ERR(us_keyring))
 		return NULL;
+	restriction = kzalloc_obj(*restriction);
+	if (!restriction) {
+		key_put(us_keyring);
+		return NULL;
+	}
+	/* Reject all links, the kernel bypasses the restriction. */
+	restriction->check = restrict_link_reject;
 	cs_keyring = keyring_alloc(CERT_STORE_KEYRING_NAME, GLOBAL_ROOT_UID,
 				   GLOBAL_ROOT_GID, current_cred(),
 				   (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ,
 				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
-				   NULL, us_keyring);
+				   restriction, us_keyring);
 	key_put(us_keyring);
 	if (IS_ERR(cs_keyring)) {
+		kfree(restriction);
 		pr_dbf_msg("Can't allocate cert_store keyring");
 		return NULL;
 	}
@@ -485,7 +494,7 @@ static int create_key_from_vce(struct vcssb *vcssb, struct vce *vce,
 		desc, (u8 *)vce + vce->vce_hdr.vc_offset,
 		vce->vce_hdr.vc_length,
 		(KEY_POS_ALL & ~KEY_POS_SETATTR)  | KEY_USR_VIEW | KEY_USR_READ,
-		KEY_ALLOC_NOT_IN_QUOTA);
+		KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BYPASS_RESTRICTION);
 
 	rc = PTR_ERR_OR_ZERO(newkey);
 	if (rc) {
@@ -653,14 +662,6 @@ static int add_certificates_to_keyring(struct vcssb *vcssb, struct key *keyring)
 
 	pr_info("Added %d of %d keys to cert_store keyring", added, count);
 
-	/*
-	 * Do not allow to link more keys to certificate store keyring after all
-	 * the VCEs were processed.
-	 */
-	rc = keyring_restrict(make_key_ref(keyring, true), NULL, NULL);
-	if (rc)
-		pr_dbf_msg("Failed to set restriction to cert_store keyring (%d)", rc);
-
 	return 0;
 }
 
-- 
2.53.0

