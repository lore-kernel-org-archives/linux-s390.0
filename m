Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B843B2AA;
	Wed, 19 Aug 2026 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107685; cv=none; b=R7gD4Wcd5nZmApjjBQCKZyaOT4Cea8s47BoFtmGJAXYDSLFO7T9aJz1ZD/ngUZjtk+ZuFzjnrYsQXmNAZKiLnOBiGdjXdEC98W3ypV3ena0J2VjOuTkef9o+IrOkLdt4bhEs4MaU+pKic0B9n92IZ7mvuOCuXm+WReMty05VOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107685; c=relaxed/simple;
	bh=i9c+JSL2U4hmyb+0z2zMU3ymC9xHAC4Tyh4V69g9OSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pl32tq+Y1wXVwLa/UVEsIEJRBMbWn/1DjPPOeIc47v6O9UUmy85ISnHAGJZhpjuJ3bKmYf7/SBsmIGY7+Rsli7IyZAWiJ9txDOBI/jL5KO7I3AzsDa6jxiViV1y1P2XdLXojO/ME4UHCupE183rv7xjAYsip/MSeVIcsjBTOts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynbrub4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynbrub4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECC11F000E9;
	Wed, 19 Aug 2026 02:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107683;
	bh=83sKuy5+IK9zu5bhHgd/Pu9FbTXbvTJhQtoBvw7+/NY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ynbrub4itaCxlmUQiOMWFplQxziwDcWBZ+w/lizVZPvBi3TJAzK/MZENZvD7eZEs+
	 bgnmq0LhKYHg0ZMbqJQOj3J9/sfgXRzVLIVYk67V+mKBXYoqE4hafQRCcnuDSOjkFH
	 vYXEXi/xe+NskwyAGoMrO9KwZZlbIYjjTEJXJwVC3Xyjb9aZ4FXyKLOidShaFYKtbv
	 dNxtGfdKJnV2biigwZ5F9nQcd8wg7zcHoKoDqZ0VQmfnWqcDEuR4TDtpiBFpO6hmxb
	 pVwbowXfzt90gKJ3SmY+1px6DYhLya4PWBAdogb+YeHlYHgOCHumMfQS5NtrbNrMBa
	 9Jv+Vlla98s5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 07/13] sysctl, net: update
 register_net_sysctl{_sz}() callers with template arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, bpf@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, mptcp@lists.linux.dev
In-Reply-To: <20260818-sysctl-module-aliases-v2-7-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-7-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:48:03 +0000
Message-Id: <20260819024803.6ECC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Syntax error and implicit function declaration when CONFIG_SYSCTL i=
s disabled due to macro collision.
- [Low] The `__UNIQUE_ID` macro is used without arguments in `__MODULE_SYSC=
TL_TABLE_NAME`, preventing it from generating a unique identifier.
--

--- Patch [7]: [PATCH RFC v2 07/13] sysctl, net: update register_net_sysctl=
{_sz}() callers with template arguments ---
commit 35e3405d9382d3cfe84c302ce928023b61da151b
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

sysctl, net: update register_net_sysctl{_sz}() callers with template argume=
nts

Update most callers with dynamic table/path to use template arguments.

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb642..bdd67dd879d24 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -12,6 +12,7 @@
>   */
> =20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define SYSCTL_MODULE_ALIASES_UNIQUE_ID

[Severity: Low]
When SYSCTL_MODULE_ALIASES_UNIQUE_ID is defined here, the macro
__MODULE_SYSCTL_TABLE_NAME(table) in include/linux/sysctl.h expands to
__mod_device_table(sysctl, __UNIQUE_ID).

Since __UNIQUE_ID is a function-like macro requiring a prefix argument, does
omitting the parentheses prevent it from being expanded by the preprocessor?
Could this create identical literal symbol names for all instances in a mod=
ule
and defeat the uniqueness mechanism?

> =20
>  #include <linux/slab.h>
>  #include <linux/types.h>
[ ... ]
> @@ -3910,11 +3911,15 @@ int neigh_sysctl_register(struct net_device *dev,=
 struct neigh_parms *p,
>  	      BUG();
>  	}
> =20
> -	snprintf(neigh_path, sizeof(neigh_path), "net/%s/neigh/%s",
> -		p_name, dev_name_source);
> +#define path_template "net/%s/neigh/%s"
> +	snprintf(neigh_path, sizeof(neigh_path), path_template,
> +		 p_name, dev_name_source);
>  	t->sysctl_header =3D register_net_sysctl_sz(neigh_parms_net(p),
>  						  neigh_path, t->neigh_vars,
> -						  neigh_vars_size);
> +						  neigh_vars_size,
> +						  neigh_sysctl_template.neigh_vars,
> +						  path_template);

[Severity: Low]
Does this call to register_net_sysctl_sz() cause a build failure when
CONFIG_SYSCTL is disabled?

It looks like register_net_sysctl_sz is globally defined as a macro, which
unconditionally expands over the static inline fallback definition in
include/net/net_namespace.h, producing invalid C syntax. Additionally, would
this macro expand to __register_net_sysctl_sz(), which lacks a stub in the
!CONFIG_SYSCTL path, causing implicit function declaration errors?

> +#undef path_template
>  	if (!t->sysctl_header)
>  		goto free;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D7
