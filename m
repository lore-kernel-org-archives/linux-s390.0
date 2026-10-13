Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5551EDFD
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932216; cv=none; b=D9HZlP3C4R1dMYd/YNG2znB7o6btXQsuGEEDHmfa55YfBPvu4nssZtX+iwW0HBwtLiIJeWPxrBHFoxplwSzQLyuXCRlAPHpi0LeXYJ9YV58oToctqMMYZgpgWXP4YH4NSZWmiB3CIGIZ/TXCnTIa7DzAUpwLp8DbIXiGSzQx+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932216; c=relaxed/simple;
	bh=/OiBLdMWYxWLHuhpfX8EUpXWitwq95gHYfYD1aOfa1M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HM9vAhCKxsDJKYpstwReBpOrNtoKsHWB0HV1oWPKgS2689WXF52ehhezBFbme09m/0EKrvPGzioRyadUZqec61zOcvd8KiEVVpe9qy+WD5V3TAEIvjYRWTPCWxzUDFxdNLN/PeR1d4kizMl4j0Wio2MiV60UW6ksZgpNg7ifCiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok+BWzW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok+BWzW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A340B1F000FF;
	Tue, 13 Oct 2026 22:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932211;
	bh=gjkgxxinhqTDIQGP/ABYkBIuyO2cHEre5iS+nuSjUYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ok+BWzW8LTbJHjPWuh2+er1A+/R/lxIJ7ow13QTtxixuHzRI9G7BfQ2KfZngeepEP
	 +LQBLh2wQN8falGFtp17zZgWQjm+cKYDabUW8hLhYVMmz6U/XO0GptExn/p0pP31DL
	 szpp9BUUkniN3hM2HsaDdfw/u+CK7YFTtG7lbG5CCOdzYN9IeWFBPXfdXJZNBhRICW
	 imncxFIuwKTgSSLpzUSS4AEVdm+mT/kE5cp6JbpeDGOvVgXUSo4Gmd2OIp3KdcBS3k
	 6SjUDuP4PlpmeaW+oAFD8tRn2sTBNkWkiyzwAwj22wy1ZkNDN1F1Cr100NF22xcJgH
	 s/ophu6aLIzPg==
Message-ID: <sashiko-outbox-170611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] kobject: Require explicit initialization of
 struct kobj_type::release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Kees Cook" <kees@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Nayna
 Jain" <nayna@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "David Teigland" <teigland@redhat.com>, "Alexander
 Aring" <aahringo@redhat.com>, "Juergen Gross" <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Richard Weinberger" <richard@nod.at>, "Zhihao
 Cheng" <chengzhihao1@huawei.com>, "Felix Kuehling" <Felix.Kuehling@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261013223946.1836757-12-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:56:49 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] sysfs: Use-After-Free in kobject delayed release via devm/memset
- [Low] sysfs: incorrect documentation for dss_overlay_kobj_uninit() cleanup
--

commit 25c0a8c68e5a115989252d41a0d4731867415d79
Author: Ian Rogers <irogers@google.com>
Subject: kobject: Require explicit initialization of struct kobj_type::rele=
ase

Annotate struct kobj_type::release with __require_explicit_initialization
so the compiler diagnoses any struct kobj_type initializer that omits
.release. For the remaining legacy struct kobj_type definitions where the
kobject is static, per-CPU, or embedded inside a devm- or parent-managed
structure rather than freed by kobject_put(), explicitly initialize
.release =3D NULL.

Link: https://lpc.events/event/20/contributions/2392/

> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index e796ddb5383f8..7fdd0ca36b98a 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -167,6 +167,8 @@ static const struct attribute *const ioat_attrs[] =3D=
 {
>  ATTRIBUTE_GROUPS(ioat);
> =20
>  const struct kobj_type ioat_ktype =3D {
> +	/* ioatdma_chan is allocated via devm_kzalloc() rather than freed by ko=
bject_put(). */
> +	.release =3D NULL,

[Severity: High]
Does this setup cause a use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE is
enabled?

When kobject_put() is called, it queues a delayed_work to execute
kobject_cleanup() later. Because the struct is managed by devm_kzalloc(),
the memory is freed immediately after unbind, leaving an active delayed_work
pointing to the freed memory.

[ ... ]

> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon=
/kunpeng_hccs.c
> index 0cc2953d59a54..5d083d2b72caa 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -1038,6 +1038,8 @@ static struct attribute *hccs_port_default_attrs[] =
=3D {
>  ATTRIBUTE_GROUPS(hccs_port_default);
> =20
>  static const struct kobj_type hccs_port_type =3D {
> +	/* hccs_port_info is allocated via devm_kcalloc() rather than freed by =
kobject_put(). */
> +	.release =3D NULL,

[Severity: High]
Can this devm allocation cause a use-after-free for the delayed_work?

Similar to the ioat_ktype case, the devm_kcalloc allocation means the struct
containing the kobject is freed upon driver unbind immediately after
kobject_put() executes, leaving a pending delayed_work on freed memory.

[ ... ]

> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drive=
rs/video/fbdev/omap2/omapfb/dss/display-sysfs.c
> index ae937854403b1..3d787245f5b51 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
> @@ -304,6 +304,8 @@ static const struct sysfs_ops display_sysfs_ops =3D {
>  };
> =20
>  static struct kobj_type display_ktype =3D {
> +	/* dssdev->kobj is embedded in struct omap_dss_device and zeroed in dis=
play_uninit_sysfs(). */
> +	.release =3D NULL,

[Severity: High]
Does this zeroing pattern corrupt the active workqueue when
CONFIG_DEBUG_KOBJECT_RELEASE is enabled?

Looking at display_uninit_sysfs(), the code calls kobject_put() followed
immediately by memset:

void display_uninit_sysfs(struct omap_dss_device *dssdev)
{
	...
	kobject_del(&dssdev->kobj);
	kobject_put(&dssdev->kobj);

	memset(&dssdev->kobj, 0, sizeof(dssdev->kobj));
}

Since kobject_put() schedules a delayed_work, wouldn't the memset
synchronously destroy the active work struct before it can run?

[ ... ]

> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c b/drive=
rs/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
> index 1da4fb1c77b4a..9aa16b3dee5ef 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
> @@ -429,6 +429,8 @@ static const struct sysfs_ops overlay_sysfs_ops =3D {
>  };
> =20
>  static struct kobj_type overlay_ktype =3D {
> +	/* ovl->kobj is embedded in static overlays[]; dss_overlay_kobj_uninit(=
) only calls kobject_del(). */
> +	.release =3D NULL,

[Severity: Low]
Is this comment accurate?

Looking at dss_overlay_kobj_uninit() in the same file:

void dss_overlay_kobj_uninit(struct omap_overlay *ovl)
{
	kobject_del(&ovl->kobj);
	kobject_put(&ovl->kobj);
}

The implementation contradicts the comment by explicitly calling
kobject_put().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D11
