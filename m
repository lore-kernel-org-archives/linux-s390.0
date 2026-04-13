Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306B3BE638;
	Mon, 13 Apr 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077280; cv=none; b=LUAg1yyFaq/pEqrur8grNhYzJXiScwXHNPfhOA3vd8uHbtUMOY2EvNitTKs1+1z+vIQG54X/p0GTcZBozF/wF2iZXhA++a+lPg5s2q2GOMPQGphiGIKPTHPgbMlMkgP4kymdLmLDooek0/MZm8njUgjXML46PF3k8Tzj4dEtaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077280; c=relaxed/simple;
	bh=oZFNFPlmRDIobi7A8ew/H2ZRHi/i0kuM8zTc7nkhHpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlnlrtlTU6ldlJhl1PoFUnLzWbSb1lAJv650EkerOROQ68NwpyLhD+5ZpudCEpSbAik23tqd6DyNESSn4b0bIVzRXkTH/EiU2dwwQXZ8SxiAj8/HylHBiSsvPYyMd/U5yzeYRxdHzMYByv+Yh3m42eUsl1+hY4P1gSY76cz4HH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eRpeU+aM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eRpeU+aM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D9B5ID2052850;
	Mon, 13 Apr 2026 10:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pyJcrqL3sCj9QFHyW
	cSvBgZKHXK+ljxVjpr457w+3ZA=; b=eRpeU+aM4GQL0uen/6wtjwawR5KVFELUc
	xakJjJ+dS/s2bswNuVYsoiuYYc8G4/UIAS/AdSRyKwtbv3TQscSsCm2ZVIZQqM52
	l1lDZGrK0zrXGm2utxYlJO6dN0DlwUs/o51S2xxPrAKLyjKDJM6o7+KDZgqywfXH
	9pkLE8OkRcW5PF3Htzwrp8vGPPwhCW2AaWfqZRzoPmbBKCjuhxcmT7/9hkJE0fds
	W34nSJmvXdIZycjc24Ej2b6U9KODVDgqN6pYoDf3DTCNhrrQFbgYTPpTJtcZ8+Ec
	J4and1yeNV3+ScCV/WmEzoBpnUWFuIgXso/K1NigSPrL+t2blvwtA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3q910-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D88Mk6015666;
	Mon, 13 Apr 2026 10:47:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mscx23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAlo4F53805498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A17D62004B;
	Mon, 13 Apr 2026 10:47:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 362A420040;
	Mon, 13 Apr 2026 10:47:50 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:50 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Steffen Eiden <seiden@linux.ibm.com>
Subject: [GIT PULL 10/12] KVM: selftests: Remove 1M alignment requirement for s390
Date: Mon, 13 Apr 2026 12:46:38 +0200
Message-ID: <20260413104721.203024-11-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gCljUnpvOThwjK4slH-OIZ6mLBKezM21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX2b63kAwkH5Zv
 biQ3iTP4At0tFLAJQCd22THTjLBN0c5ltM8qh6INO/RtGlk3PXDzAboHS4pTlpt3M9lm9k0yHaz
 mWCEOHsj0V2GS4GInzMQMQxAzNwCQ8e4WxUIyhjw9bGBtAyU+J0BmSmTBdb6gv+VVy81ZbW6K3I
 LJxlH7ONeTc/7Xrw89UQUegn9+4uR9uYhchCSC121Rib7SpgpZAni2HjyPg/gY6uSvA5iQwKvXV
 sQXL3hmx7f7DbkzvUAyEMUoGrR9mK+l1LaGkTbkpn8lJA1gDpsfIHKodR1gWy73UP3Lkqm03RA3
 b4osMPzByfwBuDLkkhQlSMtwQsXGbmjW6HUHzSeJ9SJjv1kBxEQf5g/0HyZTHqkm3/rOaL6PbZ3
 Y9g6Yz0aR+8UUXdWZYikVRzKE05FFePHvLDusCwdobFTIMQ8jRfvGBoX7VJUXgbZtbu/+iIMjPx
 /zXsQaq/lLLA5B0iV+g==
X-Proofpoint-GUID: gCljUnpvOThwjK4slH-OIZ6mLBKezM21
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69dcc9db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UTmhEy8gFCsRmEP22h0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130106

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Remove the 1M memslot alignment requirement for s390, since it is not
needed anymore.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c         | 3 ---
 tools/testing/selftests/kvm/include/kvm_util.h       | 4 ----
 tools/testing/selftests/kvm/kvm_page_table_test.c    | 3 ---
 tools/testing/selftests/kvm/lib/kvm_util.c           | 9 +--------
 tools/testing/selftests/kvm/lib/memstress.c          | 4 ----
 tools/testing/selftests/kvm/pre_fault_memory_test.c  | 4 ----
 tools/testing/selftests/kvm/set_memory_region_test.c | 9 +--------
 7 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index d58a641b0e6a..7627b328f18a 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -641,9 +641,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	}
 
 #ifdef __s390x__
-	/* Align to 1M (segment size) */
-	guest_test_phys_mem = align_down(guest_test_phys_mem, 1 << 20);
-
 	/*
 	 * The workaround in guest_code() to write all pages prior to the first
 	 * iteration isn't compatible with the dirty ring, as the dirty ring
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
 
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index dd8b12f626d3..c60a24a92829 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -261,9 +261,6 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 				       guest_page_size;
 	else
 		guest_test_phys_mem = p->phys_offset;
-#ifdef __s390x__
-	alignment = max(0x100000UL, alignment);
-#endif
 	guest_test_phys_mem = align_down(guest_test_phys_mem, alignment);
 
 	/* Set up the shared data structure test_args */
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
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index 557c0a0a5658..1ea735d66e15 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -196,10 +196,6 @@ struct kvm_vm *memstress_create_vm(enum vm_guest_mode mode, int nr_vcpus,
 
 	args->gpa = (region_end_gfn - guest_num_pages - 1) * args->guest_page_size;
 	args->gpa = align_down(args->gpa, backing_src_pagesz);
-#ifdef __s390x__
-	/* Align to 1M (segment size) */
-	args->gpa = align_down(args->gpa, 1 << 20);
-#endif
 	args->size = guest_num_pages * args->guest_page_size;
 	pr_info("guest physical test memory: [0x%lx, 0x%lx)\n",
 		args->gpa, args->gpa + args->size);
diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index 93e603d91311..f3de0386ba7b 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -175,11 +175,7 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 
 	alignment = guest_page_size = vm_guest_mode_params[VM_MODE_DEFAULT].page_size;
 	gpa = (vm->max_gfn - TEST_NPAGES) * guest_page_size;
-#ifdef __s390x__
-	alignment = max(0x100000UL, guest_page_size);
-#else
 	alignment = SZ_2M;
-#endif
 	gpa = align_down(gpa, alignment);
 	gva = gpa & ((1ULL << (vm->va_bits - 1)) - 1);
 
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 7fe427ff9b38..a398dc3a8c4b 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -413,14 +413,7 @@ static void test_add_max_memory_regions(void)
 	uint32_t max_mem_slots;
 	uint32_t slot;
 	void *mem, *mem_aligned, *mem_extra;
-	size_t alignment;
-
-#ifdef __s390x__
-	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
-	alignment = 0x100000;
-#else
-	alignment = 1;
-#endif
+	size_t alignment = 1;
 
 	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
 	TEST_ASSERT(max_mem_slots > 0,
-- 
2.53.0

