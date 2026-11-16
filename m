Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839769;
	b=lxu6WswH0V09wVUpO8Lu0p+s05ShwAbZP05wsoY2vZFU/XFNpFNZWeugutNtMbSE72/b
	 jlNbhNgdaujEQBfKJ2ONotgAr7m29UjyYyXHyqmLikvmaLmEZtGakYEliMBKk4mYU8M4K
	 2KN8SQ4eBpeiAlSc6ELRJZQBgaETi4r9myFQ/Hc7oNDnROoHzdQXQMvPHWxwyXmmFcW/P
	 wDlSML6AaT9fLT593EbQqhphAvBBN/GLyVgKnsHlnaWKlmojvXTEoDIoUapBeB24KrlqK
	 g5rKuXqPpVws1U82AawoeL0FHzy4/6s1wn3EI12MwA3NkzzPF4GXGHu+DcpwftwBokw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839769;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fqO899TsroX4KwqvqShI40p272V4Pf6MBRO2NPieVeI=;
	b=2222VY1lv+pHdANeOwKjft0LmpKSlWAErqCjYZsSJzP1jPN4B1Nl//+mHNpLHU5H5h+I
	 nqEB4+LQs3CIxOmfK8wHp78UizlT+rKjbAB8TrKAn3+XD8naO0ttWiFNgTXYVuKorNMNn
	 tle2PliVQA6t1tyukw5goiBiwg8OfzF/18mIdOW+RinQQaiZkilCywHXQeMH3olro101t
	 BJ2apF3RZiDbQHHHSwa9ThLb4/uY/HsaQRnqZHdXdxKU4GD6ZlOPUbqPgRH1o3OROU59R
	 rYe5U9FVFGUDOznLu1Vo1tr/Knf0BlveOas5TTGmjLC/0VgRfp5fbaBP0/iEYEU/sWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P5OBMEbG;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C5606A883;
	Mon, 16 Nov 2026 14:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA0C5606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P5OBMEbG
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDu1hP3407829;
	Mon, 16 Nov 2026 14:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fqO899TsroX4Kwqvq
	ShI40p272V4Pf6MBRO2NPieVeI=; b=P5OBMEbG0AZHIRNqLs2lwSk0FOBxTM0DJ
	OXmBg2++C33pZWQiWAh7UFpP0TwJzhlwwpE6ShJEG01lhzg9cu7O/Wc2fy0KyH4t
	K/OQEX1ZwK9seLsOFNQpSxkrKAYpp/8e9u/c9KKUzRiQZpamroDr5G6/s/iKIBd0
	J1wZuAWLBDtObV9QGqzMFy/gkX6gki0z//LrC4/siuea5ZrxDUOeJHkFWx+wVCEH
	m2CIkfv9KhKshxRjJtf7mBT4MXpapW6HDWlHIvwxPw+LAZlpMjJas2FDIfLJuegT
	Z3VMCIh3P3tK9q7++5i6J8bmXi4jqW3wu3kFh6FpRah8wwHvYVTAA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxd2kwsy1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:36:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC50Ol1877660;
	Mon, 16 Nov 2026 14:36:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hy46fymsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:36:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZd9047120772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03D962004B;
	Mon, 16 Nov 2026 14:35:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A34D62004E;
	Mon, 16 Nov 2026 14:35:38 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:38 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 10/15] s390/cert_store: Fix keyring refcount handling in get_user_session_keyring()
Date: Mon, 16 Nov 2026 15:35:29 +0100
Message-ID: <20261116143534.158375-11-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=B6UsQ+tM c=1 sm=1 tr=0 ts=6afb14d6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=RkZ7sokP1PKCfPO0osYA:9
X-Proofpoint-GUID: kP_NRR0ytOzC52tJ1CT4P463lj8PJMua
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX6jMkh00uNpKi
 stYw0iylmIb1gVFfBQ1fcvzYnQ7sZPGyGLn6jP1O5/cyldcaFnAdawnxdS0MG3jm1fxYg23QP/J
 aFsSOPKURMr2mDdk/hIPd05GAMg8D7c=
X-Proofpoint-ORIG-GUID: kP_NRR0ytOzC52tJ1CT4P463lj8PJMua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfXy6MHhCjBs0L5
 79ZNmGD2dn1amS7XbvWfIADbJrACwKiNjHTGFKpV5YzzIq1slVZkOBJwYdv097SZnfIWWZvafMe
 Lw9KyEnfNnm6iZuh/9BThZdm7oeGMwckFPVSOvsn0avmc9ZFrL7f6CngJRItgtt/Oh3/Hk8cID5
 EzlBisQaOExJCrIQUEP3H6NiRl4ErRgCg0ezrroVCDDw6quITf8kgAdrWF+Aoj3bS8F/lEfneV1
 arB141ZlQHES2RUjXVyl+cB2rfS3CcUS50O50rL33Bq3rZFqjdHzEHZYvXZKM0/Eayt8dKtPn1M
 92WmqU3yLpC+v/K08gFB31Jpgl5ai7UGYiMsKy32aLVeeNwjr/u9arY5vRvdzO8CX4Hk/2/I/3B
 vIkblT8nMsW7T5OM5JaIa6RGm8ZHrFMrINJyQ2vY83q3bhdbWNyCwRfuXk+D2sjcffggMqJlZFF
 gwhlYvZDLy2N2qf9b+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160057

get_user_session_keyring() drops the reference of the looked up keyring
before returning it. Callers therefore use the keyring without holding a
reference.

Return the keyring with the reference and let callers drop the reference.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index d11637c85063..ec6352528a2b 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -308,7 +308,6 @@ static struct key *get_user_session_keyring(void)
 			   PTR_ERR(us_keyring_ref));
 		return ERR_PTR(-ENOKEY);
 	}
-	key_ref_put(us_keyring_ref);
 	return key_ref_to_ptr(us_keyring_ref);
 }
 
@@ -370,6 +369,7 @@ static struct key *find_cs_keyring(void)
 						&key_type_keyring,
 						CERT_STORE_KEYRING_NAME,
 						false);
+		key_put(us_keyring);
 		if (!IS_ERR(cs_keyring_ref))
 			return key_ref_to_ptr(cs_keyring_ref);
 	}
@@ -399,8 +399,10 @@ static void cleanup_cs_keys(void)
 	keyring_clear(cs_keyring);
 	key_invalidate(cs_keyring);
 	us_keyring = get_user_session_keyring();
-	if (!IS_ERR(us_keyring))
+	if (!IS_ERR(us_keyring)) {
 		key_unlink(us_keyring, cs_keyring);
+		key_put(us_keyring);
+	}
 	key_put(cs_keyring);
 }
 
@@ -418,6 +420,7 @@ static struct key *create_cs_keyring(void)
 				   (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ,
 				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
 				   NULL, us_keyring);
+	key_put(us_keyring);
 	if (IS_ERR(cs_keyring)) {
 		pr_dbf_msg("Can't allocate cert_store keyring");
 		return NULL;
-- 
2.56.1

