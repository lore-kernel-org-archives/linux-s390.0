Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850592;
	b=Lar5RF6ZxlN9gY8YS6bjYrikfBgGNBVyEEDE1qR34FQ4MeAAzTHydBByrblqs2eWNEBq
	 D0fuLKqDvyokcEphNB+QYym7NSMQhNczUJjD+zXH4Xsfs31Hu+FjPpD7ruJoXMgZdTprv
	 hqYdZWtPDCZWBMvB4z3sUzDVIdEiN4SM4yZ4mn2fU0uK5H3pD4T3Zd1qZHsrCcFdODw4h
	 xuQzMMilKOC0V+irSGFrOJ6Cy1cKlfiqTb5igWyJwdkdL9/6lxEvEhTzL8ke6OzRWFO+7
	 ZfiH8BwkQ4rrzage8qMMkjCh2mhMl0LRTbHz+4H/il/24qHJEpuy73E3K+jNA9JpoAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850592;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5mJchz4CGpikjFuthHfsRaTGDvZZ/WdNZKflE5H0IsM=;
	b=Nxj4TOWqDrPnzyxjJnJx8o58ro5wjuQxp7LySYUFHWm2QylodrA/FVq1H/GK+YOxtnaJ
	 6FxYbU0dN0/VDPuNJTMBMMInnjTH6tRsH0LKV98cRv5uR4Qo1rn/RRO6BBtLXpYX/WDao
	 oz/xWY3YUC5LJvu3OaPOHQSfK1/W7ciGmfwptfT+qTC1OhzfUw0WUZrxiQoG6nPrfJYJd
	 Ev1Wfa7GLCHRrsW/R+w4OGt9gg1dvlhD86IEOsLZlHxGipTfyHNkC8aFZoh2kBDdJK9UF
	 CVUBAl7ThHzJxmqGd2Apl5rT4yoV+McScOWNg/ueyudMSX14rTG6U7ZIwo21SbYieEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="aXTGO/8x";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60056606A322;
	Mon, 16 Nov 2026 17:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60056606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aXTGO/8x
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQA9D3730063;
	Mon, 16 Nov 2026 17:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5mJchz4CGpikjFuth
	HfsRaTGDvZZ/WdNZKflE5H0IsM=; b=aXTGO/8xRAqC1kjGlWcWWEEoKFJRaRQ9v
	GO5SZ0A4VAOPZ7W/zR/2dmUJm3sUiC40VnQG68DJ0q9TAJEU9Ze956oUF9I9hBoG
	zP9/PFe4ttBnV6EU56keVN6Oq8Znx+rHxND/aEZTDl3uB1+zgAjCjvD6JKj9TCFE
	sQyMinNaXmNX8HMmGM81FjdnDad5DVahVVF78CKvDirgBzw5Pg4qnxh3qktVuSjU
	b3AEbKC5fhjEvvm6iOZfBkOYZ+jmcVBlSk1tgOGEIP/HXonQfyHwf8vL49SBA9AR
	DcyaRpD+v/Z1RGBcIwrrxBhKMvS4BkKXajk67hBhW6yaG/ErF3cGg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxd2kxep1-191
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:36:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGCK3co2350710;
	Mon, 16 Nov 2026 14:35:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bv9xf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZcxG21824160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 984A92004B;
	Mon, 16 Nov 2026 14:35:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40F8C2004D;
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
Subject: [PATCH 09/15] s390/cert_store: Fix error handling of get_user_session_keyring()
Date: Mon, 16 Nov 2026 15:35:28 +0100
Message-ID: <20261116143534.158375-10-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=B6UsQ+tM c=1 sm=1 tr=0 ts=6afb3f1d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=HYdFE7ZeBFOXOEGIoXAA:9
X-Proofpoint-GUID: SVXwtcf90waoy_18xl6r83JWk3PTtZGN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX3UtVa0OsjgWv
 5I+YoqoZNgxH+sna8SDnHYfj9X47BjuHwbyqcVqcMs63jMBxQ8P5LgpsewWgN7dV+fgPl2xfYHy
 qqafyh0YlWu8ZrtpjFOQtrlI6U9XrQ8=
X-Proofpoint-ORIG-GUID: SVXwtcf90waoy_18xl6r83JWk3PTtZGN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfXzzNbiMwFEMI0
 hhR4jtIgAFPQn5jeoh5wESy8w+u5Eg3nWkJlgcll4nqSk6WAyOsjdUVK6hFFOVwINMuKRbkwBk0
 AggYclFGaa6qn9uf2vIlhNApa8FBY480JVzpyrNbqfQoQOO9b4j8kDGqRtLDx19qAjNqlW/p2nf
 BGLAFfYlZREokw0bN7Kj0CMf6cVTNaT/SJtTbM1FK3sLXXLO0Th3WPb36xwck1ZCEzdGr/IBCc5
 CoZ9vSqe5rp9zgtA5Q49fgPF3BOQBXcEjPwiBPRj6qCZcGyQiARgnKDv19SuX066cnV9L2oPvug
 meYkKRtjpYt+R+cNLKZ7TfysD0iLfIHPHbNX/NqFRHqlotXfDWRNxMfJIA+RkvfE1YRjUrLsoVe
 JjOF5nWE8LvdHYGZnqwLzlX8NrvDmCr3azRaMpzNczkmx1n7HCwYqKFgWRSMu5ejEEyWDt3jfqK
 Yhp9KBBE9FPcFTkBJ4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160069

create_cs_keyring(), cleanup_cs_keys(), and find_cs_keyring() all pass
the return value of get_user_session_keyring() to other functions without
checking it. This can lead to dereferencing an error pointer.

Check the return value before using it.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index aefbefb40c74..d11637c85063 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -361,15 +361,18 @@ static int invalidate_keyring_keys(struct key *keyring)
 
 static struct key *find_cs_keyring(void)
 {
+	struct key *cs_keyring, *us_keyring;
 	key_ref_t cs_keyring_ref;
-	struct key *cs_keyring;
-
-	cs_keyring_ref = keyring_search(make_key_ref(get_user_session_keyring(), true),
-					&key_type_keyring, CERT_STORE_KEYRING_NAME,
-					false);
-	if (!IS_ERR(cs_keyring_ref))
-		return key_ref_to_ptr(cs_keyring_ref);
 
+	us_keyring = get_user_session_keyring();
+	if (!IS_ERR(us_keyring)) {
+		cs_keyring_ref = keyring_search(make_key_ref(us_keyring, true),
+						&key_type_keyring,
+						CERT_STORE_KEYRING_NAME,
+						false);
+		if (!IS_ERR(cs_keyring_ref))
+			return key_ref_to_ptr(cs_keyring_ref);
+	}
 	/* Search default locations: thread, process, session keyrings */
 	cs_keyring = request_key(&key_type_keyring, CERT_STORE_KEYRING_NAME, NULL);
 	if (IS_ERR(cs_keyring))
@@ -379,7 +382,7 @@ static struct key *find_cs_keyring(void)
 
 static void cleanup_cs_keys(void)
 {
-	struct key *cs_keyring;
+	struct key *cs_keyring, *us_keyring;
 
 	cs_keyring = find_cs_keyring();
 	if (!cs_keyring)
@@ -395,21 +398,26 @@ static void cleanup_cs_keys(void)
 
 	keyring_clear(cs_keyring);
 	key_invalidate(cs_keyring);
+	us_keyring = get_user_session_keyring();
+	if (!IS_ERR(us_keyring))
+		key_unlink(us_keyring, cs_keyring);
 	key_put(cs_keyring);
-	key_unlink(get_user_session_keyring(), cs_keyring);
 }
 
 static struct key *create_cs_keyring(void)
 {
-	struct key *cs_keyring;
+	struct key *cs_keyring, *us_keyring;
 
 	/* Cleanup previous cs_keyring and all associated keys if any. */
 	cleanup_cs_keys();
+	us_keyring = get_user_session_keyring();
+	if (IS_ERR(us_keyring))
+		return NULL;
 	cs_keyring = keyring_alloc(CERT_STORE_KEYRING_NAME, GLOBAL_ROOT_UID,
 				   GLOBAL_ROOT_GID, current_cred(),
 				   (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ,
 				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
-				   NULL, get_user_session_keyring());
+				   NULL, us_keyring);
 	if (IS_ERR(cs_keyring)) {
 		pr_dbf_msg("Can't allocate cert_store keyring");
 		return NULL;
-- 
2.56.1

