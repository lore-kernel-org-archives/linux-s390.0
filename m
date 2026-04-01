Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDC47DD61;
	Wed,  1 Apr 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065216; cv=none; b=o4NH4EwZ+zMMJBoikWrBiS/oeKUHrRYjVxYefwgy9PEuy1AShXKXyRifZ4M4yiZ+0caXtqUnKVksMtTyKu5ZwaUWN/BgCVQUMvY0/DtpdpnCxBb4x7B8ymF52E5FZBfpAaA32nl4SG80ESC0E7GOoilucsSEqMgBXDmpAJQyfvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065216; c=relaxed/simple;
	bh=alUmo1jFUVxy2lfouq4BqOdKVM2W75j/mEINF9RYMlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOotX9S/vw2UtmhA1K7K5AzdGtueytgtkUe0KkyFQq26AWXaF7cIDxjPoMPjNEZwc5kbZr3NTlbVLW6ZlzDe0PMtfnezJNBXFJQabGxrwQkYxBxwO717Gga8zLfPmFL+HUxzle8PuX4qNaWETnGalmQybTZoBnSysCF/NzoKp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rGFI80if; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rGFI80if"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631GnTvC3012799;
	Wed, 1 Apr 2026 17:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=azZqOZ7bsexxLHvTh
	VMxk4QQTqaW6/A9H3X16uWdo0I=; b=rGFI80ifYayHU6BjXJwrIFAxsy+e5uyEL
	mNKdYYllwlrqwrqlthlBjO378VVTB6W0dYaFHtumiGTsuJckwI65+Pkqy9jYhFaE
	oTlN0q64lRb+Vb153qEmnJxN6TZGXIQhHrMLUeu7DdKt0GuGeF0pyIZb4YPldD0Q
	G4Q0AeCRE+G7ycGwtDXmEuhs4yeLWJhZkXM7tLVCZ/wGyyViHSkFK6FrVZz9XrJ+
	5HImtGK78KOREUgac2j9170pb8U2MVtHmRRWucQcYiIwF157cwFBTbytr/9xslFd
	9O7K+LAZkQaTvZ4Nf6wX2jzjoTk6wdKI9ScVy09T51MeJCbzA4QBA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g21gh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631GHcU1022217;
	Wed, 1 Apr 2026 17:40:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan6qe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631He0ij45744618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:40:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D63020040;
	Wed,  1 Apr 2026 17:40:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60F3420043;
	Wed,  1 Apr 2026 17:39:59 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.24.224])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 17:39:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 4/5] KVM: selftests: Remove 1M alignment requirement for s390
Date: Wed,  1 Apr 2026 19:39:54 +0200
Message-ID: <20260401173955.314821-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401173955.314821-1-imbrenda@linux.ibm.com>
References: <20260401173955.314821-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cd5877 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Jr3PCXUVmlYdUNPdThEA:9
X-Proofpoint-ORIG-GUID: 5a3igfdH59egTVf8X_D48pQXGQ-BQzD3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2MiBTYWx0ZWRfX4C9ebgAOTpw2
 BxSU+weycUQPB5KMYFwUO2RPA0rBAvcnYHkZFb8NIGLDnJPTTSB8sS/lj8XB7VwxUgnXW+1Rg28
 PvWllInF4IU7UnVJ3wTnZuMa1roR+ZSGJvxGzv/+zmwmWCIEHP8iFCmVGuX1W7D30KP3ylukDRi
 XBvWRMdIK3kJykrWCH+BHIErRssMY+eFX1UsHVx5A6iJHLz7xSIn04Nmf5oM7aRmB1JQ7IURH3q
 2dEFIil0Tf78sjD/9L5CYQaQbxkHpyPvuFsV6OhsqcIWDGDws1L5oSpQkt2HF3McBM4OFXZd5yD
 oYPQi6YvCjuR/vFptU4Yx+GR+L51goULZ9INe1iGz3j/XfM+bg2jWWTU9uH49yBWAnetDpDyfOV
 l8ibc5zGj9YdVq7Sqyn/LEPQ+1D3xXgHq9TWxyQV7xh8UKdWGLxF9vx95V7hV30XN06zBpbI8fA
 E2QcJ71KKefUDqKyC2w==
X-Proofpoint-GUID: 5a3igfdH59egTVf8X_D48pQXGQ-BQzD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010162

Remove the 1M memslot alignment requirement for s390, since it is not
needed anymore.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 4 ----
 tools/testing/selftests/kvm/lib/kvm_util.c     | 9 +--------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 8b39cb919f4f..f861242b4ae8 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1127,10 +1127,6 @@ vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_pages)
 {
 	unsigned int n;
 	n = vm_num_guest_pages(mode, vm_num_host_pages(mode, num_guest_pages));
-#ifdef __s390x__
-	/* s390 requires 1M aligned guest sizes */
-	n = (n + 255) & ~255;
-#endif
 	return n;
 }
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1959bf556e88..f5e076591c64 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -985,7 +985,7 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	struct userspace_mem_region *region;
 	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
 	size_t mem_size = npages * vm->page_size;
-	size_t alignment;
+	size_t alignment = 1;
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
 
@@ -1039,13 +1039,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	TEST_ASSERT(region != NULL, "Insufficient Memory");
 	region->mmap_size = mem_size;
 
-#ifdef __s390x__
-	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
-	alignment = 0x100000;
-#else
-	alignment = 1;
-#endif
-
 	/*
 	 * When using THP mmap is not guaranteed to returned a hugepage aligned
 	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
-- 
2.53.0

