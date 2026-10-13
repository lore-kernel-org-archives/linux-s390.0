Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD720511E67;
	Tue, 13 Oct 2026 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903257; cv=none; b=d8egmFYKtNZPjrQ7DWxFMPzsiTUde5uJan2tYBFN+5wEZ2zBvn12WkoWzgt7l2WtDwhLM9CyBUdTZ0bm4+GKG/aXz5wtd509/HTTQGkTH/yLqswLNHkplec3TSA4A41Ptp2hxXqtPFwEUXpPc2KV86b1Ekn9+j6x4SCwXSJ5VVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903257; c=relaxed/simple;
	bh=QOJ2sQp8bbqIwzTmLaifGO9oYvZ0hzvP8nt7PYsN1ZQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mkYZrMAdoXTff0IETNVtE6MuW8zfiaBpTPd5Qxw3hX9eK3RE7gt8ghKQ28gXbrm3SxW5WjIAQF9cO1hkAh9vc166GXxpopIPck1BAfViZNyx5YhINNSTTxEnosQwhhrjlLjknzLjc3SW244zkJBJzNIBsuX1F6sVHa+8pZEL/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU43yrmB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU43yrmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1453E1F00893;
	Tue, 13 Oct 2026 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903256;
	bh=Zptec0P4kYHP17Blbfi0s1nSdR8z6Jn034oLM/NJbOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bU43yrmBMKkDtTX7iZ5wp73a1fgiTxwWZEoE6Efi5uzMD2PaZs4l7+GSVv8uP+kb3
	 2M0rUCiKVznG4NrObD9UTZglarVcbzS1fnfFYIhD3RZ1iZTLTY4PO1UB6kclTaNHHv
	 5O6XxjIwAcgefOEuoQDCvY5C7YV/mhrm7xKYIViLtN5SRD7YUBBdmIhzIs1IhDcu2Q
	 SsO9ZU5BTpYo+4+kQSe1dtUi9OJYCyrA4BPlRWxnGlKl6eyfOVmCER8TGwFypH0L1K
	 +t1/1s531QiH57ctLZIQnINoNSrH/EFnGEIlGNJ8uzA7bW6q1NWF5AABM91IVvW4CG
	 hIcJW73LU/eXg==
Message-ID: <sashiko-outbox-169946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: s390: fix ESSA addressing exception injection
 in migration mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013144225.8885-2-ggala@linux.ibm.com>
References: <20261013144225.8885-1-ggala@linux.ibm.com>
 <20261013144225.8885-2-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:54:15 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: s390: invalid exception code injected due to negative argument
- [High] s390/kvm: Incorrect exception masking and invalid PIC injection in=
 __do_essa
--

commit 0857e0bc0073ed5469250557e895e66a7a5d870f
Author: Gautam Gala <ggala@linux.ibm.com>

    KVM: s390: fix ESSA addressing exception injection in migration mode
   =20
    __do_essa() treated any negative return from dat_perform_essa() as the
    normal "no CBRL entry appended" case and returned 0, so a page-table
    walk failure silently dropped the addressing exception.

> diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
> index ff80d02c9f564..1bc6d2ec5b083 100644
> --- a/arch/s390/kvm/gmap/dat.c
> +++ b/arch/s390/kvm/gmap/dat.c

[ ... ]

> @@ -1092,7 +1093,9 @@ int dat_perform_essa(union asce asce, gfn_t gfn, in=
t orc, union essa_state *stat
>  	union pte *ptep;
>  	int res =3D 0;
> =20
> -	if (dat_entry_walk(NULL, gfn, asce, 0, TABLE_TYPE_PAGE_TABLE, &crstep, =
&ptep)) {
> +	if (dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE=
, &crstep, &ptep))
> +		return -PGM_ADDRESSING;

[Severity: High]
Would this mask other valid, positive Program Interruption Codes (PICs)
that dat_entry_walk() might return?

For example, if dat_entry_walk() returns PGM_SECURE_STORAGE_ACCESS from
hitting a memory hole, it appears it would be unconditionally mapped to
-PGM_ADDRESSING here.

> +	if (!ptep) {
>  		*state =3D (union essa_state) { .exception =3D 1 };
>  		return -1;
>  	}
> diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> index b3cb2c2c3aa71..2abd1bdfdf322 100644
> --- a/arch/s390/kvm/s390/priv.c
> +++ b/arch/s390/kvm/s390/priv.c

[ ... ]

> @@ -1168,8 +1168,10 @@ static inline int __do_essa(struct kvm_vcpu *vcpu,=
 const int orc)
>  	entries =3D (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
> =20
>  	nappended =3D dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state,=
 &dirtied);
> +	if (nappended =3D=3D -PGM_ADDRESSING)
> +		return kvm_s390_inject_program_int(vcpu, -PGM_ADDRESSING);

[Severity: High]
Can passing -PGM_ADDRESSING to kvm_s390_inject_program_int() result in an
invalid program interruption code being injected?

Since the code argument of kvm_s390_inject_program_int() is an unsigned u16,
passing -5 causes an integer wraparound to 65531 (0xFFFB). This would inject
a corrupt exception state and violate the architectural ABI instead of
injecting the correct Addressing Exception (0x0005).

Regarding the test_essa_migration_pgm selftest added in a subsequent
patch, it appears it fails to catch this regression because its
exception handler pgm_handler_c() hardcodes a GUEST_SYNC(PGM_ADDRESSING)
call without actually reading the true PIC from the guest's lowcore
(__LC_PGM_INT_CODE).

>  	vcpu->run->s.regs.gprs[r1] =3D state.val;
> -	if (nappended < 0)
> +	if (nappended =3D=3D -1)
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013144225.8885=
-1-ggala@linux.ibm.com?part=3D1
