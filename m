Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983811;
	b=MCTrH41dh+Zu7sfBPRLZVun+qP7KnNLCmGLLIQaNZKfrdnMW1m51oW/ALn69VpcQL4Kl
	 quvq09rezA93wOag9y2ctWZ86o2i3ExBLxYh4GFqzuSR7JmdKHVulipwmgFDFqhUjPYhJ
	 yefSziff+FFV0nsVNQs4fJgiPrcuAlNvU9HFdMOO4Tlzw3GPQecuoGh0uLa6H2pBEp1Av
	 FtKGRwv80w3xBwZM+YchXegRae6QeCrohzaUmzwflL3g4JeO8nMF3gZYo6f8aN+e3ViQI
	 MTDJSzmOJNZW4PxtOvaVAeeyNXT8kRgWTDCPOuOsBQmHRAwVrbPNdTjLGomyNaSOm4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983811;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PeQihC3y7/REzVrQYHI/7rfz49AoexqILKgTo689pzQ=;
	b=SoVNq4bFieX6QsA/u5XMjE+D9AIdqchBkfF7UNpiSpFyQ0/LDn3uGT2BaAdhKSfxxSH2
	 j2Uls53Plp3PVhCV0hEKbU/c99UMW/qSHq+V/INIetETpx6EUCUSuaiZcB6OIwCAp1Yqi
	 mkGZfmed0ISjkQk9I6PFH0+elvIRySOnueXCiuwu8gjtpDG4aeWUoJ2dBzqhYFB9DYcvZ
	 0C/FWTh+faTsu/Uy+y+QKMnlLp4JArlxkQYeMfnfwSVOAJFs/neHXexUThjZfW9ZmlSne
	 KxLOMzMUOioHFXXHhSprcxU33Zj4hpyP+sdlx5xrK9Iy5CQYpQxHcM87z6Zk33ItU4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fBrZbmNB;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BF606A326;
	Fri,  6 Nov 2026 16:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125BF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fBrZbmNB
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEMpL1544506;
	Fri, 6 Nov 2026 16:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PeQihC3y7/REzVrQY
	HI/7rfz49AoexqILKgTo689pzQ=; b=fBrZbmNBPscBupYva1w8Un73+pGyTclNq
	oOV6noQ9s1YFDXfk24n0dAM627PtK4dP236eGxgZcwwOrQyPF1lXBpV6/Yk3Viz9
	WiBDo/7b5Yvbo+sUa7sFzMtsOWI4M59N9qRmp/7Ae5uSY3Nt6oBJoefcG7KH+3yT
	/XELuEm2e7qfBwbgpm/QA5G0kJm7Dl2LQEjH8wjYXm47qkOPFCuIjaFnIIAeV7he
	JZuDqUFOFAMO+5/HctxrNvcSOXrStzDELdXOX85b7126Xtinw1mD8ADS98nMt8vI
	pCui/BamutmaJb4tf+eNX1ScLpBZuiwwr07qGOxz+nW1H1ztUZjlA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbwvr5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4ssW3584921;
	Fri, 6 Nov 2026 16:50:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka72gt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6Go4HD10748456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:50:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C43FA5805A;
	Fri,  6 Nov 2026 16:50:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BBFD5805F;
	Fri,  6 Nov 2026 16:50:02 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:50:02 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [GIT PULL 1/6] KVM: s390: fix ESSA addressing exception injection in migration mode
Date: Fri,  6 Nov 2026 17:49:53 +0100
Message-ID: <20261106164958.431978-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106164958.431978-1-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GNgYzOxJrzsxzRgrK08rlXUtsPVX_5UL
X-Proofpoint-GUID: GNgYzOxJrzsxzRgrK08rlXUtsPVX_5UL
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aee053e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=DC66tu63K5JfY2WZsL0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX2bxiJUEcac1U
 ZXZYSDaKpFZlYm4n1UHBs4rb+mwt5Mb5qsaOdimAw6a6vU+0fpARhjCoph+EY3SX+al2qGE+fjY
 0Ylq2Ho/J7finuijvSwfSQOpa3diljU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfXxXH8qY2xUl/k
 yC0JFxHB5ZVGDbEnadiKFad0kz5PBN1cFy0zgRsFr7/5FFlIxHYIpvPlQRrb+dy/mEeanrj+w6n
 +gsc6l4Ve/okX4fn3zODCkeeNFGYHnEMIbXD0R57S8Ul08HOK9TtlXbb28QdIbrh8i5jhNU7ueX
 aMRQJr3RVapi5ZmkDxwEltQZfKQWo3aaN4d+npt8LW8t/lL5iYC4K/mhRbg11OwvotSTDBlTclS
 WBBKjq1C7mgC5LwmycorZX6YYfAXkH3j0DaPJy0KezImC5oKflZTKKyyn3oHlhg0gNLZz35NLuk
 5LPif6nlPQQz+Gz2GfppLhoCO390GcGNwyYVPg77dWemSqdaGRF/AJF2eq0gpqbAyrLhSfIMhLO
 xCv3M9CyM2HtKVhqWgk+it0YAxvBV3rd42nZBOmQ8FoefGgN2rjr3tQdBjWhPrs5cHPSNA335ZP
 xtBDWO2+t4/dY8LHpkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060066

From: Gautam Gala <ggala@linux.ibm.com>

__do_essa() treated any negative return from dat_perform_essa() as the
normal "no CBRL entry appended" case and returned 0, so a page-table
walk failure silently dropped the addressing exception.

Return -PGM_ADDRESSING on a walk failure and inject the program
interrupt in __do_essa() for the -PGM_ADDRESSING return value.

DAT_WALK_ANY is required in the dat_entry_walk() call so that a GFN
backed by a large page (segment or region entry) does not return an
error: the walk stops early but succeeds, leaving ptep as NULL, which is
already handled by the existing "set exception state, return -1" path.
Without DAT_WALK_ANY such addresses would fall through to the new error
path and incorrectly inject PGM_ADDRESSING.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c  | 5 ++++-
 arch/s390/kvm/s390/priv.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index ff80d02c9f564..a2031aece4ed1 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -1084,6 +1084,7 @@ int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
  * * %1 if the page state has been altered and the page is to be added to the CBRL
  * * %0 if the page state has been altered, but the page is not to be added to the CBRL
  * * %-1 if the page state has not been altered and the page is not to be added to the CBRL
+ * * %PGM_ADDRESSING if the guest page-table walk failed
  */
 int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty)
 {
@@ -1092,7 +1093,9 @@ int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *stat
 	union pte *ptep;
 	int res = 0;
 
-	if (dat_entry_walk(NULL, gfn, asce, 0, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep)) {
+	if (dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep))
+		return PGM_ADDRESSING;
+	if (!ptep) {
 		*state = (union essa_state) { .exception = 1 };
 		return -1;
 	}
diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index 856939acf012f..b252c812dcbe7 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -1169,6 +1169,8 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
 	entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
 
 	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state, &dirtied);
+	if (nappended == PGM_ADDRESSING)
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 	vcpu->run->s.regs.gprs[r1] = state.val;
 	if (nappended < 0)
 		return 0;
-- 
2.53.0

