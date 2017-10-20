Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 0/3] s390 refcount conversions
Date: Fri, 20 Oct 2017 10:47:47 +0300
Message-Id: <1508485670-24070-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, peterz@infradead.org, keescook@chromium.org, Elena Reshetova <elena.reshetova@intel.com>
List-ID: <linux-s390.vger.kernel.org>

This series, for S390, replaces atomic_t reference
counters with the new refcount_t type and API (see include/linux/refcount.h).
By doing this we prevent intentional or accidental
underflows or overflows that can led to use-after-free vulnerabilities.

The patches are fully independent and can be cherry-picked separately.
Patches are based on top of linux-next as of yesterday.
If there are no objections to the patches, please merge them via respective trees

Elena Reshetova (3):
  [S390] vmur: convert urdev.ref_count from atomic_t to refcount_t
  [S390] net: convert lcs_reply.refcnt from atomic_t to refcount_t
  [S390] qeth: convert qeth_reply.refcnt from atomic_t to refcount_t

 drivers/s390/char/vmur.c          |  8 ++++----
 drivers/s390/char/vmur.h          |  4 +++-
 drivers/s390/net/lcs.c            | 10 +++++-----
 drivers/s390/net/lcs.h            |  3 ++-
 drivers/s390/net/qeth_core.h      |  3 ++-
 drivers/s390/net/qeth_core_main.c | 10 +++++-----
 6 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.7.4
