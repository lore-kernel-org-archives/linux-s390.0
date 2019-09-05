Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732757AbfIEIkm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 04:40:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x858bbrv102274
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 04:40:40 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2utxbyswbm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 04:40:40 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 5 Sep 2019 09:40:38 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [GIT PULL 8/8] KVM: selftests: Test invalid bits in kvm_valid_regs and kvm_dirty_regs on s390x
Date: Thu,  5 Sep 2019 10:40:09 +0200
In-Reply-To: <20190905084009.26106-1-frankja@linux.ibm.com>
References: <20190905084009.26106-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190905084009.26106-9-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, thuth@redhat.com

From: Thomas Huth <thuth@redhat.com>

Now that we disallow invalid bits in kvm_valid_regs and kvm_dirty_regs
on s390x, too, we should also check this condition in the selftests.
The code has been taken from the x86-version of the sync_regs_test.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/lkml/20190904085200.29021-3-thuth@redhat.com/
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../selftests/kvm/s390x/sync_regs_test.c      | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index bbc93094519b..d5290b4ad636 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -85,6 +85,36 @@ int main(int argc, char *argv[])
 
 	run = vcpu_state(vm, VCPU_ID);
 
+	/* Request reading invalid register set from VCPU. */
+	run->kvm_valid_regs = INVALID_SYNC_FIELD;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv < 0 && errno == EINVAL,
+		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
+		    rv);
+	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
+
+	run->kvm_valid_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv < 0 && errno == EINVAL,
+		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
+		    rv);
+	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
+
+	/* Request setting invalid register set into VCPU. */
+	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv < 0 && errno == EINVAL,
+		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
+		    rv);
+	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
+
+	run->kvm_dirty_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv < 0 && errno == EINVAL,
+		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
+		    rv);
+	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
+
 	/* Request and verify all valid register sets. */
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	rv = _vcpu_run(vm, VCPU_ID);
-- 
2.20.1
