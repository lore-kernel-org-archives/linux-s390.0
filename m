Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4D5012A1;
	Fri, 18 Sep 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744186; cv=none; b=fAlWcscrB9qfXoPP9wGNRV0Y8GEiOn9QYEYKQ6U5YQ++WiIt/30/vYTVzufHX/FXiTjOZ3mbO5lD6DglU6ZB17pO+1vMBNaIhwc0HX5Zw09eni2C5SspHpJ7SY6zSct/JbGvi/JAzhfnYhgoJ6THh7oB6AIbtBPsXiyF8Kkre1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744186; c=relaxed/simple;
	bh=TtM9kwrMMKoyaR+diDWUh2KMBBs8pgGpHrGXHDm+kHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=druHcneENF+TRmHCwWGvIfn2XdMBLfYXxiZGd4JkHh8Kdnk+vcADUGmKiFeqSgkb9ggdzO1pY6M4ggaRIKstRpz80IQtH7bW8g1H7y7FlvzCVfrh9stD2WR2zsH9utSCCpf9v0Wa+t0FNInKCbveehH9fR6WjFzRO+inJAmMyyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WzGNAoQ1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WzGNAoQ1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVZ9u1421217;
	Fri, 18 Sep 2026 15:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=efA7ye
	nfnlaL35r8RFkn+CXDO+qHGWhy9Bn+6UuhEMU=; b=WzGNAoQ1qJ+xCGzhD+YXe3
	L9hFdd/8RtrFKDV5kAmI9bhzt2kru//jsG9ilZ9rnsaMeDprVGg9v/PdEpvnzfHb
	05zNKOUHnQtjHNPZl3VtoxY8VgaQwm2KXebDlfriFfZHKbXxF/ZKZqtqSabXY+mj
	kS3jqfIgcSuiDoUCQngOjZg7DFtKi/ClO/HmQpVSQJuBn5+ABibphtkA/R1ygJar
	PntbOdYnwUnLlLjFou3ATtSD3Azca7aziWJ2nlNyYKkG/YSjx9b5eKi2B29RtwRR
	nZD93rNX+M2h2JgWwOTOjWU+BFrpIgqW6iq8JZq0wXMotbWzl5N6W0h/XSgpUwvg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvg4vt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDOF8f739719;
	Fri, 18 Sep 2026 15:09:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q8m9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9VPJ32244312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3590B20040;
	Fri, 18 Sep 2026 15:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3C5E20043;
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:31 +0200
Subject: [PATCH v7 14/21] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-14-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=TtM9kwrMMKoyaR+diDWUh2KMBBs8pgGpHrGXHDm+kHI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQ5T0X9hX9lc+qvy7I8jUjyth5sRvFzbO/vlUccWzl
 bk9qUHTO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZhIUBnDP929umeMbu6YUnRD
 aufLpAivm4p9Ur3bt8+2SjBI9vzKt5yR4d30iWInYqrlhd2DuxewZn7YmCPt9GT9njO7GsPrjcK
 /8AIA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXy9U7tQ0p0xL2
 Fz38m0eipnGobWscoG3Xy93G09uwa9D569vSNYhVIpd1gvllpMFejEnaEr6kLTXhT4v37zk74TH
 X+1D7BSJNWcj03+8OATh4AhgrE7/n2k=
X-Proofpoint-ORIG-GUID: tAh0tAcL9UnMyVVaq11GWe6OFItnYqiF
X-Proofpoint-GUID: 1AST3oevkjeQ5Dj52xXZm24HAnKZH_J-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX910iu4vj0Bfd
 vNH8f2xibEbU44BixWr9qR5fuXXIbJdfEjgSjThxAFtFEC5iL43ZPcM7VY5J8Ve6afEYRJPdB7G
 X3aI7wpaleaGTJoY6J9QnMO5TeV/xpeHS/oYHQmNnUCSxJCwK6FcCE1kccMNGlvYSkQmrPecHlf
 m9jv3HSZ3i0ez3FiLWworTCVTdoJYIf9ohFaLAGi5bzQccB1KDerkpEbXA0Vucn0PVgzFFqF/dE
 5j5Of2qL4z7z8p01IMNMD6bi5WIiAgv3V3PohniO9A0leeUTte7G3UG5eEXJlsgOM86CgsXh20L
 8mtCNXV+Qu2YV5CbMVdwUWiobD4b3eQV68XCmgrG0n+E/jMATWL2aeqfh/LFvZLswXc6L+SKUpW
 t/jfDlHv5Pw89QqX2wzl7Ns5GyCsfLTg3grBoHy8clykL46qj/v/i1MTlsLcQ8KZlyaOu/NkD/m
 L4aTnemzds1aQKILQrQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad5430 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=b1Ck5HAT0Q-BmxMTSzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

To handle vSIE configurations with an ssca we need to pin and unpin
multiple consecutive guest-2 pages in guest-1. As these might not be
consecutive in guest-1 it is necessary to iterate over all pages and
store guest and host addresses for later use.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 1b88470efd4a..fa43b6c46bbb 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -71,6 +71,11 @@ static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
 static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
 
+struct kvm_address_pair {
+	gpa_t gpa;
+	hpa_t hpa;
+};
+
 static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
 {
 	return (scb->ecb2 & ECB2_ESCA);
@@ -251,6 +256,46 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
 	mark_page_dirty(kvm, gpa_to_gfn(gpa));
 }
 
+/* unpin multiple guest pages pinned with pin_guest_pages() */
+static void unpin_guest_pages(struct kvm *kvm, struct kvm_address_pair *addr, unsigned int nr_pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		unpin_guest_page(kvm, addr[i].gpa, addr[i].hpa);
+		addr[i].gpa = 0;
+		addr[i].hpa = 0;
+	}
+}
+
+/*
+ * pin nr_pages consecutive guest pages
+ */
+static int pin_guest_pages(struct kvm *kvm, gpa_t gpa, unsigned int nr_pages,
+			   struct kvm_address_pair *addr, unsigned int *nr_pages_pinned)
+{
+	int rc = 0, i;
+	hpa_t hpa;
+
+	gpa = gpa & PAGE_MASK;
+
+	/* the guest pages may not be mapped continuously, so pin each page */
+	for (i = 0; i < nr_pages; i++) {
+		rc = pin_guest_page(kvm, gpa + PAGE_SIZE * i, &hpa);
+		if (rc)
+			goto err;
+		addr[i].gpa = gpa + PAGE_SIZE * i;
+		addr[i].hpa = hpa;
+	}
+	*nr_pages_pinned = i;
+	return rc;
+
+err:
+	unpin_guest_pages(kvm, addr, i);
+	*nr_pages_pinned = 0;
+	return rc;
+}
+
 /* copy the updated intervention request bits into the shadow scb */
 static void update_intervention_requests(struct vsie_page *vsie_page)
 {

-- 
2.55.0

