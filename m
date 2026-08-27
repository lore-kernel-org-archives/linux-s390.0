Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC43ACA4A
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832365; cv=none; b=UEvnO5nW/tvDjrCkCoJbuL34guEiPn3owqeL4UM1As/jxdD4C0CNNGYUrHcDd4ECOZieGG4wKnFpsF1ScQVgqvZVMbZ8LJk4T9a6OkjdmCu4G3b1lCqYUGIV233drW+alE/0iWLb9p8sWIDVi3lP3jZ+0B87sf/jFjA7SmJAhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832365; c=relaxed/simple;
	bh=SDNS89cl7JzCwvmMG2Uudwn9iKT2bszjJX2+AmYNeds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iHV5XvzXd9SeZp1N+NJMd+o6TaxexQdLHjyOu/eNjH81rHwUKCj0pJ7+90Bfjh9hqhyN/1QAr/TKmN5+hann/8bm3Hi4Vdl2HbXdTTgKd0/iTXREijdl3sFcNJZNG9JTqjO1iUfAeHWjMUs7G/1w9DORFVvjXAVRCSK7SDFVZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpdq/kkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpdq/kkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB93F1F000E9;
	Thu, 27 Aug 2026 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832364;
	bh=SDNS89cl7JzCwvmMG2Uudwn9iKT2bszjJX2+AmYNeds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hpdq/kkkwbnEM112eNnuFLCdQjIRH9IgvFAO/QUSDnqtSm/m2BlelXwwDVVpGGWyv
	 D6wcBSZ/mDKawMVybjPXaT8I2/mlnlbGxXumQEQUUKQFZ7jCtEGElloRJMN9UImOSQ
	 9cwZksyKVVVplaYSm7FnpXuk70Ri/Kf36baOw6ig7FG0Z6sGpFGqb1kT/ggmbjK55Q
	 YzqdqS6GEeYQPR53f7swNhhppsMrlB/ARQ/lXX5pZ3WKiFh7Mil2gDV9hVGVTOkdkW
	 PUIBZnkvRduk210om9Z6Sjjcxj/u3C6hy2QlTG5M4L9ynrhEJxuFckEVsIjIV7rADQ
	 Jv+C9ohCL4WaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/boot: Fix physical memory search range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasily Gorbik" <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <p01-03.g46f7a6bfbc01.ttkffvj@ub.hpns>
References: <c00-03.ttkffvj@ub.hpns> <p01-03.g46f7a6bfbc01.ttkffvj@ub.hpns>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:06:03 +0000
Message-Id: <20260827120603.DB93F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> search_mem_end() calculates the number of 1MB blocks with a signed int
> literal. CONFIG_MAX_PHYSMEM_BITS values of 51 and above either overflow
> the signed int or shift beyond its width. This produces an invalid search
> range when the binary-search memory detection fallback is used.
>=20
> Use an unsigned long literal so the full supported physical address range
> is represented.
>=20
> Fixes: 4d14c2666b6b ("s390/mem_detect: replace tprot loop with binary sea=
rch")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c00-03.ttkffvj@ub.h=
pns?part=3D1

