Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839751;
	b=XXJrMBId2RzKR0/W8sJuIV9D45cPsO/1dadsfCZcBSIVrJRSWRMPtwTfqcZX7rnhnH5p
	 GwfSQboBYfT2BN0d3QkAtqNSqUQPt8++MP9c2k/ywhCfknvZOmPJgI3iZ08BzNjfIg3uV
	 gokj6ihEoW7jKKeHluZaWFLw+bHxAgi/Ix2TIiAT6rjAQ0AHmok1tQUMeZtxyvm0jvPYD
	 lrhIxy1oMZKO8CpuljMdw5tru6wAbmoSsS1hzuKnFyAwoiirq70aFo4WclOUgGeZLX9h5
	 xSYxW8MMczP/E5b/FhjOe9wyMBdqeul259TVp9VB6TIsl2Ojsa35gPb778/ymqDBJHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839751;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uDq11G+zys4kND7yQ81bYF9vCJA0wK+psEFY0N7e9vQ=;
	b=l0LTmeyXxE8gVUmBk/69BCyQ+GNc9mxUTf8TR+W+AFFlamMK7CHfRRi6pw3SR5iacx0U
	 5BzVA9pjVfw3c30Tq1/0Vh4oh9+OSw53U3OAqdZSEKp3nBWqGj7NgAVSFnDFETo3O0F2j
	 u8ffL0LdxheDLUgqN+cR9Wxr4MkWLo0KMVB2vnOkv9/hBjAsjtgcG/8j0sOwo5GPrQTmP
	 W7FGoZBDCLeXDXz7tKMd2UIFZGuuxitT/0VZsaAM96OVD0F0bA3dumh+NFbXslTPXpU+m
	 6+ew7q+tyi61XNjpBRepevke7bOX+hVwhQj6pEoWtTjlbHRRLq4DIOIYsh0s0A08kcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="ahyvpg/N";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3D606A334;
	Mon, 16 Nov 2026 14:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C3D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ahyvpg/N
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDueXC3452601;
	Mon, 16 Nov 2026 14:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uDq11G+zys4kND7yQ
	81bYF9vCJA0wK+psEFY0N7e9vQ=; b=ahyvpg/NXIa3b36L+T/f122xOcHMw4Eyb
	qCFSo+gx/sToiWbBISZ+xbT5+LUzjss0GutJGIgvEg4/tpULepkMcNd9AI3QuDWo
	TbuSgFawot0pA5GXYVut8rOCC/6HZ2ISwjvWGdCzlxnBHuTfguTeqgTs4D9mFYy3
	qznuvXvVrfvo16l/5fQrTOr14im3YGC0J4sFYPmwhPoSfXEPmgI4d23pPuQ3Ezvd
	xzcobyGoavXgKSHEWqnELDz66K/JsxtkS4QcAiYIxs+ErpjR1C8nLgQ1AXQ0d87r
	7tI0BHuGI8enPDk2vPbv0eGGsSBJXXObTznE6ouAb/DpfVjyjXQyg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf9vdkq6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC4x6b1877640;
	Mon, 16 Nov 2026 14:35:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hy46fymny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZbZF49086924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B944B20043;
	Mon, 16 Nov 2026 14:35:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 645E42004D;
	Mon, 16 Nov 2026 14:35:37 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 07/15] s390/cert_store: Fix potential use-after-free caused by find_cs_keyring()
Date: Mon, 16 Nov 2026 15:35:26 +0100
Message-ID: <20261116143534.158375-8-hca@linux.ibm.com>
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
X-Proofpoint-GUID: r1DWJGgDa65EJqv1B8HQWHFlgUDbmomA
X-Authority-Analysis: v=2.4 cv=dtxOmFg4 c=1 sm=1 tr=0 ts=6afb14c4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=lfOYzgPIGkoDIwjHn4wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX9nqUn96rk1id
 /N3iGLmUEFr50haoY76kOHzo1lhqHV94taqP+nn0nbvL/KyLhlpsUu95H0IRD+6sjPHUwy6uZne
 wi/k86jaBAxxLxjnt7VsPhVZgpDGS6Eiv5SBWVYE1sNAqOWKF747fn6rGosHcdPq0kDD8AnMSyv
 Bb9aYsELkvRHg4iwvmRL6iwajWFobKMQoCqw0OnXoqQZQgXD5FS4Mi+12hpYmhfgMlrXkaOyfJO
 sqapIKgDBC+rig3Dvi5MhdqdqYGAYdlzBKDcPzAZKRPxxFLE3II14j9f1kEJ5yI2NSpIpHPm8lI
 k5xXQe+LWlCV63lrRjMskUBIAbMn2EWj7jWC9+JdWk6lw0YhoU3fWdxgYItjJ8PeWHBHkO8genO
 zRfxtYIo5YacpvhwKqqVl3PkzHfzU6pwLt0gP5a0geQDLugGn3o36VoQOp6z3j0fPNFnQ2m1G8q
 8Yayt54prqHpWsm0NkA==
X-Proofpoint-ORIG-GUID: r1DWJGgDa65EJqv1B8HQWHFlgUDbmomA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfXwhsbY0TEXgB8
 4w+JbTg0VaobdkwL3ioIyOrQOUZWiRN6A2TX1vVLoiKrOPrDfdbhVS/YlAQkVMyns7QToHSeoxR
 G+/2XFtIMb2REnCj9Ph8lS8kiO7TgkI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160057

find_cs_keyring() drops the refcount of cs_keyring before returning it.
Which means that callers operate on potentially already freed memory.

Let find_cs_keyring() return cs_keyring with a reference. Since
cleanup_cs_keys() now performs a balanced put via find_cs_keyring(),
remove the separate cleanup_cs_keyring error label in fill_cs_keyring()
and drop the reference unconditionally instead.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 386fe39fe8bd..b720dd26a557 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -367,17 +367,13 @@ static struct key *find_cs_keyring(void)
 	cs_keyring_ref = keyring_search(make_key_ref(get_user_session_keyring(), true),
 					&key_type_keyring, CERT_STORE_KEYRING_NAME,
 					false);
-	if (!IS_ERR(cs_keyring_ref)) {
-		cs_keyring = key_ref_to_ptr(cs_keyring_ref);
-		key_ref_put(cs_keyring_ref);
-		goto found;
-	}
+	if (!IS_ERR(cs_keyring_ref))
+		return key_ref_to_ptr(cs_keyring_ref);
+
 	/* Search default locations: thread, process, session keyrings */
 	cs_keyring = request_key(&key_type_keyring, CERT_STORE_KEYRING_NAME, NULL);
 	if (IS_ERR(cs_keyring))
 		return NULL;
-	key_put(cs_keyring);
-found:
 	return cs_keyring;
 }
 
@@ -720,14 +716,12 @@ static int fill_cs_keyring(void)
 		goto cleanup_keys;
 
 	rc = add_certificates_to_keyring(vcssb, cs_keyring);
-	if (rc)
-		goto cleanup_cs_keyring;
-
 	key_put(cs_keyring);
+	if (rc)
+		goto cleanup_keys;
+
 	goto out;
 
-cleanup_cs_keyring:
-	key_put(cs_keyring);
 cleanup_keys:
 	cleanup_cs_keys();
 out:
-- 
2.56.1

