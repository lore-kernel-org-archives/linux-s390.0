Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE146EC8E;
	Thu, 10 Sep 2026 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038011; cv=none; b=RxT+4sEnBteo3fD/8OrazyK5EXeDRKjlvRGm4V1L5ZQSqGLDvXP4XbgehDoCtUQ+IfwAkwb/D0+rXhBEs1toVps9KKqMT+zF9N2XZynyIUD7jv9o2ATNy1O9ECeox/bucQEtpw24qR/IJUhIQNZ39FQeBF/whhVbWB+yxJcZMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038011; c=relaxed/simple;
	bh=3wqGI0nig/gl7n6Paa6u9N3mFW1svrDXhwa96wwCujw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=atyUu3mp62z1ck/2Mwxdr1EWZs6yUJxSBa1WxO5pyBq9AhwfKxH7viof6AE5VdWae8Kpvlvb2qQdzXKZqTsnEWEvJ7XmE6Q+yRZa0rn1vWCjptvVnIBMqX0pU/UeEjo8o8zA880wVlA2SQ3EI7zhqQJj5Y7XvVTW4Yn6WCetmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+4g5h2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+4g5h2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB3C1F00893;
	Thu, 10 Sep 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038009;
	bh=dFQw63bj1F/kPxxC9sqt+7gLUa5LGEkiBMoIMmY1uR8=;
	h=From:Subject:Date:To:Cc;
	b=S+4g5h2NWFTKw9U3EFXYMboABy/RasNDJ7dRe0fdCFq3Rdq7Z+kPzO+SH5PvxFfp2
	 Sk1Wx2pSLwFDQ+c1VjPfmiSbJmbRB7pYRJ/Koa798p2iawxJzSnNkMx9CXg2aa5eU/
	 bGbX7rmjh5OzR7CsTolHe/luzwOvRkyY2TnRqOb2cIyvoNLQgGR3J0narGVHpnl3WU
	 p58nYT8ERhkN/kwT84oiwqwoN9vTQQdlwiBj/nKQKHcC1PTkbEaBth6m0Ossp47d8I
	 UkTdXZw4sAvrFyGJ5fkZ+mk9dh4R0tE4raHtrxgPaw6Qjb/KQ0XWguZIU75eEfej1B
	 +hzX8r7SbFVDQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 00/13] s390/cio: replace page allocator calls with
 k[mz]alloc()
Date: Thu, 10 Sep 2026 14:00:02 +0300
Message-Id: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOyw6CMBBFf8V07ZA+CAVX/odhUcoUqoaaKRIJ4
 d9tce3y3Jk5dzYWkTxGdjltjHDx0YcpgTyfmB3NNCD4PjGTXFa84RqiajhYH4DQ9CuIGrVyrq5
 K6Vg6ehE6/zmEt/bH8d3d0c7Zkjc6ExE6MpMdc3SgLhSQFXk8+jgHWo+HFpE1f7sXAQmNdqqpe
 SVVeX0gTfgsAg2s3ff9C6Oc0mreAAAA
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
v2 changes:
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
      s390/qdio_setup: Use kzalloc() for the storage list
      s390/qdio_setup: Use kzalloc() for the SSQD request
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

