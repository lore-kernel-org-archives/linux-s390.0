Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99723D2A1
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138528; cv=none; b=osk8g3d0Y+oowTOFwMPeZsmvJZ4JqJi08MYZ5CAbmOpRrIU1HDDq+MY7+FTLkjg+D2rONOU8a+gCCJ6FpGonTPZDzmIdlC249tQv4C5m3PVopXvpQnPAAhorzZrzHIxX3YhlH4WzgE3QoRKbEQi2RGKubH/O+/boZmSkO71PDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138528; c=relaxed/simple;
	bh=6++LkhKbJC7zac+T3PS0deZciH7eMbTQJ1wfE/gVoTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MivdkXAhS5LGZc2mrZi0fbXj/KLHVQBZ6mOJ2myXWmyRCFmMsmY4Z40ts9TRg6Rqh5Dc/1626vpK7q1Xjd6sHwD6NiT/GZsRskJ8IiddVf7XYzRPP9awxyN/7r2UVkQlhj8VO2hKZoAQRQ4M4b8pvKMJ/l5q3QxHScXR59J1k4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giZ5xklS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giZ5xklS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18271F000FF;
	Wed, 23 Sep 2026 04:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790138527;
	bh=h0lNjHVhBhgeYzoyU2G1bbYwfJYcrdLqgZIglNuH2qE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=giZ5xklSXNA5R7y7Sm8eJp3AOFr/lKjEVVHOyY2yoUMI6e1TZyfcE4tBTxtHvNo6j
	 JE8nhXlGopJMKLbaH2Z+8ks8+kt3/fyDnFwfkyIp1zZ8LP2Wle/DLvnCwxBRvPpMpx
	 CmWKj8mYeZbFnywJMCAkuyyvmz7J7GFTX/SRGcRfF4vErAJeI1oB7BQm+DQCUdFcau
	 BSVQHRTf0hNfDOkbSrolmtWounwBK5U01Z6B6iZ1IIzGWZQLFdwm4Z83f+pkXjsvYC
	 laAlQnST7bNDMyDAzk8XRkiACa0pB4655FEWsRTqstbzWFVFv++P2U9lORCo1VKkkc
	 72ePh6dyXajZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/mm: Drop all pxdp_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260923043226.331880-2-anshuman.khandual@arm.com>
References: <20260923043226.331880-1-anshuman.khandual@arm.com>
 <20260923043226.331880-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 04:42:06 +0000
Message-Id: <20260923044206.C18271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: s390 build failure due to conflicting types for pxdp_get() help=
ers
--

commit f8684b75ea3db8facc582e1cba2e98f8430ce2eb
Author: Anshuman Khandual <anshuman.khandual@arm.com>

s390/mm: Drop all pxdp_get()

This commit removes the s390 platform-specific pxdp_get() helpers, relying
instead on the generic definitions in the core MM headers. It also adds
forward declarations for these generic helpers to satisfy local dependencie=
s.

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
> index e882663a58e77..0a0b0ec42b624 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -25,6 +25,11 @@
>  #include <asm/page.h>
>  #include <asm/uv.h>
> =20
> +static inline pte_t ptep_get(const pte_t *ptep);
> +static inline pud_t pudp_get(const pud_t *pudp);
> +static inline p4d_t p4dp_get(const p4d_t *p4dp);
> +static inline pgd_t pgdp_get(const pgd_t *pgdp);

[Severity: Low]
Does this cause a build failure on s390 due to conflicting types?

These forward declarations define the parameters as const pointers, but the
generic fallback definitions specify a non-const pointer. For example, in
include/linux/pgtable.h:

static inline pte_t ptep_get(pte_t *ptep)
{
        return READ_ONCE(*ptep);
}

This mismatch between const pte_t * and pte_t * appears to result in a fatal
compile-time error during the build.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923043226.3318=
80-1-anshuman.khandual@arm.com?part=3D1
