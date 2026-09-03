Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39042589D
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423371; cv=none; b=uythnUZdCUk7OPSgF4hKjNwNTVU3lkwkl9uDXmGuVvMwg/RLhxOMxlPsklB+p3uF9ThEEaTiwACnHJBwTUuE+3EY+1/T0EO9luWj/VrtPxwHNtVHpg9p4nRhQug9RWP1PbVQ7R/3J60tNRcsOUlXmxrKEQ0n9kz9koPUuLTGc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423371; c=relaxed/simple;
	bh=YtQr9XwnbimWO74xMJEaqVolxwI2HTj3iM330AoLkRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rI355ADb2WAvx+xxZz1E1YvWsEOD2OtdNC3N3a/E6HxgcZYOWuua0qRRKPsOJlEj9YD55lXQiIjcmZoRrmwz92Ixwn0iVgFFW5D/2RIUIDraL4VeWpU3g96ppzpjc343HMKr9l7ikTnWylKqX+W31z8t0ylxdOHqWhYT2Hn6LI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gRPs4fgY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gRPs4fgY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361fmg1056176
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 08:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=C/MOBd+DLwPiPvz/HvWAvc6Zsa7CyrwKSaNbttHDK
	rY=; b=gRPs4fgYBnBWEAqKe1aoN6uFRfwiQ4dc7XSCNfRilWG+0udqh4zYIek8m
	V41lIwX/GxTh0M6VdY0r7Vg6MS5oE0EoU2DavOMHZhNwMqU/gIOX9BAe0qIFIjy2
	yoVEwxsnLfehzS3AHreBNscUQhog/1IVyLeKx8RGD6FZXo4TYDtoF8Dpd0q5izDz
	ZgE8nkDPi6SjARPCK5IrbXK/XhlBDLf7+t2ednNVgPshvhiwEly5Xkymz/Zu0i+D
	Adcuftwm9bL8gU/HKXr6loFSKliPocb9k1qM4eW7pbAGYjEGejYS1M1/0nRpXNXN
	HmQjd4+8mL4IypWd4tZB4B02/6xuw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue3ep0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 08:16:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6838BFWZ007506
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 08:16:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyehbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 08:16:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6838G4UP25231644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 08:16:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBA022004B;
	Thu,  3 Sep 2026 08:16:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A360920040;
	Thu,  3 Sep 2026 08:16:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 08:16:04 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org, japo@linux.ibm.com, sumanthk@linux.ibm.com
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] s390/pai: Simplify pai_init() and always return -ENODEV on failure
Date: Thu,  3 Sep 2026 10:15:57 +0200
Message-ID: <20260903081557.2023814-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WSvuFV6NXv3LBE8H_NZlqfQTbpO5v351
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MSBTYWx0ZWRfX/2yGgiZEnE4g
 57n5jI/Zs+8l+c8xqZM1W+43J149WA/br+UtIyLdADD0C77u7sIWYZiElHU+oK76wC2FWMfcUWg
 1QviRR0IPBwomB8H6mjCGb9ISIV9wa/xxkSJKPG4RyPGDaxa2NxGIMV7a5iAiJtWfeqFvj9bzSE
 uyTxTFcMLcZ7ra+NqMBpHOhLVXWHZfw2fbrsJsAL527dM6O2ZKCFZZeTbZAvR+jzzOOBBS2qsRY
 QPaCfFNPPRo9Tu6WriZ+/SIye+TPR5WXfifWsGHXy+FIOyJqddOK+P/kSNZv7Hf8MjfkeEP9Snt
 SnhFKIpg3VPaO8ivVt0tZyP/wPmyn+P6wHt7BpekhaBb9fbQMkiD0ZXlSb0rlzFMSLX9b6dOlqx
 mBnNL/E9VkFE9pndFAUWZEJKt7F/eG/GfAUugMf7CdJxyWX1By+XyMLEE9iqKpez8VHs5R25S2Q
 QJ6ODRtuWBdHZVca8Sw==
X-Proofpoint-ORIG-GUID: WSvuFV6NXv3LBE8H_NZlqfQTbpO5v351
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MSBTYWx0ZWRfXwRSw9sO/qLF1
 TKiTuCHawP07fHQTCpeYHfZuFuh5QUiaNNhrsxaKQcGZYF1SHhVSlSZJPI4VzXuirwfN9ytDOkl
 PDB8TA/kT4CqCtBMHBnaKiQ9dbJFoqw=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a992cc9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=3XznFXSuqshgfcZZ2_IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030071

Code simplification and remove variable state.
Return -ENODEV in all failures to indicate the PAI PMUs are not
available.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 013c3dae21ec..b6c9dca09510 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -1304,7 +1304,7 @@ static int pai_offline_cpu(unsigned int cpu)
 
 static int __init pai_init(void)
 {
-	int state, rc;
+	int rc;
 
 	/* Setup s390dbf facility */
 	paidbg = debug_register("pai", 1, 1, 128);
@@ -1315,23 +1315,21 @@ static int __init pai_init(void)
 	debug_register_view(paidbg, &debug_sprintf_view);
 
 	/* CPUHP_BP_PREPARE_DYN --> before CPU is brought online */
-	state = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "perf/pai:prepare",
-				  pai_online_cpu, pai_offline_cpu);
-	rc = state < 0 ? state : 0;
+	rc = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "perf/pai:prepare",
+			       pai_online_cpu, pai_offline_cpu);
 	if (rc < 0)
 		goto out_debug;
 
-	rc = -ENODEV;
 	if (!paipmu_setup())
 		goto out_cpuhp;
 	return 0;
 
 out_cpuhp:
-	cpuhp_remove_state(state);
+	cpuhp_remove_state(rc);
 out_debug:
 	debug_unregister_view(paidbg, &debug_sprintf_view);
 	debug_unregister(paidbg);
-	return rc;
+	return -ENODEV;
 }
 
 device_initcall(pai_init);
-- 
2.55.0

