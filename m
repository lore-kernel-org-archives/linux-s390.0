Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71404FECD8;
	Fri, 18 Sep 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744185; cv=none; b=KRa5ZXIKvGRRNYJIUa6psj0R3AWe4xVyx91NayYUSvs+T7Smq/X5Q1LnDRSw6h2i2JsxGCRuXgsFOI9B5DFDVXE+g4vOVoQUykRq2ul2r0QKIuxM5glns+zNGDX82cplxb2do9KCqPRDgt13auKqgu+RmzzAvfBvcHrO8ck74Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744185; c=relaxed/simple;
	bh=JbCTY5czQ2lyFJx14YUcQENthF//u0ldeOm7ieGrhos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DO4K5olP5DM1EZyBpQGeh7AdUqVybV9+q478JtHSSXN1Uk5Bp5UbRVH7kR6BLhD1O5lU528Ghn3EBEo9cRK3+wxk/g4vAzvj/YovnnNkpZumcLzcwyKT71fD0ufE/TiYMbZsiTlbGWeKqcBMGeF2MH0cB4dOW2nTLDelzU9uZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gtvK3NiU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gtvK3NiU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVlOH1421480;
	Fri, 18 Sep 2026 15:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v0pp20
	kn0SiHTwWCMGbTWv1cUtU3AMO190DtcmeXBqo=; b=gtvK3NiUJf9NVV8i1IsOv+
	Hv2+gHLpbQh7YycF8oo6J2cQ/2Dlo/iTwzq2YmC7bthLeBtRD22C9O8OGMrYMRkO
	mpbRECHKH1FRf8uLyd4pP99OqxCerjiox1MyfEw5HbpIU9wULSIpkUOt1O9vggm6
	TdCE8AjQyw7Ag5q4ENm067hWp4OE57RNgarwuksHSw0+q47lhhi1GYFpThcrQtFd
	Lch8CAv7uzZv4HjUfQBY43p/duWqkQXgirmrHpnfpTxFXyHePShcPyEdVYUYv56b
	IKN57B5DHqccIWq6zHgyq+uLN/IMRzzsFfbR2+4HaYbgWiXCfrRSCRndo6qn4KMw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvg4v1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNtE9777365;
	Fri, 18 Sep 2026 15:09:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yxxr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9Qwh55706018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DFF420040;
	Fri, 18 Sep 2026 15:09:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDABF2004B;
	Fri, 18 Sep 2026 15:09:25 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:25 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:22 +0200
Subject: [PATCH v7 05/21] KVM: s390: vsie: Move pin/unpin guest page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-5-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=JbCTY5czQ2lyFJx14YUcQENthF//u0ldeOm7ieGrhos=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxRvT3ths76Wr6s2pMRW4+GKU1MTrr/89mZFi7jj2
 vuFDEbXOkpZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZhIuSgjw36RB2UH7LZO87+2
 1vVwxIfIyA3vf3/XjZE1vX1k/SWr2CBGhuaEdzz/7y0o/XgkjImt8+zSvrqMaY7BCta9xzKn2mX
 e5QAA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX5p/jm0WoqFQX
 tgXU2J7+jOkqXrwjHSMzugqFPUbEcowhXbZ3YtqMTjmPb/+DTBFVZjMaajHFWwOR5AGBLm9mcn1
 rR/SVORTLgNF5vmkAnB7AA56m5u2jsk=
X-Proofpoint-ORIG-GUID: qPMO8RjDrSG5qeUm-ufJMOT2fkAZpxJz
X-Proofpoint-GUID: eX3n-deiZ43ZAfBtGJZdLW14QcZ2B5ce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXwl6LNzm8bzBw
 zBixmbSPGzEqupUt9GRHtp0W+aNlssZltAiGOBKxNxN6JnC0l09f4LBvaIA0d0EEiDE/3xu6DVG
 vgGbXKqH/esbsJqTxd6g5NLzR1JNpJWl8vKbmXnCTZESZL8mH3SvshbIQEK0xnZcxNWgXMyzyBA
 RYwJjLXy6bXNo9u/Cf+Uj1bG0TGSBZpL+eiKQQZa/vRQCRFCjid+XFkuZVsV709IP+Mrs6X0Chd
 kfiPcNbRLPul4sveS/LavNo+SjBPoLUZJd27JxmGhetglXe+wgTHimDBUM8ZarF0Bxv8/BVGpcl
 YX9IvPX3dggY3fXbiOibH+kjG4XqDea9WksAEitqv9KTo3rxjToZLsiG3zRkC9zApnn/PNYI/PT
 DAWv5tQUJSfJ9zpyOWULdkcpgOKqBWZjsvszqajbOR9tpj7Zh/fWVpAbuHO2QeEY/KZwxzvdoWp
 bgKbgA7+AIqRagB2rHA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad542b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=PzVfekSpv1mMiI4dbA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

Move {,un}pin_guest_page() up in preparation for the next patches to
avoid having to resort to forward declarations later on.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 52 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 04cb38aad33c..e867d96917dd 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
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
@@ -720,32 +746,6 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct
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

