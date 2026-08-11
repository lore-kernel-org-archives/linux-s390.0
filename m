Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE69442B0E;
	Tue, 11 Aug 2026 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455423; cv=none; b=gaHqGQuGgPqbX+EyqbPg+Zer+kVQdYXS9i9tTSx1FDltKYwd+v1/4Tq3DtAJVeW9nnTMoZ8F5Eaj/ptPf0tGUFhFC/DhMhZlCLkl5tnJGS4wL3WgCPlQdrJhUVqWwwPxGg9W+f+hisSrfbkG36ukZyvkprwE/ALUYsCMVBcR+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455423; c=relaxed/simple;
	bh=zuthN6HjS/AiOUi4lIU3gHsB3uC9c93aISi2xPp39FM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPxDlBzc964mV/Ghd3LjtN9Y28ViLsUwqmAaybJtIPVYijgLa71XzuuO4v9Dd5SaYYmDTlXWbGxWMffSROALRkJbv8u6RAJ7+Pgw6aWWl3rOQsFdWtUohyGEvaQgLp4/Z6sT/2IHk+CPVfvL9e9k6XOtviNBxJFIgpyGUsNqIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MyFXIlS0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MyFXIlS0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWWUA537752;
	Tue, 11 Aug 2026 13:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=70V3WW
	fFUp9pdvJCairBkrfVQKtr/niU+0TPeCngX4c=; b=MyFXIlS0j5EhmJyRCPxuY9
	E9SlNAqMyJGIcIH0hQHmnlKRHYwNN7RcFsIJD5jbf5w8xI/W9oJYFMgG0FL5XvSt
	o8fWMIUuxwcNrMifRCeIwnoi8XRcmEA2sTUTn3HCM1FksNzvRr6KMNl6Fi6CCEav
	krbe5HkePSsZGJOmB8WQGJ8aT+LA8K1rT0ICBmZM3FBGZHa2WRgX/02CfyGYs/bP
	p2KCHjQfbqfoGDRTqY8cPRDn9Xt5Te8fTI1UStev4uFHsJ0Gked/2OF3ZjwC1uwX
	Pmaf8LFMIm7fWoluN0D+3j37Hd1Jj2piHfDz4TwKIsJzEPh1LXjXO9NzUxUmwtOA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9n5mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQKGf025619;
	Tue, 11 Aug 2026 13:36:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy0vb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDaZxX51315132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D3132004F;
	Tue, 11 Aug 2026 13:36:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B57120043;
	Tue, 11 Aug 2026 13:36:34 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:34 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:25 +0200
Subject: [PATCH v3 10/20] KVM: s390: vsie: Add helper to release gmap
 shadow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-10-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=zuthN6HjS/AiOUi4lIU3gHsB3uC9c93aISi2xPp39FM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqlFSMZOsXndYnf5/Od68LPJCj8jUW0Huis8Z55xMu
 TuvfyZTRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABO5e5qR4dIlpR1Xv7t4MV2X
 qH6VZr7t0W7/UwpiEUKdLkkfp265X8vIsLdy79HACs8A7oyOrmjTF2+ctN5O4Nk1vYbLt1n63YI
 aTgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX1Y4UquhWHd9+
 OGm5W4/VFQbB0GXiBM7sdzAFYc+n6/OJRoFoXhTlw0yeZdwMhY22j826u0ypA6MLIcvsstXWMED
 2v52/Bjb6MTbymc8s03lcNQoy8om3yHWLpNrPN/S/KLNGDPpuSrdp2KfFANwQ9E0GPme1Vc+oe+
 YENO7LD2KGJ84c2fNcjOXaZzwl9my5he6BOgRbQi8Se4Ii4XG77GjOKiR7Qxy9fH1nM5cyWHb3a
 mFeUgR1Xd0yjBlRPkWL1H34tanZMdijfdi0QVbeCBV3y4mzM5MfECzdC3/5vr2G+TfqZNH6L+MH
 sINFo5cSNqthdE6gg6dJb+hr951uLZPO9o25yOjzrrSJ6RfVTne9Vp4NzDf0pHfvHObCRWisW6R
 DpQvoRfsFiCvB6+e89k57Yz5eEK03mey9R6QOMrG83jgDQYR9dQgDI5CmrYxthrin28j4MHohqu
 PrOyxXwSqgnandDtKdQ==
X-Proofpoint-ORIG-GUID: emM6S-PBxnhSQnab30iu2Sv7GctyMbm8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfXwlNzSAfQylnR
 k+Tgq99x5SsNKYD7OvVSy8BwRH4/ZJ33VM4OdNGz5JHG1nUrvkTU129T6RFk9+fwBBPiWAQCo5C
 d0KDX18m3GHbVzcd4KpGUZ+0q9KlI08=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b2568 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=520cwpyMf__qVmlIlYMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: emM6S-PBxnhSQnab30iu2Sv7GctyMbm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110113

Create a helper method release_gmap_shadow_safe() to simplify releasing
the gmap shadow of a vsie_page.
Will be called from multiple places in upcoming patches.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 6bde6a3ee850..d0806871885c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -164,6 +164,15 @@ static void release_gmap_shadow(struct vsie_page *vsie_page)
 	}
 }
 
+static void release_gmap_shadow_safe(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	if (vsie_page->gmap_cache.gmap) {
+		guard(spinlock)(&kvm->arch.gmap->children_lock);
+		if (vsie_page->gmap_cache.gmap)
+			release_gmap_shadow(vsie_page);
+	}
+}
+
 static struct gmap *acquire_gmap_shadow(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	union ctlreg0 cr0;
@@ -1585,11 +1594,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
-	if (vsie_page->gmap_cache.gmap) {
-		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
-			if (vsie_page->gmap_cache.gmap)
-				release_gmap_shadow(vsie_page);
-	}
+	release_gmap_shadow_safe(kvm, vsie_page);
 	prefix_unmapped(vsie_page);
 	vsie_page->fault_addr = 0;
 	vsie_page->scb_s.ihcpu = 0xffffU;

-- 
2.55.0

