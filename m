Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245F440624;
	Wed, 19 Aug 2026 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163865; cv=none; b=fXKzUcDfgmxHfLh4pxarBhUmZ3dkQXLphhTSZGYLf9zDKjITHgcb4xSjR0sdpzedntFnxL/Q7OHjM7vRW87dsTXhljgD9AJS29A4YitR/cr/cM81KLzaMQWFfEPBnfYH4EIKv8gLM0LGHbnfiKHWfQagaVRysvdijhc8D2mRXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163865; c=relaxed/simple;
	bh=Y625hPyvYlRDZKwzX+gDPNUQswtRVovt5LkBbvFD1Mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQ53rPPdrBPRlYcMIPdy2Dw+nu7crcwLExnqYEDODNG7LSeTK/DLxiCvhxkKHM6Ox7OfiC73urGB+dTJ9oHVXPmx1KwZNeQJblDwAgWR/12hP8hL72WQ0KfrMgZ3hv2Wai30RFkpaeQJdpHRgL8N0N3LVymTWAH/I4nCDMN2lCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHH/tkjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHH/tkjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7784B1F000E9;
	Wed, 19 Aug 2026 18:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787163863;
	bh=RazbD2NAUy0Hh8n18ySk9CQIaGVjdA/hYm3TFR5uPMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OHH/tkjE6cCAQMX8u1ZNL7ty+3lu5xBavJFjs81PxXUg3jwrD9kLAe0HvNQnXWwN4
	 tR31yCu3YkaNgLJ4/CS+lVMNTEYNYF911BxX9Dq9bFJAoMZ/g2PzU5mP6Hyz/UPDuA
	 ZcP1tdCMt0AO5ob2Wk5l18GhfsNOb5nbSVbv46YrygiMhfkunk87lNMvkbuEokw3B+
	 2awN9/O+YCokmkRLRm+h4rIqAzlR7YJkrszhlC4EHwKbKZtOLtdLfDVXr00jL8IMlB
	 Os03fvEANCbzsZeMge7qFXbynWTQXx7vo91Leqjyu61YPLQZg6FXVCmSREG+N387lK
	 biT93AfrlNeeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 02/13] proc: add config option
 SYSCTL_MODULE_ALIASES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: bpf@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, mptcp@lists.linux.dev
In-Reply-To: <20260819-sysctl-module-aliases-v3-2-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-2-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:24:22 +0000
Message-Id: <20260819182423.7784B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit introduces a Kconfig option `SYSCTL_MODULE_ALIASES` b=
ut provides no implementation for the feature it claims to add.
--

--- Patch [2]: [PATCH RFC v3 02/13] proc: add config option SYSCTL_MODULE_A=
LIASES ---
commit 37ecdac6e4285c04cfa8fe2dd84f446aa5082a2f
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

proc: add config option SYSCTL_MODULE_ALIASES

This commit adds a new Kconfig option for the 'sysctl:' module aliases
feature, allowing users to enable or disable it during kernel configuration.

> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 24f5a36f45df8..ea77cb2b0b0e3 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -98,6 +98,19 @@ config SYSCTL
>  	  building a kernel for install/rescue disks or your system is very
>  	  limited in memory.
> =20
> +config SYSCTL_MODULE_ALIASES
> +	bool "'sysctl:' module aliases (EXPERIMENTAL)"
> +	depends on SYSCTL && MODULES

[Severity: Medium]
Is the implementation for this feature missing from this patch?

The commit adds the SYSCTL_MODULE_ALIASES configuration option, but there
do not appear to be any references to CONFIG_SYSCTL_MODULE_ALIASES in any
C source files or Makefiles. Could this cause a situation where a user
enables the option expecting the functionality described in the help text,
but the feature remains completely unbacked by code?

> +	default n
> +	help
> +	  The /proc/sys files registered by a module do not exist until the

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D2
