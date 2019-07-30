Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfG3KBY (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jul 2019 06:01:24 -0400
From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/2] KVM: selftests: Enable ucall and dirty_log_test on s390x
Date: Tue, 30 Jul 2019 12:01:10 +0200
Message-Id: <20190730100112.18205-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>

Implement the ucall() interface on s390x to be able to use the
dirty_log_test KVM selftest on s390x, too.

Thomas Huth (2):
  KVM: selftests: Implement ucall() for s390x
  KVM: selftests: Enable dirty_log_test on s390x

 tools/testing/selftests/kvm/Makefile          |  1 +
 tools/testing/selftests/kvm/dirty_log_test.c  | 70 +++++++++++++++++--
 .../testing/selftests/kvm/include/kvm_util.h  |  2 +-
 tools/testing/selftests/kvm/lib/ucall.c       | 34 +++++++--
 .../selftests/kvm/s390x/sync_regs_test.c      |  6 +-
 5 files changed, 98 insertions(+), 15 deletions(-)

-- 
2.21.0
