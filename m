Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BF3F9A12;
	Wed, 26 Aug 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756727; cv=none; b=NjXtoNBIveHxXWGiTIT6Zn7fIHGJmfIGvNASRLmjV3e0fH8jpCLcoaKl/m26mgj7A91AAnt5Omz/cvurkh24H+8JC/X5xWLL2Rw7S2SHCkLRIqjOqL+buIeAXSd8YQVpuNBZM4pbOX4k7HReNCB/SR64D8I6CRv5SSjPdM63RjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756727; c=relaxed/simple;
	bh=pv23s7eg4VCeiAZxy8aJaqVYnlXsMEqvKuhSWy10NkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZapGva/SbKCRS+v/TGt9LTPXYjEtEQhjok8gKCQIniqIFvgUhTd+u/jhCj1c9BECKRa5mIqG+Hc6qffmShsWHj8jeRjGbTeKjSFz0IU/6uqO4rNHOgCkI7DHLTGGRhcD5Oib5pdZY6tJyT35EK5C0EwUYm6SA5fC+Y90BUm7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=me9UpQ0S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="me9UpQ0S"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1ZgY2333854;
	Wed, 26 Aug 2026 15:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GJO6uB
	IZfuzTXKTpIIF8KxmB96batrTQ72bc7rvet0o=; b=me9UpQ0Sj51SJUpGhn7qez
	Xx7tLjdeRpVmN+mofT6RL4zFI+N/yOy1CRhdoVnFg8dNjvf/CdAXz0NGfbBD8Cd5
	+hX2h6MdYDHD9y+9j1qDBgOVGm3Zc/5hIcYMxpr9/st980/X7OWTPqm3eF0XGXp+
	ILq+eWdCGCxv7LZrEo37Irc/9j482jAJDiHX2/aeL2M6ue7bApOc7RCpfESBwCm3
	wi2rCPZlFjl7Wsg5Vokq/bS6d84GXYfXE+20kpFh7SzF/wDAYdzDzpeID4BYvitg
	7BgwVAffA8OzA1YZHtCKRSAWFNwhpeSHWFX6HMVIWC9584lYhP74AroBJLmgzH/w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqycfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuRpE000780;
	Wed, 26 Aug 2026 15:05:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragjedg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5ILn33292780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA85020040;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD0E82004B;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:07 +0200
Subject: [PATCH v5 05/21] KVM: s390: vsie: Move pin/unpin guest page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-5-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=pv23s7eg4VCeiAZxy8aJaqVYnlXsMEqvKuhSWy10NkE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKsir1//+0Epj+fBJMUF24+9l2y/OveNYdTpJB2Ti
 N2VF16EdZSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCR3VMZ/gdJLKrqdY9/MOtS
 TY9UUdVr2bVGezr+aH/dfn7G2tz/xyQYGfp/LDk288nEY/F5La+eBPFV3P/zoPLE0qcfv3hLbOn
 ZtYIbAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bQ0Rtrlt8K5vGGSLn_MpPfmVEL3A8mTk
X-Proofpoint-ORIG-GUID: PAZz3c5iykNWwPed90JkAwXPbAwoiKuq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX0+UPlOQHADsz
 4N7tKE6dU8NjB3gDGLoJFg6grh3bsAZN6xv903PaoGt4RSn3GyDDFXi3Y0Jb25ifXjsk1cZvUHT
 eJuRgUC15F32aSr9ihTLz4fHJJh/2o4O8BByvn3eNeLdKLLAst6w0vyDsWeucDw16pT2PtsA1Nb
 d7sKzRMlysITBtqqEdOYF7L3A1EEn/kcS0cCqqshRUr/WPd5vlhWVPG9ZF1VEe98dfd8PDzX1++
 dbA4/8hOE9s7zuq8gx6GjeD6j0P013ssow9ndnVC86CamrJM4QE+bqFs4OwzHSJPqyMJV7rTanG
 KBfzLOPOaFoEXIFPYW5ENtz33Yfe7VTrLAHGIRK4dRUaLW7V6Y0jGmyXPySccjfj+nn2YGFsRFT
 U3YgWWfnVAcCHeH+QAfYZj7eVkTXAWfJKKGjXksrBCAKcSiij8Uellpybk5bGnVpxVNKO4HCAI6
 S9uk5g1a6ELk1U3ewjA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f00b2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=PzVfekSpv1mMiI4dbA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX6zYC6U7myIxS
 RqEEl6GV73M9puUnFfhVD7zZeD2nSm3ccd61rFE3HNSFfcktWc4E6Rt6Y9cNRpXw2Dho0SLM0qU
 5l5lyRgGRzH7cN+63cHeJoFvY2QxgZE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

Move {,un}pin_guest_page() up in preparation for the next patch.
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

