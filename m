Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727702AbfGAM67 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Jul 2019 08:58:59 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61CuvGl146936
        for <linux-s390@vger.kernel.org>; Mon, 1 Jul 2019 08:58:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfh6udb9e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 01 Jul 2019 08:58:58 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 1 Jul 2019 13:58:55 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/7] KVM: selftests: Move kvm_create_max_vcpus test to generic code
Date: Mon,  1 Jul 2019 14:58:47 +0200
In-Reply-To: <20190701125848.276133-1-borntraeger@de.ibm.com>
References: <20190701125848.276133-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190701125848.276133-7-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

From: Thomas Huth <thuth@redhat.com>

There is nothing x86-specific in the test apart from the VM_MODE_P52V48_4K
which we can now replace with VM_MODE_DEFAULT. Thus let's move the file to
the main folder and enable it for aarch64 and s390x, too.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190523164309.13345-10-thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/Makefile                          | 4 +++-
 .../testing/selftests/kvm/{x86_64 => }/kvm_create_max_vcpus.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)
 rename tools/testing/selftests/kvm/{x86_64 => }/kvm_create_max_vcpus.c (93%)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ed8eb6007566b..05a94a13a0a31 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -22,15 +22,17 @@ TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_close_while_nested_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
-TEST_GEN_PROGS_x86_64 += x86_64/kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
+TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
+TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 
 TEST_GEN_PROGS_s390x += s390x/sync_regs_test
+TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
similarity index 93%
rename from tools/testing/selftests/kvm/x86_64/kvm_create_max_vcpus.c
rename to tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index 50e92996f9186..db78ce07c4164 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * kvm_create_max_vcpus
  *
@@ -28,7 +29,7 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
 	printf("Testing creating %d vCPUs, with IDs %d...%d.\n",
 	       num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
 
-	vm = vm_create(VM_MODE_P52V48_4K, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
 
 	for (i = 0; i < num_vcpus; i++) {
 		int vcpu_id = first_vcpu_id + i;
-- 
2.21.0
