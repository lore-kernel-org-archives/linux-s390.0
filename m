Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728351AbgAaKCZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 05:02:25 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VA0gdu148523
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:02:24 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xv09xta1j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:02:24 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 31 Jan 2020 10:02:22 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v10 4/6] selftests: KVM: Add fpu and one reg set/get library functions
Date: Fri, 31 Jan 2020 05:02:03 -0500
In-Reply-To: <20200131100205.74720-1-frankja@linux.ibm.com>
References: <20200131100205.74720-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131100205.74720-5-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

Add library access to more registers.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  6 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 36 +++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index 41cf45416060..a6dd0401eb50 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1373,6 +1373,42 @@ int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
 	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
 }
 
+void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
+{
+	int ret;
+
+	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
+	TEST_ASSERT(ret == 0, "KVM_GET_FPU failed, rc: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+}
+
+void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
+{
+	int ret;
+
+	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
+	TEST_ASSERT(ret == 0, "KVM_SET_FPU failed, rc: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+}
+
+void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
+{
+	int ret;
+
+	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
+	TEST_ASSERT(ret == 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+}
+
+void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
+{
+	int ret;
+
+	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
+	TEST_ASSERT(ret == 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+}
+
 /*
  * VCPU Ioctl
  *
-- 
2.20.1
