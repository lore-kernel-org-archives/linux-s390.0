Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853781;
	b=NOfQ38JO11sifmwy3zuCrnTuRAAnuUrmfSbpmNseZ3g3meMc9RBpaq6NpjrmAfbUHoie
	 Z4ohNhHZPd5b/gcrZ0ju64H7UqAB2qdEFm8RBZPEmXeDovWSxuKHXw7zdly6POvFHZeV/
	 LvI6o8nDWh52hITGheJoWheoM3cWcVytVJro6223Vog/radzSRGfw8S8woJ+VbJ47sqZF
	 vU4ivQaWy6G/WOz95lkVAltfABp5RH4AvWTk8yBPeFUUVAxm5VvyUaZfTHece8bl99iQC
	 emehI3fuFG5B26dlf9t+EFJfSDtYMclbzCMD2AGGUm7kbwFWhvm/uK47vXyBkh2BJow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853781;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4Dt8UvYqN45Q1jq3hRtmbwqb95X+fOufXdlZIkND6MQ=;
	b=JeYsZH9T10Pqed7n8Pwp9w87101qRuxwiClCiBx1d1l3o0cnICAMluFE3zk6SmRu5FT+
	 FswlzaenQr+GpiYU1pvHIM+qz3JU9HF1HN7jhH5wOKip3BQTYgCCbbIJgNoyJrRZ+Sf9D
	 5JsRIecJvhoeogBv61VOOazZ/M4mQvN93oYPKa2BW6aXyMCSiVr0ghsY3SFPU+D+mHbg0
	 6rV5xEdZPg3FjbNsdh2XSybMTqOmOp6KIx6+cEY1BKCnjpv58wX+2Fao0KeD31Zb/3E9q
	 5+R7FQMgUA2vBOtmODhPfR+FmDup5h3IRlI09R9HcJwEr9Rv9Eaw7t3hj6PGJmwWzNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohNH5Gne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68998606A31C;
	Mon, 16 Nov 2026 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohNH5Gne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F361F000C4;
	Mon, 16 Nov 2026 18:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853781;
	bh=4Dt8UvYqN45Q1jq3hRtmbwqb95X+fOufXdlZIkND6MQ=;
	h=From:Subject:Date:To:Cc;
	b=ohNH5GneK3A7EOdyU+Jd+fzHkBpcFAjOiqXLLG40Bqz4EMUQxQHbMaxWLGrAUgpr1
	 D8dmX/P08z4tLfV/byuKIwTnl+WtT/bv39FXW6XhyzaGg3f1EYfOC9ccyoM//9l1v3
	 xWaHHTfTDCJUUEn0ImVtvQ//nKjUAAHnsXH8iyEMOXKx+017NpL431mj4IILZYGc/1
	 i2RsoQ+vgBOunWpt9AceF9lFiqemwF3WE61glPMXrmU0r3Ub2cTHHjVD+tjqYJYNMy
	 u26wa2YrhEf6WzmUX9fxU5bFFW2lk5eEDazTgk0t2C+q4lSWxfylvjoypdv5AI+JxX
	 LFFqt1acbeNFw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 00/15] mm/hugetlb: various fixes
Date: Mon, 16 Nov 2026 19:29:21 +0100
Message-Id: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/13NQQqDMBCF4auEWZsyiWIlq96jSNE4iWlFSxJDi
 3j3Eks3XT74+N8GgbyjAIpt4Cm54JYZFJMFAz12syXuBlAMJMpaoDxz414UbuNqKU49l7oyKI2
 pS6ygYPD0dABQ7Np+d1j7O+mYI1mMLsTFv4/DJLL7tZu/dhIceYcdluXQiwbN5UF+pum0eAvtv
 u8f2dLrs70AAAA=
X-Change-ID: 20261027-fixes_hugetlb-2c4f02ff6304
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>, 
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 luojiajun <luojiajun3@huawei.com>, Josef Bacik <josef@toxicpanda.com>, 
 stable@kernel.org, Ackerley Tng <ackerleytng@google.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>, Chris Mason <mason@kernel.org>, 
 Daehyeon Ko <4ncienth@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982; i=david@kernel.org;
 h=from:subject:message-id; bh=9K2LhqofrRy5sX+UjJYGABWwyD7YIUGt24m0J81fj3w=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e7d9aJdxWxh97VTWrwZeX82i0FNMrP9nBH5xPaxW+
 iXj9Vb9jlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbi853hn85kBYbLPz6UHLG3
 yK7csK217OalmjNn4jnXB6Ry7XvyvInhv6OPWYy8xy4Fu/vTnTibDt3Yl/yU87Z1x8952o3a19v
 F+QE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

v2 of the hugetlb fixes. There will be more at some point ... let's
drag these over the finishing line.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- Rebased on top of akpm/mm-stable
- Applied tags
- "mm/hugetlb: compare against persistent count when freeing lowmem folios"
  and "mm/hugetlb: account temporary folios separately"
 - Use const struct hstate pointers
- "mm/hugetlb: fix reservation leak on min_size= mounts"
 - Clarify that this is only an accounting error in the description
- "mm/hugetlb: account restored reservations before freeing folios"
 - Drop RFC
 - Don't allocate surplus pages for restored reservations
 - Free unused surplus pages directly instead of via free_huge_folio()
 - Document available_huge_pages() and assert that hugetlb_lock is held
- "mm/hugetlb: delay anon folio rmap removal until after the TLB flush"
 - Drop RFC
 - Flush delayed rmaps in hugetlb_unmap_range() (due to rebasing)
 - Move hugetlb_folio_restore_rsv_on_unmap() declaration to mm/internal.h
- Link to v1: https://patch.msgid.link/20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org

---
Chris Mason (3):
      hugetlbfs: do not grow a sealed file in mmap()
      mm/hugetlb: keep surplus folios that are reserved
      mm/hugetlb: fix reservation leak on min_size= mounts

David Hildenbrand (Arm) (10):
      hugetlbfs: fix integer overflow in fallocate()
      mm/hugetlb: compare against persistent count when freeing lowmem folios
      mm/hugetlb: preserve reservations when shrinking on HIGHMEM
      mm/hugetlb: account temporary folios separately
      mm/hugetlb: fix mremap() racing with page migration
      mm/hugetlb: serialize page-cache allocations with truncation
      mm/memfd: recheck the page cache before allocating a hugetlb folio
      mm/hugetlb: count again if the reserve map shrank
      mm/hugetlb: account restored reservations before freeing folios
      mm/hugetlb: delay anon folio rmap removal until after the TLB flush

Josef Bacik (2):
      mm/hugetlb: keep surplus folios when the pool shrinks
      hugetlbfs: fix unmapping folios from private VMAs

 Documentation/mm/hugetlbfs_reserv.rst |  30 +--
 arch/s390/include/asm/tlb.h           |   5 +-
 fs/hugetlbfs/inode.c                  |  36 ++-
 include/asm-generic/tlb.h             |   5 +-
 include/linux/hugetlb.h               |  17 ++
 mm/hugetlb.c                          | 424 ++++++++++++++++++++++------------
 mm/hugetlb_internal.h                 |  24 ++
 mm/hugetlb_sysfs.c                    |   2 +-
 mm/internal.h                         |   9 +
 mm/memfd.c                            |  17 ++
 mm/mmu_gather.c                       |  16 +-
 11 files changed, 404 insertions(+), 181 deletions(-)
---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261027-fixes_hugetlb-2c4f02ff6304

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

