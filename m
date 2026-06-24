Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895230569F;
	Wed, 24 Jun 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299982; cv=none; b=iDfCoVoW7FPbI+3a+LaL+eFy4X9RGCPcAY4Z2tnhzaXvkU81vuMez551z2OVCYWTBR91qqNfR4g11d9wqFx9bQFUOdJ+prpTfBt7uiSPnKNOTWHEM1KeNUClw8C862NUGSaG0+fRkQqLmKpH4XBzVIzm2u3wRJzkRW6iQbXOfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299982; c=relaxed/simple;
	bh=W1xwG7Gzop10fyWg1cBznxROsactbKcABG1PmCtNaUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULvkjIw/rE8IGKuM5hf6DBPYd+aCmDazzPbFtLfhEThInijtbH2op3HTwdWRN5EjUprsnlpqSKwLtkSL9dKncf8i0ndI1EEejgGAdG+4z0z1qyPjRYC3x0HsLFEi1Z81mqV9SCO8digsEUU3XIn7rPLHNPGbos8d04CvVrHkI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OnwKbLi7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OnwKbLi7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmOsf561176;
	Wed, 24 Jun 2026 11:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=N3YBSoQIlk0KFXyc+
	ld6NvrFoNygBToaIOb/GYevCu8=; b=OnwKbLi7Gfg/5GMoqX6LSfW5E/ZZJjMCx
	HAju3gESxwqkrIk6hy15Kv9gECT18FQTBTeb21Z6dtwyfI8sH4QH7hWw1kCmqtdy
	ztYPBXPz3wASPAHeM6NUpqBbKu9iIzmoCyoAZaMmoSt3fVxPxovkRBUngQ0C6aBi
	Kfjmen3Qxy2yV/qSI7MDaBpe1H7oBchzlfYi9H2y6Yykg00JVYlDWFtHV6X0xLXi
	NmVIu0HAYa5MZi0txEvE1QavfY3X+SfTRkfJWzLEqE34PyKzdZIIbV8mlEXUdG/f
	4ifCB+9/BK+LOEY+UpOZQi5JWIKdr2ewQ1X/1Fea41Bb0Zj+Hg1HA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsuh20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4eOo022073;
	Wed, 24 Jun 2026 11:19:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg8107-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJUGx46793196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4C5A20040;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0B5D20043;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 07/12] KVM: s390: Fix code typo in gmap_protect_asce_top_level()
Date: Wed, 24 Jun 2026 13:19:23 +0200
Message-ID: <20260624111928.144283-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX8cCagTUTE822
 RDd5y2WnE0zA5urLDzMiOzSkJqbRa8jOMOlQucF1G51YxM10qN1ZwWPURwPNOPtonkW8x+eWnQT
 z0QEYZ5AFDfckrfhtpNStDG7HxBJh+tseeYmOlZ126lNJ7GN0dOAjwpGwnLVNt9RC2vLf07P+FW
 UDeZAnwV9zAjxfv8KHsIEs+Q8MM3hgNUq5Gjc+cBJLUalYKxqyC47sBijkqr/xodtkta7WvWUCR
 dh46whjRY++1eYLjPH7fF3JyxsVLnTlPnr0f+JtfY/QPcpHcd+/Cl3Y3s4udNDC0k3xy+rJ+KUb
 Iww3b8Lu5OE43baQQCHvudKELEbaRz5U1XDC+fJ8msX03r8yP5kO/9wSwbHAOjns+REdQQZ82k5
 ZKhoExjjnmCKbulzJTuBi0R5EcDOmNeyCPh53a21qBxzM/kw6qMG2SE6026kl/a74kQP88bU1FB
 HUZYV3IfIGGKGtHvHhg==
X-Proofpoint-GUID: 53twZB_BZEuYX1jq0e5OydjTx58WTWiW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX66Yx62MXsb0o
 SAygqYXzKqHZ0M66VPFaAtYCND/N7Gih6sJwnjFrA+8ltP5a+V1Il1HJ2ZjTXd8wihC8BXI556M
 M/r9RLZf+jf+RESrVU7qLgQ6oxyCDgo=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3bbd49 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=SbJAmB9yzU3N3pmr4mQA:9
X-Proofpoint-ORIG-GUID: 53twZB_BZEuYX1jq0e5OydjTx58WTWiW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240094

The correct length to pass to kvm_s390_get_guest_pages() is asce.tl + 1,
not asce.dt + 1. It was a typo, which, due to fortuitous circumstances,
did not cause bugs. It should nonetheless be fixed.

Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260623153331.233784-5-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3192f610f696..e6e786811db8 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1262,7 +1262,7 @@ static int gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gma
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt + 1, false);
+	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl + 1, false);
 	if (rc > 0)
 		rc = -EFAULT;
 	if (!rc)
-- 
2.54.0

