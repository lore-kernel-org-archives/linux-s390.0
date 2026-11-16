Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839760;
	b=UQx5vbpU1xgBzhg7c5D3bKSyzrgJ+uaOkF+ZTvc+RiVxYaROrTQud9j4dxMGiF3Lxtz+
	 Fgv92CrhjMcXJvegjBOtq91TpJmTGuZz45xh4hTG0jNIBH4NwqrQE7GtTBp+XdtEyJ8t7
	 82KSLdhMXW68WF2fYFDZFMMI8eyw30kxucXtwjW1Mnc2JIKwaLyv8fR/74tYOOW+zVXoC
	 /UK9YHPZi+zLT4H7So5o1P0l/nnys+3AGBmJJMrLnMHAI2aq0kE3fKVUAUxjjEvME7dQt
	 k5Gph95IN7rSgS5J/UcWuPkW0GnQtzXRY8ouoDnmD+LMzC7rpkFbcx/VyjryH1TNZig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+e6HY9Ng1lrlIq96oijHHvlvCz0R3sjIAK3/RygsEGc=;
	b=l3o6IXjatj/GBT7byq3lkXmGpGkUY3aLzmpFnY8dtfDBukUGPUZTWLl8DEYarY0jKV6v
	 8BwkMURPOGSFYibIEArykGv3XNl3tyuK40O8YN39s8KyBiLAHKI0NpuvwJ/ua19C2lCdK
	 gdr/nyGcKrZa1UHMqSwIHPPXWohSinbHnerW+CmUy1tFg6FRjX6tOvZA+gLJetNWDflkO
	 pLGSt8Dd9usorYlskQThzDnB6m2qe7nq369c4UDxJLqr4/gXYwvqVEja32eGjo5MVbPAL
	 Ufyi/dxfb8fZ1FbNQ5aSyuASbnxiK7QRPYXemzeaDtDA0+PdCE6W9RX94M3JHnLxmKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="jAU8/Snd";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF2606A32F;
	Mon, 16 Nov 2026 14:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CCF2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jAU8/Snd
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDuhnD3631638;
	Mon, 16 Nov 2026 14:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+e6HY9Ng1lrlIq96o
	ijHHvlvCz0R3sjIAK3/RygsEGc=; b=jAU8/Sndsx2Uwk8oyzm8xJA8MCH8AMdHg
	fQ17UjHcYbec80ZJ4I7ub+EJ6zwxRn70wKjrchkoDJOVTDQ84OJebeRQmer34h9t
	TBDjEiFqcx9RlYESA8GcyckowLn4s84QdINEeahUfN1puGQ3qQquSlxPkpIyibLZ
	rYa9GGDGUl0N8pZlzNb2/u0xfXDupAxbuGl1NZHmbLcbP7EtwqyoT1EOQlwL0g6i
	8xdKw+2XQwDh7RMar54fc3tnsl8TwuHVz7MReuSl6yntqaAparHPMp9mJ/Db256L
	M8HOFoMzizvuxGVgs0OZ1g8D4I38j7awEzlgWJSOlqd8AaTkTg85Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf5665pf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC4xxv1877637;
	Mon, 16 Nov 2026 14:35:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hy46fymq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZdmQ52691344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 660B42004D;
	Mon, 16 Nov 2026 14:35:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 129D120040;
	Mon, 16 Nov 2026 14:35:39 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:39 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 11/15] s390/cert_store: Do not search the process keyrings for the cert_store keyring
Date: Mon, 16 Nov 2026 15:35:30 +0100
Message-ID: <20261116143534.158375-12-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX44TFJzrvRpIh
 69Z9Klpd4cUs+oc1CpmIi8/RKrpXkW6LU8+2PMJKolDGnfhXdMYAwNqHLy0RTmMru3lZz0455XP
 0XcYIYBvcnHPey3Fm+lktteGWyXB5ug=
X-Proofpoint-GUID: l4f3LL1913f2Hg6PPIoIdPVoumgL1b6H
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afb14ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=0dunWCLzcPS5ikFJ:21 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=RULMvB_RHQLfq7f3AZIA:9
X-Proofpoint-ORIG-GUID: l4f3LL1913f2Hg6PPIoIdPVoumgL1b6H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX67XMNVrlcTb/
 MjmNVB5qL2CvORSBKkNEmZKXpnjjkjkmEmUVt9x5p9iU13oGiuV9mb4RJPReorSB5cFcchWy1WA
 tqD3z69KHA4CDaTi+gJmDIIVCVqC9CBTTKKeCeoNxFRW2tt7XFFYRGm9YAc/FbJ2TYo12/q4j6B
 EQpi69M6YkxKhG9TEyc7MPK9Skc8tvTUNCvZJjn0zhDvHAQ50RGF/6lZafkdS09iajl6z6KoDjH
 DzNDDJGj0caH0tUbrZzsn01xZRHxMMn3mTmKCrf5ypfx2NIXmWy9WVRKSRpFzbJV3RcRs7Ry9C/
 7J44cOhndvwSvUNu37eK3SLjfAbuOemozL8zBwmDe0IoSUVovIwrugtAz+PrK3zQFFXCTGCq64j
 lmvZOUucpDiU0O1SR5hf2bNd8N09N+X0BhFsSGvydEzLZqCetvG11J+2g7u+MxyZjmJ4SoTUd53
 88rU75WjBHPh0vA67ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160057

find_cs_keyring() first searches the user session keyring for the
cert_store keyring, and falls back to request_key(), which searches the
thread, process and session keyrings of the calling task. Any keyring
named "cert_store" found this way is accepted.

cleanup_cs_keys() then invalidates and unlinks all of its keys, and
clears and invalidates the keyring itself, without checking permissions.
If the refresh is triggered by a task which inherited a session keyring
that contains a keyring named "cert_store" not created by this code, this
keyring and its keys are destroyed.

create_cs_keyring() always links the keyring into the user session
keyring, so the first search is sufficient. Remove the request_key()
fallback.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index ec6352528a2b..551b538ea930 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -360,7 +360,7 @@ static int invalidate_keyring_keys(struct key *keyring)
 
 static struct key *find_cs_keyring(void)
 {
-	struct key *cs_keyring, *us_keyring;
+	struct key *us_keyring;
 	key_ref_t cs_keyring_ref;
 
 	us_keyring = get_user_session_keyring();
@@ -373,11 +373,7 @@ static struct key *find_cs_keyring(void)
 		if (!IS_ERR(cs_keyring_ref))
 			return key_ref_to_ptr(cs_keyring_ref);
 	}
-	/* Search default locations: thread, process, session keyrings */
-	cs_keyring = request_key(&key_type_keyring, CERT_STORE_KEYRING_NAME, NULL);
-	if (IS_ERR(cs_keyring))
-		return NULL;
-	return cs_keyring;
+	return NULL;
 }
 
 static void cleanup_cs_keys(void)
-- 
2.56.1

