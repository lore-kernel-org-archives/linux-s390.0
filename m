Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF92609EE;
	Tue, 23 Jun 2026 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229757; cv=none; b=apbpalaOcFUEscsnsQs01fDZlHbwCFszuPr94u5KFXE9aWcvw0iqDkLOXOtp/P2H+JMETvuqts1tj6WH99ihXis1er0d/nnMFKaBFt1e+MzNhR3HmH86jC5Lkc8l6UMrV66YWLUma+dteTDIxaTWg7/EugSLoZuK0hJ7qocU6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229757; c=relaxed/simple;
	bh=YgYknKlcsqA39fNVtDTqp2XVRH1hDhmlNkPBKeFTUtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mUpdh8/zSOUMR48NM/DpZBE9JyvVzKtTHAQmUcLPHU03RfyVxq1+dpT0HcjUNj6AVMY9i1m0ZnnZbpii6OHvCwT8MhyROziOwXZZHjKx3PIpsZNkFaWRB0zyHmww2xQiC3qvGRc2x4u0XL8qiAwymA/Au+3R4IoS+p8Kpmsy0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk/6pPjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk/6pPjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77AB1F000E9;
	Tue, 23 Jun 2026 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782229756;
	bh=7AORbLBjq24eTSoJGD2pooK8+OLDXdfCEuDgvrnqgZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hk/6pPjVRfea1cppj5Uh5RC5vUDqDJ4ikahljzJOzJbI++K6Bg6zK3H01LuA+XYHh
	 rTt/Y71IxzKBO3FUshh2jG0GZWBW9HxDbAYY2c9W/6f6AwRVqgMw+SkIuMF/k4GdFA
	 xDiuM4spm4+rIwLV9SaECTqtdCoWQHTiYCbVS1akM6AHb2APhGCmZq778OLN2Pe9T3
	 dRym5KgZDtPddcCun9Nkciex5vNFTWKdoBJ9MS4rfVvIEWoDkf6s0YhuCLcUJDI2HQ
	 RkxOdz0skFHmP+nb8hKQJrwHcjSdOZEyd1i7j1EBvvtCBLBFT0xbH9gHQuMqnmDqmN
	 Xx+rZhhAz/yGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] KVM: s390: Fix dat_peek_cmma() overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260623153331.233784-3-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
 <20260623153331.233784-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 15:49:15 +0000
Message-Id: <20260623154915.D77AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The KVM_S390_GET_CMMA_BITS ioctl allocates the `values` array usin=
g `vmalloc()` without zeroing the memory. During the page table walk, `dat_=
peek_cmma()` and `dat_get_cmma()` can skip unmapped segments or clean pages=
, leaving uninitialized gaps in the array. When copied back to userspace, t=
his leaks up to 1MB of uninitialized kernel heap memory.
--

commit 561661723442584bc83ff1dfa1a8372280efbf28
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

[Severity: High]
This is a pre-existing issue, but does this code leak uninitialized kernel
memory to userspace?

The KVM_S390_GET_CMMA_BITS ioctl allocates the values array using vmalloc()
without zeroing it:

arch/s390/kvm/kvm-s390.c:kvm_s390_get_cmma_bits() {
    ...
    values =3D vmalloc(args->count);
    if (!values)
        return -ENOMEM;
    ...
}

During the page table walk here, unmapped segments or clean pages can be
skipped without writing to the corresponding index in the values array,
such as in __dat_get_cmma_pte():

arch/s390/kvm/dat.c:__dat_get_cmma_pte() {
    ...
    state->values[gfn - state->start] =3D pgste.usage | pgste.nodat << 6;
    ...
}

Because state.end can advance without filling all gaps in the array, the co=
unt
calculated here will include uninitialized elements. Since the ioctl copies
this entire buffer back to userspace based on the returned count, could this
leak previous kernel heap content?

Would it be safer to use vzalloc() in kvm_s390_get_cmma_bits() instead?

>  	/* Return success if at least one value was saved, otherwise an error. =
*/
>  	return (rc =3D=3D -EFAULT && *count > 0) ? 0 : rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623153331.2337=
84-1-imbrenda@linux.ibm.com?part=3D2
