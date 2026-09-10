Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A337E5FD
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038911; cv=none; b=M6gOvxFSzkv8tx0c9+iwnNP7CGe8iPTEY5tfMYrhri+gsk5l8lsUGL7IUVIAWqeacbTq+y14OdTvzRUJ+u3DJt9l1ruucPHdnDcTiQGeSo3Oy0DshnnZZ6uo5D51NK1f0Hmop9vwqC9Qpjps9JE3UpolWVKM+i52CHHWFfZYLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038911; c=relaxed/simple;
	bh=Cy+3ebXUT/+dRc+xIrPIgdZrGEDJcaL3m5qlC0vg2uE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SgJK7PpuTWX3X60ANAIDCN6LkB2fy3aoaJ+ZYXeV3L8wZPKreQ4sifFPGb1+pa55XwSs2n4pxd5iMUsE5KthE9VqK6qlNK7bfJsFHpdbSI7x4UOq71R3RwsRw/dudTtxFHuVKUCO6cPBVOXzrfeBsC2BdQeGxOiD83zM/RkPI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaEaDNoA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaEaDNoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94671F00893;
	Thu, 10 Sep 2026 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038910;
	bh=UEjMGf3BrLYUAdEq/pTKAjfBOVFKuop0pNEnRp671rE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iaEaDNoAX9MY0sJmMRmo/2PCmUUDO2kb2Q6mjlieLeQA+uwIMPsXBVS6iLi+/eV0L
	 orbTLpKBXxl9lr7/PDkM/mKEe60eIyAg0sbe88/ZpOQYX8jwpbbPyskEczvHl9sYYJ
	 7SmdrKVyOKsPYcjqagqNhMqdhjJjVpCshZk6CBGtQu9YcOJAFPu65eEVSej9CtMUYK
	 l8iZGY+gUtjKebC18T2KWCPKL1OGPcgm9E/NnbVL565A9LY8kpPSUoYaFsDYKd+LSH
	 I+nKEdhSnCyew9pvZrG+VMLiTa2k7lIVom213ZtDrbdBcMu3TEiILD1hYHj4QVy2w4
	 /PDu/bPXh9CIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] s390/cmf: Use kmalloc() for the CMB area
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-6-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-6-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:15:09 +0000
Message-Id: <20260910111509.E94671F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kmalloc() does not guarantee the 32-byte alignment required by the=
 measurement block hardware for non-power-of-two sizes.
--

commit d40fffe39ac5da27ae9d3ccc129516e13b780620
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/cmf: Use kmalloc() for the CMB area

This commit replaces the use of __get_free_pages() with kmalloc() for
allocating the channel measurement block (CMB) area. It suggests that
kmalloc() naturally provides the required 32-byte alignment without
rounding up to a power-of-two number of pages.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
> index 92ab3d546fe47..8fd41a7dfc20b 100644
> --- a/drivers/s390/cio/cmf.c
> +++ b/drivers/s390/cio/cmf.c
> @@ -501,12 +504,12 @@ static int alloc_cmb(struct ccw_device *cdev)
>  		WARN_ON(!list_empty(&cmb_area.list));
> =20
>  		spin_unlock(&cmb_area.lock);
> -		mem =3D (void *)__get_free_pages(GFP_KERNEL, get_order(size));
> +		mem =3D kmalloc(size, GFP_KERNEL);

[Severity: High]
Does kmalloc() guarantee the strict 32-byte alignment required by the schm
instruction when slab debugging or KASAN is enabled?

If the maxchannels module parameter is set to a value resulting in a
non-power-of-two multiple of 32 (for example, 3 channels which is 96 bytes),
the allocation uses the kmalloc-96 slab cache. While 96-byte pacing might
naturally align to 32 bytes in a default configuration, enabling
CONFIG_SLUB_DEBUG or CONFIG_KASAN adds left redzones to the objects.

This shifts the returned memory pointer, breaking the 32-byte alignment.
When cmf_activate() uses this pointer for the schm instruction, it will
cause a hardware fault and a kernel panic (Specification Exception) because
the measurement block origin is not on a 32-byte boundary.

The previous __get_free_pages() implementation avoided this by unconditiona=
lly
providing page-aligned memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D6
