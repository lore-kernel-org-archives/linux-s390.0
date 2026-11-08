Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127745;
	b=dzNF/b+q/KMGmXCrNvO7uaKzQW3IMfkluB2LAMXpk0eYuehDsB08uxP8LySnAe0Igk3I
	 U3PzDTZnndG8dvAXAmes4wR6URQ6df3mQPpsW31bbVdPD3JAo0Z66ENn0P6PpYG0acJa3
	 PAyyGp/bsmVNAjAP42TiBEtWn48wJG4A0Q50clo1Leay+f5miLEpDSs1o9UTd8hpoaWgL
	 mUqPCNMu3xSCre4ORy7BxuYOyyZmxqrw/idrpKFNo/IC2g/YCpBCrJK8NRLfDnvxgLzwT
	 bvP2mckV57nBRBpDtY9ztCQIkZHS0pgyL/kLazObOE5DoehLs4BR7pxJiqZP3q4Jkgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127745;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=c8Q0bWXQ6RT9rRjdC0o9m0ug2qpmw/mvlFkhYeZZerQ=;
	b=5sgH1rpmNo9e4AIdN1DP1vb6KT5NzOr55LDnTa7V1Q10sxZ1w1vNDGmFTymWXu2Xj7l8
	 jrqtckfnkIQAeLuf4A8yWk2r3G2Cb5cdHDzTkf50ayLuj1kE8oDIa7cx1vvsl1JGtH+1+
	 i15vu1SGL7jSaMXFNrIZkP1f2BySDU/oTO0CGNTE8Y47QtU0rDI3QXvjwWjLiDTlzG0Ep
	 Yfn/tkJIe5BzJFMYisaBrTJ43nKY6mf1FSXGqxUDm7batGRl0eqGWWCgy5WFjH/T9jWqu
	 qc1Nk6INvbRJG55fUsUgkYgh7eAB9a43KlJTzQhV8wu9F2EPWXRhbQuJetKGelMLB9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NcxBb/bP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD84606A31C;
	Sun,  8 Nov 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcxBb/bP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952B21F0089F;
	Sun,  8 Nov 2026 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127744;
	bh=c8Q0bWXQ6RT9rRjdC0o9m0ug2qpmw/mvlFkhYeZZerQ=;
	h=From:Subject:Date:To:Cc;
	b=NcxBb/bPYVzLh8IxCRGKE30mePt8i/4rBZ8VVI3ef0E7fDxYHXlazGBuKbJhZ2Q2G
	 GnPalGlnzQfIgbeidFRVYxH2p1f+XJb84Z5+7p074/l07N9h2ekPpUP+kZVt59V2q4
	 pdNplLXDejZWvHGmUlf3s5OVVAz2VFeF8AlE1ShlQd2bDXKqSXu6YJp+BQv3u9yCWi
	 Ybs9v83cYMnoot+oKN8gs9GI5HKxZ1ZsX3hs4cYQihKu46kA8ih77gMJJgr3aKerYD
	 mlHmF7dGHoCDO45XxO21DhfqTZs9Xvkw2ScxCPizfmqU7+cpLCXqTJduNDEPA8C9Zw
	 VLR7AskqBd3sQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/5] s390/char: replace page allocator calls with
 k[mz]alloc()
Date: Sun, 08 Nov 2026 10:48:57 +0200
Message-Id: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMTQ6CMBBGr0Jm7cS2JGK9imHRlgHGxGJm0GgId
 7fV5ft+3gZKwqRwaTYQerHykgvYQwNpDnki5KEwOONOxpsOtfUGSyUoFIYPOh9NG2wcu7OF8no
 Ijfz+Ga/9n/UZb5TWqqmLGJQwSshprtEiPHE+3oOuJLDvX8/1gHqTAAAA
X-Change-ID: 20260907-s390-char-ready-29b03a1bf781
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev

This the next episode of conversion of page allocator calls to kmalloc
family :)

This series covers s390 character drivers other than SCLP.

= tl;dr cover letter copied from the previous posts:

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

The patches are deliberately kept small, so that every conversion can be
reviewed, and if needed reverted, on its own.

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-char

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

---
Mike Rapoport (Microsoft) (5):
      s390/zcore: Replace __get_free_page() with kmalloc()
      s390/vmur: Replace __get_free_page() with kmalloc()
      s390/vmlogrdr: Replace get_zeroed_page() with kzalloc()
      s390/uvdevice: Replace get_zeroed_page() with kzalloc()
      s390/hmcdrv: Replace page allocator calls with k[mz]alloc()

 drivers/s390/char/diag_ftp.c     |  5 +++--
 drivers/s390/char/hmcdrv_cache.c | 18 +++++++++---------
 drivers/s390/char/hmcdrv_ftp.c   | 14 +++++++-------
 drivers/s390/char/uvdevice.c     |  4 ++--
 drivers/s390/char/vmlogrdr.c     |  4 ++--
 drivers/s390/char/vmur.c         |  8 ++++----
 drivers/s390/char/zcore.c        |  8 ++++----
 7 files changed, 31 insertions(+), 30 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260907-s390-char-ready-29b03a1bf781

--
Sincerely yours,
Mike.

