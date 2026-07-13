Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89393AEB2D;
	Mon, 13 Jul 2026 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931426; cv=none; b=myioNx/CTnVkeVLaO/PwM7ZjPFx5tiwPtQDu0voMev1/igJZMuFDtmv0+xl66oNwQ6EYYFw0dcG8ocbaeDVM9+XI/o5N09zU/5mOa3VIX5iJKroo0VR70eWEGSJBZ8xKODqqMWWl2bPMIcsAgOKQfH3HQutptIzKuszUJIVT9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931426; c=relaxed/simple;
	bh=9ZnjUzssi9uaPKdPu+5nhru7+0Bpe8WRiGV4lkIVnKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKmq3cUF6TRFfN/B8O1QQ21zylolYSZl0b+7RSoMG/AMFxSCH7DS82Rnf8Y79ypX9qwyd2a7lvZnkWBGofUmEqBUrp7DwuFxKaecOqlx2xro2Uq5OgrD6BidHnW6Yz2haVy4HOiuEdhR2Vh9OTHoIlA9I9ibW0l4Sj9rs5rlsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JM6URZg+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JM6URZg+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6gPL51669232;
	Mon, 13 Jul 2026 08:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FyCiTNNL/ZwVbqfmE
	IYbK7YyNU48Fcb41XAcLfwndUw=; b=JM6URZg+TC13Qr1RXyGcmmXNG3CmAkKyy
	Y+3YuZKYrLvzvf6orAmOHy2oKlfqzb4/RuMSeVVPdDxijfIijKf80MDXntXoZdDy
	UxIdFICzF0jsqW7oKTD0mansb8qT1yy/HdLW/RIQmRx8tEgSfbspY4SEodEa6nBl
	2nl6pd+XWI7yysVkvUAGuEGNxSrcjfIJ5BaCzlNNt+SnpXYSJhdT+MzWc3kNc5hh
	ICnUb0B/NTxgcOh7CxKaykYk0fIVI8+7MLRGk5TjmVJywbJHAVyRd+vGyflRyi13
	rakn4kgkBcORQdjsJemN2E9/Va7GeHt/8y5u928ZO31Xvj7PHEA3A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwf912-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D8JYLv010572;
	Mon, 13 Jul 2026 08:30:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg4jj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D8UIwr17039938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 08:30:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C343C5804B;
	Mon, 13 Jul 2026 08:30:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB9605806A;
	Mon, 13 Jul 2026 08:30:15 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 08:30:15 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [GIT PULL 2/5] KVM: s390: vsie: Avoid potential deadlock with real spaces
Date: Mon, 13 Jul 2026 10:30:04 +0200
Message-ID: <20260713083007.65863-3-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713083007.65863-1-borntraeger@de.ibm.com>
References: <20260713083007.65863-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tZozTDf4y4oLZd2j7E9T_eGg6LbBLt4F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX3h0sj4tWgH4m
 GGUcEDDGpk5fwQ2xQK+bGHpnuASLHqz2FljQBf2ib9i4JP8dg2svZG3Bl9OydvHNthufzvZ6rAz
 1Xga9J651aoqeRNP+5u5P0VuEN2sVXKr4oRrMdy3hEjjx4APIdnkgJ/aAY9Twcg3RcoTJrHYbep
 2diRBbG4lJMzJB9Z+f0n9aTtR3nf80eluE4jK1+6A5dOKMlIFoSPadAEPMTQHDGQ4qbP68dA07n
 lHZS6zPZPjMjHbOQxx/s+slT98IxzcYsAeNrNzd+bFIfV/+p92iRv+2fVTMjlCp1Cwn6+PAadL4
 0TaDQVE9+dA5n06brc/s/mQn4T+6ghZ2q3CsFKgjxX8jT2NmTLZqN+3RYNXM4SNZih/LzQaDWuc
 1a85/3tzjPakjkq6V20TVSFX9GgRxyUE+FRybpssQavbPni9z6f+zdqe8CZVXvKblQruddneeKz
 9Nif36rubPhroXdau3g==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a54a21c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=h1X_5t0Fh-6HCxHrEOoA:9
X-Proofpoint-ORIG-GUID: tZozTDf4y4oLZd2j7E9T_eGg6LbBLt4F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX/KHVlLTaoxlU
 sJZqJ2WUYH/C43L9xoIH5MFkvtmmAMN8+yM+DbdoPBiBAPu0v0LLLCaNtaByhmvdeCVU9Nx7WVP
 OtHTImzmLv5LKuNMDiN9e7AZ7vxnNHY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130084

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

The natural lock ordering is mmu_lock -> children_lock, but in
gmap_create_shadow() the reverse order is used when handling shadowing
of real address spaces.

Convert the inner locking of kvm->mmu_lock to a trylock; return -EAGAIN
if the lock is busy, and let the caller try again.

This path is not expected to happen in real-life scenarios, so its
performance is not important.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 298fbaecec28d..8abb4f55b306b 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1374,8 +1374,13 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
 			/* Only allow one real-space gmap shadow. */
 			list_for_each_entry(sg, &parent->children, list) {
 				if (sg->guest_asce.r) {
-					scoped_guard(write_lock, &parent->kvm->mmu_lock)
+					if (write_trylock(&parent->kvm->mmu_lock)) {
 						gmap_unshadow(sg);
+						write_unlock(&parent->kvm->mmu_lock);
+					} else {
+						gmap_put(new);
+						return ERR_PTR(-EAGAIN);
+					}
 					break;
 				}
 			}
-- 
2.55.0

