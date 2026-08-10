Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9232F76D;
	Mon, 10 Aug 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377266; cv=none; b=O5dbEzXoJZk06KeUFeNyO2uzc8RyA66BbaT0+tFu548nJzb3sTd4BukOEX7Dvgk9sDt+cBZ8YSXja79fR+loC9CLnOKYpFgCSianZG8AmBj70e3toZxC3bkuJYZI+l5ssUj7zQd1I3MdKBw7KIfq+uzFvVCMgpR+TNTws8Su9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377266; c=relaxed/simple;
	bh=CEk1YLxXIt80jAcUDclDk76mtkc7kWx0qW3TSMaCDto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iodTFnMPd8HEKKp9fUBhLoT06Tr02tj6vW4u4U2yQTTJC9ZXYzthp+VIk51qvrXaNDJpRzyDao+jpgxTE1pbKAli0uGhVNn5lix/9nJOJXdZnc28gBp9SkHahpQF9JQgMXopC0fZsAjwtxbQ977mra/Y2bgRkh26lwDkLUae37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C63uFc1o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C63uFc1o"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWVpI2062331;
	Mon, 10 Aug 2026 15:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y0upoM
	Cf5j6BEIBwMmxpzgZaZChlEJv1kuygYL/Hvak=; b=C63uFc1oLAM1F71TzaoD2i
	HLl7USliidAOQVA6fAw/QcAB8WV2u/cQohqFjrxaiBB51I1quyFM84dpaPrnmFu/
	bHeXpb88DqEU+Q3LQFA1v4KfwheKKEP1HZror2HDV3ZrZ1q1bLWole/kvUdvgdqi
	4lvcJc4fjFUPgoXju3yRveTpD7AuBNUJ4QjdLGoqab9LCvbgPZ0ERBVjRHn67HlS
	YQkHXNOYU7I3tNJ1FlucEOTTUWE230D5yIgbdDOp8fdUkm+T+tCHKr4PBHi6IyKQ
	wnm4y+p1ubWdhDHGUori93o2AD88snt5WKO8bKpjrrPt46nltGX0QlCTFUu6jbnw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw0dhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgYS8012261;
	Mon, 10 Aug 2026 15:54:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxw6qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsGxZ22151868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 936952004D;
	Mon, 10 Aug 2026 15:54:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF5A32004B;
	Mon, 10 Aug 2026 15:54:15 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:15 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:53:54 +0200
Subject: [PATCH v2 06/20] KVM: s390: vsie: Move pin/unpin guest page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-6-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2629;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=CEk1YLxXIt80jAcUDclDk76mtkc7kWx0qW3TSMaCDto=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVXxTZ2uvUWtsfzD82Naxmmeb2/u/bH8wUP6n1VPg6Q
 /G5l2LaHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEyEm52RYWGTZO+m9Z5XzeT/
 vM6d5xyQ1p1st+H5syWqqeGz1V+yyDP8FeDIfFN1N0+OSyNk3rVAKe653y/NNZ/86m6ybZ67fo8
 BPwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a79f42d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=PzVfekSpv1mMiI4dbA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MNKRAxCfJRBpS5K9f_mxfQfl49PQ3PlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX9HCnBzOELFRW
 CawYr0nrnT4Lpzj0dC5gsoV/G0SHFXzW8oNNyXbtqUWWvuRlX/+wKchKn31Le0AGYu5CsqVgv+l
 Zb/P9aSkhHYV6y8hkt947pISVfiUspyEc4RwJ9j/uIO9yBfQrZ8hPSLoRs/jtsQ/bcREMK7XJon
 iSsqI4mCldDuVm/4YVWHRGkVfwW8tNG6bVGdsBPsGCaiQsISxvYwZPny5TsKe3DqVI+g4lfr7wM
 FQf1DR5lBYrGVQ8h67S0iH1oWOK54YVDbN0mNETikppjdk88uP6DGjHgnGEBQmPoiQ4ZqMDkcOH
 XhujpDHHG7Nw7QjmIIxU7vcStH2O7AWiFlaRnOlVL/uXuZRzawnqr4GLWqlj2sjSNdTFHuaVCBO
 QgLy2QA3amHXKNMW9xPUjHKSTbXkfUCjcEX8IXopOr4l0e7ogg1RlvTexNN7xppzrc4PZ38Zvwk
 +hsAG6fQIpRB3+Y3v1A==
X-Proofpoint-ORIG-GUID: MNKRAxCfJRBpS5K9f_mxfQfl49PQ3PlK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX6lDnOTsRK0BC
 Aq/ntq048JdduQdWvb9agw2/lteirF+vH+bqisKeMgN4adkjc+kfxiNSS2HHV1IWIWIvEBK2MXM
 twaPPPpNaCegUXiWK0rfAGP3IDqgfgs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100134

Move {,un}pin_guest_page() up in preparation for the next patch.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 3f49d2e6986d..0e32d1543ae2 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -149,6 +149,32 @@ static int prefix_is_mapped(struct vsie_page *vsie_page)
 	return !(atomic_read(&vsie_page->scb_s.prog20) & PROG_REQUEST);
 }
 
+/*
+ * Pin the guest page given by gpa and set hpa to the pinned host address.
+ * Will always be pinned writable.
+ *
+ * Returns: - 0 on success
+ *          - -EINVAL if the gpa is not valid guest storage
+ */
+static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
+{
+	struct page *page;
+
+	page = gfn_to_page(kvm, gpa_to_gfn(gpa));
+	if (!page)
+		return -EINVAL;
+	*hpa = (hpa_t)page_to_phys(page) + (gpa & ~PAGE_MASK);
+	return 0;
+}
+
+/* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
+static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
+{
+	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
+	/* mark the page always as dirty for migration */
+	mark_page_dirty(kvm, gpa_to_gfn(gpa));
+}
+
 /* copy the updated intervention request bits into the shadow scb */
 static void update_intervention_requests(struct vsie_page *vsie_page)
 {
@@ -752,32 +778,6 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct
 	return rc;
 }
 
-/*
- * Pin the guest page given by gpa and set hpa to the pinned host address.
- * Will always be pinned writable.
- *
- * Returns: - 0 on success
- *          - -EINVAL if the gpa is not valid guest storage
- */
-static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
-{
-	struct page *page;
-
-	page = gfn_to_page(kvm, gpa_to_gfn(gpa));
-	if (!page)
-		return -EINVAL;
-	*hpa = (hpa_t)page_to_phys(page) + (gpa & ~PAGE_MASK);
-	return 0;
-}
-
-/* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
-static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
-{
-	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
-	/* mark the page always as dirty for migration */
-	mark_page_dirty(kvm, gpa_to_gfn(gpa));
-}
-
 /* unpin all blocks previously pinned by pin_blocks(), marking them dirty */
 static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {

-- 
2.55.0

