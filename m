Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E28328610;
	Tue, 16 Jun 2026 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629424; cv=none; b=FrKDp/3PFuEsoPW3+ZVMNYJq89sfefXQJYjdlAGXbRnADXPMZFDTvNVZYXkT3eeEAH6t10EVMDzs+67ll5rJvITcNjXZ4ZPQQLqJywwrGPu6DoLby0TE7/icNU6eoKVvvnB8Kx2sboJWqnNU4ThK3AHPzyuniRjdGJ4t3Fhz6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629424; c=relaxed/simple;
	bh=b4OWftl7QvwrjMR+uykCb/YJCG7izcr3evAJqvvqwb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wj4Wl+BLax2+Hi5d0pHCTETaPe62uetOM+M0k8Mx5wAiokqzXwKKB6WR573klUtC4GUyGUP9c/5XaJqyoAIoI4OpgQQmkIeknxUlyup3C1wyHMvhqiMf0N+QFs1e4RjkTan1Mi4dCqm7LO/oghbRSwUqKY9cw8ledQ+qXN9MsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABOckunw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABOckunw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6961F000E9;
	Tue, 16 Jun 2026 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781629423;
	bh=heh+0+fn1QlyQuK6UCL2qSShItxfzKRue+vROYYsbSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ABOckunw3I1iY60iih/TSjOAbHDfyaDdS9QSR3FO2U8vtQGmwwxX9FKPUe3D1oJgs
	 pZE6pler3ft0bUJeXMbK3nWbZyiaETDJZ5Cr+83PvQ3Y7Law9gP+Zr2poaQAbSMtiM
	 91fibdQKXe0SFAvcOsx9JnXOmr9lHk+5jOGapvJzC6RrF+KGXCe/OPOVqiCM3el6YS
	 u+uDGT7KBNRkYUvO+TMXMBQmjBppTVds9gwhP+Q0GstrWJgJm2gCkG1xvHGKY9m/K2
	 Jpgf1t9l8B9X4awl4xbUE+8I7gx395jefXDwLykeNbWD8V5sjBxA5H9hbugLb7iFNM
	 U9Mb8x+2NpXGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] KVM: s390: Fix dat_peek_cmma() overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260616165110.360921-3-imbrenda@linux.ibm.com>
References: <20260616165110.360921-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 17:03:42 +0000
Message-Id: <20260616170343.4E6961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] kvm_s390_get_cmma_bits() leaks uninitialized kernel heap memor=
y to userspace because the vmalloc buffer is partially populated and skippe=
d indices remain uninitialized.
--

commit f6af8b3c3817150f3fd3255f80c30b252be59298
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix dat_peek_cmma() overflow

If userspace passes a start address that is out of bounds,
_dat_walk_gfn_range() will fail with -EFAULT, but state.end will not be
touched and will stay 0. This will cause *count to underflow and report
a very high number, and the function will end up erroneously reporting
success.

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 4a41c0247ffa2..cffac7782c4bf 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -1209,7 +1209,7 @@ int dat_peek_cmma(gfn_t start, union asce asce, uns=
igned int *count, u8 *values)
>  	int rc;
> =20
>  	rc =3D _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_=
DEFAULT, &state);
> -	*count =3D state.end - start;
> +	*count =3D state.end >=3D start ? state.end - start : 0;

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential information leak to
userspace related to how this count is populated.

In arch/s390/kvm/kvm-s390.c:kvm_s390_get_cmma_bits(), the buffer is
allocated with vmalloc() instead of vzalloc():

	values =3D vmalloc(args->count);

During the walk, __dat_peek_cmma_crste() can skip unmapped regions by
advancing state->end without writing to the values array:

	if (crstep->h.i)
		state->end =3D min(walk->end, next);

Similarly, __dat_get_cmma_pte() can skip clean pages within the max bit
distance without writing anything:

	if (!READ_ONCE(*pgste_of(ptep)).cmma_d)
		return 0;

Since this *count value directly determines how many bytes copy_to_user()
copies in kvm_s390_get_cmma_bits(), can this leak uninitialized kernel
memory to userspace if the skipped entries leave gaps in the array?

>  	/* Return success if at least one value was saved, otherwise an error. =
*/
>  	return (rc =3D=3D -EFAULT && *count > 0) ? 0 : rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616165110.3609=
21-1-imbrenda@linux.ibm.com?part=3D2
