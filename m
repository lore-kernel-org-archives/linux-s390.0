Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30053 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726765AbgD3PYn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:24:43 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 00/17] s390x updates
Date: Thu, 30 Apr 2020 17:24:13 +0200
Message-Id: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Andrew Jones <drjones@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>

Hi Paolo,

The following changes since commit 5c052c904ded7ecd80d8f7efe2803821b45ce4=
83:

  kvm-unit-tests: nSVM: Test that CR0[63:32] are not set on VMRUN of nest=
ed guests (2020-04-21 12:16:07 -0400)

are available in the Git repository at:

  https://github.com/davidhildenbrand/kvm-unit-tests.git tags/s390x-2020-=
04-30

for you to fetch changes up to f7df29115f736b9ffe8e529ba9c2b418d2f5e736:

  s390x: Fix library constant definitions (2020-04-30 16:52:14 +0200)

----------------------------------------------------------------
New maintainer, reviewer, and cc list. New STSI test. Lots of minor fixes
and cleanups

----------------------------------------------------------------
Andrew Jones (1):
      s390x: unittests: Use smp parameter

Christian Borntraeger (2):
      s390x/smp: fix detection of "running"
      s390x/smp: add minimal test for sigp sense running status

Cornelia Huck (2):
      MAINTAINERS: s390x: add myself as reviewer
      MAINTAINERS: s390x: add linux-s390 list

David Hildenbrand (1):
      s390x: STFLE operates on doublewords

Janosch Frank (10):
      s390x: Add stsi 3.2.2 tests
      s390x: smp: Test all CRs on initial reset
      s390x: smp: Dirty fpc before initial reset test
      s390x: smp: Test stop and store status on a running and stopped cpu
      s390x: smp: Test local interrupts after cpu reset
      s390x: smp: Loop if secondary cpu returns into cpu setup again
      s390x: smp: Remove unneeded cpu loops
      s390x: smp: Use full PSW to bringup new cpu
      s390x: smp: Add restart when running test
      s390x: Fix library constant definitions

Thomas Huth (1):
      MAINTAINERS: Add Janosch as a s390x maintainer

 MAINTAINERS              |   4 +-
 lib/s390x/asm/arch_def.h |   8 ++--
 lib/s390x/asm/facility.h |  14 +++----
 lib/s390x/io.c           |   2 +-
 lib/s390x/smp.c          |   6 ++-
 lib/s390x/smp.h          |   2 +-
 s390x/cstart64.S         |   5 ++-
 s390x/smp.c              | 105 +++++++++++++++++++++++++++++++++++++++++=
++----
 s390x/stsi.c             |  73 ++++++++++++++++++++++++++++++++
 s390x/unittests.cfg      |   3 +-
 10 files changed, 196 insertions(+), 26 deletions(-)
