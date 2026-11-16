Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851029;
	b=bs+76WqKJfKAemTnKe+pKBvoeh4EATieTkYQM1EhyW9eNjzjHnyNdQoZc968p1I05vKw
	 q4yYOlp/HGfYOBemYBgPMUhaVzRp7Z75bEjpW/mFWO6WpD/Xb5AirmeOdwXKd1YYUJy9K
	 rg2MiOYwT94j0P4MKz1jnzQifCok54a8Go6AXkjS2AGWn8AuVg5/PFWSy94hiwWD4YTEc
	 7RdRI9cBPwS88kk/RyzB1IPrj3VzSZMOaJAcCiU4Uw13NQCnShcK5ODX/YcXHmiyg3NH5
	 oo1Ofb7YwIgbU4yLwBJWb4zZghhvksGt9JvsHh1Q50kgH6UVCkp/3ssC4sPNrVvGBiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851029;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5jSfhEhqLT6l6hzvDkpsCH3vJQM/7fPrepX3Qz6s3U8=;
	b=2urlWH90DtGG26fg+Xb5K2eDlfKoi5Y5qEmV7mklFQXoveIuiy/teRH2ClMmeejWGeqK
	 3C/h1pAOojB0MwDjFD+ueKfhp89q2nhvC2Z9s6dDHniQ3RLGJV+RLyXxFOh36LAUQB19u
	 vAox/7owrMeoLycFSzVXCYhLtdD7KUQlJjjB8I+T3NJnY71ab7sYwD1nLOgPyQbgm2Fwq
	 LQRph1UZ/0x29aodUfBtiQDjTIf8+8K9rWELLP8pp+mL7lZagYCQIMQE1oHDqgl5ZOJF7
	 LyuifsUhWxubIKXZ8jIsBRKCK/3IaDkoPLuQOj86MnBoKXd7dZTc9zBQQkI0fm8XQXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f5e1XxUX;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD79606A31C;
	Mon, 16 Nov 2026 17:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD79606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f5e1XxUX
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQFAx3773817;
	Mon, 16 Nov 2026 17:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5jSfhEhqLT6l6hzvD
	kpsCH3vJQM/7fPrepX3Qz6s3U8=; b=f5e1XxUXybewNkxJqyuKZzT2D2QSDkIj6
	NayGgGryXlte0S8AKMsSaT4R94cDncf21KO+ugWr42Vd6O+mAJEhK4oDEp3hITyM
	u0yOtdZCbrzQ15v4JJD/9tuS6cr9vaD2V1BCwrDwdpnqL5B84b7wOasKfo+zPpJd
	/rZMQAqYCX6MbueXZhgprsQdAgGaKhzfdSObUbHBPcD2jhmXBuDRjM6vqHSayPdk
	56LxwjF8vKP1DxhuzXuh6RJekaCyINIDfZtX1FPcvdHz2ec3ObbHsRrcrMBAfBis
	Dd2N7Oxhf/kjS+XWiNHqvAOlv/lFgVwzTF4Hi/gtmErSL81YpLIVw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf9ve8d1-963
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:43:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGCK2392350702;
	Mon, 16 Nov 2026 14:35:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bv9xf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZZxg32375066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D16D20043;
	Mon, 16 Nov 2026 14:35:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36E7E2004D;
	Mon, 16 Nov 2026 14:35:35 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:35 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 02/15] s390/cert_store: Fix return code handling in invalidate_keyring_keys()
Date: Mon, 16 Nov 2026 15:35:21 +0100
Message-ID: <20261116143534.158375-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116143534.158375-1-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
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
X-Proofpoint-GUID: kIKTiwrukeguBaimPCvnSKL-JysOqU0X
X-Authority-Analysis: v=2.4 cv=dtxOmFg4 c=1 sm=1 tr=0 ts=6afb40d2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Bq1eG61FlSwVBpsXNy4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX2w1Nqzsf5HVu
 GwdWKfBMM2Of1N0uAzxHOZeyQM3GDHOtGBXmemmoJZC8rUaNczzU1PAwaDXw7BcgxHLv8+y0NT2
 6vqsK/JlJasgTb6P3TJj89zHzJe5dcW/BFzRykB2g5cYyV4NFaOWvgZ4KIKsWybShM62B1FNuO6
 7WOB5XSw/8F0ZHSjzEeFZrrz+UBDMjHRaKR6+Yo1JnKK3kOJPX7GrWyyBuGBv1/TlMjms/lubhR
 GXyqBFv/Hi4ucde1LDAiwGFuUiInnAUkoOk+ejghXeZaV3e3Xjs7iXQuLXcle2OhXnbJV7qTQmR
 TlmU+pPE2WAqGQmAjDKydz8L7i9gpBGp0irhAMj23zGKuo9SSIR5/TFmvxf2X6nkrULKTD7I0hk
 0jOQtnPHKOKu747LkijkmQkh4p11RuSe+SfbXY7cFMTvXgB5DjtM2WZ8LKLPH1BMhCtJ4wyHUMU
 QT1nTSuXXYVYPepsFNw==
X-Proofpoint-ORIG-GUID: kIKTiwrukeguBaimPCvnSKL-JysOqU0X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfXyFoJf2NSI/JC
 ZQettMgKG4iXo+aZbpzX2D1SfMypih4j7x9+pIUQtMZRgYXQOdpYaHw3nS8yZizfW0EMF6CKjob
 zy+VRY8Eqk87mMqC++5qqVKFB5+IXYc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160069

Add missing error handling in case key_type_keyring.read() returns an
error.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index d35b1ea22507..89cc3a1683a3 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -316,15 +316,16 @@ static struct key *get_user_session_keyring(void)
 static int invalidate_keyring_keys(struct key *keyring)
 {
 	unsigned long num_keys, key_index;
-	size_t keyring_payload_len;
+	long keyring_payload_len, rc;
 	key_serial_t *key_array;
 	struct key *current_key;
-	int rc;
 
 	scoped_guard(rwsem_read, &keyring->sem) {
 		keyring_payload_len = key_type_keyring.read(keyring, NULL, 0);
-		num_keys = keyring_payload_len / sizeof(key_serial_t);
+		if (keyring_payload_len <= 0)
+			return keyring_payload_len;
 
+		num_keys = keyring_payload_len / sizeof(key_serial_t);
 		key_array = kzalloc_objs(key_serial_t, num_keys);
 		if (!key_array)
 			return -ENOMEM;
@@ -334,6 +335,7 @@ static int invalidate_keyring_keys(struct key *keyring)
 
 	if (rc != keyring_payload_len) {
 		pr_dbf_msg("Couldn't read keyring payload");
+		rc = rc < 0 ? rc : -EINVAL;
 		goto out;
 	}
 
@@ -345,7 +347,7 @@ static int invalidate_keyring_keys(struct key *keyring)
 		key_put(current_key);
 		rc = key_unlink(keyring, current_key);
 		if (rc) {
-			pr_dbf_msg("Couldn't unlink key %08x: %d", current_key->serial, rc);
+			pr_dbf_msg("Couldn't unlink key %08x: %ld", current_key->serial, rc);
 			break;
 		}
 	}
-- 
2.56.1

