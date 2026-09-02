Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDB3822BE;
	Wed,  2 Sep 2026 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329731; cv=none; b=axAwFOdnqIwp5kcVa981b+DetpHsRaF9dWOqs2qzxZ2f4nD6SEhir/6GjrInJEGS7lk11m9ahZ201vK0R4z14Yk0FHRK4quaMWeX4iYtUjfCSReyGvbxhV8YR513SQWnHahdAWgPi1+/dvzr2r9yv44CA2xUerkz3Y+F+J6X+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329731; c=relaxed/simple;
	bh=qCPmEOizwwxPSEOajJk71IyfzkrCx0rBoPyriTWIfnI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NAfiUofrLONQaLreXa9aF/R7OXc+vLqeT4r04wHr7esyzQnHB6kraM6LK5P9gtwjEAVLpfl8UAR74MGztHXW02RCNmUx3d6md5r9/xGFL4oE4TFjfhwHx4mYRdlMdtIRPJ3iixWmHCozQ07YPmFU/a7b+ISChXG+VNwMlKdR/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drZbWKHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drZbWKHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195291F000E9;
	Wed,  2 Sep 2026 06:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788329730;
	bh=GmSsU1jxZJ3K3cHXPdQ2pwKw5aWYndJA6ll/0Ff4QV8=;
	h=From:Subject:Date:To:Cc;
	b=drZbWKHPEVv1/wUpkmlyciVkocNy5ez0dMGtcuXpx5sJbb1MQ1ZxrtbDujmpD065R
	 e402b22GtB3geWHpTHo56KoLzNEi+2eLEW9lOYqIQZ4dpxiIMqzkFyl3RTEk5x+huf
	 WQBKX/4jZv/Bc+QxkHuU7ofEwn8DyOSBncnPRHXV75QENbucfUoTaOn6ui9+4F4Ukx
	 M//UQjTFAuG+ebFeGq3aBvx0sr0LcHTEydaJpubgXCUE5qnbb0k2+IETFHMTIrgWHW
	 fmDRDvCcBcp+Pb+ezYSY9XZbCnKURk1wjDGCOigfDEKfA2E8JRiZPoyEX8LZyrZ5O4
	 n2Lv0DESNwnOw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/4] KVM: s390: replace page allocator calls with kzalloc()
Date: Wed, 02 Sep 2026 09:15:12 +0300
Message-Id: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ7CIBAE0F9p9uwaoFGqv2I8wLLa1YiG1cak6
 b8L9fgmMzODchFWOHYzFJ5E5Zkr7KYDGkO+MkqqBmfc3gxuQO0PBu/TA52xu2iS9z4R1Pqr8EW
 +69Xp/Ld+4o3p3fatEYMyxhIyjS1a6bc9FrKwLD9kkKdyiwAAAA==
X-Change-ID: 20260828-s390-kvm-2015b0d777dc
To: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.17-dev

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-kvm

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

---
Mike Rapoport (Microsoft) (4):
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the STHYI buffer
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI buffer
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB
      KVM: s390: Replace get_zeroed_page() with kzalloc() for sie_page2 and CMMA

 arch/s390/kvm/s390/intercept.c |  9 +++++----
 arch/s390/kvm/s390/interrupt.c |  8 ++++----
 arch/s390/kvm/s390/priv.c      | 19 ++++++++++---------
 arch/s390/kvm/s390/s390.c      | 12 ++++++------
 4 files changed, 25 insertions(+), 23 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260828-s390-kvm-2015b0d777dc

--
Sincerely yours,
Mike.

