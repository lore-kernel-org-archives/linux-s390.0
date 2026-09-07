Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087B4477FA;
	Mon,  7 Sep 2026 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776634; cv=none; b=hF/mUp3ihyecsTrrSOmx+xQGSRNheh5USY8C33iMfcQRqll+fXzcQvx5zPsyQtrTQShQPIACagff/+3z5tSAN32/WmUwPf3XMb/eE4OqphyXN7aE576wScesA6oLYNapYhluut61uEfhQIoLgEVvBRg0EWWRLoFeht8uAiaTO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776634; c=relaxed/simple;
	bh=qFJbJp9Uv4c+AIOE27dclvuDeZ9IhDKG4rxK4P7RsjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qv6TUVWsea2KAu+wuM10Gdb/bbtdHM5loSyO1aIA/aptMnyI0F8wxxHq9NVVswU+qQvdd+unN7pu277p0qgphq63U9T2VY4yD9tXRUhjc9Br3W5+ztI76Xh5aMp7XWFnbNsAcyUPZOeMEBHm2qaliPCDSDOETqU+19qRtAHza8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3K/wLkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3K/wLkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8631F00A3E;
	Mon,  7 Sep 2026 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776632;
	bh=QBl4EA0xu6TPR7bo/qzVGPSEuODGi+VrBZaLJjj3jl8=;
	h=From:Subject:Date:To:Cc;
	b=W3K/wLkWX6CuLvlwKhn0U4ZI+2bfSag8owmRUSS2l3C9lstfTM1Sfn0T2ncJCgU6J
	 S0EkLOlgCjZQBUiu3f+Lek67z0vBdvPdze/Xni/fOUSI72mlaW1NQyiuPg2/qJocav
	 EWWl6qkc01U3JcOk8fowht2ZHXeZSgXZEmqoXYfGtTui6FIs8Zwcs8DFh8sdgHo+It
	 1Wo9Q3wbcU99rGLPdrWqL/9QEx0FqTuk6yNTKuFuoEBW7Q7zq9ubdPnDdxVmutDYBT
	 i3COGAB7YhhUwquaROAmQWRS3C0/o0Rtf+EAFOE17+/s0ogpHf72iK2IXEysqtlQeS
	 wrvNlk1e3LGkQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 00/13] s390/cio: replace page allocator calls with
 k[mz]alloc()
Date: Mon, 07 Sep 2026 13:23:41 +0300
Message-Id: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CMAwE0KtUXmOUD2paroJYJKlDwyJFNiBQ1
 buTlOUbzcwKQpxJ4NytwPTOkpdSoQ8dxNmXG2GeqsEo06tRORQ7Kox5QSY/fVEP5GxKQ38yCer
 owZTyZz+8XP+WV7hTfLaX1gheCAP7EucW7XRHixw1bNsP2whiIZEAAAA=
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

 arch/s390/include/asm/idals.h   |   6 +-
 drivers/s390/cio/chsc.c         |  20 +--
 drivers/s390/cio/chsc_sch.c     | 300 ++++++++++++++--------------------------
 drivers/s390/cio/cmf.c          |   8 +-
 drivers/s390/cio/qdio.h         |   2 +-
 drivers/s390/cio/qdio_main.c    |  19 +--
 drivers/s390/cio/qdio_setup.c   |  14 +-
 drivers/s390/cio/qdio_thinint.c |   2 +-
 drivers/s390/cio/scm.c          |   7 +-
 9 files changed, 144 insertions(+), 234 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260907-s390-cio-ready-18e73ff8642f

--
Sincerely yours,
Mike.

