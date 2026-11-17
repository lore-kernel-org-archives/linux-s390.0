Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920820;
	b=2C/vBskXyhwFb/2S+knjTHuqbn/PkBuVC8bV0Lij0DEPzA6NqwobcR4YfEvVW/v7OZAA
	 W753u/0QGIeBG3fuRUXFqpqB5vHHngT9HpE+F0BXSJhW3WuLxxrUGeIl/RDYl86aiUC/1
	 5czmSDeZPpH89h/BcLXht3rGfbRi0Wrr3eMtPRRYLykUfOSjypJrH903q3XdPhzTFnmJ+
	 URPfkjKjFgNEAClwky5Bgdu0WaZVm12TAv6G6hbwN+szL2l5sWufeuOm78pOCiIReB8tk
	 kdf8Yl46KlFfsB366KyQ/+xdVqN0WGtBsYq4UleeHFDSPXETmXzjMhrICzSE14A6j9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920820;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=1pVjlFKLqrkizC9FmJoCvgI9LyQi88+dBoMO0i3338w=;
	b=lF5YqOYshc42Wf6K9AumoyeiRVtE0GI9+nQDHWe9vNuDGKUA0SUGECu36aHdMzn0fKE/
	 gchAthn7fZiJAOltAeV/n7NvBA9yfD1wZ9oyndjzvzTKlIMslN+a3sVqaXqpsOsPIuNLN
	 lsYjPTkh9p+g5Xn181ofOEcX6WkQvARn/sWAUdoCQhACteVe9/k+vRvc5mSqIwr5ptBYb
	 bgqI9ykrk2dBuk0nNxth0lT0qkExvRE6ZeHEgV20TQRf/gOzRbmkBT3selKiJL4Q93QSX
	 0r+/Jc7SR2872yStpZe654QksUmOD3IQAFRkoXrfD7M6AIjMmYfaFy2GmHpUi3zyCmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFcJrDjg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB898606A893;
	Tue, 17 Nov 2026 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFcJrDjg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2D21F000C4;
	Tue, 17 Nov 2026 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920820;
	bh=1pVjlFKLqrkizC9FmJoCvgI9LyQi88+dBoMO0i3338w=;
	h=From:Subject:Date:To:Cc;
	b=HFcJrDjgU5KIKe8VUxdGSrgtpeFOrq2E4A5i5M1vM3jWpYK//HFX0YELRLGduYiYs
	 R36DFGAsEIfPAf8wRD1Gi0kFcRf27LgMNogbjZaa/mY/kf4XRTFCux4O5H//2ffwbC
	 956UoH31u0lYKQqCK0V7kZFvBycOKZ7WxytlxlIxV38MkdcntgbVMavEeoEekpq8Bu
	 tzKnm92DUwib0fIztSd4MNztORti8B492mwdPp4rLn2teFl5H8FPr9sqDtNJnOPyAK
	 0dqLXjJoLydhIJuf4yhcljWDb5IeUplvtkOeGxjlaQXQqAEN++Jf8EvOYwGX+cp6ln
	 MgpgGDeUQSg6A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 00/14] s390/sclp: replace page allocator calls with
 k[mz]alloc()
Date: Tue, 17 Nov 2026 15:06:52 +0200
Message-Id: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOQRKCMAxFr8J0bbWFoVhX3sNh0ZYIVWyZBBkZh
 rtLcenyJT/vZ2EE6IHYJVsYwuTJx7BBfsiY60xogftmY5aLXAktKk6FFpxcP3AE08xclGCtkWB
 K0Gy7GhDu/rMbb/WP6W0f4MakSQlrCLhFE1yXRhF968PpZWgETPvO0xhx3l+aZPLs7VKK81/7J
 LngBVROC7BKVer6BAzQHyO2rF7X9QvegnOG4QAAAA==
X-Change-ID: 20260907-s390-sclp-ready-05ebba1ea5e9
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Sven Schnelle <svens@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev

This the next episode of conversion of page allocator calls to kmalloc
family :)

This series covers SCLP buffer allocations.

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
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-sclp

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

---
Changes in v2:
- sclp_cmd: allocate a power of two size for the CPU info SCCB and drop
  the misleading paragraph from the commit message (Heiko, Alexander)
- sclp_ftp: use struct sysinfo_2_2_2 pointer to get rid of casts
  (Heiko, Alexander, sashiko)
- add Reviewed-by tags
- Link to v1: https://patch.msgid.link/20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org

---
Mike Rapoport (Microsoft) (14):
      s390/sclp_vt220: Replace get_zeroed_page() with kzalloc()
      s390/sclp_config: Replace get_zeroed_page() with kzalloc()
      s390/sclp_pci: Replace get_zeroed_page() with kzalloc()
      s390/sclp_ctl: Replace get_zeroed_page() with kzalloc()
      s390/sclp_con: Replace get_zeroed_page() with kzalloc()
      s390/sclp_tty: Replace get_zeroed_page() with kzalloc()
      s390/sclp: Replace __get_free_page() with kmalloc()
      s390/sclp_sdias: Replace __get_free_page() with kmalloc()
      s390/sclp_sd: Replace __get_free_page() with kmalloc()
      s390/sclp_cmd: Replace page allocator calls with kzalloc()
      s390/sclp_cpi: Replace get_zeroed_page() with kzalloc()
      s390/sclp_ftp: Replace get_zeroed_page() with kzalloc()
      s390/sclp_mem: Replace page allocator calls with k[mz]alloc()
      s390/sclp_ap: Replace get_zeroed_page() with kzalloc()

 drivers/s390/char/sclp.c         |  9 +++++----
 drivers/s390/char/sclp_ap.c      |  4 ++--
 drivers/s390/char/sclp_cmd.c     | 13 +++++++------
 drivers/s390/char/sclp_con.c     |  5 +++--
 drivers/s390/char/sclp_config.c  |  4 ++--
 drivers/s390/char/sclp_cpi_sys.c |  4 ++--
 drivers/s390/char/sclp_ctl.c     |  5 +++--
 drivers/s390/char/sclp_ftp.c     | 14 ++++++--------
 drivers/s390/char/sclp_mem.c     | 12 ++++++------
 drivers/s390/char/sclp_pci.c     |  8 ++++----
 drivers/s390/char/sclp_sd.c      | 20 ++++++++++----------
 drivers/s390/char/sclp_sdias.c   |  5 +++--
 drivers/s390/char/sclp_tty.c     |  5 +++--
 drivers/s390/char/sclp_vt220.c   |  4 ++--
 14 files changed, 58 insertions(+), 54 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260907-s390-sclp-ready-05ebba1ea5e9

--
Sincerely yours,
Mike.

