Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128663;
	b=Ijqf8r3h3ok+XGkZ8UXnccH0vo6ms4xwtZFrA9m0sIupxrIpeNHDHcxDQbs60IhBjA/B
	 m8P+DAfsfhpSfS5UK+lRmEr2nv4ooXYo+3C4RGD/EW/MrwzJIk8eJidUfCKdtfWOxB3pn
	 aqtRSGLjOIUNeqS5160weinHpRAqwDPXo4+JTdQr0Bwrwsph44VOtv1vNfdNex4F5AR3x
	 UF/QIN2LjIgIAG9mWN2Jbgfe5zrcLhMAxpoc1gBldejlsMxypi3uPPZIrNEuuKxJcMdpZ
	 aKoIFnR5uQYKYweKV1VgK6ALSZmQ6C6OHyHx5rW8r5SPTHSWz0tiMC+xsOiq3HxvHzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128663;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=RwkS9/FSU2e9I7Q0Tq42tC4QHg0DrVHP4W+u4uUUs60=;
	b=dBoEjqM/xTbmhplbO1r6boS18eVQb0Lx4ogwo/yH4OiBXnxBDwVxt3yxMnln2hTtvDW7
	 xztuLam4kGe9tKwEIDbimLhxTD179S4oTIXPCO1EAm2shJEjeYgVsfEOz7zYARBNopVXi
	 7GYI8BwhPHkAQ2lTFE1KysRQ3ZCWQhVKvDhJnHMt5dboSGYM16Iw9beizc5c4spngiDR5
	 yLfS/2k8RISMnYhFgrwlwH6pPYLeLzvgzDamNFi70kAMjnyPMAR8yJmHiDWUckC9+xSAk
	 iEF9HU1FEdlKJ+k2yK5hHZTJCfXVNEAHSzQ/WfeIKQKNpGQtdoEaamJ32peew564u3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQkTGoU0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17359606A31C;
	Sun,  8 Nov 2026 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQkTGoU0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7F11F0089F;
	Sun,  8 Nov 2026 09:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128662;
	bh=RwkS9/FSU2e9I7Q0Tq42tC4QHg0DrVHP4W+u4uUUs60=;
	h=From:Subject:Date:To:Cc;
	b=IQkTGoU02Fa9oi0HZxYWUC5uYQ5KKZOzVzWKEgd3cb5ufumpMEw36eL+fU6N0rgOh
	 9ODviYrXPcUUIJUzlI2fBbZgLtNifNvnUYYBgdC/uzAA06RMOQ1AWkq01z68kGRnEu
	 MmJi1O4yFtyPxadZ9VLQ4O1fEP1yh4P2PracC2DcMDaA4ExsNi2jumKry4q6nViDnP
	 oHqnV7gUXkv3wLawvyVk+RM54F1Z8JRdPnmkwAkhKD0rW5VbQRf39Hm6AebU0byD/P
	 EW7l4M8ImG5OjX1KX+lvmAQiHg/dH9UF7UB8iL+RBzT6tZ8R0OQIwNZFJkPxgKhnUU
	 mI1q8hLDfIrmQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 00/14] s390/sclp: replace page allocator calls with
 k[mz]alloc()
Date: Sun, 08 Nov 2026 10:58:31 +0200
Message-Id: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMAxFf4X02caBQTN/xfDQjQo1OkiLRkP4d
 zd9PDf3nBWMVdjgXK2g/BKTKWWodxXEkdLAKH1maFxzdN6d0A7eocX7jMrUf9C1HALVTC17yNa
 sfJX3r3jp/mzPcOO4lEx5BDLGoJTiWKZJZZC0f5AtrLBtXznUonuTAAAA
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
 drivers/s390/char/sclp_cmd.c     | 12 ++++++------
 drivers/s390/char/sclp_con.c     |  5 +++--
 drivers/s390/char/sclp_config.c  |  4 ++--
 drivers/s390/char/sclp_cpi_sys.c |  4 ++--
 drivers/s390/char/sclp_ctl.c     |  5 +++--
 drivers/s390/char/sclp_ftp.c     |  8 ++++----
 drivers/s390/char/sclp_mem.c     | 12 ++++++------
 drivers/s390/char/sclp_pci.c     |  8 ++++----
 drivers/s390/char/sclp_sd.c      | 20 ++++++++++----------
 drivers/s390/char/sclp_sdias.c   |  5 +++--
 drivers/s390/char/sclp_tty.c     |  5 +++--
 drivers/s390/char/sclp_vt220.c   |  4 ++--
 14 files changed, 55 insertions(+), 50 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260907-s390-sclp-ready-05ebba1ea5e9

--
Sincerely yours,
Mike.

