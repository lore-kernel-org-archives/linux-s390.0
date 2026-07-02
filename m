Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43333D953C;
	Thu,  2 Jul 2026 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007290; cv=none; b=d/F7eKE2prp5ojW6xYcEme/YCaRYBVrxbHOVsTmEqHIrG+X5ks1mfw9MaTrym28Jr6GRZPhEIKrA/CcS1WUxdjW3YkWTT3tsOmRrfgGuRqTIj5ZRgAODrSU4fji35e5T6uJeUxHNxdO+12NYBCOTO139ISU4FLqZkwf+wq4cz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007290; c=relaxed/simple;
	bh=SnxFFSso9ZbH44As4c7gMI43enTUayoL66vMtlUa3Mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rCiEjocQa8jo44zpLVYwNszwidLU0KbKlp2cRU34PsVfIo09j8jDeb8v2kYfSen0AsrlN7UIxZSh1rmmBiBCwHBN7n2s7IdC7Lr2HeBI0X0oF5fn7lw0WfheMgnlkidTEbJiE+ecDlt63HRD5pVi4rjb9sZ3YhxNNWRAuyuh67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA8kQsnV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA8kQsnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997981F000E9;
	Thu,  2 Jul 2026 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007288;
	bh=7XvmqnyjGC0fw8sJHUkd8hQjVnuCxZJnNsfA5a2i/nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aA8kQsnVanJHXwbNCcfMkI57ywhemN8cQZhp56MyZgp1JFacQHNSn6qZuVWtiQaSl
	 +o5sXyXhcZxulDWkk6PFFwbr0aFTr55Jh6pCYPyXYP9ngHEA68btOUOW9xSIBpxRlA
	 McwLgs/vFT4Da3RMdQu4irDbdpDfK75gAuTzUEZpf/cv+53m5z13gONY9SrB3p6TLk
	 kW6sUi/AyVpQ6EcYBuXp3jRCo78Yt0CNfHypVQmUOspcdlzfclUnmb4mQW3yqehAef
	 6+98BWU9WU6YmTZGo1AS9sakn0XKlfKlUe55H0mDG8deCNZCpWbp4pElT+2/xD9gLy
	 VqvxNLTgRwsFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/8] KVM: s390: cmma: Fix dirty tracking when
 removing memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260702152406.204782-7-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
 <20260702152406.204782-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:48:05 +0000
Message-Id: <20260702154807.997981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Double decrement and underflow of cmma_dirty_pages counter when re=
creating unaligned memslots.
--

commit cfdf82bf92088bc4e4a719ccbb0ad71b6708ed76
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: cmma: Fix dirty tracking when removing memslot

This commit fixes the dirty tracking counter when a memslot is removed.
It introduces a dat_walk_ops callback to appropriately decrement the
cmma-dirty counter for any cmma-dirty pages being removed.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 512c81eee0684..2ac3a9ac46988 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -5792,11 +5792,19 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
>  	return 0;
>  }
> =20
> +static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, str=
uct dat_walk *walk)
> +{
> +	if (pgste_of(ptep)->cmma_d)
> +		atomic64_dec(walk->priv);

[Severity: High]
Does this leave the cmma_d bit set in the PGSTE, which could lead to a doub=
le
decrement later?

If a memslot that isn't fully 1MB-aligned is removed or moved,
dat_delete_slot() replaces the PTEs with hole tokens but preserves the PGST=
Es.
When userspace creates a new memslot over the same GFN range, dat_create_sl=
ot()
replaces the hole tokens with empty PTEs, leaving the stale cmma_d =3D=3D 1=
 bits
intact.

During migration, could dat_get_cmma() visit these newly recreated empty PT=
Es,
see cmma_d =3D=3D 1, clear the bit, and decrement the counter a second time?

This would cause the cmma_dirty_pages counter to underflow. Since this valu=
e is
returned to userspace as an unsigned 64-bit integer, an underflow could cau=
se
QEMU's live migration loop to never converge.

Should we clear the cmma_d bit here after decrementing the counter?

> +	return 0;
> +}
> +
>  void kvm_arch_commit_memory_region(struct kvm *kvm,
>  				struct kvm_memory_slot *old,
>  				const struct kvm_memory_slot *new,
>  				enum kvm_mr_change change)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702152406.2047=
82-1-imbrenda@linux.ibm.com?part=3D6
