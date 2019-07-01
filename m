Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727665AbfGAM65 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Jul 2019 08:58:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61Cv1bx120287
        for <linux-s390@vger.kernel.org>; Mon, 1 Jul 2019 08:58:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfj3825tt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 01 Jul 2019 08:58:56 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 1 Jul 2019 13:58:53 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/7] KVM: selftests: Align memory region addresses to 1M on s390x
Date: Mon,  1 Jul 2019 14:58:44 +0200
In-Reply-To: <20190701125848.276133-1-borntraeger@de.ibm.com>
References: <20190701125848.276133-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190701125848.276133-4-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

From: Thomas Huth <thuth@redhat.com>

On s390x, there is a constraint that memory regions have to be aligned
to 1M (or running the VM will fail). Introduce a new "alignment" variable
in the vm_userspace_mem_region_add() function which now can be used for
both, huge page and s390x alignment requirements.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190523164309.13345-6-thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[prepare for THP as outlined by Andrew Jones]
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9ea9ba28af1f1..ab7fcb9acf3da 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -557,6 +557,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	int ret;
 	struct userspace_mem_region *region;
 	size_t huge_page_size = KVM_UTIL_PGS_PER_HUGEPG * vm->page_size;
+	size_t alignment;
 
 	TEST_ASSERT((guest_paddr % vm->page_size) == 0, "Guest physical "
 		"address not on a page boundary.\n"
@@ -606,9 +607,20 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	TEST_ASSERT(region != NULL, "Insufficient Memory");
 	region->mmap_size = npages * vm->page_size;
 
-	/* Enough memory to align up to a huge page. */
+#ifdef __s390x__
+	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
+	alignment = 0x100000;
+#else
+	alignment = 1;
+#endif
+
 	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
-		region->mmap_size += huge_page_size;
+		alignment = max(huge_page_size, alignment);
+
+	/* Add enough memory to align up if necessary */
+	if (alignment > 1)
+		region->mmap_size += alignment;
+
 	region->mmap_start = mmap(NULL, region->mmap_size,
 				  PROT_READ | PROT_WRITE,
 				  MAP_PRIVATE | MAP_ANONYMOUS
@@ -618,9 +630,8 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 		    "test_malloc failed, mmap_start: %p errno: %i",
 		    region->mmap_start, errno);
 
-	/* Align THP allocation up to start of a huge page. */
-	region->host_mem = align(region->mmap_start,
-				 src_type == VM_MEM_SRC_ANONYMOUS_THP ?  huge_page_size : 1);
+	/* Align host address */
+	region->host_mem = align(region->mmap_start, alignment);
 
 	/* As needed perform madvise */
 	if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
-- 
2.21.0
