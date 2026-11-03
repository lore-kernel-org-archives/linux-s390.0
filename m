Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712703;
	b=h2k5+9Sk69WSVaRdEBSadqxk23XgAHErk2Yt5CoA4WK/f47LQv3D8aJYQBPeGWzkAI4X
	 ZgH3BU8/vidR653b8MAAYOv9SYamv8IcdAA0KE+oXO9kdVxaOSuE2QGHfS3qZ93GbimFC
	 TCOK7GjezhoSps54WuZVej8tuD4qYY5qwp/IDerimIxcrWZ9kelzdFAWMHaIySxMkKLjF
	 Tn/HLepK62iaLSkaO3eAFRIg2m3nqsaNIb5r61ADNx0H/GPFg0KEkRcR2jBBY7L7DAfmn
	 poXQ95SIGGYTDFwPr/0ArjNlZOGFoAbIpCxzVmWyy0DnLFzBVPSWxwrClVEQYIkzPzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712703;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RyaWAmGggQYyP6jdmvq5bvsNO1h1kkdUaWxYijyd/60=;
	b=eFz69hoxk4P390gotZlaFqQDryc6qwGAF43KZrvjxlwNpgcqIYCEaaj+GINg2I+qqX67
	 D53ezyYiFc5DjNrNCMpOnWvoKFJ0PaLQBcExMyJI6lDXzGo8iodpcVvHha4Y0HDtBn5dx
	 YxuxDjugejke/jo7FJ4MdicmUCj9c2O8Tp+nCyzmXh1XSzcUzRNhKqdjLVlvaaUuSKL4L
	 +saoa87pvSoaYRtiMRphjpJWtG2LQJPw8olytthzfreq25X21/Df2G1FM+pS6xuN5fN2i
	 9OjWW1odcRAiUSRxDM9oVjPTKXqoMwZX9p0OTHWig7UyL1wBf/Tabbc+kM1lFNgIGQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCzOaLR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA7606D822
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCzOaLR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4BE1F0093A;
	Tue,  3 Nov 2026 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712703;
	bh=RyaWAmGggQYyP6jdmvq5bvsNO1h1kkdUaWxYijyd/60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCzOaLR3VsJGa/IDgkrfipR5m/FQ+LaefPijqlU2i3hszYY/wsbDvZLgHhDS5e4VH
	 N3gTCGcoJcFlBuhAW1cVuOaNs6vvu+PCIXLssZYpHPlRx7FPxsQqqIgJRSMBbl7GP1
	 7Jk1AI93xjeNmzROgT33mRvZdEmLyLCW7wpF8L3oWd9vY6/C07QQVKaJOja6HK1eDP
	 rV8htJ2Jr9ZaxDAIK8N6yA8VwM93z+2TKwBwprGHR29GtjDlqx6p4PycU0UiZteZC5
	 T4uudYwUVM/qMphNlbWVuDlwgBXnpmWT0Fno5TzA07Dp8JNSSWTdKY8ABrj0eTVbAw
	 TEP4DKamIGMBw==
Message-ID: <sashiko-outbox-195354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] mm/ksm: make break_ksm() more scalable
Reply-To: sashiko-reviews@lists.linux.dev
To: xu.xin@linux.dev
Cc: acme@kernel.org, adrian.hunter@intel.com, "Alexander Gordeev" <agordeev@linux.ibm.com>, akpm@linux-foundation.org, alexander.shishkin@linux.intel.com, apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, byungchul@sk.com, chengming.zhou@linux.dev, david@kernel.org, dev.jain@arm.com, gerald.schaefer@linux.ibm.com, "Vasily
 Gorbik" <gor@linux.ibm.com>, gourry@gourry.net, harry@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, irogers@google.com, james.clark@linaro.org, jannh@google.com, jolsa@kernel.org, joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, ljs@kernel.org, mark.rutland@arm.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, mingo@redhat.com, namhyung@kernel.org, nico.pache@linux.dev, oleg@redhat.com, peterz@infradead.org, riel@surriel.com, rppt@kernel.org, ryan.roberts@arm.com, surenb@google.com, svens@linux.ibm.com, usama.arif@linux.dev, vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, xialonglong2025@163.com
In-Reply-To: <20261102132956.302480-1-xu.xin@linux.dev>
References: <20261102132416.300084-1-xu.xin@linux.dev>
 <20261102132956.302480-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:31:40 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] mm/ksm: redundant ksm_walk_lock enum and helper in break_ksm()
- [Low] mm/ksm: non-const stack mm_walk_ops in break_ksm() contradicts comm=
it log
--

commit 05d53e6a6817e77860f887304a4f4cd4936f2c61
Author: Xu Xin <xu.xin@linux.dev>

mm/ksm: make break_ksm() more scalable

This commit replaces the boolean lock_vma parameter of break_ksm() with a
KSM-local enum ksm_walk_lock and constructs struct mm_walk_ops on the stack
instead of selecting between two static const tables.

> diff --git a/mm/ksm.c b/mm/ksm.c
> index d4fc0b0965aa1..84d363dabdc8a 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -661,15 +661,25 @@ static int break_ksm_pmd_entry(pmd_t *pmdp, unsigne=
d long addr, unsigned long en
>  	return found;
>  }
> =20
> -static const struct mm_walk_ops break_ksm_ops =3D {
> -	.pmd_entry =3D break_ksm_pmd_entry,
> -	.walk_lock =3D PGWALK_RDLOCK,
> +/*
> + * Locking contexts in which break_ksm() may walk the page tables.
> + */
> +enum ksm_walk_lock {
> +	/* walk under mmap_read_lock() */
> +	KSM_WALK_MMAP_RDLOCK,
> +	/* walk under mmap_write_lock() */
> +	KSM_WALK_MMAP_WRLOCK,
>  };
> =20
> -static const struct mm_walk_ops break_ksm_lock_vma_ops =3D {
> -	.pmd_entry =3D break_ksm_pmd_entry,
> -	.walk_lock =3D PGWALK_WRLOCK,
> -};
> +static enum page_walk_lock ksm_walk_lock_to_pgwalk(enum ksm_walk_lock lo=
ck)
> +{
> +	switch (lock) {
> +	case KSM_WALK_MMAP_WRLOCK:
> +		return PGWALK_WRLOCK;
> +	default:
> +		return PGWALK_RDLOCK;
> +	}
> +}

[Severity: Low]
This isn't a bug, but is enum ksm_walk_lock and ksm_walk_lock_to_pgwalk()
needed here?

include/linux/pagewalk.h is already included in mm/ksm.c and defines enum
page_walk_lock (PGWALK_RDLOCK, PGWALK_WRLOCK, PGWALK_VMA_RDLOCK_VERIFY),
which is already used directly elsewhere in mm/ksm.c. Since break_ksm() only
uses walk_lock to populate ops.walk_lock, could break_ksm() take enum
page_walk_lock directly instead of introducing a 1:1 wrapper enum and
conversion helper?

Also, the comment on KSM_WALK_MMAP_WRLOCK says "walk under mmap_write_lock(=
)",
whereas mapping it to PGWALK_WRLOCK causes process_vma_walk_lock() to acqui=
re
the VMA write lock via vma_start_write(vma) rather than only asserting that
mmap_write_lock() is held.

>  /*
>   * Though it's very tempting to unmerge rmap_items from stable tree rath=
er
> @@ -697,17 +707,19 @@ static const struct mm_walk_ops break_ksm_lock_vma_=
ops =3D {
>   * protection keys here anyway.
>   */
>  static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
> -		unsigned long end, bool lock_vma)
> +		unsigned long end, enum ksm_walk_lock walk_lock)
>  {
>  	vm_fault_t ret =3D 0;
> -	const struct mm_walk_ops *ops =3D lock_vma ?
> -				&break_ksm_lock_vma_ops : &break_ksm_ops;
> +	struct mm_walk_ops ops =3D {
> +		.pmd_entry =3D break_ksm_pmd_entry,
> +		.walk_lock =3D ksm_walk_lock_to_pgwalk(walk_lock),
> +	};

[Severity: Low]
The commit message states:

  break_ksm() currently takes a boolean 'lock_vma' to select between two
  static mm_walk_ops tables.  This is fragile: the ops struct is full of
  function pointers and making it mutable (to switch walk_lock at runtime)
  turns it into a juicy target for attackers.

  Replace the boolean with a KSM-local enum ksm_walk_lock and build the
  mm_walk_ops on the stack, so the table stays const and there is no
  shared mutable state.

Previously, break_ksm_ops and break_ksm_lock_vma_ops were declared as static
const struct mm_walk_ops in .rodata, whereas this change declares struct
mm_walk_ops ops on the writable stack without const and reinitializes it on
every break_ksm() call.

Does moving the function pointer table from static const storage in .rodata
onto the stack without const match the security rationale in the commit
message, or should break_ksm() either keep selecting between static const
struct mm_walk_ops tables (as done in fs/proc/task_mmu.c) or at least mark
the stack struct const?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102132416.3000=
84-1-xu.xin@linux.dev?part=3D3
