Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EF418A55;
	Fri,  4 Sep 2026 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502954; cv=none; b=Yqp3vm4PgR78o6iDlf1dF3amudKl20fUIRaSALjMu1LDurN8C1f7Z/ePQdGeJKPyFptyT8dDW1qdPdjMAzzV/6KyzYJpfPqDJcaoo1zXM4fm3SxZRhvNTAk4Vj5S6f9P5oJODeUjde2UQMsDYt4Ibc+PSthMTXiqqnIEcLtGPPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502954; c=relaxed/simple;
	bh=7vHeBJQBf4OO4SyjiLvxNtEIOPxw4itdGQ47KrQ0N9I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGu47eQRh0GOElRZYbihbb6JdAjZU/XA6Ua6ik0o/FXJR07d4QngDOUB/zHcxY+kJQ+tgXJyLrz+bGm2C7X/Nnn4n7baikhzuQ+XhRVLsM2+573YRcgDdP8hCq7U6q0U+BcPYdTC+Zr8Rznkc0k8CkdW/nc8JPh6rC5jc5DWoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7i6Phyq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7i6Phyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BABE1F00A3D;
	Fri,  4 Sep 2026 06:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502953;
	bh=Rn0aKbNyY+ztrnrJoq42iBGB5/avnUMQTBfcgS+hhy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X7i6Phyqp+tnRBET6Lk7XJzTWPFUDdOZBRhdKNzCfOm4tuPmSoLN5mx8EwFzAwPMI
	 M9CviGjXe3vJTSdTELVo098OiFZm7pIA+728s3WZpfvCaPG2p0wlVTEFYlWOnP3cYd
	 BPTKfWPjarTCxH32GHLYz5kgTABebG8tqLkD/GiaXKc86SzdTx1bOEd8YB02cHfIvA
	 5yTzgeX+pSsFKPJJ3VwqtzkjHSItcggavKJJURNAsn2CYS6c/p4rxIFoesjIs3kGt9
	 +nRq+Vg9L83qgFVrjqxcIU5jInI5fMcKQ5Dx57AJXiFR2TAg76MMvFpHEJ5f4bEPHC
	 KmFMsKK7mg0FQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 08/11] KVM: s390: Fix race in
 _destroy_pages_crste()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260904060647.562443-9-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:22:32 +0000
Message-Id: <20260904062232.9BABE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Time-of-check to time-of-use (TOCTOU) vulnerability in `_destr=
oy_pages_pte()` allows arbitrary physical page destruction.
- [High] _destroy_pages_crste loops over up to 524,288 pages for a 2GB larg=
e page without yielding, causing massive latency and soft lockups.
- [High] Stale PTE value used to construct new PTE in `gmap_clear_young_pte=
()` overwrites concurrent changes.
--

commit beff0ee5655a939df38ade64a4fe7014bdc87cd5
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix race in _destroy_pages_crste()
   =20
This commit uses READ_ONCE() in _destroy_pages_crste() to read the crste,
avoiding dereferencing the pointer multiple times.

> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index 4968330e9553b..3f3fa864cc36b 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c
> @@ -994,11 +994,13 @@ static long _destroy_pages_pte(union pte *ptep, gfn=
_t gfn, gfn_t next, struct da
>  static long _destroy_pages_crste(union crste *crstep, gfn_t gfn, gfn_t n=
ext, struct dat_walk *walk)
>  {
>  	phys_addr_t origin, cur, end;
> +	union crste crste;
> =20
> -	if (!crstep->h.fc || !crstep->s.fc1.pr)
> +	crste =3D READ_ONCE(*crstep);
> +	if (!crste.h.fc || !crste.s.fc1.pr)
>  		return 0;
> =20
> -	origin =3D crste_origin_large(*crstep);
> +	origin =3D crste_origin_large(crste);
>  	cur =3D ((max(gfn, walk->start) - gfn) << PAGE_SHIFT) + origin;
>  	end =3D ((min(next, walk->end) - gfn) << PAGE_SHIFT) + origin;
>  	for ( ; cur < end; cur +=3D PAGE_SIZE)

[Severity: High]
This is a pre-existing issue, but does this loop process the entirety of the
large page before checking if preemption is needed?

If a PV guest is backed by 2GB large pages (Region 3 / PUD), could the loop
execute up to 524,288 Ultravisor calls without yielding, potentially causing
massive latency or a host soft lockup?

[Severity: Critical]
While looking at this file, I also noticed a pre-existing potential TOCTOU
vulnerability in _destroy_pages_pte():

arch/s390/kvm/gmap/gmap.c:_destroy_pages_pte() {
	if (!ptep->s.pr)
		return 0;
	__kvm_s390_pv_destroy_page(phys_to_page(pte_origin(*ptep)));
}

Can a concurrent modification to the PTE (e.g., by another thread handling a
page fault or unmapping memory) occur between the lockless ptep->s.pr check
and the subsequent pte_origin(*ptep) fetch?

If the PTE is cleared concurrently, could pte_origin evaluate to 0, causing
phys_to_page(0) to be targeted by the Ultravisor hypercall? Could this allow
an untrusted guest vCPU to cause destruction of an arbitrary host physical
page?

[Severity: High]
Additionally, there is a pre-existing issue where a stale PTE value appears
to be used to construct a new PTE in gmap_clear_young_pte(), which could
overwrite concurrent changes:

arch/s390/kvm/gmap/gmap.c:gmap_clear_young_pte() {
	pte =3D READ_ONCE(*ptep);

	if (!pte.s.pr || (!pte.s.y && pte.h.i))
		return 0;

	pgste =3D pgste_get_lock(ptep);
	if (!pgste.prefix_notif || gmap_mkold_prefix(p->gmap, gfn, end)) {
		new =3D pte;
		new.h.i =3D 1;
		new.s.y =3D 0;
...
		pgste =3D __dat_ptep_xchg(ptep, pgste, new, gfn, walk->asce,
					uses_skeys(p->gmap));
...
}

Since kvm_age_gfn() takes the KVM MMU lock for read, concurrent KVM fault
handlers can also modify the PTE. If a concurrent fault modifies the PTE
after gmap_clear_young_pte locklessly reads it, but before it acquires
pgste_get_lock, wouldn't the concurrent modification (such as setting the
dirty bit) be silently overwritten because the stale read value is used to
construct the new PTE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D8
