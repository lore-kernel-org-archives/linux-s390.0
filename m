Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579954;
	b=KHFaLy2RF1m1nylTFZkMd0YW6TQJhBseK0gdrzOAPFYycpJVTf7z7kTbVUie3D/5+282
	 ar/2HfrZmaWVDq9C0BqMSoP8O/1pDJwJ38ijQcVL7dWU8WIiEfENPg2+ToFb+XMLOgtF6
	 T+oVY1scTImDSShTW7YXMs9iSqfrG8k+RtBqRyz8RUq5LAP4faox8BXxG74f9Y9Ox6Uk1
	 ygU7kwkzjUzsbppEP4Xac1hnVaBjcPUDuuYggS2fREUTpyOqpUIxQr9cIy3mjOP+HGvLb
	 kR5Ny0/cauWYESZTUUr8BcLwMnTyJ6z9k+8Pa/UuQ1LX47PQ5a4cBniPf1hKCpMboig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PdkwCA/lPR2UA0tFpB0e/zCyPFWIqew25q+Xd8i7qwo=;
	b=0/BxOhm3PU3ocw3U+AnwJcgLyNBmXlzLT8TqUgBTtYva1ZP9sVLEsav1nR04ZURkvj+t
	 w0j90/rfrF5PdgXA2iic89/dX20nKNKSeJ8hAIG0Dp4Cfz20DXRI2b1BWtRK85VEMZ81/
	 iN4RcXG7vc4DHbQ/S9ea/On0Ql3ryENNuKtO6xyVNkMgE2JAU/6LeEA0EXHy2UqZLEYR2
	 Tg/Svf17XiWVvq0ZfHzvXS4RnHOi9gB5FxXw4MtGdKnncw/19EtSItaQV+64jgzqTGrqT
	 4VkW3NkQJw2y0kPAurXMymIzg+FfA9mRFz5B4Oyb5cTnZtVdJXtmyJPKmGS6ksJrv6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wzz0eqgw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C96606A323
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wzz0eqgw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793871F000C4;
	Fri, 13 Nov 2026 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579953;
	bh=PdkwCA/lPR2UA0tFpB0e/zCyPFWIqew25q+Xd8i7qwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wzz0eqgwlaTGzc32OK6qtUk/penlQBVGoWZv+0xoiWyD1K4tFfBuDvVMfIgGdzrt7
	 5TVXeDjBViK0vmiHh+u+FnawbpsB9HE22EjYl8xenAjOsoENhGDhAJC7ZnkRv6F1mP
	 P8VqWNt0P2bqugMOqtVAkqhotFoUR4UMuzANVTgIlKGUJlTd1A/MgkODDpRgCTQ7Vu
	 bBeMmIdFUQc99n1oz8geQnZSdeIcAJlKOfycCKh/oalIiGwZNRs5PFbT8L0n033NOA
	 j2spB2TBA9JlqzF+4vmxSDOSS4m1boyfnJukCHu2ety8EtlRvDj0dlh2jLaMXqO5U3
	 qWuFstoMCxVfg==
Message-ID: <sashiko-outbox-212976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] mm: fix eager write-bit restore for
 write-notified shared mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112142039.907090-3-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-3-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:25:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> change_protection() applies vma->vm_page_prot, which lacks the write bit
> for CoW and write-notified mappings. Callers set
> MM_CP_TRY_CHANGE_WRITABLE when vma_wants_manual_pte_write_upgrade()
> returns true, so that entries that can be written without a fault, such
> as dirty PTEs in a shared mapping, are made writable right away.
>=20
> For shared mappings, that function passes vma->vm_page_prot to
> vma_wants_writenotify(). Once writenotify is enabled, this protection
> lacks the write bit, while the vma_pgprot_modify() result it is compared
> against adds it back. The two never match, so vma_wants_writenotify()
> returns false before checking for soft-dirty, uffd-wp and writeback.
>=20
> As a result, write-notified shmem mappings never get
> MM_CP_TRY_CHANGE_WRITABLE. For example, commit 931298e103c2
> ("mm/userfaultfd: rely on vma->vm_page_prot in uffd_wp_range()") made
> uffd-wp unprotect set the flag so that dirty shmem PTEs become writable
> again, but this never takes effect. Unprotecting N dirty shmem pages
> still leads to N faults that only set the write bit.
>=20
> This dates back to the commit in the Fixes tag, which moved the
> equivalent check in mprotect_fixup() before vma_set_page_prot().
>=20
> Fix this by passing the protection recomputed from the VMA flags, as
> vma_set_page_prot() does.
>=20
> Note: this only affects performance, as the next write fault restores
> the write bit anyway.
>=20
> Fixes: 64e455079e1b ("mm: softdirty: enable write notifications on VMAs a=
fter VM_SOFTDIRTY cleared")
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142039.9070=
90-2-clopez@suse.de?part=3D1

