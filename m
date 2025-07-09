Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885E26B955;
	Wed,  9 Jul 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045915; cv=none; b=DV7gIBson3a7bBF7NC2WlTo3N0NnJRWshxmN0EH56tcsZC8rmSvFWstPj4uEG7sQ4MQkXwdNJuJACnzJ243vUgmvZoJusGMoGkbjIjN1Xtnlj74buTCxZkewjhrzi9VjZ1GKENOJwICiXF9nRoDz00JH9pllhT1zBmhpMCtFNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045915; c=relaxed/simple;
	bh=CaY+xDiUF61Ss4ZxV+ubwoLn+N1hFeUPiQ5PClx/bKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OudGmYpS8yzsAI0NhcVlLwcwl6E5NxvxFAYt0Bz9O59gXSlOnmbVNeOD3kfZwvYwjecIbRJwnVo/w0An5/q/EoN6UkZd1akgNVrl14zNX5sHbpGaKDk1to9H+lNXN9czUbENQCE/abx5vuZdUYP/jpZ0l66Ogv2llliWTtVjMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TCSzG2BR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TCSzG2BR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568MoE2R026957;
	Wed, 9 Jul 2025 07:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qoIMtXbg2MHTy+lDCsyvThab9zvRkop7eIpWtzvnR
	U8=; b=TCSzG2BRW4Cl7MbuH+3zpj6aLlRRYn+/oX2Flm07S2NgDYd9rECKOnJmw
	Xj96uiWShWDrPxYMjxn0nhve+zvVto59wE5kFRKRRAWebnLh7q1TgcAFfbewJGVL
	rQIPGJoB4JeVKmfmEpf8580VcdViGKCsxA0nq80uFI25edl8tsBJhBn/okK+lH6d
	lCX5SmsHuEjSYFCVR9wzgMxZc733De0KerDicg+Djez2ObSFVTM9a/n+ZAt/IUQy
	gwDstg5EH/QHUSYbXXydZyFtHMF+Ni364QtuS/EGgLQWnamEz9SgRhSXUbqmkOe7
	2FbC+rEUR6VyJWWgancZ7MFHYP8zA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur74r1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 07:25:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56971Lcm025642;
	Wed, 9 Jul 2025 07:25:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcp733t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 07:25:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5697P6rF50397594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 07:25:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B7052004F;
	Wed,  9 Jul 2025 07:25:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB4522004E;
	Wed,  9 Jul 2025 07:25:05 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 07:25:05 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf list: Remove trailing A in PAI crypto event 4210
Date: Wed,  9 Jul 2025 09:24:52 +0200
Message-ID: <20250709072452.1595257-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA2NCBTYWx0ZWRfX8NjUdxGHd4Zc 0gKr+a6efRHbMbRVznqESTiaNaf17PuYXmZwmAkaxyrcLqxVvidKmrLB1nrkLdLOKLDhM7O4l0+ F9QlW8PaqwnAhDzwZ61/x7guSuh8ErEQJf06YMkluDKFdyzt0qqZzcmavZbxZaUjbbhr5pQDmxX
 UznN7IS04BbhvEZ8y9wl9T7ynXyhSxM8hXCsGtx493AisT7jdOhnGq1x2VVblfUqMm/4/NXHhvd 5HRJiO794tN4X2LgrocQ4FTvxmZuudxtnHDD05+mIKsUF8TzGZmoMfUFnXw71szNXwumddYd5Cn cX4wOYooQ715xtyfc3FxHUzpJwswm/KSMBKpe4jMMd3w15c497lOBSXxFlW4Z3oCOzCB2nvFyaR
 NkRURJY9f0RmamDuYw1t8JTo/1HoaVnmXHyoEyCq3Hf7XEWTqNx3g3BFizfVq8HCj1+Vu9Ta
X-Proofpoint-GUID: WR3eQ-oe2qYdsKJk_LawaHXVSbdj-Zeo
X-Proofpoint-ORIG-GUID: WR3eQ-oe2qYdsKJk_LawaHXVSbdj-Zeo
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686e1957 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=HSx2QSFV-y9RVaElNDMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090064

According to the z16 and z17 Principle of Operation documents
SA22-7832-13 and SA22-7832-14 the event 4210 is named
   PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256
without a trailing 'A'. Adjust the json definition files
for this event and remove the trailing 'A' character.
   PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256A

Also remove a black ' ' between the dash '-' and the number:
   xxx-AES- 192 ----> xxx-AES-192

Suggested-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z16/pai_crypto.json    | 14 +++++++-------
 .../pmu-events/arch/s390/cf_z17/pai_crypto.json    |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json b/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
index cf8563d059b9..a82674f62409 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
@@ -753,14 +753,14 @@
 		"EventCode": "4203",
 		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_TDEA_128",
 		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED TDEA 128",
-		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-TDEA- 128 function ending with CC=0"
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-TDEA-128 function ending with CC=0"
 	},
 	{
 		"Unit": "PAI-CRYPTO",
 		"EventCode": "4204",
 		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_TDEA_192",
 		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED TDEA 192",
-		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-TDEA- 192 function ending with CC=0"
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-TDEA-192 function ending with CC=0"
 	},
 	{
 		"Unit": "PAI-CRYPTO",
@@ -788,21 +788,21 @@
 		"EventCode": "4208",
 		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_128",
 		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 128",
-		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES- 128 function ending with CC=0"
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES-128 function ending with CC=0"
 	},
 	{
 		"Unit": "PAI-CRYPTO",
 		"EventCode": "4209",
 		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_192",
 		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 192",
-		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES- 192 function ending with CC=0"
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES-192 function ending with CC=0"
 	},
 	{
 		"Unit": "PAI-CRYPTO",
 		"EventCode": "4210",
-		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256A",
-		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 256A",
-		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES- 256A function ending with CC=0"
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 256",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES-256 function ending with CC=0"
 	},
 	{
 		"Unit": "PAI-CRYPTO",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json b/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
index a7176c988b8a..fd2eb536ecc7 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
@@ -800,9 +800,9 @@
 	{
 		"Unit": "PAI-CRYPTO",
 		"EventCode": "4210",
-		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256A",
-		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 256A",
-		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES-256A function ending with CC=0"
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 256",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES-256 function ending with CC=0"
 	},
 	{
 		"Unit": "PAI-CRYPTO",
-- 
2.49.0

