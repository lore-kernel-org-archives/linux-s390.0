Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C963B8921
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777341; cv=none; b=mq6+CQ9e2xCCAAtG7Od7BCjpyByhzSrBqWU1SuzaSCFgRR7TuSuHDTiilMp/FFiI1ucLnFBf8aHqbdNxdRbGAooG3laxsmYmraEtvrCI/T2LDrsjmdMjxdPu0P1suZvWE/lo/3ZCP/AGQ1kZjcgwL5uCJ/LyiBF2vDPochPvtyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777341; c=relaxed/simple;
	bh=KfhcmdAedZp3aL9wbCP6yxJxRnPDTtqYwUoucVenV8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oTm1BJY909kslshloa1OX4/hcKF0VdDTWS1WMcHBCNv4KTXRstzd3n10raCMDQqr2rxst8niA2nZwSGSNxjPfhL6U6ATTJOT23qV4pn3XlSZWWzAgweJSa+hOVw+iLsVoYeb6G6qMOMsBnPgkxlj5Pp+WOqfLrvbRk1dCNKwL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK572jF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK572jF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250761F00A3A;
	Mon,  7 Sep 2026 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777340;
	bh=0cdMPTBWk9ImRyKRgHa0xmhDC4nlLzQty4BVOpoDifU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CK572jF9lFpivLDehQDTIHBhYvPGAVm1mOmWMS5l3+nbJ0tyBmHi20n/fTapyRcCF
	 4Ll7QfHNCvrlKTALjiYNpjZWGnYMvdbnSw3UdTxzMZU/k6quazVjKsxxZckv9HvHvQ
	 zJXlEhQP55zuS6utU4yYc4oxS3+HpslJIMtQuynQhn3LllNBtanZRqN0az0M/seYiY
	 01FDwdIAUYFnSeJRAZZGafWu7ma6ixmpJ9V6O6iwBSzSPZTUqmcw4rBtSUvrd6qXjS
	 mbZEqeNoIMIt8iUErCQdK2g+kVzyIAS/oSEkFEn9m6uhzAoV0+Gvtai43SKr58HtGZ
	 LyrEY0MpuAGEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] s390/cmf: Use kmalloc() for the CMB area
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260907-s390-cio-ready-v1-6-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-6-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:35:39 +0000
Message-Id: <20260907103540.250761F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Integer overflow to zero-size allocation causing lowcore memor=
y corruption.
--

commit 2913241109f97628467377f13982dfc657e8d846
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/cmf: Use kmalloc() for the CMB area

This commit replaces __get_free_pages() with kmalloc() for allocating
the channel measurement block area, and updates the free path to use
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
> index 92ab3d546fe47..6c46b0d0b3da4 100644
> --- a/drivers/s390/cio/cmf.c
> +++ b/drivers/s390/cio/cmf.c
> @@ -501,12 +501,12 @@ static int alloc_cmb(struct ccw_device *cdev)
>  		WARN_ON(!list_empty(&cmb_area.list));
> =20
>  		spin_unlock(&cmb_area.lock);
> -		mem =3D (void *)__get_free_pages(GFP_KERNEL, get_order(size));
> +		mem =3D kmalloc(PAGE_SIZE << get_order(size), GFP_KERNEL);

[Severity: Critical]
If size evaluates to 0 (for example, if the maxchannels module parameter
is configured to 0 by the user), get_order(0) underflows and returns 52 on
64-bit s390x.

The allocation size expression PAGE_SIZE << 52 evaluates to
(1UL << 12) << 52, which wraps around modulo 64 and evaluates to exactly 0.

Will kmalloc(0, GFP_KERNEL) then return the ZERO_SIZE_PTR sentinel value
(0x10) instead of NULL?

>  		spin_lock(&cmb_area.lock);
> =20
>  		if (cmb_area.mem) {
>  			/* ok, another thread was faster */
> -			free_pages((unsigned long)mem, get_order(size));
> +			kfree(mem);
>  		} else if (!mem) {

[Severity: Critical]
Since ZERO_SIZE_PTR !=3D NULL, will this error check fail to catch the
sentinel value?

If this check fails, the code continues to the success path:

drivers/s390/cio/cmf.c:alloc_cmb() {
...
		} else {
			/* everything ok */
			memset(mem, 0, size);
			cmb_area.mem =3D mem;
			cmf_activate(cmb_area.mem, CMF_ON);
		}
...
}

For size =3D=3D 0, memset(ZERO_SIZE_PTR, 0, 0) does nothing. The code then
proceeds to call cmf_activate((void *)0x10, CMF_ON).

Since the schm hardware instruction is given physical address 0x10, will th=
is
instruct the channel subsystem to blindly write DMA measurement data into t=
he
CPU's lowcore (PSA), resulting in system crashes by destroying critical ker=
nel
state?

Prior to this patch, __get_free_pages(GFP_KERNEL, 52) gracefully failed by
returning NULL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D6
