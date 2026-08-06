Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E43E7BB7;
	Thu,  6 Aug 2026 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047735; cv=none; b=i3TcWpBPW/mbEP8afts6UKDQI5N4zLmVo+N3hIO65mjF3sk4heO3yRIq/4mUl5irCXBz4WbubgcbYpWI3V3PcrsDKJNiUl8fFOcnolt7hAWif+J96Fj0byH1yhum9aEeyQvyDYzTrI5aFk3MoHnV8areXU2L8sfgtOFNdrw7DnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047735; c=relaxed/simple;
	bh=36K49AEfeagBmppZKl01/mLZsA6meHDNHWRaA8PXigM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JVISN5JKc8G2GcfddF2OIWisVXBH06oBxKtdt1EzjFyTUAv4Ggrpy8TC6h+rFFELRupVQjBmJYr1R8R8Oqa6FJXhI8pVnMlYRimd/dKDetmMQLaHy8uEfBPLnQomeUOb/oz3ccdZeaeanvVdJTpBjpPpOiLVp+D0AYqnLusuFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hynVvmV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hynVvmV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BAB1F000E9;
	Thu,  6 Aug 2026 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047730;
	bh=jcHucSQGZG2mJUgxwNPfPL6Y2CV6Qk0U4YRTMIGE4LU=;
	h=From:Subject:Date:To:Cc;
	b=hynVvmV1NpBBoEEy0gO/z1/Pv3PFrDsPl4hf9m+UEGBSnZr6Ek6+d0acIjKSwcaBg
	 h8+GeFzduD0e91UFgdI9JzhbvN9FcGy/a9DqFg8VL/iaSIeyeh9clqw9pUWC9TY5ng
	 MTu67puVBIgFxiv+CWu+3yze3m5SIrDGzufxCnV++QAesxeVv66YeC7Qbf5Cl5C+qH
	 yJO7CcZ1Kc3GclTNFxadXFVKdd5HYgu7jDd23K5pPgJMsvGk4SG/6NkNf9VNF+bJkR
	 D0RNHDtOiNlao1Em6A4/ZjGPjmcoaKwxSyCX6J6SyhK7RIkiadq3U17T5zk37unfUF
	 myzUvJaBpBmNw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v4 00/20] mm/rmap: index MAP_PRIVATE file-backed folios by
 anonymous pgoff
Date: Thu, 06 Aug 2026 21:21:25 +0100
Message-Id: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMbsdGoC/33OQW7DIBAF0KtErIMFGBu7q96jygImg0NimQhc0
 iry3QNOFqkqefmlmff/nUQMDiP52N1JwOSi81MOcr8jcNLTgNQdcyaCiZYpzqmRNIIetRmRgr/
 R5MJMr4O3lmoGwNBwaaAlGbgGtO5nxb8Ozxy/zRlhLmK5OLk4+/C7tide7gj4hKHiqhNKNrypq
 8HN1XiOnxcME46VD0P5fO1RW3sSp4yCFbLnDC3r5btRBiWxVj4twTYtkS1xbGSvGqVVa/9Z9bv
 Vb1p1trBDsGhRd1z8sZZleQDfWDMMlgEAAA==
X-Change-ID: 20260711-b4-scalable-cow-virt-pgoff-a0cc0eb14bc6
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
 linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 syzbot@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19421; i=ljs@kernel.org;
 h=from:subject:message-id; bh=36K49AEfeagBmppZKl01/mLZsA6meHDNHWRaA8PXigM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJK3px+sEIowkzr5yH/mRMUWLckys6MWsbpFNtyW/XGp
 EuB8vbrOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCROBWGv3JPav8vvbVf94j0
 j8a2i2Gyrja/VaKOxqtcyN1+zfu+ajojw33n4suR/0MS5L/Nlrv7dLJtI7Ox+yuOvrbIl3dWJpp
 cZwEA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

In memory management we've managed to manufacture a great deal of confusion
around the concept of anonymous memory. We have:

1. 'Pure anon' memory - anonymous VMAs whose folios are anonymous and
   swap-backed (thus for reclaim purposes, treated as anonymous). These are
   simple enough.

2. shmem - file-backed VMAs, file-backed folios (from rmap perspective) so
   present in the page cache and mapped by an address_space object, but
   whose folios are also swap-backed (thus treated as anonymous for reclaim
   purposes).

3. MAP_PRIVATE-mapped /dev/zero - a strange beast whose VMAs have
   vma->vm_file set, but which clears vma->vm_ops to satisfy
   vma_is_anonymous(), resulting in VMAs that were mmap()'d referencing a
   file, but are in every other sense anonymous, including the folios.

4. Other MAP_PRIVATE-file backed mappings - These possess file-backed VMAs
   and have file-backed folios until CoW'd, at which point those CoW'd
   folios are anonymous.

This series fixes issues 3 and 4.

In order for us to traverse VMAs using the reverse mapping, we require two
fields - folio->mapping and folio->index. The first tells the rmap code
where to look for VMAs, and the second tells it at which offset the folio
starts within the referenced object.

For anonymous folios, folio->mapping points at an anon_vma object. For
file-backed folios, it points at an address_space. And:

* For file-backed folios folio->index is simply the page offset of the start
  of the folio within the file.

* For anonymous folios belonging to pure anon mappings, folio->index is
  equal to the anonymous page offset of the folio.

* For anonymous folios belonging to file-backed mappings (i.e. CoW'd folios
  of a MAP_PRIVATE file-backed mapping), folio->index is equal to the file
  page offset.

This series establishes a new anonymous page offset property of VMAs to
allow us to map anonymous folios at their anonymous page offset, consistent
with pure anon.

The purpose of doing so is to lay the foundations for the scalable CoW
work. This is necessary because scalable CoW looks in the maple tree for
the VMA located at folio->index << PAGE_SHIFT, before falling back to
looking up tracked remaps if necessary.

The MAP_PRIVATE file-backed case means that folio indices will very often
conflict with one another and this remap tracking becomes substantially
more contended, and of course the fast path can never be used.

This also makes it possible, in future, to unshare anonymously mapped
folios with deep fork hierarchies on remap, eliminating the need for remap
tracking in the vast majority of cases.

Similar to page offset of pure anonymous VMAs, we update the anonymous page
offset of unfaulted file-backed VMAs on remap, but do not once
CoW'd (i.e. vma->anon_vma is non-NULL).

Overall, there is little impact on mergeability, which remains exactly the same
for pure anonymous and shared file-backed mappings, with the only impact being
on MAP_PRIVATE-mapped file-backed mappings, which must now match on anonymous
page offset as well as file page offset to be merged.

To fail to merge like this would require CoW'ing the mapping, then finding
another VMA with identical file and compatible page offset to remap next
to.

This is therefore very much an edge case that should have very little
impact (and which scalable CoW may very well address in any case).

We also address the outlier case of MAP_PRIVATE-/dev/zero mappings which
have file page offset but satisfy vma_is_anonymous() by making them truly
anonymous.

This is low-risk as for anything meaningful these mappings behave
anonymously, but it is very beneficial to do so as we eliminate an odd
corner case, and those are notorious for attracting subtle bugs.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
v4:
- Updated tags (thanks everyone!)
- Adjusted some prose as per David.
- Adjusted whitespace to 2 tabs in 2/15 as per David.
- Improved linear_page_index(), __linear_anon_page_index() to be more
  succinct in 2/15 as per David and updated commit message to reflect it.
- Added commit to provide vma_[flags_]is_cow_mapping() - nearly all callers
  are calling is_cow_mapping() as is_cow_mapping(vma->vm_flags) so just
  provide a helper to do this for them.
- In the same commit update all is_cow_mapping() callers and remove the
  now-unused function.
- Change linear_anon_page_index() to assert on !CoW mapping using
  vma_is_cow_mapping() in 2/15 as per David.
- Updated 4/15 to output index differently depending on whether the VMA is
  a CoW mapping or not or whether the file index differs from the anon
  index as per Gregory.
- Updated 6/15 to change the 'update page offset' logic in copy_vma() to
  not be gated on CoW or VMA_SHARED_BIT as discussed with David.
- Updated 6/15 to improve the 'faulted in anon vma' assert stuff. It was
  very unclear so rename the variable sensibly and update the comment.
- Added a separate commit to fix the mess that is the faulted_in_anon_vma
  and the VM_WARN_ON_ONCE_VMA() assert in copy_vma() - make it actually
  only update the vmap in cases where the VMA was replaced (backwards
  remap), update the checks to reflect this in a way that's actually
  understandable and improve the comment.
- Updated needs_adjacent_anon_gpoff() in 9/15 to use
  vma_flags_is_cow_mapping() as per David. Updated the comment to reflect
  it.
- Broke out changes to vma_address_end() into a separate patch as per David.
- Eliminated pgoff in vma_address_end() as it adds confusion - just use
  pgoff_end, which was what pgoff used to be (confusingly).
- Placed more variables in vma_address_end() as constants at the start of
  the function.
- Dropped KSM comment in 9/15 as per David.
- Dropped linear_folio_page_index() patch altogether as per
  David.
- Realised all off uffd is only anon so use linear_anon_page_index()
  throughout there and also the huge memory case for the same reason.
- Added a patch to make remove_migration_pmd() accept a folio instead of a
  page.
- Added a patch to calculate large folio index using PFN as suggested by
  David, eliminating the need for linear page index lookup at all.
- Added a patch to add self merge VMA userland tests.

v3:
- Renamed virtual page offset to anonymous page offset across the series as
  per David and adjusted prose to reflect it.
- As part of the rename, eliminated  vma_anon_pgoff_addr() and the
  conflicting vma_[start, end]_anon_pgoff() functions by passing anon pgoff
  to the merge logic and having that figure out which page offset to use,
  significantly simplifying things.
- Introduced needs_adjacent_anon_pgoff() to be really clear about what the
  merge logic is doing.
- Passing through the anon pgoff fixes the issue Sashiko raised with shared
  file-backed mappings having incorrect anon pgoff (inconsequential but a
  wrinkle nonetheless).
- Dropped unnecessary needs_rmap_locks change in 9/15 - this checks to see
  if rmap locks need to be taken due to the range being moved
  backwards. Since both file-backed and anon page offset are updated on
  such a move, it suffices to check only the former. Updated commit message
  to reflect it.
- Sashiko complained about a couple missing .is_anon_walk entries in
  pvmw's - page_mapped_in_vma() and migrate_vma_collect_huge_pmd() -
  however neither impact anything - the field is only meaningful for
  vma_address_end() if nr_pages > 1 and neither site is impacted. Moreover,
  neither site sets pgoff either. Update the commit message to explain
  this.
- Renamed is_anon_walk to pgoff_is_anon and document that pvmw->pgoff is
  only meaningful if pvmw->nr_pages > 1.
- Highlighted the user-visible changes to /dev/zero being true-anon in the
  relevant commit message as per Yang.
- Fixed a bug in the proc-self-map-files-00[1,2].c procfs selftests - the
  code was trying to MAP_PRIVATE 'an arbitrary file' then asserts that
  file-backed procfs entries exist, but happened to choose
  /dev/zero. Updated to the guaranteed-available /proc/self/exe, as
  reported by Mark.
- Fixed an issue with drivers that intentionally mark vma->vm_ops as NULL
  (using the legacy ->mmap callback). If they do this set dummy ops, which
  is what they meant. The mmap_prepare case is fine as nobody does this
  there and this will be fixed when all drivers are finally converted to
  mmap_prepare. As reported by Sashiko.
- Added some missed VMA selftest vma_start_[anon]_pgoff() conversions in
  the merge test commit as per Sashiko.
- Various small prose/comment fixups.
https://patch.msgid.link/20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org

v2:
- Removed incorrect assert on always-NULL folio from 7/15, as per syzbot.
- Updated 2/15 so linear_virt_page_index() checks for vma_is_anonymous() as
  well to be cautious about 'special' (VDSO, VVAR, etc.) VMAs accidentally
  being asserted when CONFIG_DEBUG_VM is set, as per Sashiko.
- Updated commit message of 9/15 to mention the subtle change in NUMA
  interleaving behaviour, as per Sashiko.
- Updated 10/15 to assert virtual page offset for adjacent VMAs for various
  VMA userland tests, as per Sashiko.
- Updated 13/15 to remove the !vma->vm_file check altogether after
  MAP_PRIVATE-/dev/zero is made pure anon in vma_start_virt_pgoff().
- Updated 12/15 to check that the /dev/zero device is a character device
  since it turns out that block and character devices have their own
  separate major/minor device number namespaces... :) as per Sashiko.
- Updated 12/15 to fix a bisection hazard where vma->vm_ops would be
  overwritten by vma_dummy_vm_ops for MAP_PRIVATE-/dev/zero, as per
  Sashiko.
- Updated 12/15 to fix another bisection hazard (...!) due to
  ordering of vma_set_anonymous(). Removed in 13/15.
- Added comments to __vm_virt_pgoff[lo, hi] fields referencing
  vma_start_virt_pgoff()'s comment to be clearer what these are as per
  Xu Xin in 1/15.
- Various typo fixes + cleanups in prose.
- Updated the cover letter to point out that the MAP_PRIVATE-/dev/zero
  issue is addressed in this series too.
https://patch.msgid.link/20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org

v1:
- Rebased onto mm-new.
- Dependent series heavily reviewed and looks highly likely to land, so
  un-RFC.
- Added explicit check for /dev/zero and removed ability for arbitrary
  mmap/mmap_prepare hooks to make themselves anonymous.
- Made MAP_PRIVATE-/dev/zero mappings truly anonymous.
- Added MAP_PRIVATE file-backed mapping merge test to selftests.
- Added a MAP_PRIVATE-/dev/zero VMA userland test to assert that the VMA
  really is made anonymous.
- Added MAP_PRIVATE-/dev/zero merge tests to selftests.
- Fixed missed virtual page index site in try_to_merge_with_ksm_page().
- Updated folio_within_range() to use virtual page offset for anon
  folio. This had no impact as it is only called for large folios at the
  moment (and MAP_PRIVATE-file backed mappings can't currently be backed by
  a large folio) but making the change now protects us for the future.
- Fixed typos etc.
https://patch.msgid.link/20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org

RFC:
https://patch.msgid.link/cover.1782745153.git.ljs@kernel.org

To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Jann Horn <jannh@google.com>
To: Pedro Falcato <pfalcato@suse.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
To: Miaohe Lin <linmiaohe@huawei.com>
To: Naoya Horiguchi <nao.horiguchi@gmail.com>
To: Rik van Riel <riel@surriel.com>
To: Harry Yoo <harry@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
To: Kees Cook <kees@kernel.org>
To: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Nico Pache <npache@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
To: Dev Jain <dev.jain@arm.com>
To: Barry Song <baohua@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
To: Matthew Brost <matthew.brost@intel.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Rakie Kim <rakie.kim@sk.com>
To: Byungchul Park <byungchul@sk.com>
To: Gregory Price <gourry@gourry.net>
To: Ying Huang <ying.huang@linux.alibaba.com>
To: Alistair Popple <apopple@nvidia.com>
To: Peter Xu <peterx@redhat.com>
To: Xu Xin <xu.xin16@zte.com.cn>
To: Chengming Zhou <chengming.zhou@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
To: Alex Deucher <alexander.deucher@amd.com>
To: Christian König <christian.koenig@amd.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
To: Huang Rui <ray.huang@amd.com>
To: Matthew Auld <matthew.auld@intel.com>
To: Thomas Hellström <thomas.hellstrom@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: James Clark <james.clark@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: John Hubbard <jhubbard@nvidia.com>
To: Muchun Song <muchun.song@linux.dev>
To: Oscar Salvador <osalvador@suse.de>
To: Chris Li <chrisl@kernel.org>
To: Kairui Song <kasong@tencent.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
To: Nhat Pham <nphamcs@gmail.com>
To: Baoquan He <baoquan.he@linux.dev>
To: Youngjun Park <youngjun.park@lge.com>
Cc: ljs@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org

---
Lorenzo Stoakes (ARM) (20):
      mm/vma: introduce VMA anon page offset field and add helpers
      mm: provide vma_[flags_]is_cow_mapping() and remove is_cow_mapping()
      mm: introduce linear_anon_page_index()
      mm: abstract vma_address() and introduce vma_anon_address()
      mm: update print_bad_page_map() to show anon index if appropriate
      mm: introduce and use vma_filebacked_address()
      mm/vma: fix self-merge check in copy_vma()
      tools/testing/vma: add tests for copy_vma() self-merge
      mm: propagate VMA anonymous page offset on map, remap, split + merge
      mm/rmap: track whether the page VMA mapped pgoff is anonymous
      mm: clean up vma_address_end()
      mm/huge_memory: update remove_migration_pmd() to accept a folio
      mm/migrate: calculate large folio page index using PFN
      mm/rmap: use anon pgoff to track MAP_PRIVATE file-backed anon folios
      tools/testing/vma: expand VMA merge tests to assert anon pgoff
      tools/testing/selftests/mm: test anonymous page offset merge behaviour
      mm/vma: only permit MAP_PRIVATE /dev/zero to be mapped anonymous
      mm/vma: make MAP_PRIVATE-mapped /dev/zero mappings truly anonymous
      tools/testing/vma: add test to assert MAP_PRIVATE-/dev/zero is anon
      tools/testing/selftests/mm: add MAP_PRIVATE-/dev/zero merge tests

 arch/s390/mm/gmap_helpers.c                        |   2 +-
 drivers/char/mem.c                                 |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   4 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |   2 +-
 drivers/gpu/drm/panthor/panthor_gem.c              |   2 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |   2 +-
 drivers/gpu/drm/xe/xe_device.c                     |   2 +-
 fs/proc/task_mmu.c                                 |   2 +-
 include/linux/mm.h                                 |  89 +++++++++--
 include/linux/mm_types.h                           |  12 ++
 include/linux/pagemap.h                            |  39 ++++-
 include/linux/rmap.h                               |   4 +-
 include/linux/swapops.h                            |   6 +-
 kernel/events/uprobes.c                            |   2 +-
 mm/gup.c                                           |   2 +-
 mm/huge_memory.c                                   |  26 ++--
 mm/hugetlb.c                                       |   2 +-
 mm/internal.h                                      |  89 +++++++----
 mm/interval_tree.c                                 |   4 +-
 mm/ksm.c                                           |   6 +-
 mm/memory-failure.c                                |   4 +-
 mm/memory.c                                        |  38 +++--
 mm/mempolicy.c                                     |   2 +-
 mm/migrate.c                                       |  21 ++-
 mm/mremap.c                                        |   6 +-
 mm/page_vma_mapped.c                               |   6 +-
 mm/rmap.c                                          |  22 +--
 mm/userfaultfd.c                                   |   4 +-
 mm/vma.c                                           | 165 ++++++++++++++++-----
 mm/vma.h                                           |  92 +++++++-----
 mm/vma_exec.c                                      |   2 +-
 mm/vma_init.c                                      |   1 +
 mm/vma_internal.h                                  |   1 +
 tools/testing/selftests/mm/merge.c                 | 161 ++++++++++++++++++++
 .../selftests/proc/proc-self-map-files-001.c       |   2 +-
 .../selftests/proc/proc-self-map-files-002.c       |   2 +-
 tools/testing/vma/include/dup.h                    |  98 +++++++++++-
 tools/testing/vma/shared.c                         |   3 +-
 tools/testing/vma/tests/merge.c                    |  49 ++++--
 tools/testing/vma/tests/mmap.c                     |  50 +++++++
 tools/testing/vma/tests/vma.c                      |  50 ++++++-
 tools/testing/vma/vma_internal.h                   |   1 +
 42 files changed, 865 insertions(+), 220 deletions(-)
---
base-commit: 5093dba1014c1d7f7e247fd118f0fa8f22136046
change-id: 20260711-b4-scalable-cow-virt-pgoff-a0cc0eb14bc6

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

