Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214614;
	b=YVHjOWlqLBHOqiVDRPemkGAftNoV/x7KEu7KAWnPA0wuXJnlNf1sL1YCWt6fT+ogsa+c
	 JcdQdALIvBCaQR4JkaE0K12RjtXz/O0Y6V6cGej7YqeSZUNa8cwQC/IDgm5mGvPiKvEIO
	 MSsd5fEXyc8n9YBMgX3LzzxWnL7Pqz+RgXlewlxboa1gs99RP6ZEtMxo3wb2GEEIA8hZ/
	 kJNG1O2x6O3sci3HI2YH+UQaJcJRyl4FwU6Q4PHqdbac/FZ6wGuUHsuBmB9dctxQ6zD5k
	 mA6r4C5doXnJ11hJX0DMGPoYe+HCHGsVa7XVNVBy+oV6ATY0AalsiFkYbQk2+p4CFng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214614;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/JK3I4YwpyC6pX+GmJP3VhsjNAm4A9hfzYhfPC1P+R4=;
	b=Sq0qfP8GBiJ3wO540H6ffze9GA5tYbN9A1BFU6u5JwPZ6prN3ddDIjcje/md2azAiZ/C
	 Ng0FF2mhBSh0TqI31YVQu79JLLTcfv6cCntWZlUIp72gNnoNk4EoSaTY9zltwYJvtqXV4
	 rT7ylH5UdVcMqq8afiNajTbqFVuxT/7KyLJtZLOXppXSpHqNprG/oRz4inqlKDMU0kdIT
	 CzOiFY1vrShutHWVngJqRsClqKlRTd5AqapACOViEApSTPx1RntUwd//5iM42Hy5GwH/Y
	 FDSnUM/uckU9iXmZdEE+T2kSVGIJOY1YK42/XaAcAhAra5vvXFF7YazdHv98cmHe/iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heVeqfKN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26F606AB25;
	Wed, 28 Oct 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heVeqfKN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B121F01829;
	Wed, 28 Oct 2026 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214613;
	bh=/JK3I4YwpyC6pX+GmJP3VhsjNAm4A9hfzYhfPC1P+R4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=heVeqfKNPA8dOLJ/TdtXP3XEvy+T5Y/0mDaVyF0nhLtR4zC0MO/oEMz9SDzYNXiu3
	 Nyy7HHHjDowVvs9RbsdW9qsxIfpPv0MOsR+5rcTOBrmc5DVZgHVZwAXdRlj2JqV+t5
	 SWUz4DayQhhB3gm6lG8NOa0L7fWy05CxVtZQW6T6nPIJ/dU3DKWMmHtEHZIc2tnNdT
	 WzGjyhgdSp5T8oXXoBbljS1rYrD+blzWBXy9UncWlGvPZXB1U5J1O5GM98jKcX6jX/
	 Dntl2FCBMBZVRJFriQzpf5H7spz3/E8b5DYYubaIMKpJOG1jKR5FKq1fIgdgF0v64g
	 ktXdukJY9sjcw==
Message-ID: <sashiko-outbox-188343@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] KVM: s390: Improve unmapping of large ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028185422.272146-5-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 19:10:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: s390: unit mismatch comparing gfn against _REGION3_SIZE in =
gmap_unmap_gfn_range_fast()
--

commit a8a43df04b3daf5a4e6da5896223864c27f0c852
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Improve unmapping of large ranges

This commit speeds up unmapping of guest address ranges larger than 1M by
detaching PMD entries, clearing the detached PTEs, and reattaching the PMDs
instead of invalidating each leaf PTE individually.

> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index 225fdae3d57ca..04f3ab03a041a 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c
[ ... ]
> @@ -462,6 +453,129 @@ bool gmap_unmap_gfn_range(struct gmap *gmap, struct=
 kvm_memory_slot *slot, gfn_t
[ ... ]
> +static bool gmap_unmap_gfn_range_fast(struct gmap *gmap, gfn_t start, gf=
n_t end)
> +{
> +	const struct dat_walk_ops ops =3D {
> +		.pud_entry =3D _gmap_unmap_pud_fast,
> +		.pmd_entry =3D _gmap_unmap_pmd_fast,
> +	};
> +	gfn_t aligned_start =3D ALIGN_DOWN(start, _PAGE_ENTRIES);
> +	gfn_t aligned_end =3D ALIGN(end, _PAGE_ENTRIES);
> +	bool failed;
> +
> +	lockdep_assert_held_write(&gmap->kvm->mmu_lock);
> +
> +	/* Prefixes are below 2G; if the start is above 2G, nothing to do */
> +	if (aligned_start < _REGION3_SIZE)
> +		gmap_unmap_prefix(gmap, aligned_start, aligned_end);

[Severity: Medium]
In gmap_unmap_gfn_range_fast(), aligned_start is a gfn_t (in 4K page frames=
),
whereas _REGION3_SIZE is 2G in bytes (1UL << _REGION3_SHIFT, or 0x80000000).

Comparing aligned_start against _REGION3_SIZE checks whether the guest addr=
ess
is below 8T rather than 2G, causing gmap_unmap_prefix() to walk all vCPUs
while holding kvm->mmu_lock in write mode for any fast-path unmap starting
between 2G and 8T.

Elsewhere in arch/s390/kvm/gmap/gmap.c, gmap_limit_to_type() shifts
_REGION3_SIZE when comparing against a gfn_t:

	if (limit <=3D _REGION3_SIZE >> PAGE_SHIFT)
		return TABLE_TYPE_SEGMENT;

And arch/s390/kvm/gmap/dat.h defines the region-3 page count directly:

#define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
#define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)

Should this check compare aligned_start against _PAGES_PER_REGION3 (or
_REGION3_SIZE >> PAGE_SHIFT) instead of _REGION3_SIZE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028185422.2721=
46-1-imbrenda@linux.ibm.com?part=3D4
