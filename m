Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgLROS6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Dec 2020 09:18:58 -0500
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 0/4] s390/kvm: fix MVPG when in VSIE
Date: Fri, 18 Dec 2020 15:18:07 +0100
Message-Id: <20201218141811.310267-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

The current handling of the MVPG instruction when executed in a nested
guest is wrong, and can lead to the nested guest hanging.

This patchset fixes the behaviour to be more architecturally correct,
and fixes the hangs observed.

Claudio Imbrenda (4):
  s390/kvm: VSIE: stop leaking host addresses
  s390/kvm: extend guest_translate for MVPG interpretation
  s390/kvm: add kvm_s390_vsie_mvpg_check needed for VSIE MVPG
  s390/kvm: VSIE: correctly handle MVPG when in VSIE

 arch/s390/kvm/gaccess.c | 88 ++++++++++++++++++++++++++++++++++++++---
 arch/s390/kvm/gaccess.h |  3 ++
 arch/s390/kvm/vsie.c    | 78 +++++++++++++++++++++++++++++++++---
 3 files changed, 159 insertions(+), 10 deletions(-)

-- 
2.26.2
