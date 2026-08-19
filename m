Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D5B67E;
	Wed, 19 Aug 2026 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107022; cv=none; b=kBRGwHlSm9/8E1Upt7vSQk7l6XSIUm3JYw0uSZQFAfGj3I3XuU5ljX/viRF1OCsIEb8IGqTvt4STTxrpqgjkp4A1+na7Rb9Jxww0H2TqmrnhRnr6Lf5FabpHUFKI8yPehzQuyWRAAp+Z6piJjO9SdYLjVnCAKHXWexQcYUfYYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107022; c=relaxed/simple;
	bh=eIkKYkUQh89vYYHfRpfEzxb+8k08AVux6dVXKXdIFW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qza7Kcx6irYBsX89EJmLR60eXFfu2keChX4HdRS8d43PNg9iJ13AUCJROKoo9nrHe19s4qGQLLq+zEPt+oxEboOQ+IY2ioNLH4Kyu+A3bDL0UkPrnV6RAR/mQJ+JiUW+CEpwtpXSpAzahr1nBrC+6HH5jWmM+ZLfmbt0frVhF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlMT1Joj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlMT1Joj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5197B1F000E9;
	Wed, 19 Aug 2026 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107021;
	bh=ne+PMF9IauEbQWIWAJ/MqYWGHi351ngPLJ5L6RPU7sM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AlMT1Joj7M4gov3fadciBIDCxoC4eyMpjiTXkK/ew828WMcC3lAz5YAIr8DWVlnM+
	 O85JxWzvLj9vj3tBBsgkf2VwGsZC9GJMpy/9YXAxg3sbf/mab6IcDKJQt8dBxU00tw
	 /pkSRkrKvDUs6qdFJSuh1NwUUwh1V7Zdl4/gFMfYOPkrxlX0SjKmBrpxA8vTWx8+Vh
	 aVS5/ELSybuZOdRRl3K2r2fdPjDTwF61IEnetsNDRg5Mi8EFS7tsgFY6ICPXvI4Vuo
	 ujqB9sLR4eyQbI7LA8ofDkNdKeqM7Y3l10+DeAsAheOoQ9mEvMJSlj8OkId1kg5zRs
	 sDZTz2yJWkimg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 02/13] proc: add config option
 SYSCTL_MODULE_ALIASES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, mptcp@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260818-sysctl-module-aliases-v2-2-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-2-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:37:01 +0000
Message-Id: <20260819023701.5197B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The Kconfig option `SYSCTL_MODULE_ALIASES` is introduced but never =
used in the codebase.
- [Low] Grammatical error in the Kconfig help text: 'This options adds' sho=
uld be 'This option adds'.
--

--- Patch [2]: [PATCH RFC v2 02/13] proc: add config option SYSCTL_MODULE_A=
LIASES ---
commit 931fa1a5261f1467829ad7b64b387a4e318eb177
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

proc: add config option SYSCTL_MODULE_ALIASES

Add a config option for the 'sysctl:' module aliases feature.

> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 24f5a36f45df8..e6591ec4bcf0a 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -98,6 +98,19 @@ config SYSCTL
>  	  building a kernel for install/rescue disks or your system is very
>  	  limited in memory.
> =20
> +config SYSCTL_MODULE_ALIASES
> +	bool "'sysctl:' module aliases (EXPERIMENTAL)"

[Severity: Low]
Is this config option fully implemented in this commit? The
SYSCTL_MODULE_ALIASES option is being introduced here, but it doesn't look
like CONFIG_SYSCTL_MODULE_ALIASES is referenced anywhere else in the C code,
Makefiles, or scripts.

> +	depends on SYSCTL && MODULES
> +	default n
> +	help
> +	  The /proc/sys files registered by a module do not exist until the
> +	  module is loaded; meanwhile, userspace cannot find or access them.
> +
> +	  This options adds 'sysctl:*/<path>/<file>' module aliases for the

[Severity: Low]
This isn't a bug, but there is a typo in the help text: "This options adds"
should likely be "This option adds".

> +	  /proc/sys files registered by modules, so modules for nonexistent
> +	  files can be loaded with 'modprobe sysctl:/proc/sys/<path>/<file>'
> +	  by userspace when needed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D2
