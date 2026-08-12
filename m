Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9146372ECB;
	Wed, 12 Aug 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542768; cv=none; b=aYu0M8jFio9p3BtzI54jPry541voMruB/Iiq9JFW5C9xAmisW0XTlevq/CgwLYAw8q62Svnrmin3Ay9qRqL2U97LbHX4gUFqZbAY+oaLlGvDjMEuMCDDGcbmnzcalSc2E189OOpEhySWDdQMCnnldW9HB9GZR2e7Z1KEuaRGkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542768; c=relaxed/simple;
	bh=OhqqgBAh9sjJCKT3+kYEpB1hj3kGIJBEE12R3D0kmg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9yIMcRgatpvJ4BDnYYUC2doRFxFUm6RSvNrwbUebUS2ndz/bv9UGoP7zhu8EnhU8xR7xN8Kmwmvctxeu7iJ0sAa1PP2ICeNLX7GisX/Vee6VeM/fy2rM5QmP0oBRdPCilUYJmFO1ygz4QxiS9mkz96PgrvQdFgeE9VejdeREFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C9++L3oB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C9++L3oB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3mHP3214486;
	Wed, 12 Aug 2026 13:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xImHKF
	5bvSefZqko8BmC6jpda23+y4Gr63tO4oa5XAM=; b=C9++L3oBzwTpcaTmgiWS/i
	FKOH2FqKmCeekwTPnf6qrrN40NaxXNoXKfqVerHL5NnZi7z+MABIAqH7DwXebU6v
	pR/0h7v7MvyY9OinCs1+1ogtxYu9ZGcwBdVsaN5D9Br559uECCEmoFwnvR/YXlMb
	gFuAbHHOP8mqmf5k0k2BhuFhlG+Q1GB1qb8ezNniTERgFdHmOq2eEe0UK+bAZsTF
	oFXKIGK9gK+4LORpstx146H6yQZ89XBV1P0xUeO2FjM699QCF7rItGwkULwaAg0x
	e66cFbn+HGCmxljY4e0vOV2n4WgnKVi9f9cGaIou3ClHBN0/Zth1A5/fbwx0Kn3Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31wqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfbY5009795;
	Wed, 12 Aug 2026 13:52:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6dm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqc0433947972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AFE92004D;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D203520040;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:35 +0200
Subject: [PATCH v4 06/20] KVM: s390: vsie: Move pin/unpin guest page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-6-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2630;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=OhqqgBAh9sjJCKT3+kYEpB1hj3kGIJBEE12R3D0kmg8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYsU2C9JaF/UveDfrZU6oc9OLY85y/OwS9eBd96hD
 d/b3zt0lLIwiHExyIopslSLW+dV9bUunXPQ8hrMHFYmkCEMXJwCMBExNUaG71HT0rz75q7ZWmvK
 XZTC5/NJJn3Gy4VMj/iPVL77u/p1LyPDA+ufceLJCvPad+WeP3F4fY5iiMWO97a6JSdkg89GX/X
 gBgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c7aaa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=PzVfekSpv1mMiI4dbA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XSPFNjpM5D7XCZO0tbfL9GLMXt4MbJvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX6SH8Bqb+Aiki
 NMk1Lm1bpHI8bFQ2lw1ppK7vTWPH0s0yH1utyBMbefid8cDB6XftfbAuSTgELeKH6NoxaOnBgDy
 4GpGuBSRzpr4LY5YQzOViA0BE57FdY/w5jf2QWtUZkRKfhNnH4cmwfAFK+ToF80Xy00+xsgnl45
 B1Xrm1wFVnQB0lrCgLzh7tvX10+UZTBsmJx39Kysj2sbLgMOETGfVAcKsRc50IMzFqd3remziUu
 NDMVx/ylb7h3K2m4yOm+LPpGb8vxQcFBtLjPUjmmSA9GCfiomOWGwSBJ9hRbWjyr6AI0zSgT16w
 hIeHXggYPSReHYzaMNkhcdQREjTlYZZFvIlCISEW8/u5+o5+EoaP5MYUYO0KScLSk5UEsahsiV5
 uNBfurQ1rgtuVwEWnS3qn7WvL7AgVFwqbsNkHp1PJbhGYc7+FcU8N+i2302/L8EgrsUGdNPGe52
 lZpyIKkTyS0SYU8pHuw==
X-Proofpoint-ORIG-GUID: XSPFNjpM5D7XCZO0tbfL9GLMXt4MbJvr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX9wkwnrxsIp/1
 QqUn2DJrFhgylspWA1boINrjUElsm6vGibLnNfUt6/HR6SN05dpJCIKTvvpu279j83WNBGsVHyr
 SZhJoA0A70fcy0o6/I43yKjrVrPbHlM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

Move {,un}pin_guest_page() up in preparation for the next patch.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4b67bde0535f..1b4f6b1691a2 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -150,6 +150,32 @@ static int prefix_is_mapped(struct vsie_page *vsie_page)
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
@@ -753,32 +779,6 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct
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
-	kvm_release_page_dirty(pfn_to_page(hpa >> PAGE_SHIFT));
-	/* mark the page always as dirty for migration */
-	mark_page_dirty(kvm, gpa_to_gfn(gpa));
-}
-
 /* unpin all blocks previously pinned by pin_blocks(), marking them dirty */
 static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {

-- 
2.55.0

