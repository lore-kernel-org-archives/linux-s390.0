From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Huge page pte protection
Date: Thu, 25 Jan 2018 16:33:16 +0100
Message-ID: <1516894398-12694-1-git-send-email-frankja@linux.vnet.ibm.com>
References: <86c5bd00-a552-1737-8db8-3f7b3c21057e@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <86c5bd00-a552-1737-8db8-3f7b3c21057e@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

So, this was stable in both pre and postcopy, at least until I stopped
postcopy and hit my BUG_ON in gmap_shadow_notify_pmd. For some reason
migration of my 10g l2 with small and big l3 takes 60s instead of ~30s
now. For the next version it will need some more love.

The second patch will be in the next version one way or another. I
just felt that gmap_pte_op_fixup looked weird in a pmd handling
function.

Janosch Frank (2):
  mm: s390: Only notify on 4k pages
  mm: s390: Rename gmap_pte_op_fixup

 arch/s390/include/asm/gmap.h |  5 +--
 arch/s390/mm/gmap.c          | 90 +++++++++++---------------------------------
 2 files changed, 23 insertions(+), 72 deletions(-)

-- 
2.7.4
