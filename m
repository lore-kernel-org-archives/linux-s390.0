Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8437A83D;
	Sun,  6 Sep 2026 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683244; cv=none; b=SwJbG7c8BNfRmsz/F8VMpGxy5U6Fc4668VC4uEcQG6cIlLGpjRpwahR1sgnTmMYp9irBupWmg6iUdQXt+QnD+1Ir/c0Wd+DmK/fL2/bk0hyiGR2BAsrOIX9iDieBybH2jZYsT9okUOYF8Xt8Bv5Xkis7CB7JPT05PulRQNGRFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683244; c=relaxed/simple;
	bh=ahXbhc6dyXOpER7SQ6hnp4/RP2kpB+BQRc7YElDY63s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nWGkMkxMJvuq/vH5t3TdxsOcupi67xb7u0zqA8Uph1hQtyDza6v9do+I6gYaS9Ls18zpZnR38a5pPRg7TiuHvbM+/EoyabTPY7XVvtLC6WHB2x1L4vuFxmj+poQHG4QzEqpLzZq09bvXyORhvRsqn5OCyqQ98zM1Cn+MOeEUsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke5hoBPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke5hoBPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C7D1F00A3A;
	Sun,  6 Sep 2026 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788683243;
	bh=unXDzhDOfQIn4PXJKkkXKY5S5G9gVC+CucPNUSrjj1Y=;
	h=From:Subject:Date:To:Cc;
	b=ke5hoBPCBLJfy7v18TrpdtuvZX5gMfZZthDjmoILRiAamuDXoSFO3XcwRb11byypO
	 gUkfNiPCaQkZU7GB6HMSY8QEB105yNJawxQaP6WADohh06xSb1VdKXlXBwG0jONw8Y
	 HsjiaGzJYDz9ykUVvwsCapLoCTz+EQ9cpQNGJqdGr0vefP7rqDw/8LdwNc/Zhy+eD2
	 mcMAMfoBGZP45+TNodejhQskuczfCfx5wwcq2kSpZFJJHVNyEaIGIaEkUsZ6eX2QA3
	 QDbdGvNGmUNfPVShK5fwPPcmmkO7w3UGCig3HHWTFlnTd1OYvdgRAtulAxPFq3a6tV
	 iZpW+SWVbrZ8w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 0/4] KVM: s390: replace page allocator calls with
 kzalloc()
Date: Sun, 06 Sep 2026 11:27:08 +0300
Message-Id: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WOzQ6CMBCEX4X07JJtCX+efA/DgZYVKlrMFhsN4
 d2lcPD4zczO7CI8sSUvzskimIL1dnIbqFMizNC6nsB2GwuFqsBKVeCzGmEMT1Aoc41dWZadEVv
 8xXSzn73q2hzs3/pOZo73MaFbT6C5dWaI0o5lmgEbGe3B+nni7/5KkLHmWK1R/VeDBIRMG6yrI
 s9Ry8tI7OiRTtyLZl3XH4EKmajSAAAA
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
v2 changes:
* Mask out the next CBR entry offset SIE stores in the low bits of cbrlo
  before handing the address to kfree()
* Use __free(kfree) in handle_sthyi()

v1: https://patch.msgid.link/20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org

---
Mike Rapoport (Microsoft) (4):
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the STHYI buffer
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI buffer
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB
      KVM: s390: Replace get_zeroed_page() with kzalloc() for sie_page2 and CMMA

 arch/s390/kvm/s390/intercept.c | 23 ++++++++++-------------
 arch/s390/kvm/s390/interrupt.c |  8 ++++----
 arch/s390/kvm/s390/priv.c      | 19 ++++++++++---------
 arch/s390/kvm/s390/s390.c      | 12 ++++++------
 4 files changed, 30 insertions(+), 32 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260828-s390-kvm-2015b0d777dc

--
Sincerely yours,
Mike.

