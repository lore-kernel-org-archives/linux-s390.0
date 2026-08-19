Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCB2931C7;
	Wed, 19 Aug 2026 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107479; cv=none; b=Jg++XMcH10tFSNJg2ad904svjfHIIC6xpmXCO+eddkqOVuDX7hD3Z4hHo4amVXDeHLHI3wh2REe59we9vtRwwrJOOUYnye/JJNu/JNVgwjvvtuWmCTCnlYKLYnYGNLWwKa43qywHafvLL9IJnQYyRtLjH75HCoXBe4wL3ceOaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107479; c=relaxed/simple;
	bh=X/0y7vrhWbs72tMs0PEY7kCoxztvpG18SP+Kb5Dpj0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I3h/bBr8WqqZYxH7P3AlIeKhc5GIkGda7tJQ/GpfKlycD9Pnhl+m6fkcNPpYfvMyLxWhEO2usPytPFnXAyprW6sfsFAOiKVENf8ioiwQ17ZixGeWTtjvSWUQZFaiovNUs8n/JVKE7rhbycsWeuSHqsYOK9TGxBfTGTa6X/Jsl+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlGzPeSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlGzPeSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E5E1F000E9;
	Wed, 19 Aug 2026 02:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107477;
	bh=sG0B+r2TsUy61dsUKcYrsekhVYedxq9TOINeyXwRE2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WlGzPeSDHZsntqaoUNweeIL//XV9EXHcNSuFTfGU6hkj+Y/koZ/Cd81RhofDJPTVE
	 ZeM8TpUp3Ch95/c/gNJPE0zQGda0sdRcluzQSEzx32hyYeS9ETz86NSERPOeG35tAm
	 /W3NC0ta7nTXOqXiDiPafEwUI0y1jeF6O8D9wK7NrjpioMOibJJc717TeMthXxU6DI
	 w3+xYHiqdIazhMxyqHlJHEj/Tcy7IFY9j1O+UlCNleU08nFvzHGpoeFenehof65rKf
	 niI1BRv9cxoiYs3tCfhV1XW5PvE53qMbE5ZHUyAY67Y/e3+KiUgsCF8lPGLm+gtC2Z
	 DPpDywdkr4Tmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 04/13] sysctl: add register_sysctl() wrapper for
 MODULE_SYSCTL_TABLE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, mptcp@lists.linux.dev, bpf@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818-sysctl-module-aliases-v2-4-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-4-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:44:37 +0000
Message-Id: <20260819024437.87E5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The macro `__UNIQUE_ID` is used without an argument in `__MODULE=
_SYSCTL_TABLE_NAME`, preventing its expansion.
- [Low] Dangling trailing backslash on the last line of the `register_sysct=
l` macro definition.
--

--- Patch [4]: [PATCH RFC v2 04/13] sysctl: add register_sysctl() wrapper f=
or MODULE_SYSCTL_TABLE ---
commit 5518fc079c95785ae760d86da6be17693ac8aeea
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

sysctl: add register_sysctl() wrapper for MODULE_SYSCTL_TABLE

Add a MODULE_SYSCTL_TABLE call into register_sysctl() for existing callers
to automatically use it.

> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 6960fe22c50bf..7e05fafd5544e 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -335,8 +335,58 @@ struct ctl_table_root {
>  #define MODULE_SYSCTL_TABLE(path, table)
>  #endif

[Severity: Medium]
Does this code prevent __UNIQUE_ID from being expanded correctly?

Looking at __MODULE_SYSCTL_TABLE_NAME in include/linux/sysctl.h:

#define __MODULE_SYSCTL_TABLE_NAME(table) \
        __mod_device_table(sysctl, __UNIQUE_ID)

Since __UNIQUE_ID is a function-like macro that requires an argument, using=
 it
without parentheses prevents preprocessor expansion. This results in the
literal string being used to construct the symbol name, which defeats the
purpose of generating a unique identifier and could cause symbol redefiniti=
on
errors if MODULE_SYSCTL_TABLE is used multiple times.

> -#define register_sysctl(path, table)	\
> -	register_sysctl_sz(path, table, ARRAY_SIZE(table))
> +/*
> + * The register_sysctl() wrapper for the MODULE_SYSCTL_TABLE macro

[ ... ]

> +#define _register_sysctl(path, table, table_tmpl, path_tmpl)			\
> +({										\
> +	MODULE_SYSCTL_TABLE(path_tmpl, table_tmpl);				\
> +	register_sysctl_sz(path, table, ARRAY_SIZE(table));			\
> +})
> +
> +#define register_sysctl(path, table, tmpl_args...)				\
> +	_register_sysctl(path, table,						\
> +			 __sysctl_table_tmpl_or_default(table, ## tmpl_args),	\
> +			 __sysctl_path_tmpl_or_default(path, ## tmpl_args))	\

[Severity: Low]
Is this trailing backslash intended?

The trailing backslash on the last line of the register_sysctl macro
definition will unnecessarily consume the empty line that follows it.

> +
> +/* Helper macros for optional template arguments */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D4
