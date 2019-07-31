Return-Path: <linux-kselftest-owner@vger.kernel.org>
From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 0/3] KVM: selftests: Enable ucall and dirty_log_test on s390x
Date: Wed, 31 Jul 2019 17:15:22 +0200
Message-Id: <20190731151525.17156-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>

Implement the ucall() interface on s390x to be able to use the
dirty_log_test KVM selftest on s390x, too.

v3:
 - Fix compilation issue on aarch64 (thanks to Andrew for testing it!)
 - Added Reviewed-bys

v2:
 - Split up ucall.c into architecture specific files
 - Removed some #ifdef __s390x__  in the dirty_log patch

Thomas Huth (3):
  KVM: selftests: Split ucall.c into architecture specific files
  KVM: selftests: Implement ucall() for s390x
  KVM: selftests: Enable dirty_log_test on s390x

 tools/testing/selftests/kvm/Makefile          |   9 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |  61 ++++++-
 .../testing/selftests/kvm/include/kvm_util.h  |   8 +-
 .../testing/selftests/kvm/lib/aarch64/ucall.c | 112 +++++++++++++
 tools/testing/selftests/kvm/lib/s390x/ucall.c |  56 +++++++
 tools/testing/selftests/kvm/lib/ucall.c       | 157 ------------------
 .../testing/selftests/kvm/lib/x86_64/ucall.c  |  56 +++++++
 .../selftests/kvm/s390x/sync_regs_test.c      |   6 +-
 8 files changed, 287 insertions(+), 178 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/ucall.c
 create mode 100644 tools/testing/selftests/kvm/lib/s390x/ucall.c
 delete mode 100644 tools/testing/selftests/kvm/lib/ucall.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/ucall.c

-- 
2.21.0
