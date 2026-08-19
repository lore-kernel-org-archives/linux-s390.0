Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396935F5E4;
	Wed, 19 Aug 2026 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107256; cv=none; b=Tg+/KBv6/3G2lDTqac1LP9ZMqQoQ4gs63d31B/6Al5WQq6E06Rsn+TF0pJ3fHV95hfAIZRgmNaJSq9fgNZkosXTCkfcEBcrg674Dosn1XSOTU6WHdwrhphSbH8togl77krkAqALHy/keJYL0U8zxaybCAXYaokhwWBV8EkB5z7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107256; c=relaxed/simple;
	bh=m8npIfx7ZMCoxUsRpb3bXfiU5gaVYoWDn5BYsavSWDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RrmalWqVOT8TuK+649f2J2NtL57m1iGMhlUmwUQ4vmW2EIdd2sbf81HNn0NMVUii63otwDnH6Hzl57CDo7VuGJ3x8cd+LAWDp5MAfY/v2Rze1I79ncS9Tt8ffSStdcXUPBHveanQZfJYfR5mvbCwQw11WHpCw7KgzUWoxTMVuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9LU/tuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9LU/tuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB0E1F000E9;
	Wed, 19 Aug 2026 02:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107255;
	bh=V/Jn2nVCMsHhH7obqkjJ8UsdQ5t929qZlQYKZq6HomE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G9LU/tuAuYz8KXGSFVBz7cWkE3qQrdFLegne4M0NnYtS/1CkvGFTbUSwfLFNFQyjV
	 zgFsrGrc070oZnR+p7rDufNN6JtN7aY8fxpinygNpev02lDJp99yAaqmCwhGu0Kqpx
	 hmC/WFAokC6zHl/Kzccy+agXBGeHSBg9/baq8F7QDq7LnTKIsqJlTN7oi5TbeInWEp
	 L9p2NS68fGOe77+PSE1YRya1Fkz0K4jvSF5KHMzLrzrDZK2hcFON60k676tkoJD/1U
	 SOP9a2jeO6wy2t8hokIJ16OeuX92IHM6ZByIc/C1nnrpc5VzzklpjH7h1rJWNr4zjR
	 dFb3jzGiXaWJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 06/13] sysctl, net: add
 register_net_sysctl{_sz}() wrappers for MODULE_SYSCTL_TABLE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, mptcp@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260818-sysctl-module-aliases-v2-6-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-6-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:40:54 +0000
Message-Id: <20260819024054.DDB0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] When `CONFIG_SYSCTL` is disabled, the build fails due to a preproce=
ssor conflict where the newly introduced `register_net_sysctl_sz` macro exp=
ands inside its own fallback static inline function definition.
--

--- Patch [6]: [PATCH RFC v2 06/13] sysctl, net: add register_net_sysctl{_s=
z}() wrappers for MODULE_SYSCTL_TABLE ---
commit fad97277609904f7e692d6e11a61fdff7e4ff635
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

sysctl, net: add register_net_sysctl{_sz}() wrappers for MODULE_SYSCTL_TABLE

This commit replaces register_net_sysctl() and register_net_sysctl_sz() with
macros that automatically use MODULE_SYSCTL_TABLE for existing callers. It
renames the actual sysctl registration function to __register_net_sysctl_sz=
()
and adds optional template arguments to support dynamically defined paths a=
nd
tables.

> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index e5ee673b9fcf8..2127049c71ced 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
[ ... ]
> @@ -520,13 +520,48 @@ void unregister_pernet_device(struct pernet_operati=
ons *);
> =20
>  struct ctl_table;
> =20
> -#define register_net_sysctl(net, path, table)	\
> -	register_net_sysctl_sz(net, path, table, ARRAY_SIZE(table))
> +/*
> + * The register_net_sysctl{_sz}() wrappers for MODULE_SYSCTL_TABLE
> + * automatically create symbols in sysctl registration sites.
[ ... ]
> + */
> +#define _register_net_sysctl_sz(net, path, table, size, table_tmpl, path=
_tmpl)	\
> +({										\
> +	MODULE_SYSCTL_TABLE(path_tmpl, table_tmpl);				\
> +	__register_net_sysctl_sz(net, path, table, size);			\
> +})
> +
> +#define register_net_sysctl_sz(net, path, table, size, tmpl_args...)		\
> +	_register_net_sysctl_sz(net, path, table, size,				\
> +				__sysctl_table_tmpl_or_default(table,		\
> +							       ## tmpl_args),	\
> +				__sysctl_path_tmpl_or_default(path,		\
> +							      ## tmpl_args))
> +#define register_net_sysctl(net, path, table, tmpl_args...)			\
> +	register_net_sysctl_sz(net, path, table,				\
> +			       __sysctl_table_array_size(table, ## tmpl_args),	\
> +			       ## tmpl_args)
> +
> +/* Helper macro for optional template arguments */
> +#define __sysctl_table_array_size(table, tmpl_args...)	\
> +	ARRAY_SIZE(__sysctl_table_tmpl_or_default(table, ## tmpl_args))
> +
>  #ifdef CONFIG_SYSCTL
>  int net_sysctl_init(void);
> -struct ctl_table_header *register_net_sysctl_sz(struct net *net, const c=
har *path,
> -						const struct ctl_table *table,
> -						size_t table_size);
> +struct ctl_table_header *__register_net_sysctl_sz(struct net *net,
> +						  const char *path,
> +						  const struct ctl_table *table,
> +						  size_t table_size);
>  void unregister_net_sysctl_table(struct ctl_table_header *header);
>  #else
>  static inline int net_sysctl_init(void) { return 0; }

[Severity: Low]
Does this commit break the build when CONFIG_SYSCTL is disabled?

Because register_net_sysctl_sz() is now defined as a macro unconditionally
above, the fallback static inline function in this #else block:

static inline struct ctl_table_header *register_net_sysctl_sz(struct net *n=
et,
	const char *path, const struct ctl_table *table, size_t table_size)
{
	return NULL;
}

will cause a macro expansion conflict.

Should this static inline function be renamed to __register_net_sysctl_sz()
to avoid expanding the macro in its own definition and to provide the fallb=
ack
implementation needed by the new macro?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D6
