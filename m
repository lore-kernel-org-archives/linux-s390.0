Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF423B05A1
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371865; cv=none; b=n4bez2R0bcTlceffnKaHlHPkPy6q5Sq8THNDNd+PpUZGgpfyLbJwvM6EzbCUGqzdVommEB5QaS6qFJaQ0cyuet3bG6ERZKnLf7KlYXkb3/CKFT9t6yYic3dSy32FyfQkG45Su52bZSkJ28sOru8YL3LIdQAjbVXLmg6T0jH6X5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371865; c=relaxed/simple;
	bh=kqQJgZWOAzCuCpNMnQd5IRLRFQaQKEPVz2H4x6JTUhA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AWa76KiZO0ZnaYguLoVvdprHLN/XLxB/BLlHaPSU6jolQDDK0RMgKeQO7oeawMN5uHWBp9SELFz62Ed1v6cXRXU78JJYnZdA9Ai5iBztRmk8OwZT4vNBq4/ARnY45SKujXg72jj9akk0AOGhtcLIDX6uzhnaR26ahDQ/0ag2QCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kptflivO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kptflivO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47821F0089B;
	Wed,  7 Oct 2026 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791371846;
	bh=+2I8hl/+FA6psam9Y35R4nU5lENA0nNLWYNstJpe0hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kptflivOGpNJXBqj0nQL1cmjE5PhFrhE7et3cTgEUR1IZlOLQdTYfWQUK9lF76DrP
	 qaS5lJz8XaDhmyZ6ncr2wWba9XddqkySqVMhD9FW179dxQbSt5dAYP/1siUprBG6ia
	 PUBs/ptX8iRhAZLkwGjKGizZzKBmuusVMfUfoMlIIBWHrkrm5xTa2aFYzJsEwCRB1f
	 liVwX5LP106KfgFWKADVN+tOaUUCTn6jLiNbJonuiDQ+saO2aOjCvoDRSnc1L6qb3L
	 1U7DwS6HHs2VlS/SdJY/LYsQy5S4N22Y1eZ7B6JZJAnDyZ/eP1xSaW4FWM31x55K91
	 5k16oda3jRdWQ==
Message-ID: <sashiko-outbox-162921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/pci: Add function handle to RPCIT insn trace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261007-rpcit_trcfh_upstream-v1-3-8a2718cfb90b@linux.ibm.com>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
 <20261007-rpcit_trcfh_upstream-v1-3-8a2718cfb90b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:17:25 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/pci: info leak of uninitialized struct padding in zpci_err_=
insn_rpcit
--

commit 9deafec98847a2a1de20826fbaa6431e1e3c973f
Author: Gerd Bayer <gbayer@linux.ibm.com>

s390/pci: Add function handle to RPCIT insn trace

In certain debug situations it would be helpful, if the insn trace for a
failing RPCIT would reveal the PCI function on which this was attempted.

Introduce a variant of zpci_err_insn_req() called zpci_err_insn_rpcit()
that accepts an IO virtual address and a range parameter together with
the req conveying the function handle. Switch zpci_refresh_trans() to
use that new error trace.

> diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
> index 053afb3e7a990..ae9ed4aa2ec9c 100644
> --- a/arch/s390/pci/pci_insn.c
> +++ b/arch/s390/pci/pci_insn.c

[ ... ]

> @@ -29,18 +29,40 @@ struct zpci_err_insn_data {
>  	union {
>  		struct {
>  			u64 req;
> -			u64 offset;
> +			union {
> +				/* PCILG/PCISTG/MPCIFC */
> +				struct {
> +					u64 offset;
> +					u64: 64;
> +				};
> +				/* RPCIT */
> +				struct {
> +					u64 iova;
> +					u64 range;
> +				};
> +			};
>  		};
> +		/* PCILGI/PCISTGI */
>  		struct {
>  			u64 addr;
>  			u64 len;
> +			u64: 64;
>  		};
>  	};
> -	u64: 64;
>  };
> =20
>  static_assert(sizeof(struct zpci_err_insn_data) <=3D ZPCI_ERR_INSN_DATA_=
SIZE);
> =20
> +static inline void zpci_err_insn_rpcit(int lvl, u8 insn, u8 cc, u8 statu=
s,
> +				       u64 req, u64 iova, u64 range)
> +{
> +	struct zpci_err_insn_data data =3D {
> +		.insn =3D insn, .cc =3D cc, .status =3D status,
> +		.req =3D req, .iova =3D iova, .range =3D range};
> +
> +	zpci_err_hex_level(lvl, &data, sizeof(data));
> +}

[Severity: Medium]
Does this code leak uninitialized stack memory to the s390dbf debug trace
buffer?

According to the C standard, unnamed bit-fields do not participate in
designated initialization. The struct zpci_err_insn_data starts with:

struct zpci_err_insn_data {
	u8 insn;
	u8 cc;
	u8 status;
	u8: 8;
	u32: 32;
    ...

Because the unnamed bit-fields are skipped by the designated initializer he=
re,
up to 5 bytes of uninitialized kernel stack memory are left in the padding
of "data".

Since sizeof(data) (which is 32 bytes) is then passed to zpci_err_hex_level=
(),
could these indeterminate stack bytes be copied into the trace buffer on ev=
ery
invocation of zpci_err_insn_rpcit()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-rpcit_trcf=
h_upstream-v1-0-8a2718cfb90b@linux.ibm.com?part=3D3
