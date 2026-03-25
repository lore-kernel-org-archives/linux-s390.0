Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CAD3D9043;
	Wed, 25 Mar 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458802; cv=none; b=i70DAFNbrH+gf1q0d4NNZKAgGJ1YlVRlxTYtS3aVPkFOaNEpD9c1iuPnRN1R8Zra2zTIBuIEMkzMRfTenwFWnqNzGLNkgeG+kw7ulHNpQNSiaIRD+stv4INwJ39NrzCmzq91+XJGW+GhKIu4PQmK+y1rBylZmUdjlhHw6k/vYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458802; c=relaxed/simple;
	bh=AD1Wo2ci/5DqF4gGSVesfq5rSxmCnlBmXMXYiJZ+rMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr+swQ40GrFs6zoTH6Rc6y51KE2iV3VquCshYrj1dlK+bFteT3zBZXW58f+XYhATzD1u9r2HtOoMSr54TupBFd6fPFHNDM8BAI5F4zOBHkXSnT0qd0GhYZr8J1vSMVRYiwfHtb8gohsbfOZGmBOH8NF1O+9w/PH9vX2fr6RNELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lk9Qol6l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lk9Qol6l"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P81GDs3317009;
	Wed, 25 Mar 2026 17:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lTiUuR+K7zie45gtF
	ik5T0EO3v+6hZxFUJ+mJC7sVzA=; b=Lk9Qol6loy2zKouijFB+5V5wkDRTGjwIS
	iwnP1JRTyybQcsQMUK2K2cBZo/k1WN4nYso33GyW+WjIh8GxmcoWHk1EilbZWfc+
	Eh6lN9mYMP3vb+HIoblC3htexFgC+gQwnona+vwsoxYr+O8LM/jiEH7LW91eoeNr
	cO2UEBCEsBF+vKyeRp3O0cG7F1W06ThiYw5dnCtjSgqaiM86EoCYELzztu99kRta
	Yj8WFtaerKEKG5q3VCPIFGAgCEUQ7czx8yO9jkYNgIEEnZ2Q98gSZq5EIuDSZN5f
	ajH9hqXdIU6gD4atuLSuj/LWDOEwxzCZAFdOvM6kQrCOg7kPSWVUw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky08p1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PF50Kh031631;
	Wed, 25 Mar 2026 17:13:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsyku8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDDSP46399994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F04EE20040;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAEC62004B;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 03/10] KVM: s390: vsie: Fix check for pre-existing shadow mapping
Date: Wed, 25 Mar 2026 18:13:04 +0100
Message-ID: <20260325171311.182210-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325171311.182210-1-imbrenda@linux.ibm.com>
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfX/ylaM9y9kc8J
 qQVoyPzWhC7zUP4LK427gJ5ZO0yIPCinfJB4oZ0YGVOk0HPVO2EAH090B0gxvht3Rdm9NQkui72
 /ahDoL0nHsGQ9RWLrkNx28F4fvF7UqiH1Qbb0L4u3mM1PdBhF4kVvDyrrkdScGASwQkVFtX/r5e
 Yn3ZlxPK/G7DlFEPKHsbDexMOetgGN9/DZ5i/uW5WUepVwetRlO0PiumZLsRMS9ShFQuRkZf42q
 rE4IPaZekQotf7Vm0uIGL1HKoI9jsQ4lcIVarRZiPAsM+oNbhntiY8P6HiFKM6R9UJl6Rbla/2U
 +kG8ZrTk0505T5BpbaUg10H4Dhz/5eAYWt2fiMeVceZI1JynxY7R+gP10m+X6FkbzaHooAWroHq
 tPetXLaI+wNm2kJ3p9NS0jebEKFdtmllW9Nd5275WAApBaZ7Zx5h7omrjRG0HPv+7D5Fdg3+WNj
 JEOHwEQDkhzNOtlQPLQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c417ad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=IDpXgTtpuR7I2MJaEF4A:9
X-Proofpoint-ORIG-GUID: mu6qjxOasey2VQ5WBsl5dw8oQsLrZsFv
X-Proofpoint-GUID: mu6qjxOasey2VQ5WBsl5dw8oQsLrZsFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

When shadowing a nested guest, a check is performed and no shadowing is
attempted if the nested guest is already shadowed.

The existing check was incomplete; fix it by also checking whether the
leaf DAT table entry in the existing shadow gmap has the same protection
as the one specified in the guest DAT entry.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4ee862424ca0..8fd690255e1b 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1506,8 +1506,9 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	if (rc)
 		return rc;
 
-	/* A race occourred. The shadow mapping is already valid, nothing to do */
-	if ((ptep && !ptep->h.i) || (!ptep && crste_leaf(*table)))
+	/* A race occurred. The shadow mapping is already valid, nothing to do */
+	if ((ptep && !ptep->h.i && ptep->h.p == w->p) ||
+	    (!ptep && crste_leaf(*table) && !table->h.i && table->h.p == w->p))
 		return 0;
 
 	gl = get_level(table, ptep);
-- 
2.53.0

