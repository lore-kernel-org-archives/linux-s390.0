Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbgIAJSo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Sep 2020 05:18:44 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 0/3] s390x skrf and ultravisor patches
Date: Tue,  1 Sep 2020 11:18:20 +0200
Message-Id: <20200901091823.14477-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Hi Paolo,

initially I wanted to wait with this pull until I picked more patches,
but it doesn't look like that will happen soon and my vacation is
getting closer. So here we go:

The following changes since commit 1b53866b0b494277ab41c7c0cec4ee00969dd32e:

  Merge tag 's390x-2020-31-07' of https://github.com/frankjaa/kvm-unit-tests into HEAD (2020-08-09 18:06:26 +0200)

are available in the Git repository at:

  git@gitlab.com:frankja/kvm-unit-tests.git tags/s390x-2020-01-09

for you to fetch changes up to 2ea7afb64d34b5dd841334f72b99251ab56433cd:

  s390x: Ultravisor guest API test (2020-08-11 03:19:46 -0400)

----------------------------------------------------------------
* Added first Ultravisor tests
* Added SKRF key in PSW test
* Added custom program exception cleanup hook
----------------------------------------------------------------
Janosch Frank (3):
      s390x: Add custom pgm cleanup function
      s390x: skrf: Add exception new skey test and add test to unittests.cfg
      s390x: Ultravisor guest API test

 lib/s390x/asm/interrupt.h |   1 +
 lib/s390x/asm/uv.h        |  74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/interrupt.c     |  12 +++++++++++-
 s390x/Makefile            |   1 +
 s390x/skrf.c              |  79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg       |   7 +++++++
 s390x/uv-guest.c          | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 lib/s390x/asm/uv.h
 create mode 100644 s390x/uv-guest.c



Janosch Frank (3):
  s390x: Add custom pgm cleanup function
  s390x: skrf: Add exception new skey test and add test to unittests.cfg
  s390x: Ultravisor guest API test

 lib/s390x/asm/interrupt.h |   1 +
 lib/s390x/asm/uv.h        |  74 +++++++++++++++++++
 lib/s390x/interrupt.c     |  12 ++-
 s390x/Makefile            |   1 +
 s390x/skrf.c              |  79 ++++++++++++++++++++
 s390x/unittests.cfg       |   7 ++
 s390x/uv-guest.c          | 150 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 lib/s390x/asm/uv.h
 create mode 100644 s390x/uv-guest.c

-- 
2.25.4
