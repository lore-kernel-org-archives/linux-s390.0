Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232048AbhBIPnu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 10:43:50 -0500
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 0/2] s390/kvm: fix MVPG when in VSIE
Date: Tue,  9 Feb 2021 16:43:00 +0100
Message-Id: <20210209154302.1033165-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

The current handling of the MVPG instruction when executed in a nested
guest is wrong, and can lead to the nested guest hanging.

This patchset fixes the behaviour to be more architecturally correct,
and fixes the hangs observed.

v2->v3
* improved some comments
* improved some variable and parameter names for increased readability
* fixed missing handling of page faults in the MVPG handler
* small readability improvements

v1->v2
* complete rewrite

Claudio Imbrenda (2):
  s390/kvm: extend kvm_s390_shadow_fault to return entry pointer
  s390/kvm: VSIE: correctly handle MVPG when in VSIE

 arch/s390/kvm/gaccess.c |  30 ++++++++++--
 arch/s390/kvm/gaccess.h |   5 +-
 arch/s390/kvm/vsie.c    | 101 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 121 insertions(+), 15 deletions(-)

-- 
2.26.2
