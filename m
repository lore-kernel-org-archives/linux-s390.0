Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839750;
	b=bhGn/G/vJ9WcQTWtuUrXLFKdl4cEySP4VtMsYvmqA3s+KsdwPfYiW67ihR0isfUbStTx
	 t7/nubUTWiZjBZzsPk39bVirPrS8q4liNBnybPl495EiYyI4d4TMIVBMzDra4SKIDNGLl
	 yS2UnhxYcxB0psQ2WkJdiTp0o23nSjEaLvgrYJAy2NIXpZjzye7MB+JZcPk0g7gwtjUqb
	 64LDQTw7Nv1tXh3eYJkXS1Z4ljLhJ6ueIPsn+ujsD/ofWovvctOFD5kXQl4urwevGz1U1
	 WNs7jd31WdruRyBCE32jbwDynXc7drv1NLlMyT9WSZQsDRet0afmWaEqqbBCPLOGK9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839750;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=F6sF0pWEsir4W3657Mx3EjA1IMKs6o/+6PzJq3EE0Do=;
	b=Id8drx+6GO5mRlCLSwurR2s3O2vmd5PfUqmololwqA7pmR6Vm7voFktVv8PuHiQZU2Na
	 u3Ln/VVdXPOLLY5o7htAyO7Jl8jRVRmwB6Brdv8/jkSOxvbDSg7XMLvpCp/uLVK6kxZ2p
	 iMovdkpPJM0xqnWEHnn8CoTZw28XIKRFdEE8sGrq9cH9c6bakwehw9WRJarshE9GcA9OV
	 WuR4fddxmkwVlbciysVd2FjTvlI2dneKFGuqV1Mju3icSFc5tmZxsnOTzDcyDcVwTanVl
	 rUg/LKY7BRRMtxuvdffY2016fVIKgEd2cSZaagdScvcR3br5Off5qiD3MNR1+Htamzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=onaMSBr0;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE7606A31C;
	Mon, 16 Nov 2026 14:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94FE7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=onaMSBr0
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDuPCD2214223;
	Mon, 16 Nov 2026 14:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F6sF0pWEsir4W3657
	Mx3EjA1IMKs6o/+6PzJq3EE0Do=; b=onaMSBr08sDlg/OFe86P9zx65DDNl8K/T
	wAGUgazYI+H+w+aTozMFLyK43AkG53in3a/6YT5lCBW1FkG8NjrbFLUoQ1ye6na5
	K3U81KbbvmTXP24mgN+omDB3hMlDmBi13/s4pZtsB6bmmEqPJD88Q30yeeTbgttP
	MFZnJ7ePp4OMSAQW3GHt0pHeG+Vq/QyyWudYN9PmPzj0Ceodrq2t/ZpYoxfD9GwQ
	ikSbePUma777/1BlyHGpFhzYnhqgFa8aSqiffktoH70nFMtx5gnNpxK8igFNZb9q
	9EdLPgBD6O7qISmccOGFqMwKofOETCbY4Wd7dgoq9rlbKD77x7eAg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxe2d5p6f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC4rr22972402;
	Mon, 16 Nov 2026 14:35:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00ns922c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZc6b21824158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31FEB20043;
	Mon, 16 Nov 2026 14:35:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C783C2004B;
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
Subject: [PATCH 08/15] s390/cert_store: Remove unnecessary static specifier in create_cs_keyring()
Date: Mon, 16 Nov 2026 15:35:27 +0100
Message-ID: <20261116143534.158375-9-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX9tPXfmPK/ds1
 lFEk0IhYpePZJm6bzx1wgUGqv9TLm8PsJf+xAVdogGQv4sSpjKr3R5XtdTWCMPDt662Qyi3iC6W
 3sH+g0EIiPBD/HzkPy4JaIwH1swVPQg=
X-Proofpoint-GUID: bn_oW0810iXHbHC4Q-wmRckD3JGflm24
X-Proofpoint-ORIG-GUID: bn_oW0810iXHbHC4Q-wmRckD3JGflm24
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6afb14c2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=u5S9ZGHLUkciNA4HE2wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX4vap7rA2I0Wm
 fo0Unn7zhEntfOscJVoknJfBQeZ5rtd2jOTiKYHCI0x4az/EwoORlqxb8IeSfZURwp8EuYm8LeV
 dqaFpD+m8Z0YMcE7Q0tLIaAab8/9R91uJn02T+qeyBlyI6MuRrXdHeRcettdnXGkIh8y9oQOiwb
 Hccox1ONdDAlY7IuCaa88C9fuQtF3diCqq1Kb39sS+9XJB1rVUyWg6GmUqamLajamAh4f8Go60J
 qZeW0aJYIDxqS3TKMF1oZ+GyF1RHWvJV7UbVwT9LHvWGXIIBSqw7NIapGumSvbhWFKJzPogsftl
 eH9/d4J8A/EjWtDT8KBOnwJwy+zs/CiGivco41EyFymMJzCaj0redU5b/VcxPIFPKWx5cmkbNyA
 y3ugMm/vc1Ie7uVzyqSraFkqgi4QhJwxgjdTq5ha8MI2/ycAuirFX1c16rdyyoVjW5Rq/38TbjF
 1kPggogtNt5+hzzHtWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160057

The local variable cs_keyring in create_cs_keyring() never reuses its
assigned value, therefore remove the static specifier. Callers are
serialized by cs_refresh_lock, so this does not fix a bug.

Even though this is not a bug fix, this contains a Fixes tag since other
commits require this as a prereq.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index b720dd26a557..aefbefb40c74 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -401,7 +401,7 @@ static void cleanup_cs_keys(void)
 
 static struct key *create_cs_keyring(void)
 {
-	static struct key *cs_keyring;
+	struct key *cs_keyring;
 
 	/* Cleanup previous cs_keyring and all associated keys if any. */
 	cleanup_cs_keys();
-- 
2.56.1

