Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D819347BD7;
	Wed, 10 Jun 2026 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110379; cv=none; b=R2HbaYh9OVfmRxM1xW8n9NWfPIpfZVrjGVOfR2draAtB3os9SkCdfZdOKXcj75vpHyZ7J3nbm9HCXx9e4WrOCP2cCBCSEEVXqn1nAYab2sLUyLGq47TsXqxLuyWDtJ8VhXrHJB8mBsR8h0lFBo5G6WYZ/K0UGA6KE5qsyt1FVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110379; c=relaxed/simple;
	bh=E9LD0KaoekkpZDOgReAv+jIHFcm3JMDkv+YM2vE7mVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZhE1UuxQpYtZR7WjGfPlM+mcJuAkUzvBbYdJ7J4/upc4KmV6ZCZoX13FxbrER/hhC7oPzCYo2als7tHUVxLn0GejpgPZ2dpHOS92PNHfzAh4chMWvyNbrHK3YTsklX77hocyC3ke89Kpb7RoH9iPGxhRpl+mrA7xhxLZy1yOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dFwmisS0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dFwmisS0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6QDu94191465;
	Wed, 10 Jun 2026 16:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0M6otYUwAQsCSsg3O
	XW+47eGEZKvl9gACVSlDP9kStk=; b=dFwmisS0FW5t+qo+/bQN+gIP9n/deMDCq
	Cmwxvy7wd9Az09dVjaMbfgj7idRIUudSVqDdlwIvbgPOSbmswxXOUg1OhL4EzkU9
	TEwMgf9q4hl6Ms9JFoFRTMRbiYr0xRh5GpApvLfjVQahDeGaJuzv/ZjCZr+fy51a
	sv5NsgL5WhzR0d1awqXoxoIcpvNaCOT1K7HfPNMeQnJgxuhh+nKp35uknre0Hvyn
	L0UKPOOHDWHRpqbmWmxQEUmlBtQtV3Enb8q/vbeVUi0ERW144EpdUiIdbLUN439V
	VOkCexZwSIOqhPLq2QI+NEPIoDGQjkwyIoNCFNmV0T3Vkrvvrknqg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj1xfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AGno1U022318;
	Wed, 10 Jun 2026 16:52:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w7mpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AGqm1K27263308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 16:52:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F9562004E;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE2492004B;
	Wed, 10 Jun 2026 16:52:47 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 16:52:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 2/5] KVM: s390: Fix unlikely race in try_get_locked_pte()
Date: Wed, 10 Jun 2026 18:52:44 +0200
Message-ID: <20260610165247.238366-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165247.238366-1-imbrenda@linux.ibm.com>
References: <20260610165247.238366-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfXzaETWQXNQjVo
 Kkrsut80ayKvvpxAC5PfSYhgQQL5aJG4OLtYlYVuAQlL5mfbNQ3Mwod3Krc2LVKh0ue4hh+4bT5
 dlvn9T7t3UNtBosJ0ROQS/mmF7S5PSs//drN14hYL64nJGNq8TuiPZYe0tndS3n6ltKER5zE4gS
 dqJXzCkZ6wNR+7CAraL9khzofOoiI91wlAeEjylukhWnKB/1V4hgeQfNe0WEbjVrsMXG12TUiO4
 XlcN7OPt+mNWAc9Lr1gQYVahF6F4tzne9NURaKqKlFbA2Q5EdJYQLHIi+wdRTIfzAay3jUxfz6U
 x+sVQ/rBlHk6KgvdN6p1Zc5ioxQfcp5xhrYgXXy/pfNCJJXlpzZHzE4Lb3txDM711crb/qWoaAl
 jiqUJS2sZOc/FoallJ/Q3JHEg2ZEdbDNToNbCYG8BIEuyy/EPAGdZFnWkqLT1EhSdO8RnDwIzE1
 zP5l9cYLXY+0M5iRHyw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a299666 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=WbevkOawJw57NP_rgK0A:9
X-Proofpoint-ORIG-GUID: -fM0wTlXOOU5yb3Wk79ztVops0_rmc9U
X-Proofpoint-GUID: -fM0wTlXOOU5yb3Wk79ztVops0_rmc9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100156

Fix an unlikely race in try_get_locked_pte(), which could have happened
if puds or pmds get unmapped between the p?dp_get() and p?d_offset()
functions.

Fixes: 89fa757931dc ("KVM: s390: Avoid potentially sleeping while atomic when zapping pages")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/mm/gmap_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 1cfe4724fbe2..ee3f37af8aee 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -51,15 +51,15 @@ pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long vmaddr, spinlock_t
 	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd) || !pgd_present(pgd))
 		return NULL;
-	p4dp = p4d_offset(pgdp, vmaddr);
+	p4dp = p4d_offset_lockless(pgdp, pgd, vmaddr);
 	p4d = p4dp_get(p4dp);
 	if (p4d_none(p4d) || !p4d_present(p4d))
 		return NULL;
-	pudp = pud_offset(p4dp, vmaddr);
+	pudp = pud_offset_lockless(p4dp, p4d, vmaddr);
 	pud = pudp_get(pudp);
 	if (pud_none(pud) || pud_leaf(pud) || !pud_present(pud))
 		return NULL;
-	pmdp = pmd_offset(pudp, vmaddr);
+	pmdp = pmd_offset_lockless(pudp, pud, vmaddr);
 	pmd = pmdp_get_lockless(pmdp);
 	if (pmd_none(pmd) || pmd_leaf(pmd) || !pmd_present(pmd))
 		return NULL;
-- 
2.54.0

