Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83300380FE0
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118001; cv=none; b=tq4EkjS3HRNZZggtHvyw+Th7PVDiEFiMAJ0QYuHOQhhqEKxJ1v8e0OtzWSL8Fg5UGKTgwFrkKoZLsGROsKrD0cBBz5lGU3olf/uW7p5ZPA8J4u8dKRXFZQ6y/BjWFpqyGSdKHL+u4dDzS1CicQfWedwM6h9gtPIRHCy5pVUhJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118001; c=relaxed/simple;
	bh=wl2btu7SDh4RgVxLox3mC92tDWqGbfYDFV3fCrI1du0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJqY2Lnsc9Ki94tSL6Sc9W1Sju0XITE8mRE7uQSzYECLxcJ79PBAyRTpCo0VIPctZhftw6ZL5Td5VpviQ9/e49oUrhXic9WX0qVSfi2LRmATEExhJTodmrXng6PMCcWN/0EqcaHabRH5LFdfhhYpQXYGKelrunbgHiSvITEg3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UUhZoUUB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UUhZoUUB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B81cWg1218154
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EgvCRMO2tu7Bzr5DYjCrj53HCNW1t2TNrYxGstd85
	Ys=; b=UUhZoUUBN6r80y9uYB9nM2C5ylPHxD0UOkqFb8ML2ntW1tE4CeNVzTqVP
	A7uEMeAGje9Yz0yx1ko/EjcDG57IbImxxjullgM1b3sB9XIqCpcGCZV+eo3LAtLh
	aA82hq/RNDv0eKTeTAeCGT9R8W5gSGOgul+MfZNgDjb/UlgFwq0nx/AIN13vhe91
	YskdTELj7HcKt3YqRmlrRvFNMEldEtB07/TM2Zy9LB9jiY4f45KakEMM3DeqO6Z8
	CmZoOdTBEpDsajhyxBzz2mmWuz0VfYVlC5T1LBG6txKNP4x98lke+qkDBCfrrW0u
	7Cbwaq4YyigQmFe6LSYh7QNp7oy7Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8ptgs7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:13:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7o5h21318590
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:13:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq2wevf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:13:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68B9DFWF46596582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 09:13:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F022A2005A;
	Fri, 11 Sep 2026 09:13:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC2C72004E;
	Fri, 11 Sep 2026 09:13:14 +0000 (GMT)
Received: from t35lp46.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 09:13:14 +0000 (GMT)
From: Euan Bourke <euan@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc: meted@linux.ibm.com, linux-s390@vger.kernel.org, euan@linux.ibm.com
Subject: [PATCH v2] s390/hiperdispatch: use system_dfl_wq to reschedule hd_capacity_work
Date: Fri, 11 Sep 2026 11:13:09 +0200
Message-ID: <20260911091309.1238604-1-euan@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa3c62f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=fq4Gsc4iZSFbyweIEM0A:9
X-Proofpoint-ORIG-GUID: WZDzcE2OxdSif60z3wKP4Zwbo0Hu3jfY
X-Proofpoint-GUID: WZDzcE2OxdSif60z3wKP4Zwbo0Hu3jfY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEyNiBTYWx0ZWRfX8VAdjDK+S4En
 cOKNpQST0bC9Hq1Pr/Kak5SOpAauYWSUh9eWTFTe+PIOCrPbBBfHDTD211Ib+V7+KbS4nZWmvRs
 thdLNaXN8oDW0v5C/YQ7BK11pmY5gU8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEyNiBTYWx0ZWRfX5DSxLo5pe9Ox
 ewSzUfSXZCV5Ycb5QcMh8PCm5McGDgoSZCwItV3wmKHuHxumskz1glN6KtF/+2ZPYtw3cXSG/E4
 6cAteoHxUhupBysxIaJjF8Vh1BFmgP77djTJCl6ewJGAiHe5AJ/qeHGbI2SCZSadkZLC3/tpb9P
 fps5tu498COORRW6nzBXImUYzos8sLBH8Lemf0hw5lLWXU23UFHTR9l58k13r3KYtEoWXp1yaGc
 zLz2skZ+jHxWg9kn0VvU2V/OjYzOhG+ZK9Mp1JvkjorzypBuhNFjRF3eY/OJECFK2sCxHt9Q3Og
 wLERscRsX3wBtIl1BxNv97nNorBi+jURR4Zf7ziDB1sZyBdb01w0R5oIhuiE6eC15f10vjMtnaq
 0IvI035fHZIGV6b8k3tuGjCth1RnoIE2X3DdptCJCT/CBBDvNDYQyqkF/NvMvJj3No4X7TnuhYj
 QldQ+1tnBPF/4N+7NBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110126

In hd_enable_hiperdispatch(), hd_capacity_work is scheduled on
system_dfl_wq, however the work function reschedules itself with
schedule_delayed_work(), which uses system_percpu_wq.

Hiperdispatch does not benefit from using the percpu workqueue. Use
queue_delayed_work() with system_dfl_wq for consistency.

Changing the workqueue from system_percpu_wq to system_dfl_wq causes no
functional changes.

Signed-off-by: Euan Bourke <euan@linux.ibm.com>
---
v2:
- use queue_delayed_work() instead of mod_delayed_work()

 arch/s390/kernel/hiperdispatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index 217206522266..8494823559b1 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -265,7 +265,7 @@ static void hd_capacity_work_fn(struct work_struct *work)
 	}
 	trace_s390_hd_work_fn(steal_percentage, hd_entitled_cores, hd_high_capacity_cores);
 	mutex_unlock(&smp_cpu_state_mutex);
-	schedule_delayed_work(&hd_capacity_work, HD_DELAY_INTERVAL);
+	queue_delayed_work(system_dfl_wq, &hd_capacity_work, HD_DELAY_INTERVAL);
 }
 
 static int hiperdispatch_ctl_handler(const struct ctl_table *ctl, int write,
-- 
2.54.0

