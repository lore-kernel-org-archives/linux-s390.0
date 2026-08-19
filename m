Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312734F483;
	Wed, 19 Aug 2026 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164473; cv=none; b=OKnqCfY23/aE+R2rhqspbro5MskydtYkhVh8ZzZ8M67o+eoQPXO0/bHZ2NAgtraPQT+Ls/WtMLL99iJ1BSrrP4wDjfCmz5tlKRu8loYQ8aDOhr5uDgQAw1zgp82fb5rQj86BPMkxXwaLLvW0r/TQYe33utDofMU3ChnIa0IaKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164473; c=relaxed/simple;
	bh=2MUYSuJcXPcGsUgg24438ud3X2Wp2rbiBz11jyxx1Io=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bjbPnarvqF6WKFuCtdGX1ZkDfJ/sYtwgPXB5eVTb1Ru3EUZvcDrh+xrIm5jGkveGWRkyxXHKTmrSZ9aN1uDK0+z3rZWCCu0wjqQm5uN0d/cO3JZl8qaRt2aDrj3m6hTPnpJWzT2Q8u9P3t2vtP1XMywvYJQnprpD3JKXCA8V1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1cvjnnf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1cvjnnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13851F00A3A;
	Wed, 19 Aug 2026 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164472;
	bh=7ptlJR3xN4DNnDSX+0keE68VCgwmv7Ysq1QHqEN0N8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V1cvjnnfL14xBmEoQvSIft+wkZYX136kXp8MS/WmL6Kul/IxUxIp3HI8sI6AqgmIq
	 uX6BgJP0dwTy/LtHnxZR8FWo0sfjmqZx30pduDc4CojhNGdTkF87uI9WgpCv4wgN3d
	 /3irzpztlKPR8+pvqUjWe3R7lVv/koIrPD7RarhsskiEYU5tkmZBSWdhidoXjvQbH6
	 fGcy4RL3DWzNLR8ZDrU/BIzVHGDNhD36ftN6xlT0omcpzAMw4OjiREyOUnWvihcVax
	 DLYRkxGQUXjLPoz8Q5afTqf/3r4h1ZgxANccVqK1tQPGzzzCHfWmdvEv+oMcIQtGHV
	 bRTKQqwSroONw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 04/13] sysctl: add register_sysctl() wrapper for
 MODULE_SYSCTL_TABLE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260819-sysctl-module-aliases-v3-4-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-4-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:34:31 +0000
Message-Id: <20260819183431.B13851F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `_register_sysctl` wrapper incorrectly uses `ARRAY_SIZE(tabl=
e)` instead of `ARRAY_SIZE(table_tmpl)`, breaking the newly introduced temp=
late arguments feature for dynamic pointer tables.
- [Low] Fragile symbol name generation in `__MODULE_SYSCTL_TABLE_NAME` caus=
es token-pasting syntax errors for complex arguments.
--

--- Patch [4]: [PATCH RFC v3 04/13] sysctl: add register_sysctl() wrapper f=
or MODULE_SYSCTL_TABLE ---
commit c193948aeca054c46d40a2f5711a72369114c454
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

sysctl: add register_sysctl() wrapper for MODULE_SYSCTL_TABLE

Add a MODULE_SYSCTL_TABLE call into register_sysctl() for existing callers
to automatically use it.

> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
> index 3880460e67f25..cda3221e386ed 100644
> --- a/drivers/parport/procfs.c
> +++ b/drivers/parport/procfs.c
> @@ -13,6 +13,8 @@
>   * Cleaned up include files - Russell King <linux@arm.uk.linux.org>
>   */
> =20
> +#define SYSCTL_MODULE_ALIASES_DISABLE
> +

[Severity: Low]
Does the need for this disable flag suggest fragile symbol name generation
in __MODULE_SYSCTL_TABLE_NAME?

When register_sysctl() is called with a struct field or pointer dereference
(e.g., dev->table), the generated macro attempts to create a C identifier
containing -> or ., resulting in a compiler syntax error.

Would unconditionally using __UNIQUE_ID(sysctl) prevent this fragility
without requiring callers to use escape hatches like this?

[ ... ]

> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 0adc056ff54d8..b808fbc1d964f 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
[ ... ]
> +#define _register_sysctl(path, table, table_tmpl, path_tmpl)			\
> +({										\
> +	MODULE_SYSCTL_TABLE(path_tmpl, table_tmpl);				\
> +	register_sysctl_sz(path, table, ARRAY_SIZE(table));			\

[Severity: Medium]
Will this break the template arguments feature for dynamic pointer tables?

If a caller attempts to use the template arguments feature with a dynamical=
ly
allocated pointer table, ARRAY_SIZE(table) will cause a compilation failure
because ARRAY_SIZE() cannot be applied to a pointer.

Since MODULE_SYSCTL_TABLE() explicitly enforces that the build-time template
is an array, should this macro use ARRAY_SIZE(table_tmpl) instead? This
would resolve the size correctly and allow the runtime table to be a
dynamically allocated pointer.

> +})

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D4
