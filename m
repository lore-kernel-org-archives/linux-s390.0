Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081C3DAAC2;
	Wed, 16 Sep 2026 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560205; cv=none; b=SSUayGKehPvz5EBtsSZgMImAk8yjwBfw5h/SveknQQOWy7kCnCy3syxK02IT3zLH8snTc1WsjoXYZ5URjfDg7reYzoB8At5ztew8mxK0LNyiI4eheScLJvgojdsHJMgrhFd8qd4KnoApWkCl7q4QU/ObC60kc4TmY2FYU7usVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560205; c=relaxed/simple;
	bh=MjGoKE6CSFttY8zBcX/unB0CevQdaZZcv5ITsQGTXgk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mVXD8sVfeW7LHHF+VY+fGSbOui/GMWnKRF/4XuRv1j7dSGvCN7qs58WTBtOdC9U2rnaNomS9ptB53XcB+qmDCDf5HyGF6B2qIeiT6+fDlrB7ZCzdXWCRKQsOBenVO8Pu1YNbl5A8MUTv2FqWdUOUhF7jYdWNn+xyOeJwY+4up8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND/rEklH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND/rEklH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026951F00893;
	Wed, 16 Sep 2026 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560196;
	bh=KToEPbjMi+xk01qHZe/FhjtSbHLsQ7HONCzklzsUNhs=;
	h=From:Subject:Date:To:Cc;
	b=ND/rEklHl2Y5KZ1IzgzAaYP9CIAexTLWJqNxHuLKje6diN13GeXjL3D/EiGn0xpYE
	 TOQDJISGHjbkKU9tU5PK4+J8F9KV3X8VO1h6GBR/Z1gGyqptjCurxWiwJCcTmTYUDH
	 h2jsKHqpIlERYkM/5+HKRgy4qQ0FhFn3mV4VBn3n8PB8jCVvVzzvUP8p9SzdxOZLGE
	 qAFGjyJ5k9RQnbsSrLDTU8qXUdVhsWWkmJSs86jQaHnSuCr2odrRmlb/oGZs2BEoFH
	 iKfkSN18Xe8d4AdZZJ2IiTR05cX0OEA6JwJD6zAihW3AwRRyGDXpNaWd9e8EMYo1ms
	 056t6ykcqot+g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v3 00/13] s390/cio: replace page allocator calls with
 k[mz]alloc()
Date: Wed, 16 Sep 2026 15:03:07 +0300
Message-Id: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOyw6CMBBFf8V0bUkfpBRX/odxUcoUqoaaKRIJ4
 d9tcaMxLs/MnHtnIRHQQySH3UIQJh99GBLI/Y7Y3gwdUN8mJoIJxWpW0ShrRq0PFMG0M+UaKum
 cVqVwJEl3BOefW+Dp/Ob4aC5gx5ySLxoTgTZoBtvn0YZVISlante9j2PAeXto4jnmb/fEaUJTO
 VlrpoQsj1fAAW5FwI7k8kl8+Jz9+CL5UEvOtHJtC/zLX9f1Bem3PJseAQAA
X-Change-ID: 20260907-s390-cio-ready-18e73ff8642f
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.17-dev

The saga continues :)

This series covers CIO, QDIO, SCM and IDAL buffer allocations.

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

The patches are grouped by buffer usage and ordered by file or
subsystem. Related CHSC work areas and requests are kept together.

While on it, use __free(kfree) for the SCM information buffer and local
buffers in synchronous CHSC ioctl handlers. The CHSC cleanup is kept in
a separate patch.

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-cio

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

---
v3 changes:
* fix accidental flips from non-zeroing allocations to zeroing ones.

v2: https://patch.msgid.link/20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org
Address sashiko comments:
* Allocate the exact CMB area size and reject invalid channel counts.
  Correct the alignment requirement to 32 bytes.
* Tell kmemleak to ignore IDAL data buffers as only DMA addresses are kept.
* Drop the obsolete kmemleak exemption for the QDIO CCW.

v1: https://patch.msgid.link/20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org

---
Mike Rapoport (Microsoft) (13):
      s390/chsc: Use kzalloc() for CUBs
      s390/chsc: Use kzalloc() for the SEI work area
      s390/chsc_sch: Use kzalloc() for CHSC requests
      s390/chsc_sch: Use __free(kfree) for synchronous CHSC requests
      s390/cio: Use kzalloc() for CHSC work areas
      s390/cmf: Use kmalloc() for the CMB area
      s390/idals: Use kmalloc() for IDAL data buffers
      s390/qdio_main: Use kzalloc() for the IRQ structure
      s390/qdio_main: Use kzalloc() for the QDR
      s390/qdio_setup: Use kzalloc() for QDIO buffers
      s390/qdio_setup: Use kmalloc() for the storage list
      s390/qdio_setup: Use kmalloc() for the SSQD request
      s390/scm: Use kmalloc() for SCM information

 arch/s390/include/asm/idals.h   |   9 +-
 drivers/s390/cio/chsc.c         |  20 +--
 drivers/s390/cio/chsc_sch.c     | 300 ++++++++++++++--------------------------
 drivers/s390/cio/cmf.c          |  11 +-
 drivers/s390/cio/qdio.h         |   2 +-
 drivers/s390/cio/qdio_main.c    |  23 ++-
 drivers/s390/cio/qdio_setup.c   |  14 +-
 drivers/s390/cio/qdio_thinint.c |   2 +-
 drivers/s390/cio/scm.c          |   7 +-
 9 files changed, 150 insertions(+), 238 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260907-s390-cio-ready-18e73ff8642f

--
Sincerely yours,
Mike.

