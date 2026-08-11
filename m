Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC33C455C;
	Tue, 11 Aug 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463817; cv=none; b=NJqDhWv/bYkHc42Isz4sxsWL26KXXJPSoHN8mGBZy/0FpBitnF6icKLoEqTcGZEUQ4spB0hIaUplcQlzuypj3ms3SHpGl0cog+NRVMU8dWVsVuHOY3Y9GEt2tzYiweoZCwMtZDF8zTSXRxAr2uExmkgK5PrFRrSf306u6mjYJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463817; c=relaxed/simple;
	bh=rWTE/ty9JwIc7s6n5HVtXgxvhAl0EA6eS6kqY/KFX8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfAFWgXdPfBsGylMBbKTR86qgosUJSM8CJ3gEwL9cbQ85+beDbnCvgvgcTflO8UoSNxBNqjJ8bGe1w4ZN0D+FWrTh+aEaR3SWBe2K0tDTNeXoEojpNkQsoXW6zL7O5zIba1xRTYqW4vWzHDRZODCCiiztOmxpVQ2i8cxLGRo2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EHZvhYWA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EHZvhYWA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX8kb569951;
	Tue, 11 Aug 2026 15:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m1vROgpmHz1ZjMUn5
	dyMehJ0+MyaqF6PbP1t6/ot4PQ=; b=EHZvhYWA+s/1ooPqWYBVYrqzQqtIzzEf+
	M8dnr73l6pgMCyIvrxHc8DBUS4rCsqGvCB7AMjf6OahYLfODiXbZ3ZnnbhRMas8O
	EvFgiiyP+c/tkNpYVjfxWsmCrgHdWxtELIwdypuvHQJii5WV6ReLK1d9tv/ile0c
	OaAh4Cxjlw2wxZnyNHz/TXPeSGOrGYMiULdo8Xgkx3AnJHLPca8lcEIGDCauMx+j
	gdm/0bIbCiRXyaN+PkQYA0IQdUj5p5Z6YaHJXwHkMkfc0yhrOAPsd/fZuARLiA0w
	7uRj4Y8hwYwhl8Ix683frDPufgSuWIYQ3enHwGSyl4zBX2JvtVj8w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw54mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuMnQ016183;
	Tue, 11 Aug 2026 15:56:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1d87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFuiFP40436166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42BCC20040;
	Tue, 11 Aug 2026 15:56:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15EC720043;
	Tue, 11 Aug 2026 15:56:44 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 10/11] KVM: s390: Fix potential tiny kernel stack leak
Date: Tue, 11 Aug 2026 17:56:40 +0200
Message-ID: <20260811155641.219777-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155641.219777-1-imbrenda@linux.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b4643 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=geH3wxNwSTHpAUJZdnsA:9
X-Proofpoint-GUID: VDJcknpbUZpTH6TGfOW1U-NtjTSzXV8S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX1GeHrmgpHjxV
 jvxc6OrysekDvyf8qx4lvy2FCz0Wn2w+hjINZCTxPGpGJAtuBztGC9H/zEYIs6OiDiulk4iE+dU
 ThHZQuTDuKuqQ24ZG+4IsUYtnOXEJuq1VdS+ZGLN30qezQr//A/s0hbvC3GiMGA2SsTk129vKeW
 hZZTmEe1J3gV/kyKoFRowpsvU65PZMamWG3Tg771ig4D1KeGhZcTDt+p/0IUOHTzxBDGwJxmzXh
 B+pBrvpLi/yZoGrRE5ppgoTdU9tXye+mTv88dAqgKfbmTG4ffSaQpJGumUPLTdtjmToQEx0tWvJ
 aYdNGlu6aw+IGLBt1ZW8PC438hEz8hRAeclxwXuazO0sCTIn+A5TILVHCiZIxf9RbeGOx2XeUhz
 eywMAbJ6NNGFon0q7r7X6wHWaqt8YBuDpooL9v8DcXvHi2X98gjubplCctDfCSXQ5Zce2kePvFA
 1taO9ZVb+zbkLHt9baw==
X-Proofpoint-ORIG-GUID: VDJcknpbUZpTH6TGfOW1U-NtjTSzXV8S
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX5n+u6bRyk4nk
 KitJ55FEenjIVUgjlvJx/wDHy0e1Nlv+CvQzLKLnJfAlyPjmCtHziLMFNXM4ViTfa/Jx4xglE+G
 hbOAO3QVJAIGutQnGAGylkpPkRObfv4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

In some circumstances, one bit of kernel stack could have been leaked
from dat_cond_set_storage_key().

Fix by clearing prev before use.

Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: storage keys")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 47ff8af1b22f..e2a74eb4d631 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -740,6 +740,7 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 	pgste.fp = skey.fp;
 	pgste.gc = skey.c;
 	pgste.gr = skey.r;
+	prev.skey = 0;
 
 	if (!ptep->h.i) {
 		rc = page_cond_set_storage_key(pte_origin(*ptep), skey, &prev, nq, mr, mc);
-- 
2.55.0

