Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BEE3D76;
	Sun, 26 Jul 2026 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039539; cv=none; b=iDFgS+XEILf4Z7lFOjqMV20aMSHChtEoCtStaauqmEqswQqK9TQui/e6rINs6q4bjvAqL0eYjXDtwjE0DKQhaN/x76srdRJRuZwcFLPpI8dMxXNBNQbyeLEHTtS9LLSq6pgDHare6e91vRcxzz0um6bLL3MVw1KQ5PbNdbcQmzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039539; c=relaxed/simple;
	bh=H66/eEjhEsQB3Afhtvff9Cm5QwWfCtYXVyMaOyMhUQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=knWTd6c/CqtfBYU7AahSIBBj2RupZTZALEIiokxIrlqcdgeGGEBF3bRdIfzdTTrh77k2fMOCX1Z8uXu3vQzv5/7b12Vkau7EPgSzkCr4wkXrOYquzrihvxJrDdgoiLDdZSJyM7DCJgBixbdxAgQ10iQV2SIcv++7ZcRU/JIstQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmhNI1aw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmhNI1aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746731F000E9;
	Sun, 26 Jul 2026 04:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785039537;
	bh=hGmT9eatjZ+vNtLASSensDxDytL1gct1sb9XYUiEZ2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MmhNI1awKdA7mxhTa4ht8IOg4A0X61vLSfPkGl6qLpsgXG65G+cD6ASyfkN3KmINe
	 p9c359Ik0wwFXr6uifmDtaUyirAnp8d6mL1HTgAYQB6repyK7bCeKfRt0qN9efUNmA
	 yYtLBxSf5YEy/ksaHXye4KblxCZWPOkxwLeOvHgeruzyrd5xeuVSkkDxZcvWpnE9DS
	 1YdjuwosejrBCPTm77wWna8ORhCmn8cmB4Z+xm8jnOqu1i1pszFrF+qMlXtEijInP2
	 qYfnN/E8K0aK4qzYU7qZN8gkv4uPYhVgqny+zw7LDdnRq+MXo9boYixBae53/OyQMP
	 dZmoH0eiq5CiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/10] s390/vfio_ccw: ensure first IDAW remains
 constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260726040129.2946151-5-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:18:57 +0000
Message-Id: <20260726041857.746731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The function get_guest_idal over-reads the guest's IDAL buffer whe=
n processing 32-bit (Format-1) IDAWs, potentially causing spurious I/O fail=
ures if the read crosses into unmapped memory.
--

--- Patch [4]: [PATCH v5 04/10] s390/vfio_ccw: ensure first IDAW remains co=
nstant ---
commit 9c17ea86e465307c28b3fca8602d9a6e74a2028b
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure first IDAW remains constant

This commit verifies that the first IDAW read remains unchanged between rea=
ds
to ensure a consistent set of IDAWs is used for the channel program.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -523,6 +523,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
> +	u64 first_idaw;
>  	int idal_len =3D idaw_nr * sizeof(*idaws);

[Severity: High]
This is a pre-existing issue, but does calculating idal_len using
sizeof(*idaws) (which is 8 bytes for dma64_t) cause an out-of-bounds
read when processing 32-bit Format-1 IDAWs?

Since vfio_dma_rw() is called with this idal_len further down in=20
get_guest_idal():

    ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), idaws, idal_len, fals=
e);

Could this over-read cross into unmapped or unpinned memory pages and cause
spurious I/O failures if a guest happens to place its Format-1 IDAL near the
end of a mapped page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D4
