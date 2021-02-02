Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 0/2] s390/kvm: fix MVPG when in VSIE
Date: Tue,  2 Feb 2021 19:00:26 +0100
Message-Id: <20210202180028.876888-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

The current handling of the MVPG instruction when executed in a nested
guest is wrong, and can lead to the nested guest hanging.

This patchset fixes the behaviour to be more architecturally correct,
and fixes the hangs observed.

v1->v2
* complete rewrite

Claudio Imbrenda (2):
  s390/kvm: extend kvm_s390_shadow_fault to return entry pointer
  s390/kvm: VSIE: correctly handle MVPG when in VSIE

 arch/s390/kvm/gaccess.c |  26 ++++++++--
 arch/s390/kvm/gaccess.h |   5 +-
 arch/s390/kvm/vsie.c    | 102 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 119 insertions(+), 14 deletions(-)

-- 
2.26.2
