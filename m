Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgIWNsP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 09:48:15 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PATCH kvm-unit-tests v2 0/4] s390x: Add Protected VM support
Date: Wed, 23 Sep 2020 15:47:54 +0200
Message-Id: <20200923134758.19354-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org

Add support for Protected Virtual Machine (PVM) tests. For starting a
PVM guest we must be able to generate a PVM image by using the
`genprotimg` tool from the s390-tools collection. This requires the
ability to pass a machine-specific host-key document, so the option
`--host-key-document` is added to the configure script.

For everybody's convenience there is a branch:
https://gitlab.com/mhartmay/kvm-unit-tests/-/tree/pv_v2

Changelog:
 v1 -> v2:
   + rebased
   + patches 1-3:
     - add r-b from Conny, Andrew, and David
   + patch 4:
     - add r-b from Janosch
     - renamed ${testname} to $testname (David)
     - fix `print_result` function calls and the arguments used
 RFC v2 -> v1:
  + Rebased
  + patch 1:
    - add r-b from Andrew
  + patch 2:
    - add explicit dependency on config.mak (Andrew)
    - add comment about the order of sourcing (Andrew)
  + patch 3:
    - drop dummy function (Andrew)
    - add arch_cmd hook function (Andrew)
  + patch 4:
    - rephrased the documentation of the configure option (Conny)
    - Skip test case if a PVM image wasn't built or the host-key document wasn't set (Conny)
    - Run PV tests by default
 RFC v1 -> RFC v2:
  + Remove `pv_support` option (Janosch, David)
  + Add some preliminary patches:
    - move "testname guard"
    - add support for architecture dependent functions
  + Add support for specifying a parmline file for the PV image
    generation. This is necessary for the `selftest` because the
    kernel cmdline set on the QEMU command line is ignored for PV
    guests

Marc Hartmayer (4):
  common.bash: run `cmd` only if a test case was found
  scripts: add support for architecture dependent functions
  run_tests/mkstandalone: add arch_cmd hook
  s390x: add Protected VM support

 README.md               |  3 ++-
 configure               |  9 +++++++++
 run_tests.sh            |  3 ---
 s390x/Makefile          | 17 +++++++++++++++--
 s390x/selftest.parmfile |  1 +
 s390x/unittests.cfg     |  1 +
 scripts/common.bash     | 21 +++++++++++++++++++--
 scripts/mkstandalone.sh |  4 ----
 scripts/s390x/func.bash | 36 ++++++++++++++++++++++++++++++++++++
 9 files changed, 83 insertions(+), 12 deletions(-)
 create mode 100644 s390x/selftest.parmfile
 create mode 100644 scripts/s390x/func.bash

-- 
2.25.4
