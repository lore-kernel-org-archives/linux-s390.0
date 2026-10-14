Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF4535FCB
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986013; cv=none; b=ArIDWOjx2zSkdgYQmEltCWwITHrq5knahZodHxG2cNcOfw3hDHf/UUVuAqH7lEE6OsSonGS+0WJTH9jHiqVGjv8jJiK1Y7Ts0FKMyL3oKRe/pDRCNGpyZrghCte5jG5TjcRdDiP+lV0ARWOx6VB2CXTIEiaeLiprbk8+U2TcJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986013; c=relaxed/simple;
	bh=jSZAZgZxlwJzrqHOlzGw7yzzq7nwfZazzHbJ7dRYs2Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WSukJbGsXl19MYqLy5ajP4OrhnJPDrNBjPme/HbVh+sD7zRvgvB2D4DnSxSaF3l8ocSQ0HSRQoOtFKtrelaW+/eaX6NV0eLC9as8KjEPRzwrzFanMcEGo/hsmZL2ZLvbKuNIA3I0guooygYYzCHiIxol4xmiGn6Nlu5RK/fvhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLylmIhv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLylmIhv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FFD1F00A2F;
	Wed, 14 Oct 2026 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791986008;
	bh=GQ4d+isYhjSu8B2k3ov3wihjgrF/Fg7kb4b6AenTg64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LLylmIhvloXcqKQWXsyxvJcTYrohMlc4vrdBjq8zDh/pzc5GRc1daONnbGpQz6DPk
	 kw5p3X1x7aW8+sifIK9P0diRZTzgzd+3/MGLo55XNob71MgMyDIHEkrWk/tvUwR7Or
	 mg2fQiCakmYewhSpOPfJY86/6CA7b10dhOnhZ4nEOsVJ/SJ2bwUoaZyV6isNR1Mvk3
	 A2d/qTuKPS6z2A+yb78AcLRuqBOQN03vxH49ZqCOpLlUy/ntk10QiJ+hWzPsRxwpAq
	 5YSODa7aNAzxVqB8FB1SzaofmKTuF0SNqSW70NQeXteVETVKCUWhYgybWR6rxxpqoZ
	 dXSdtDsSOw4kA==
Message-ID: <sashiko-outbox-171383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched: Replace nr_iowait_cpu() with a bool accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Loehle" <christian.loehle@arm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261014134745.3032405-1-christian.loehle@arm.com>
References: <20261014134745.3032405-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:53:27 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The menu governor was the last consumer of the per-CPU I/O-wait count
> that needed its magnitude, apart from nr_iowait() summing it globally.
> Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
> that use. All remaining per-CPU consumers only test for zero/nonzero.
>=20
> Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
> and s390 idle accounting callers. Have nr_iowait() read the counters
> directly so that the global total and existing accounting are preserved.
> Replace the stale menu comment with a description of the predicate.
>=20
> Include the Coccinelle recipe for the code conversion, verified against
> the original files. The helper's comment is updated manually. Reproduce
> the conversion with:
>=20
>   make coccicheck COCCI=3Dscripts/coccinelle/api/cpu_has_iowait.cocci MOD=
E=3Dpatch
>=20
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014134745.3032=
405-1-christian.loehle@arm.com?part=3D1

