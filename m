Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE833BBC6
	for <linux-s390@vger.kernel.org>; Mon, 29 Jun 2026 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718513; cv=none; b=Yw7PgtSSrnFN50qbfTnuMCxz+kV94nvY/wh+kiEh5cYAE2Uke/6e7R3qzQNp9rVjW42IKwSuZGKD+PF1pqYHV0US8YwMDkPQ0sJ+4tLixI6V5kYJ6Ltb0kWq9WnyiGVGjFDH/3DzGJEcAZ1WJMvsJeuBVpXOjZeeONGvcGPsGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718513; c=relaxed/simple;
	bh=7FpVBSRGDERu/2ePlikwnOVX+nZ2MoPdYMxppcdIsk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cJ4kePIc2gEcLWh8ypyJfqiMOHFmLI6IztL5Dy3+TWpJ2NWgDTV9Us/XceVHO2NDqdD835XEerFiq/J9iH/KrnkEFEKhFU7B7IRAvbtbOB6EY5yN5ynQkeiZ75IALO3zV82CY+JtShSzUXutegpVLPJeUG/zZnHbpmpw/KEA/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se1WP/tZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se1WP/tZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB5B1F00A3D;
	Mon, 29 Jun 2026 07:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782718509;
	bh=MK8+UjtS3BEmu48m47WR7eMdAGq1rlYyt5qvFXDAmT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Se1WP/tZVlgVIGpeIIkm4xK8TJ4XperRVQZXgqf7upppFCDslrpr+Uyl3yjQ8/LPA
	 PP+odxHfoS3FeYqi//DrAMp/8hQNlLedSP5K/YQ64iNQ7bztH+Mm7wSJ86BlUPhg19
	 fJxJln00g2gqNHxNokXA6rNJ7X1xZ8mPdN7Qw4Hd3mxpQ0VF92BM1eKLPifej/xLu8
	 qq0CaXgN3/oT7A/p4714vAgkgmsoUc7HIsQHf66vTY9BzJYohibm9LxKKstIfVRUsv
	 P4J8ScmMedV8YPRbqn0t37rCIrUymjmRifpar28TaNpFIuUh9GiZ91VK/RfdU9bGPH
	 5up7IF48ZJzTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] block: partitions: Use seq_buf_putc() at 24 places
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <7360cab3-7a2f-4903-85f1-0f03387b0d88@web.de>
References: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
 <ajzkRM_RFKBpp0i5@ashevche-desk.local>
 <7de415a7-457d-4dd2-aebb-8e179fa0bbcd@web.de>
 <aj061omzs5WN5ar6@ashevche-desk.local>
 <7360cab3-7a2f-4903-85f1-0f03387b0d88@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:35:08 +0000
Message-Id: <20260629073509.0CB5B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read in sysv68 partition parser leading to a kernel =
memory leak.
- [Medium] Uninitialized variable 'len' may lead to a NULL pointer derefere=
nce or undefined behavior.
--

commit 350b3ea7021ee2238b49cf91963fe54906868307
Author: Markus Elfring <elfring@users.sourceforge.net>

block: partitions: Use seq_buf_putc() at 24 places

Single line breaks should occasionally be put into a sequence buffer.
Thus use the seq_buf_putc() function in these implementations.

The source code was transformed by using the Coccinelle software.

[ ... ]

> diff --git a/block/partitions/of.c b/block/partitions/of.c
> index 53664ea06b654..7803e6f4ecdd9 100644
> --- a/block/partitions/of.c
> +++ b/block/partitions/of.c
> @@ -104,7 +104,7 @@ int of_partition(struct parsed_partitions *state)
>  		slot++;
>  	}
> =20
> -	seq_buf_puts(&state->pp_buf, "\n");
> +	seq_buf_putc(&state->pp_buf, '\n');

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential uninitialized
variable bug when looking at the partition validation called just before
this in of_partition().

If a device tree partition node is missing the 'reg' property:

block/partitions/of.c:validate_of_partition() {
    ...
	int len;

	const __be32 *reg =3D of_get_property(np, "reg", &len);
	int a_cells =3D of_n_addr_cells(np);
	int s_cells =3D of_n_size_cells(np);

	/* Make sure reg len match the expected addr and size cells */
	if (len / sizeof(*reg) !=3D a_cells + s_cells)
    ...
}

of_get_property() returns NULL and leaves len uninitialized. The code then
divides this uninitialized len by 4 and compares it to expected cell counts.

If the uninitialized stack garbage happens to match, could this proceed to
add_of_partition() where it directly passes the NULL reg pointer to
of_read_number(), unconditionally dereferencing it?

block/partitions/of.c:add_of_partition() {
    ...
	int len;

	const __be32 *reg =3D of_get_property(np, "reg", &len);
	int a_cells =3D of_n_addr_cells(np);
	int s_cells =3D of_n_size_cells(np);

	/* Convert bytes to sector size */
	u64 offset =3D of_read_number(reg, a_cells) / SECTOR_SIZE;
    ...
}

[ ... ]

> diff --git a/block/partitions/sysv68.c b/block/partitions/sysv68.c
> index 470e0f9de7be3..31d348ac2dfb3 100644
> --- a/block/partitions/sysv68.c
> +++ b/block/partitions/sysv68.c
> @@ -86,7 +86,7 @@ int sysv68_partition(struct parsed_partitions *state)
>  		}
>  		slot++;
>  	}
> -	seq_buf_puts(&state->pp_buf, "\n");
> +	seq_buf_putc(&state->pp_buf, '\n');

[Severity: High]
This isn't a bug introduced by this patch, but does the loop immediately
preceding this code have an out-of-bounds read issue?

sysv68_partition() reads the number of slices from the untrusted disk
label without validating it against the 512-byte sector buffer bounds:

block/partitions/sysv68.c:sysv68_partition() {
    ...
	slice =3D (struct slice *)data;
	for (i =3D 0; i < slices; i++, slice++) {
		if (slot =3D=3D state->limit)
			break;
		if (be32_to_cpu(slice->nblocks)) {
			put_partition(state, slot,
				be32_to_cpu(slice->blkoff),
				be32_to_cpu(slice->nblocks));
    ...
}

It then iterates up to state->limit (typically 256) times, advancing the
slice pointer. Reading 256 struct slice entries takes 2048 bytes out of a
guaranteed 512-byte sector buffer.

If the 512-byte sector is located near the end of a mapped page, could
reading beyond 512 bytes cross into adjacent physical kernel memory and
leak it via the partition table?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/7360cab3-7a2f-4903-=
85f1-0f03387b0d88@web.de?part=3D1
