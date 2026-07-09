Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67C370AE7;
	Thu,  9 Jul 2026 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610136; cv=none; b=Fii6//vo05SN5vVNSKb/tmYeDyD3Y2ZQsH/17XLMQ7CcBYiuvM/bPci+hKpErJh4bS+T7V6Crjc8tXAmfIyVN/Glalk8thy9J1ZI+M1HfupvxJLUnn35Ca+R1hJfXA58HoNw55NAdvuG/hDygQB1+l/8yU0yVAaQ3RQzbTS2yWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610136; c=relaxed/simple;
	bh=Y8DJsdmLMyvu5cHoe7NIxkrDtykYXEo8c3dEQUd1s2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCkaDlQrIaE5FMiqdmvm26sXizJm0sVv5MpPrm80LHGuzOGRTGN/myfaxPedFqEN553uHPUdeTq2auRmEX1Gu2ae6fkUAOi0CucAvphaJF0XIQcdoK9rj/wtGxEomZZYAb3U2AJZN5FaGWDY8AwfOYJHQ9Rz9ETNLjU+YK88SRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jnVGOknW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jnVGOknW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EITBp2914316;
	Thu, 9 Jul 2026 15:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FmgmYQ
	goOqU8IotDdkfBRzM+SaH7tK3xs2bqw5cnUKY=; b=jnVGOknWk4BUlGPd0LaBDB
	o6XrRD2a0YQioY1xKwP5LDVrfPS1jQRcEPnq8FrByEYYFiYLtH+fvoLv8Eyy5L6E
	8dBuX/yygg7K5ktceQ4h0aUkJg4jXVq7EwzpH5+RDEPusVlZhD3YX8Y2fqn8tP3+
	7iIxoRB994DVr8mubJga5gaXjyObDkBi5lfv602G+1XnNw39ty8LtLZoSm9phCfi
	aXnX6gdiI6x6By2dVlgkApCHb4+pQ9UXVPmjQlhCcanOM53B7x2w5xLXlh5M+ve4
	z9Pfmv/nsre3D+swA2Yl5DHbcWqQvu1AoL+Mhw1c/ZfyoG1uMG36TxPAbC1dziFA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur22vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4abP012225;
	Thu, 9 Jul 2026 15:15:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ydc20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFQX151446078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C16E62004B;
	Thu,  9 Jul 2026 15:15:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E70E20043;
	Thu,  9 Jul 2026 15:15:26 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:26 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:11 +0200
Subject: [PATCH 11/21] KVM: s390: vsie: Create helpers to alloc and free
 vsie_pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-11-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2446;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=Y8DJsdmLMyvu5cHoe7NIxkrDtykYXEo8c3dEQUd1s2U=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u1l6wyuzfpRtjnvD36TvYDTzdemLnkfPuMt6Qyrib
 1+7+aylo5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIl4pjL800vffoZt/YZZwpyr
 nLrXKL4tev384KdFgU8uvtl1XNVfm4mRYZbtsdT0ayu/FfqeDPlpWMpQL5m20l3mtd0zlaPVeRu
 PsgAA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX14jj9azvj7Yw
 bBlQUBioOhPMfB7j7xox80W1mZ89AQsmmZGL6p/74Two4wQz5O1u2DxKsuHoHAV6/pQaXsHHNgJ
 CI6H5ScTaHrSslV0NFuOcl8bY2fVK4I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX0u5NM0NroQU6
 8TRmUVhcrBti6BJbHrYhhEikR4e0CM50WIDj7M32ZjiKTuNDxdH9trteUNIbo4vW90Y+7+jP9B3
 8uVdZ1M+ITpKZSkXcaobBv593nhIj/wCvdyIp38TM29i0JkIK6JXGBJe1TtX8/N5mGAaLUHTj/p
 Fs1dngXx9o5jkcWInPQ8L456DO7uKT7hnLQx4EahPspn1qZWm92tnX1gonOHUk/KED38NJltEcx
 NkN1sxWviCaqNwOIwRE8q/Is7MSPoV9CruUPtnvsVg+MJ3/wggIzVC5zJfdNtreKa5RXnfrS1Pv
 vAzapBJiKLb8WnKjiziLkCQBwEOzuhl5OzYQCyFgGfCeeuiLJ6Ifk6Y+8rvysG7/JNfyKTIYkhl
 jiFsbww2AZKVtFop2Tb9vSm9XJwchb96bunyezIylywwdmkHuPT4QUebwYj1IVRQgPJXrZyDcxy
 REnzCuBJkT4JH2UcPYw==
X-Proofpoint-GUID: sv4W8vK2mCtDXvQ5bITFglT3qZT47PSI
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4fbb13 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=-UiXzxHpo5ppJV-mmbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sv4W8vK2mCtDXvQ5bITFglT3qZT47PSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Encapsulate allocation of struct vsie_page and free into its own methods
to allow this from multiple code paths.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 5bdd9385266f..4090b4019f21 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1503,6 +1503,24 @@ static void put_vsie_page(struct vsie_page *vsie_page)
 	clear_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
 }
 
+static void free_vsie_page(struct vsie_page *vsie_page)
+{
+	free_page((unsigned long)vsie_page);
+}
+
+static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
+{
+	struct vsie_page *vsie_page;
+
+	vsie_page = (struct vsie_page *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
+	if (!vsie_page)
+		return vsie_page;
+
+	/* Mark it as invalid until it resides in the tree. */
+	vsie_page->scb_gpa = ULONG_MAX;
+	return vsie_page;
+}
+
 /*
  * Get or create a vsie page for a scb address.
  *
@@ -1538,7 +1556,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 
 	mutex_lock(&kvm->arch.vsie.mutex);
 	if (kvm->arch.vsie.page_count < nr_vcpus) {
-		vsie_page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
+		vsie_page = alloc_vsie_page(kvm);
 		if (!vsie_page) {
 			mutex_unlock(&kvm->arch.vsie.mutex);
 			return ERR_PTR(-ENOMEM);
@@ -1558,9 +1576,9 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
 					  vsie_page->scb_gpa >> 9);
+		/* Mark it as invalid until it resides in the tree. */
+		vsie_page->scb_gpa = ULONG_MAX;
 	}
-	/* Mark it as invalid until it resides in the tree. */
-	vsie_page->scb_gpa = ULONG_MAX;
 
 	/* Double use of the same address or allocation failure. */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_page)) {
@@ -1662,7 +1680,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
 					  vsie_page->scb_gpa >> 9);
-		free_page((unsigned long)vsie_page);
+		free_vsie_page(vsie_page);
 	}
 	kvm->arch.vsie.page_count = 0;
 	mutex_unlock(&kvm->arch.vsie.mutex);

-- 
2.55.0

