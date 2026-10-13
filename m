Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9351CF70;
	Tue, 13 Oct 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902559; cv=none; b=GFMkBpZD2w6/k3dWRyMDedEz9WpYY7QPGcdf3miFopJpWwA5OUBqporP4xIalAqdDi+Ni1UAiRJoGL208pAv3uF68muB46ihUUriXwLuLVkES++sDFULHbB0XKsmO7/JZbt8nFiJb25As5UGykam8CflfrtCt3F671MD9oKMCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902559; c=relaxed/simple;
	bh=UmpNNzUoQfS74SMmJ+UcweBXJ78ydkaMnPdMO3k/M0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ogss3jhTIlPPGSvu+xeHMBuHA2DwuTBm7G1QFcPx89J7Iw9zGpQGTNPWTdr0OtLhYfvKL2c72wx9NKFfnze9Vn0KIZZVVihQ3oTYmd7zOcgrS89JCjhzXrgcPpR9uJ1XbBlFebPOom/I3eaPLZiLWuZzE1nlMkE2VkMRu3MGfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VXuAxM9J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VXuAxM9J"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDh4w2728342;
	Tue, 13 Oct 2026 14:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MCJc6kbfImmOdEp6i
	HLu04Lnqa8MxTHLK/O1r9pHhFc=; b=VXuAxM9JDJq6gOoc2REj9Fdz4o0e032R9
	Pl75A1fRDqYm02JShTuUixXLgCbbfLz3r6F+UH5bRKSqgQC/hHTx+tplFp0bDfcR
	aJoggj6/wIpwRyOHAESLiZ7lAELp0IihWyHsJ5cdSyLvYr1IGJStPQSCfgDPl4Lt
	3CmFrj3bnjZOMFdrYzvT/TQPTRoeE4ahXlZDsLpM9PZQLZv/Z8eqlifKu5z5UqdZ
	HiBq9dQNkJGVmmW6b1EaaBFMBxWSeABNFBseqhoL/QH4wDx9tJ6ugMFCt/gsZpW5
	45AxJwMhYN7tuzmVO480JZ++YJ6JqCSbQVvPKwkTXEIxBrNdtLx9w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0ebh4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:42:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCPtJ42712831;
	Tue, 13 Oct 2026 14:42:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyj484-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:42:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DEgVnN31720090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 14:42:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A04BE5805D;
	Tue, 13 Oct 2026 14:42:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53C1F58068;
	Tue, 13 Oct 2026 14:42:29 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 14:42:29 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, pbonzini@redhat.com,
        seanjc@google.com, shuah@kernel.org
Subject: [PATCH 1/2] KVM: s390: fix ESSA addressing exception injection in migration mode
Date: Tue, 13 Oct 2026 16:42:24 +0200
Message-ID: <20261013144225.8885-2-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013144225.8885-1-ggala@linux.ibm.com>
References: <20261013144225.8885-1-ggala@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NiBTYWx0ZWRfX+IP7HLTE6zWo
 H0Etdoj2KUsgLVW84/qsFgKPYRR6+IFfgqufCm8rOU5Vf30OC4G3X/figGyVz+WQIbweRtWcK3c
 CVeiTsi9k9UOEhkuc6oXw6WNHDlry26CIhb/qQyCR9vkg1Tgf6kOeuysic/4VaQtVV5ub2Ab7Gq
 UW83kzHL2MbG+ezrzSTxwmiMWYis0tN2xcQrxaE0LXjAAbONWwquesXltU20RUecPrGGjETKZI6
 lkobpEDqYJk5DLQBRnVAj3N8varYOX3CJML9HdZaiA0SeQQ1cULrTQ1vFL96LpL47UICjvmDpUY
 XGpIvVcahzifq4BJR/RPrVCypUCsOxQCe++bT49P4EcLQHoNzi9jK0h6K52Ls/vMoIzff9k0BiI
 7hPxbDW71HJZeFL3CyPDHG9A1fhwiWAV4aU8ftYyEH658bvgexyoAcvUdgykuRmgq7qFj7CZMBB
 HeRtXkSFGCe5J8y0xng==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NiBTYWx0ZWRfX6y5S3bwV5fCH
 qK3ba/3CwfglWwnmuXggM04ZIJzywNJR2tVQbq9Sap+z0gO9oSPl0K49hSncJNfOTrZ3G4lGX5M
 tWx2iLBqhwC9iGyNxHWTSl2YDu2d1VY=
X-Proofpoint-ORIG-GUID: xpy5nsSEzaG2lej3zSrGR6Bdfaji44Gh
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace4359 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LGCGonwXZdm1f9Whz7oA:9
X-Proofpoint-GUID: jotDrcZZA2vxhp7cfK9XiX0SKfb83wHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130056

__do_essa() treated any negative return from dat_perform_essa() as the
normal "no CBRL entry appended" case and returned 0, so a page-table
walk failure silently dropped the addressing exception.

DAT_WALK_ANY is required in the dat_entry_walk() call so that a GFN
backed by a large page (segment or region entry) does not return an
error: the walk stops early but succeeds, leaving ptep as NULL, which is
already handled by the existing "set exception state, return -1" path.
Without DAT_WALK_ANY such addresses would fall through to the new error
path and incorrectly inject PGM_ADDRESSING.

Return -PGM_ADDRESSING on a walk failure and inject the program
interrupt in __do_essa() for the -PGM_ADDRESSING return value.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c  | 5 ++++-
 arch/s390/kvm/s390/priv.c | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index ff80d02c9f56..1bc6d2ec5b08 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -1084,6 +1084,7 @@ int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
  * * %1 if the page state has been altered and the page is to be added to the CBRL
  * * %0 if the page state has been altered, but the page is not to be added to the CBRL
  * * %-1 if the page state has not been altered and the page is not to be added to the CBRL
+ * * %-PGM_ADDRESSING if the guest page-table walk failed
  */
 int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty)
 {
@@ -1092,7 +1093,9 @@ int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *stat
 	union pte *ptep;
 	int res = 0;
 
-	if (dat_entry_walk(NULL, gfn, asce, 0, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep)) {
+	if (dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep))
+		return -PGM_ADDRESSING;
+	if (!ptep) {
 		*state = (union essa_state) { .exception = 1 };
 		return -1;
 	}
diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index b3cb2c2c3aa7..2abd1bdfdf32 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -1168,8 +1168,10 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
 	entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
 
 	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state, &dirtied);
+	if (nappended == -PGM_ADDRESSING)
+		return kvm_s390_inject_program_int(vcpu, -PGM_ADDRESSING);
 	vcpu->run->s.regs.gprs[r1] = state.val;
-	if (nappended < 0)
+	if (nappended == -1)
 		return 0;
 	/*
 	 * It is possible that all the normal 511 slots were full, in which case
-- 
2.55.0

