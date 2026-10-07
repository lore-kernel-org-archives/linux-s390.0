Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A949BD87
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372002; cv=none; b=HmjApTLr2ziEBFx8lXjs6qQ6xSY93D+nwXhPBzgVK5AplbO7JeTQ/b7fTNAXiqGBy1kVsgHS3+DlyghGC+EBfFFianoCdjAtckjGHo5Mqckn3qHlleiDkwcLGkIo91ErVg864dJXoMJa+Htdij3bmIZh3Nbp/TlltxbwIe02bKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372002; c=relaxed/simple;
	bh=BUV58crLkjWG91+c4fu+ZLpJTBdaeIRPisLY4KO6ZrE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=G4rnmOABlcjOzqbuKAQ11SvOOKeB3GrQVvh9Np1CLjRdsZiz/8oNnXAPxc/USONgx9RnqMlzi3EyTmAMU4KnwuEqvGHCe+1Vezpt+U4PO1WT9COhdKYGe8j02oKO+6SvHsA68D05Nkrb0A/DDmDDqhggpx103rV67OpVCEHpCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcYz2cmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcYz2cmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D061D1F0089C;
	Wed,  7 Oct 2026 11:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791371964;
	bh=PgMR2qojPsuS770BFYI5iWiKv7rzdLi7cPVfVPXnH1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mcYz2cmCdNFbxtlMpwT2cv3xzd5l2Y90RPEL4dY53uZ3XTH2gWrCZ6Mrl1KpYA393
	 EpAWL43Igyp8Ki1oxpifipVW3lO6R1Mj8BU/c9AI1L1J7iAKDSMVYc7WQwEpNJCPIF
	 wT0Pqofz0KAuI6r8wNQfMjWjeD4pli98v01VOwQFuCS6Uve1IcMNdQmeFjp0GJMHNA
	 J6hXflsQb8YJqSo/j0CuWPcva4lvaiQEtzz+9Z5M//Emdx3FrlfQv3JO+3HbzY+Mdt
	 rRwVOeIQaJf4AS7fL6q9E9mfgAYb8uOijPgaxnWCxo0sZCNLVx5D+G4uR5IV/BThwk
	 Tx0YFdk3vHnxg==
Message-ID: <sashiko-outbox-162922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/pci: Use 32-bit fh outside of inline asm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261007-rpcit_trcfh_upstream-v1-2-8a2718cfb90b@linux.ibm.com>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
 <20261007-rpcit_trcfh_upstream-v1-2-8a2718cfb90b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:19:23 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/pci: infinite loop in zpci_refresh_trans on CC=3D2
--

commit 1c8706bb963f0d551da7d8535f804ca9f9b4305a
Author: Gerd Bayer <gbayer@linux.ibm.com>

s390/pci: Use 32-bit fh outside of inline asm
   =20
zpci_refresh_trans() declared the PCI function handle as a u64 type just
because the actual RPCIT machine instruction required that in a 64bit
register, while the function handle is architected as a 32bit type and
defined as such in the zpci_dev struct.

> diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
> index 2ba787e2304b5..053afb3e7a990 100644
> --- a/arch/s390/pci/pci_insn.c
> +++ b/arch/s390/pci/pci_insn.c
> @@ -117,13 +117,14 @@ static inline u8 __rpcit(u64 fn, u64 addr, u64 rang=
e, u8 *status)
>  	return CC_TRANSFORM(cc);
>  }
> =20
> -int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
> +int zpci_refresh_trans(u32 fh, u64 addr, u64 range)
>  {
> +	u64 req =3D ZPCI_CREATE_REQ(fh, 0, 0);
>  	bool retried =3D false;
>  	u8 cc, status;
> =20
>  	do {
> -		cc =3D __rpcit(fn, addr, range, &status);
> +		cc =3D __rpcit(req, addr, range, &status);
>  		if (cc =3D=3D 2) {
>  			udelay(ZPCI_INSN_BUSY_DELAY);

[Severity: High]
Does this retry loop risk causing an infinite loop or CPU stall when handli=
ng
large DMA spaces?

When the s390x RPCIT instruction sets CC=3D2, it indicates that it cannot c=
omplete
the operation in the allotted time. It then updates the address and range
registers to reflect the remaining uncompleted portion.

However, in __rpcit(), addr_range is passed using an input-only constraint =
("d"
instead of "+d"), and the arguments are passed by value:

arch/s390/pci/pci_insn.c:__rpcit() {
	union register_pair addr_range =3D {.even =3D addr, .odd =3D range};
	...
		: [addr_range] "d" (addr_range.pair)
}

Because the hardware's partial progress updates to addr and range are disca=
rded,
this loop continually re-invokes __rpcit() with the unmodified original
addr and range.

If scanning the initial portion consistently exhausts the hardware time sli=
ce
(such as during IOMMU TLB flushes on devices with large DMA spaces in
zpci_refresh_all()), will the operation fail to advance and loop infinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-rpcit_trcf=
h_upstream-v1-0-8a2718cfb90b@linux.ibm.com?part=3D2
