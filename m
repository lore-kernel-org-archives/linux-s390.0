Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727341AbgA2UDb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Jan 2020 15:03:31 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TJsP96078733
        for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2020 15:03:30 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xu6srkn04-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2020 15:03:30 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 29 Jan 2020 20:03:28 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v8 2/4] selftests: KVM: Add fpu and one reg set/get library functions
Date: Wed, 29 Jan 2020 15:03:10 -0500
In-Reply-To: <20200129200312.3200-1-frankja@linux.ibm.com>
References: <20200129200312.3200-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200129200312.3200-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

Add library access to more registers.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  6 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 48 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 29cccaf96baf..ae0d14c2540a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -125,6 +125,12 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
 		    struct kvm_sregs *sregs);
 int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
 		    struct kvm_sregs *sregs);
+void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
+		  struct kvm_fpu *fpu);
+void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
+		  struct kvm_fpu *fpu);
+void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
+void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
 #ifdef __KVM_HAVE_VCPU_EVENTS
 void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_vcpu_events *events);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 41cf45416060..dae117728ec6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1373,6 +1373,54 @@ int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
 	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
 }
 
+void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	ret = ioctl(vcpu->fd, KVM_GET_FPU, fpu);
+	TEST_ASSERT(ret == 0, "KVM_GET_FPU failed, rc: %i errno: %i",
+		    ret, errno);
+}
+
+void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	ret = ioctl(vcpu->fd, KVM_SET_FPU, fpu);
+	TEST_ASSERT(ret == 0, "KVM_SET_FPU failed, rc: %i errno: %i",
+		    ret, errno);
+}
+
+void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	ret = ioctl(vcpu->fd, KVM_GET_ONE_REG, reg);
+	TEST_ASSERT(ret == 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i",
+		    ret, errno);
+}
+
+void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	ret = ioctl(vcpu->fd, KVM_SET_ONE_REG, reg);
+	TEST_ASSERT(ret == 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i",
+		    ret, errno);
+}
+
 /*
  * VCPU Ioctl
  *
-- 
2.20.1
