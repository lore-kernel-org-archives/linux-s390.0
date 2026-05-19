Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA66285CAE;
	Tue, 19 May 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202890; cv=none; b=Gkbuzp7ens0ffyQk5m4YCKiE4KTZ/Ws3xg9WaZMrD7F125aQTpjFao4lVflZ8awYncTbHNeOB1LF1061qv827Z6ImXj3HSC8/87JqWhEmAPHGrODX7aEzAHyswXKZjxMwX76p2YG1pOAYKSX7QSLAQy9DbKSeINdDWeUx6kGXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202890; c=relaxed/simple;
	bh=ALHQde3U7IVE1BgyM8621ByC6ddedcm7bj4fBqbDPhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psyAOHLokXrt1F+thzxWKTMsOE35sng3CnlQtdwBDRLJ5wknehdSaNtPvU2U4zGk48yvRw7Txv567PWvRijZUWskr7t3jdBvvfAFH+GH7rOp0HcgIz+ZEEF0fsgsxkqBdLwAyx7leMG72fR377YzfmRaghMfDaDexYjSD2CNMnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q7UvMHoz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q7UvMHoz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JDvHDE271835;
	Tue, 19 May 2026 15:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6rUCIuXRXlLw/gdce
	ueh+k0Ky52YQVxJofA29xD3VUQ=; b=q7UvMHozaKFrdRUiu5Dw6rZmM4UHV4Rrh
	hGjMVHaFzHeVySW6YpJHOiHYCRyuLsHo4fttPen1PBtFQITOn0VPeWus3jNyAEMj
	DzHCrv8Pl4f+IvI/Fe2ZviCpYF/1r8MLUCXMutkLIVe3i2+umzlG46Qv7ifHmPXC
	eMCLsqHysgDX4dwUYUC23QDemvtN2X0UOm6N59uSJ41yrf7afUPtIY8WXPmVU5oo
	+W6x2SXl6jtsHKAEQw05ogE4BSkZ2+sRg9+SY5ybyqR1xYu91OjfJn+lRq5NbziD
	cG2snmE3OO7RBYuBW2+gEjBtv3tdtJaMLH64rdjh15tN7Grg0AMWg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74wmyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JEsA5M030825;
	Tue, 19 May 2026 15:01:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky2vrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JF1HBB21430672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:01:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8811E2004B;
	Tue, 19 May 2026 15:01:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD92A2004D;
	Tue, 19 May 2026 15:01:16 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 15:01:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 2/5] KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
Date: Tue, 19 May 2026 17:01:11 +0200
Message-ID: <20260519150114.264309-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519150114.264309-1-imbrenda@linux.ibm.com>
References: <20260519150114.264309-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0c7b44 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=EVFxPqBYVl373qEVmGMA:9
X-Proofpoint-ORIG-GUID: 8UMwlNd-pdkjor2uWj2uyiLZyUULqsKL
X-Proofpoint-GUID: 8UMwlNd-pdkjor2uWj2uyiLZyUULqsKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0NSBTYWx0ZWRfX53d1jpwgwcfQ
 qWxrtOMDCrWem2LwDti0e1DGtQJynzYulEfwDaq4qTyrdXLX5iqODP6lKv+nqrvkrHfsDjqfLBh
 BgcGcZbEuE4vczIn6URemJGNqF0/WXruMwzmSOCTuPutCe6x7pI98BXe4U97ZZ8zGbdoBI5rqhQ
 l89gaz4sefZBhAk92DmHdouTqiVQhtCnfv+UWCUHVibUc4kAMinUUiXJThJmuvS6AlB47Rlp4pM
 FH2P2ev810mAGWej1ERYD2Vtyzd8tTm077ycS5KSrJgaRmRnDvzcBA2sBybwcY99qXOapKyYgDq
 dkI7MzRdmB+G60N2Q/aZPmUHj/8DRsA2n2ScDrEFqBqQwyjbQ87cAqc2RFWaTzHXDVJR2p3POnE
 A07RlRZy8hXd5Ir6yjP2UrizHIrgfsuxVmqa3ZDYhuw4WQZHvXtdbz9gPLp9S1wgSUnQ2QOxdSQ
 f/BxIt2hovMsomGeKvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190145

Fix a memory leak that can happen if gmap_ucas_map_one() or
kvm_s390_mmu_cache_topup() return error values.

Also fix a similar issue in gmap_set_limit().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reported-by: Jiaxin Fan <jiaxin.fan@ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index fd1927761980..10c98c8cc1d8 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -125,7 +125,7 @@ struct gmap *gmap_new_child(struct gmap *parent, gfn_t limit)
 
 int gmap_set_limit(struct gmap *gmap, gfn_t limit)
 {
-	struct kvm_s390_mmu_cache *mc;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
 	int rc, type;
 
 	type = gmap_limit_to_type(limit);
@@ -142,7 +142,6 @@ int gmap_set_limit(struct gmap *gmap, gfn_t limit)
 			rc = dat_set_asce_limit(mc, &gmap->asce, type);
 	} while (rc == -ENOMEM);
 
-	kvm_s390_free_mmu_cache(mc);
 	return 0;
 }
 
@@ -822,8 +821,8 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
 
 int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long count)
 {
-	struct kvm_s390_mmu_cache *mc;
-	int rc;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	int rc = 0;
 
 	mc = kvm_s390_new_mmu_cache();
 	if (!mc)
-- 
2.54.0

