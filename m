Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218434;
	b=fiaEGZrkJff22NYJ/rYpHL9Q1CnOSa0VwZ/lxy14DkPfYh01XrEwwRkHV7kToc9KxdLw
	 JpL/xC4I8PtsvR2xN+9EsFfJj5Nc1JN6VnpbdmFkSmxL3Jmi9+4Je7xcnaDvND4PDdlUS
	 WnkkUeH4HMVMazUTSOzpFlBG2AoaffkpN/cnkF47zhO1cNNgRMIco+HgQIV060kvRg+Nr
	 yaPw5eF1oGX/GtPIWqyysywOW4Ob4S/uO5Q++hW3N8NUI8vCdOmM+aP5f9chMG4ihth0I
	 xg34HOnx7OnnIPjfIDu2qeltoX0YFkhZt+KKnlrHqgpOYKu3mb2dfL3nj6vzqE+A+QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218434;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zblGlkWs1OXZ9bHPBTP+AfF1wpBrK3sa+fiGbxI6Tmk=;
	b=xHxhJfiu1sQqw3kZ7zj+rz9115cWTdsrTCASZKEkFXl6FXt+w+JVzUqyBgUGHTD9JtGp
	 EAYXuJtncnKUe9k9V3aDjUu29PzZvHs57tzJHxc3pdqg/+CK5ooP13NKD75BEbr0T3oiP
	 0JGTnRH/lQcmc/3fu8vElnGsmvJp3TO/4I5HG3CgMicog/xB7U+B9D4V1J0mVVZ2kDyOL
	 Bf2OjDeEg4UjjiS6oqJZsQXoLBBj6bg+adUFJRAIW/y5YuYm60PQi5rzYrNqFrVIpJP1F
	 UPyzPWozvGU1DnfelRe9nQMtsbt7E6WywHJLLdo5CRJTDKT+Jx4wrhaOgOLfRzeK4jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OC0jqLoF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729E606A32E;
	Wed, 28 Oct 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OC0jqLoF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7580C1F01825;
	Wed, 28 Oct 2026 20:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218433;
	bh=zblGlkWs1OXZ9bHPBTP+AfF1wpBrK3sa+fiGbxI6Tmk=;
	h=From:Subject:Date:To:Cc;
	b=OC0jqLoFLAK/f7Y/IM8DLSn3wtoD+SuKLrY4GE7olSLvMuY17nKMUBtWNwwAWrUuW
	 68eQ1fXTtwD1Mkz56lvNrm8yBb2YjWoFKe5MBwR/5ZdqiSNyl09FfN8The3pXc5f1O
	 UnrwFdXA1g119nmQF6pwyJ/F0h/GnkfkMfLILeXOmj8YK63F4vv5+FWd6IXdkwhwbx
	 mGKfWkYriQmacjifaD6SgllEGlNIvY/rte/RQ7KdgkTHDZ4grM7xPNOaUOQIzL1590
	 mvFx6xd7CIyySiul2eebB73/k3iGQeWUHzP+MdDPt1R/pi4YlYfaquMD+Xp63xCRt6
	 cVyzcMIDORuKw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 00/15] mm/hugetlb: various fixes
Date: Wed, 28 Oct 2026 21:13:28 +0100
Message-Id: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAGhX4moC/yXM0QpAQBCF4VfRXNtaQ5RXkcSaZSS0Y6Xk3S0uv
 zr/uUDIMQmU0QWODhZel4AkjsCM7TKQ4j4YUGOeaCyU5ZOkGf1A+9wpNJnVaG2e6gxCszn6BiG
 p6t/iu4nM/p7AfT82vNYJcQAAAA==
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
 stable@kernel.org, Chris Mason <mason@kernel.org>, 
 Daehyeon Ko <4ncienth@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3500; i=david@kernel.org;
 h=from:subject:message-id; bh=bNNIIjvmXZOTaOJfPgSy5HmuhJm0C5N8Ej36sP+bpik=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehRelXeaZ1r1L/+uWb21rYmaZznX7zvzWpDXjLjtL4
 9XHN47d6yhlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiRtMZGc6cuvFGgkFTpbsr
 2Szz7PXbmyN4WmwFa7g3nPvV1HUzVYyRYa6t9K2elrqoaPbnQkd4l0qxFx099ebfg5s7f3hlz9G
 O5AAA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

These fixes almost finished me.

Oh. My. God, hugetlb, what have you become.

And I am not talking about good old hugetlb. I am talking about all of the
things we slapped on top of it over the years, including MAP_PRIVATE,
reservation, UFFD, accounting and much more. I mean, I kept complaining
about all that in the past, but I just had an 2 day-long reminder from
hell.

And don't get me started on some of the proposed AI fixes. Dear lord.
There is a reason why I am the author on most of these fixes. And I
try to not swear on the mailing list.

Hey, at least huge PMD sharing was not involved this time, great
success!

Anyhow, nothing here is super urgent IMHO. Just a lot of unpleasant
things and corner cases. Most of the issues reported by Anthropic, some
found by me while poking at things.

Two bigger changes as RFC. One of them documents some remaining
problems, one of both being a hard nut to crack.

I have some more complicated lower priority, hard to solve things
leftover on the hugetlb front (besides some fixes that are already on the
list), maybe I'll report them to hugetlb maintainers to share some of
the "fun". ;)

I threw some tests at it, but there are just too many combinations and
corner cases.

Next, likely we want a kernel config to disable MAP_PRIVATE and start
deprecating it. It's simply unbearable.

I won't pretend that I understood all the details of reservation and
accounting, even rewriting some of the comments took me ages. If any
fixes here go into the wrong direction, I'm happy if someone wants to
take over this series, I tried to get the heavy lifting done.

I guess, have fun reviewing? :)

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
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
      RFC: mm/hugetlb: account restored reservations before freeing folios
      RFC: mm/hugetlb: delay anon folio rmap removal until after the TLB flush

Josef Bacik (2):
      mm/hugetlb: keep surplus folios when the pool shrinks
      hugetlbfs: fix unmapping folios from private VMAs

 Documentation/mm/hugetlbfs_reserv.rst |  30 +--
 arch/s390/include/asm/tlb.h           |   5 +-
 fs/hugetlbfs/inode.c                  |  36 +++-
 include/asm-generic/tlb.h             |   5 +-
 include/linux/hugetlb.h               |  24 +++
 mm/hugetlb.c                          | 388 ++++++++++++++++++++++------------
 mm/hugetlb_internal.h                 |  11 +
 mm/hugetlb_sysfs.c                    |   2 +-
 mm/memfd.c                            |  17 ++
 mm/mmu_gather.c                       |  14 +-
 10 files changed, 361 insertions(+), 171 deletions(-)

---

base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d

change-id: 20261027-fixes_hugetlb-2c4f02ff6304

--

Cheers,

David

