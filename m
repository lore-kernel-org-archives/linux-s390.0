Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB71C3F167B;
	Thu,  2 Apr 2026 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142114; cv=none; b=VWC7XcOLHF3srNCB4lHA/+KGoHHb/IX0qqOowJc3Jrs2bnFT2R1bkYKXb9qoawiTTly7hQutEMGRjB6gfW5K4zI2LyVSUJpJ5hIPaJqkv6I5ViDdM5AJiA88jcO8UmY6c+AI/odWKZE5nw2IO0dl7bvbqHoZMKpsxhLMWlmB8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142114; c=relaxed/simple;
	bh=F+E/FL1WwLfbnku5+Op9rkS111ZvqLwk3wQ7de4+OKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7LM1XplotUEJG2u5nK8v8RnYFhwoe1pwe4aTB3l+gGim/nMUfNGkQvEqWEKtuk55ZuDiR8AIt1q78HCV58/ig/dr+4gA86Sb/TJA58pwKU1gpN8W3ZikxpHTo71A/btF5ods1LYSCJrje8VfBkr/8bOXd8hOxYXpn8GE3f84dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NLUlAgJ5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NLUlAgJ5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6321AHLv371620;
	Thu, 2 Apr 2026 15:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=V62ibWPECQkrvOvVO
	6fSKi1YtycLnQljr6f335lZ3F0=; b=NLUlAgJ5H2I3fHRJbmsOdAIOYeW9Jp20y
	+ebhginjXcMcyo1GUGbMNTTGO8fQFt4vAbjWPoknbR0pWMkGDSvDcJwvEF3LEpEg
	JGPfvGElYBBuPHvdweZpmJE9Ct0kQ5FG18st6ywaMK5XbbQ2XA0KOY7q5ROUTb9H
	kZ51omU/jM/S+0TzY8wy7MFNj13wVhDP7AQ9EYqkYX6ZP31ESWwqfzle5Sm4gUGZ
	e8Fx4o42VtOTioqTxURSaRdMPc7GYrbp8zP0V3SLmiwh651Xw7+X3nGa9rZVFO7y
	t5dWvec6ucdRI5nfLBEvqxNDb7uiVI6QExSMBmFDAJPJhBNzZtJ/g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcmdkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632BGaHr005757;
	Thu, 2 Apr 2026 15:01:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyajbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632F1erR59900340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 15:01:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 060BD20043;
	Thu,  2 Apr 2026 15:01:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4515E20040;
	Thu,  2 Apr 2026 15:01:39 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.129.177])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 15:01:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 4/6] KVM: selftests: Remove 1M alignment requirement for s390
Date: Thu,  2 Apr 2026 17:01:33 +0200
Message-ID: <20260402150135.196943-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402150135.196943-1-imbrenda@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ce84da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=UTmhEy8gFCsRmEP22h0A:9
X-Proofpoint-GUID: XEdcIkteTLgJ2Dy6NzPuDcQl45vNjcCM
X-Proofpoint-ORIG-GUID: XEdcIkteTLgJ2Dy6NzPuDcQl45vNjcCM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzMyBTYWx0ZWRfX3hdM2Bostf/x
 MHe4aMJsxapTSmjEP9TbmkCx1Gd8Y347/GOE/shMGSyuJLhW/V5DKGBknKkZ8PzRE41CG8kFB2O
 1zAP0YPMu0yGX3OgWqzpP1RGj4XZDzVALfGAGhjDuTZ0hydw3aOT1Gjtu/kheB10wDtX6RzMFMb
 GmEUql+4Whus3wx6q5jKBAzvkajZz3z33k6vwpYaDpX1+jnyH/sZARcb/LzdTAsfV9WzWeqgD5M
 RJoZI4wHbp86ww7u85GqF29WhfVEIrCg5otRHDc61e1kIyZ/FR/eEgJPzXz925sD1YBEq5E1ZDP
 w/lXDCK50uPA0gykPkm/JzrSAC9HrefuheLju1oNekj3pZ68D7HFp8G0ejDd4P+XhBmtYR3dUht
 mLwgSA41kHovSVIGfjA6I1ObUs0pIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020133

Remove the 1M memslot alignment requirement for s390, since it is not
needed anymore.

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

