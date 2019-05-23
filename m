Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/9] KVM: selftests: Wrap vcpu_nested_state_get/set functions with x86 guard
Date: Thu, 23 May 2019 18:43:01 +0200
Message-Id: <20190523164309.13345-2-thuth@redhat.com>
In-Reply-To: <20190523164309.13345-1-thuth@redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

struct kvm_nested_state is only available on x86 so far. To be able
to compile the code on other architectures as well, we need to wrap
the related code with #ifdefs.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 8c6b9619797d..a5a4b28f14d8 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -118,10 +118,12 @@ void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_vcpu_events *events);
 void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_vcpu_events *events);
+#ifdef __x86_64__
 void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
 			   struct kvm_nested_state *state);
 int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
 			  struct kvm_nested_state *state, bool ignore_error);
+#endif
 
 const char *exit_reason_str(unsigned int exit_reason);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e9113857f44e..ba1359ac504f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1250,6 +1250,7 @@ void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
 		ret, errno);
 }
 
+#ifdef __x86_64__
 void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
 			   struct kvm_nested_state *state)
 {
@@ -1281,6 +1282,7 @@ int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
 
 	return ret;
 }
+#endif
 
 /*
  * VM VCPU System Regs Get
-- 
2.21.0
