Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712701;
	b=lIDQEMcN3t9qKN8QcqCocP3H0ShE26lAOzbcRacpTMfIwfg1q+Kk40/12Q+6++UYWUWy
	 qodl8dEvohS/E3+CqKPCqAE8pThnFLxShcxVvdo99NfXYlGKlDmFG9+qH1Bq0XBBX0cel
	 VlvLQY9+48KO8HDMgCfJZGcaDTosEc0Zb/hnnRh2GCwHpeO6DzoLWjGGW5JI+SNKFq1j3
	 7vW4E+IehOEQMbX2RKNVEWghEDD0jSOYI2aVOfEU4oOJPMuGebHLt+Wmk+NtLHwIpAOAm
	 6H3iyc4wm1C6xlnDcCxozaas3b+TelM6uSNwgNn/Azbw0UROc9ZIA/W+2eI4EvYltVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712701;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nDjw50u94+mGVh6M3W7bzuL30PRHoxO45FU8kEILcQE=;
	b=dznsdFOPBKO6sk6QsDvV1X3JFAKE6EqGLwzmpEAwXhJ+h0raZg4oGyOb2wjf6CNtvx07
	 NTeC51MQR/67tTzZABLJLdq17MjSAOVqru8RsxO1EsRRYzwgFXdu5u3+aaRW8/la9dYtN
	 0Wj/d/7RwQKrUh2JRFOqaaT6Kx6vn7iBb5H7UoNiqhQJxxfm8rnMEyMu5ZyHYhMQiUkr0
	 VJd/Mzh11dDBvliB1FZlZdZF6ouNuSNWiikY5h3kPj1YpJe357uI42+DBIUvSU9yhPlmm
	 R6KTlB0exjCGY7jbcYHXcIgtd0Bg/YZPwVVxKtriQixx/9bucjAmN7KXx2eIJsvxUtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEjMa93p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2172606D811
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEjMa93p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E95E1F00A02;
	Tue,  3 Nov 2026 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712700;
	bh=nDjw50u94+mGVh6M3W7bzuL30PRHoxO45FU8kEILcQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEjMa93puyhLZb4b3wCZrtwb4qoJvhvVjILtYoVFDYhbbkM5Hu5ZrTHcTNZiodPEy
	 rl1hWznJwKGGHKSP0jRdSs5tNE4t2EAsGwk2G4c01+BOjyAu8TxzV/Yu4ucgnZKev3
	 d883cJr2PPDnGYO6Eil32d1OyED7QYCcROIO0Bu0fZlRKZ6AUeHc1fX82NuOZGnhdU
	 4ncbdvd9XcLCQ0UjU3ipaCNlPAC38hy8whjnrOLCnEvBnqUIDPJriAM4utcrh/JF/F
	 067yE//Z7y4HQFPOrWNp8Or4qhRXmtob1QPG67P5/5CmrCYtTnVZ5jYy1nteWXErgM
	 m7ECWNbmOg33g==
Message-ID: <sashiko-outbox-195353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] mm: make folio_walk_start()'s locking asserts
 scalable
Reply-To: sashiko-reviews@lists.linux.dev
To: xu.xin@linux.dev
Cc: acme@kernel.org, adrian.hunter@intel.com, "Alexander Gordeev" <agordeev@linux.ibm.com>, akpm@linux-foundation.org, alexander.shishkin@linux.intel.com, apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, byungchul@sk.com, chengming.zhou@linux.dev, david@kernel.org, dev.jain@arm.com, gerald.schaefer@linux.ibm.com, "Vasily
 Gorbik" <gor@linux.ibm.com>, gourry@gourry.net, harry@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, irogers@google.com, james.clark@linaro.org, jannh@google.com, jolsa@kernel.org, joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, ljs@kernel.org, mark.rutland@arm.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, mingo@redhat.com, namhyung@kernel.org, nico.pache@linux.dev, oleg@redhat.com, peterz@infradead.org, riel@surriel.com, rppt@kernel.org, ryan.roberts@arm.com, surenb@google.com, svens@linux.ibm.com, usama.arif@linux.dev, vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, xialonglong2025@163.com
In-Reply-To: <20261102132927.301921-1-xu.xin@linux.dev>
References: <20261102132416.300084-1-xu.xin@linux.dev>
 <20261102132927.301921-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:31:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] mm: inaccurate commit message on write-locking in folio_walk_sta=
rt()
- [Low] mm: folio_walk_start() duplicates vma_assert_stabilised() via walk_=
lock
- [Low] mm: missing kernel-doc and private placement for folio_walk::walk_l=
ock
--

commit fbf030fed81b9a0de749bef1b3fa6307e8400b93
Author: Xu Xin <xu.xin@linux.dev>

mm: make folio_walk_start()'s locking asserts scalable

This commit adds a walk_lock member to struct folio_walk and updates
folio_walk_start() and its callers to specify locking assertion modes for
mmap_lock and per-VMA locks.

>     mm: make folio_walk_start()'s locking asserts scalable
>    =20
>     Add an additional member 'walk_lock' to folio_walk to indicate
>     locking requirements for the walk. Similar to commit 49b0638502da0
>     ("mm: enable page walking API to lock vmas during the walk").
>     But no change is made on any existing locking behavior,
>     all existing folio_walk_start() callers are currently still
>     under mmap_read_lock() protection.
>    =20
>     This change is prepared for the later patch to enable VMA locking
>     asserts. folio_walk_start now operate under write-locked mmap_lock.
>     With introduction of vma locks at the next patch, the vmas have to
>     be locked as well during such walks to prevent concurrent page
>     faults in these areas.
>    =20
>     No functional change intended.
>    =20
>     Signed-off-by: Xu Xin <xu.xin@linux.dev>

[Severity: Medium]
The second paragraph states that "folio_walk_start now operate under
write-locked mmap_lock" and that VMAs have to be locked during such walks.
Is this description accurate?

In mm/pagewalk.c, folio_walk_start() only expects PGWALK_RDLOCK or
PGWALK_VMA_RDLOCK_VERIFY and emits a warning on write-lock modes:

	if (fw->walk_lock !=3D PGWALK_RDLOCK && fw->walk_lock !=3D PGWALK_VMA_RDLO=
CK_VERIFY)
		WARN_ONCE(1, "walk_lock is not expected!\n");

Could the commit message be updated to reflect that folio_walk_start() only
verifies read-stabilized mmap or VMA locks?

[ ... ]

> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 1c397be0d092a..455428eaf1fc0 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -184,6 +184,7 @@ struct folio_walk {
>  	};
>  	/* private */
>  	spinlock_t *ptl;
> +	enum page_walk_lock walk_lock;
>  };

[Severity: Low]
This isn't a bug, but adding walk_lock to struct folio_walk without a
@walk_lock entry in the kernel-doc comment above struct folio_walk triggers=
 a
scripts/kernel-doc warning ("struct member 'walk_lock' not described in
'folio_walk'"), because the /* private */ comment does not use the
/* private: */ syntax recognized by kernel-doc.

Also, since callers of folio_walk_start() are required to initialize
fw.walk_lock before the call, should walk_lock be placed in the public
section of struct folio_walk rather than under /* private */, and should the
kernel-doc for folio_walk_start() in mm/pagewalk.c (which currently states
"@fw: filled with information on success." and "The mmap lock must be held =
in
read mode.") be updated to match?

[ ... ]

> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index e6493bbe6919e..7d85289fcb875 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -910,7 +910,15 @@ struct folio *folio_walk_start(struct folio_walk *fw,
>  	pgd_t *pgdp;
>  	p4d_t *p4dp;
> =20
> -	mmap_assert_locked(vma->vm_mm);
> +	/*
> +	 * Other locking modes except for mmap or vma read locking are not
> +	 * expected.
> +	 */
> +	if (fw->walk_lock !=3D PGWALK_RDLOCK && fw->walk_lock !=3D PGWALK_VMA_R=
DLOCK_VERIFY)
> +		WARN_ONCE(1, "walk_lock is not expected!\n");
> +	process_mm_walk_lock(vma->vm_mm, fw->walk_lock);
> +	process_vma_walk_lock(vma, fw->walk_lock);

[Severity: Low]
If a caller passes an unexpected walk_lock value (such as PGWALK_WRLOCK) or
leaves struct folio_walk uninitialized, folio_walk_start() triggers
WARN_ONCE() here, but then still calls process_mm_walk_lock() and
process_vma_walk_lock(), which for PGWALK_WRLOCK will call
vma_start_write(vma).

More broadly, since folio_walk_start() only permits mmap or VMA read-lock
verification, could folio_walk_start() simply call vma_assert_stabilised(vm=
a)
from include/linux/mmap_lock.h instead of adding walk_lock to struct
folio_walk and requiring every caller to initialize it:

static inline void vma_assert_stabilised(const struct vm_area_struct *vma)
{
	if (IS_ENABLED(CONFIG_LOCKDEP)) {
		if (lockdep_is_held(&vma->vm_mm->mmap_lock))
			return;
	} else {
		if (rwsem_is_locked(&vma->vm_mm->mmap_lock))
			return;
	}

	vma_assert_locked(vma);
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102132416.3000=
84-1-xu.xin@linux.dev?part=3D2
