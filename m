From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] introduce page_ref_inc_return
Date: Mon, 20 Jun 2016 12:38:12 +0200
Message-ID: <1466419093-114348-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-ID: <linux-s390.vger.kernel.org>

commit 0139aa7b7fa1 ("mm: rename _count, field of the struct page,
to _refcount") changed all accesses to page->_count to use wrappers.
There is already a page_ref_dec_return and we need for kvm/s390
code the function "page_ref_inc_return" as well.

FWIW, the code is under
https://git.kernel.org/cgit/linux/kernel/git/kvms390/linux.git/log/?h=next


Can I get an ack to carry this patch via the KVM/s390 tree (will
be merged into Paolos kvm tree soon)?

David Hildenbrand (1):
  mm/page_ref: introduce page_ref_inc_return

 include/linux/page_ref.h | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.5.5

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
