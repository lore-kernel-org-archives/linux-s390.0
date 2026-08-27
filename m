Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94208486637;
	Thu, 27 Aug 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845987; cv=none; b=HQDSWczq7/SBz0crPYhU6MKx3ALrOM1SneD6flL4HpiI9xwZVgDqhlC90N040juApEU2UQGwA11FPQfgp6psv+tKyJsRD976PYrmnCugfoObsU36//W2WaSSt9QCJ0LRD30O+YVEYeid7HZ2Aiz3VkKUHD9XdLFDhxxLkiLF2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845987; c=relaxed/simple;
	bh=pv23s7eg4VCeiAZxy8aJaqVYnlXsMEqvKuhSWy10NkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jGLuwudk2PQshgyBRUV/kQEnjWLZinRlcU/3NlTjZXmJa2MFHd6l6UMhlx5OrGEqEqSyXxKu4D5QEhtFF6ZPyAm557OoiSXiyIef/Nytw8navszeXSLQ3732esPcUUMqHNhaLg9UR3rljxRFknuxMzIRIfaxB8lLpMYDsCvRG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LKAJDICL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LKAJDICL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF5CJi3329061;
	Thu, 27 Aug 2026 15:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GJO6uB
	IZfuzTXKTpIIF8KxmB96batrTQ72bc7rvet0o=; b=LKAJDICL9sMZ16N/OgZb+L
	DK9XYGe7UO3gU+WHRh9kOoKg+WKdbe4lPlzls6JepjlcRSdE5u3RkVkwo6//NEUm
	qAq356PopA1ntjka2/iwBkvNUsGnoiw6W8VvHjIlYd0ezyjv1RxovMZzg4vka+xZ
	mBVI+Z37oDDCmSs1fQhVLSXHHStNH8ulbS5jLWpE0H366e6MVqna3RI/Uz/A8XV9
	JFaFpdWWbMbsTxISh2VTNY2mYhFbwIBSK95uFTzdNyMCqMiedS2wcdEj/UaeIUoi
	LH07bVo0kJDnc4Kp3vbJ3TSFe05FI0tt3GWFIO3mpamTrSb+faGsxJJSFlu+dDEA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394eeeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFffmj026747;
	Thu, 27 Aug 2026 15:53:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qh4a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFqwfp51249508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:52:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E382420040;
	Thu, 27 Aug 2026 15:52:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3254B2004E;
	Thu, 27 Aug 2026 15:52:57 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:52:57 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:45 +0200
Subject: [PATCH v6 05/21] KVM: s390: vsie: Move pin/unpin guest page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-5-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoMe/mn4c/o+Z1fSnWc/RKfHrp43iVWysIFRTrg9U
 kq5L+5tRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABO5+IyR4YO4/3qbBt3t/DGx
 Et+tzk6/9ao047pt9PpbH3Z/zf4Wu4vhv0f0JEXB6+l9rzYfMrpw75VxasJO9Wu3zmTprPlQV7d
 3NT8A
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1qGrd9K4AQNMBh6Fm7l1VVyEsdT34mrH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX1tUqmn70u2iH
 JUW0jIDnSKKgQ7I9b/Gi73LMfXZjZzq9GYv6w1whbvHBi0UwzfwTxPlYES1KXpn35noocqYdE9S
 EwEnGQyf3O6FSbqt9n5UOrjaiOln9dencsOjs5ssH9Fb/Sb7p4TW3HO7e0bcyqem0OT3497O+un
 jnUlXB0SmJuDmP7L3f3uho8Di+09E+ctzSA0Olpiqj06KHZYfi0jqnybsL++szJKUi5bKnMlqWg
 CckZ40YBiHvy1UnLFjyMj30PLwdlQodxHiZtpytnQzQ2efRqasKKnjenEimIJn+NxC8vqL5Iqb3
 Xhq+8o/AAFOQDr0WfhodPN6qBcaoVALCIw1ZMrCqz3YvszCbzvpvxGop923Leumi1uWYLqUB3KR
 fXNQeKWE8tE8n6iEnhQB/SqZN4UQReCelvkYALLVQgZQ+cGscy9yoJ/eLzkkzXuwYbL1wutQjq2
 Aj+4M/NEsO6XD3wNlVQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a905d5e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=PzVfekSpv1mMiI4dbA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX8riZo297X/O7
 +bH0VmwGNEPlCzTYbnxDTvJPp0ulfZTOUhgdAFYmrQ4aNCGu66D0DIKYRsGvBf4gN2I01Yq5SUv
 WsTaMmEQYtqBrXZ/GXggD2VoFaMXdTs=
X-Proofpoint-ORIG-GUID: 5vti7Fl-7JRtsuqRfbH42v4US3ws2pCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

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

