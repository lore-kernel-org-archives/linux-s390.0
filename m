Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850487;
	b=j5tF2mEFsIIeN4EgVyjAjomQ6vBsWgXDVlIyAIBsd7wjP+sHvefzAC4xSknTZOE9FCBe
	 heUFj6OkRAwt5Cj1gWY6xpAre3am3Gx2A8igUAFjnDQSTBeKXD19iPJoWiPhGNQSbIf7K
	 eGSmQQplcVjydv1m3V6mEfVLHl3CabIsEGH1hL+R6YiBBFeNuyAO7D5k1ktBCzeVLClY5
	 SrelL6ROsgABjlGpyM6NlmykKFOCl6yvBa7lAaLyACdzIPUpeTcWO0hiSZx3mOXexQBMk
	 SU6UKq9roetl9ugJo7mZTTlPdQBChkD7NcoPjtEwY5GYqwRyVWvSZGHFiCI0c+t0ghA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850487;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=p5pHh8ErOgZ6WAWsnLPA7wSvfNy2H5lO6A72Fa8QEv0=;
	b=Wupn6uihzHNsLLypZje/zpMIq43Ko6l2tiqvx+6HufV/pcPHUs0dtw+20FjytVPBwvQo
	 /CQIq3pcNYwylO9TbiYUxdoR6los03d1c4ehaBI7O1Vi2G5Qazhs4JggjjQmD711ziLqb
	 mjl8mV3BVIDM1IzOlwrLudSErh9GsPhbG6gQT0DiegG0RSAzVdBOyKRrB/GBpXr18Yvip
	 R0m0geyaGZYZjDdvHhU0nQjjiz/O6KL76DCJGwxaTwTFPOwK8l1VsFjsCDVre5jStV3xz
	 9Oc4XuEc61xYE4FaEfZ4f+J9GgZ09r79iXmJNDT8s1/504jxU+p5s1Jhvf8ZgcJ8eXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y1TtzkkH;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87583606A322;
	Mon, 16 Nov 2026 17:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87583606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y1TtzkkH
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQ9fI3773674;
	Mon, 16 Nov 2026 17:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p5pHh8ErOgZ6WAWsn
	LPA7wSvfNy2H5lO6A72Fa8QEv0=; b=Y1TtzkkHQ+qOEQrr1m9EPpPjVSejbhNAq
	K636gGUNnpL/C2Cm/8t2tVVeTLFWqzP8ZEjym60hfYI9VDzCihdDaC66OHKWWAsz
	PUXFR1LteoYNeeBo6JjT+/M2Tl9LnC/rDjx+CUyYIFucHPxmPrg3ZWKOFV7zfA+R
	uA+BuAooSqyMVDMkX9i86Jv4wQ/VdqpMJKAbkMOtmvAJDIQD1lLo6/tqtnNJzGaG
	hlC3krgnjZzSGirGYPmxwWazvFZJugQ03dRKHe4Ig+0/Sl66MRJH+RAEosNCsNlR
	nDJzNss72FedXzYwaet6MfRa3ZmzKCVJx7aFfuVT6dSB+ivoNpdUg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf9ve6dp-635
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:34:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDD8gx210478;
	Mon, 16 Nov 2026 14:35:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt0b0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZZa337355786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27ACF20043;
	Mon, 16 Nov 2026 14:35:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C834D2004E;
	Mon, 16 Nov 2026 14:35:34 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:34 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 01/15] s390/cert_store: Hold keyring->sem while reading the keyring
Date: Mon, 16 Nov 2026 15:35:20 +0100
Message-ID: <20261116143534.158375-2-hca@linux.ibm.com>
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
X-Proofpoint-GUID: _HdnQzTJ2_YiEZ9qRaXzLvRO5uVK6blG
X-Authority-Analysis: v=2.4 cv=dtxOmFg4 c=1 sm=1 tr=0 ts=6afb3eb3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=A4E_aTwSwAuIUOgT1l8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfXxx6wS272C5Is
 +EtcCulhq7OOeykKx2HqpDdZzVTGy4PNn/OnVazHXbdfUn4zbm03QlzzYHAGwLszmHLTJ5U76qr
 lrZmY3OVAgCSg9W93l9QgIDZiEcZEWl4Y73KeaR5tPUQ1pAPaPkbzRhsByHY3q5KGgs+fiTeaSr
 qDHpeanWSqzW19kONG0TLtY8qGeeKlTz2CybKEgN/lrFq8JRtn6GAKKU39SudKKrA6cAsFzJ9tE
 tjooFEO3u39J+JR+0fe3aBY0/HDFNGwJj/Nq/R0bKtrK9smVGF4ja4uK80tDFj7p86OrAI3kI7l
 0SnT9AkQejxQEpWAjKgG0Ffz0qgeSifI1E/VpA1VxR6ztqfLzuhCqQujzFOYTM306yICt9k+bXt
 axrfK+QrbM/LgHWoGbi6Gd0ViVDqsOvmqHHXGLH+lPYSAapDk41yhwn0kQETQwdit/RocNlBRxo
 8heEB49uJz/znbaClTg==
X-Proofpoint-ORIG-GUID: _HdnQzTJ2_YiEZ9qRaXzLvRO5uVK6blG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfXwpEAycBPAAQZ
 XXY2WGngQTMg1aPS6qJI4GNOYJ/AksVCXEwzk+HmPSj+Ux0F0rPLZv/K0aNHmOSEg47vhK3YmlO
 29jFHxhNJEmp72uNB8wnYS3V/4Paj/s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160069

From: Jarkko Sakkinen <jarkko@kernel.org>

invalidate_keyring_keys() does not hold keyring->sem while calling
keyring_read(), which is contrary to what keyring assumes from its callers,
and can lead to recurring bugs.

KEY_FLAG_KEEP alone does not protect from e.g. the following call path:

1. keyctl_keyring_move()
2. key_move()
3. __key_unlink()

Address the issue by guarding the critical section.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 998f2da56175..d35b1ea22507 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -18,6 +18,7 @@
 #include <linux/keyctl.h>
 #include <linux/kobject.h>
 #include <linux/module.h>
+#include <linux/rwsem.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -320,13 +321,17 @@ static int invalidate_keyring_keys(struct key *keyring)
 	struct key *current_key;
 	int rc;
 
-	keyring_payload_len = key_type_keyring.read(keyring, NULL, 0);
-	num_keys = keyring_payload_len / sizeof(key_serial_t);
-	key_array = kzalloc_objs(key_serial_t, num_keys);
-	if (!key_array)
-		return -ENOMEM;
+	scoped_guard(rwsem_read, &keyring->sem) {
+		keyring_payload_len = key_type_keyring.read(keyring, NULL, 0);
+		num_keys = keyring_payload_len / sizeof(key_serial_t);
+
+		key_array = kzalloc_objs(key_serial_t, num_keys);
+		if (!key_array)
+			return -ENOMEM;
+
+		rc = key_type_keyring.read(keyring, (char *)key_array, keyring_payload_len);
+	}
 
-	rc = key_type_keyring.read(keyring, (char *)key_array, keyring_payload_len);
 	if (rc != keyring_payload_len) {
 		pr_dbf_msg("Couldn't read keyring payload");
 		goto out;
-- 
2.56.1

