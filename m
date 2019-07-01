Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbfGAM65 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Jul 2019 08:58:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61Cuvn0145803
        for <linux-s390@vger.kernel.org>; Mon, 1 Jul 2019 08:58:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tfhnmuxjw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 01 Jul 2019 08:58:55 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 1 Jul 2019 13:58:54 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/7] KVM: selftests: Introduce a VM_MODE_DEFAULT macro for the default bits
Date: Mon,  1 Jul 2019 14:58:43 +0200
In-Reply-To: <20190701125848.276133-1-borntraeger@de.ibm.com>
References: <20190701125848.276133-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190701125848.276133-3-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

From: Thomas Huth <thuth@redhat.com>

This will be required later for tests like the kvm_create_max_vcpus
test that do not use the vm_create_default() function.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190523164309.13345-5-thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h      | 6 ++++++
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 2 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c  | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index b8bf961074fea..b6eb6471e6b2e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -43,6 +43,12 @@ enum vm_guest_mode {
 	NUM_VM_MODES,
 };
 
+#ifdef __aarch64__
+#define VM_MODE_DEFAULT VM_MODE_P40V48_4K
+#else
+#define VM_MODE_DEFAULT VM_MODE_P52V48_4K
+#endif
+
 #define vm_guest_mode_string(m) vm_guest_mode_string[m]
 extern const char * const vm_guest_mode_string[];
 
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 19e667911496c..c278e2f68b10b 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -227,7 +227,7 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
 	uint64_t extra_pg_pages = (extra_mem_pages / ptrs_per_4k_pte) * 2;
 	struct kvm_vm *vm;
 
-	vm = vm_create(VM_MODE_P40V48_4K, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
 
 	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
 	vm_vcpu_add_default(vm, vcpuid, guest_code);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 21f3040d90cb1..90ed1d1fe963e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -821,7 +821,7 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
 	uint64_t extra_pg_pages = extra_mem_pages / 512 * 2;
 
 	/* Create VM */
-	vm = vm_create(VM_MODE_P52V48_4K,
+	vm = vm_create(VM_MODE_DEFAULT,
 		       DEFAULT_GUEST_PHY_PAGES + extra_pg_pages,
 		       O_RDWR);
 
-- 
2.21.0
