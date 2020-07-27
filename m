Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgG0Jya (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Jul 2020 05:54:30 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 0/3] PV tests part 1
Date: Mon, 27 Jul 2020 05:54:12 -0400
Message-Id: <20200727095415.494318-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

Let's start bringing in some more PV related code.

Somehow I missed that we can also have a key in a exception new
PSW. The interesting bit is that if such a PSW is loaded on an
exception it will result in a specification exception and not a
special operation exception.

The third patch adds a basic guest UV call API test. It has mostly
been used for firmware testing but I also think it's good to have a
building block like this for more PV tests.


GIT: https://github.com/frankjaa/kvm-unit-tests/tree/queue

v2:
	* Page alloc instead of static memory reservation
	* Moved pgm cleanup function call to pgm handler
	* Commit message changes


Janosch Frank (3):
  s390x: Add custom pgm cleanup function
  s390x: skrf: Add exception new skey test and add test to unittests.cfg
  s390x: Ultravisor guest API test

 lib/s390x/asm/interrupt.h |   1 +
 lib/s390x/asm/uv.h        |  68 ++++++++++++++++
 lib/s390x/interrupt.c     |  10 +++
 s390x/Makefile            |   1 +
 s390x/skrf.c              |  80 +++++++++++++++++++
 s390x/unittests.cfg       |   7 ++
 s390x/uv-guest.c          | 159 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 326 insertions(+)
 create mode 100644 lib/s390x/asm/uv.h
 create mode 100644 s390x/uv-guest.c

-- 
2.25.1
