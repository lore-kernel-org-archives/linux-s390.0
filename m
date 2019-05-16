Return-Path: <SRS0=lgIa=TQ=vger.kernel.org=kvm-owner@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH 0/4] KVM selftests for s390x
Date: Thu, 16 May 2019 13:12:49 +0200
Message-Id: <20190516111253.4494-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch series enables the KVM selftests for s390x. As a first
test, the sync_regs from x86 has been adapted to s390x.

Please note that the ucall() interface is not used yet - since
s390x neither has PIO nor MMIO, this needs some more work first
before it becomes usable (we likely should use a DIAG hypercall
here, which is what the sync_reg test is currently using, too...).

Thomas Huth (4):
  KVM: selftests: Guard struct kvm_vcpu_events with
    __KVM_HAVE_VCPU_EVENTS
  KVM: selftests: Align memory region addresses to 1M on s390x
  KVM: selftests: Add processor code for s390x
  KVM: selftests: Add the sync_regs test for s390x

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   2 +
 .../selftests/kvm/include/s390x/processor.h   |  22 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  24 +-
 .../selftests/kvm/lib/s390x/processor.c       | 277 ++++++++++++++++++
 .../selftests/kvm/s390x/sync_regs_test.c      | 151 ++++++++++
 7 files changed, 476 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/s390x/processor.c
 create mode 100644 tools/testing/selftests/kvm/s390x/sync_regs_test.c

-- 
2.21.0
