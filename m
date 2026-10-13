Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7D340A6B
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931662; cv=none; b=JTTJ9nNqMOJIIT+sqP8FKJyT9ClFipmZqi0sOooODCN+/nbdX21jMNqlDiXSuUg9hKhRgylnpg/QDC3B8KNigJGqb9mMCGUdbXvxY7FejZS5mLjmIjvlP/Bs5aMUYadPOa6aN7yhPRjOIL2KcINVb9Q1moxJKJr7ZCT2j2edjo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931662; c=relaxed/simple;
	bh=o6b23jHIaQtErAaxeJwEWwIMm/kMCMa/21o96c6WYEA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FIcxzT1/sq6VUKDC5c9iJ2iHrOqw5GUaV+ELo9u2rPxd6D0sWj0YYfh35kdd5qRb2m8RkbQ6PTzbvBWlrIOmi7ng1RB/s8ds3MeiB9xkzTQkIM1V1cBV4WMxeHvjWtZp7qWqedZ0qLCMDBLkkYOh2azA0GE4E51RXRy1Jr7Nkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvrWacWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvrWacWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE5C1F000FF;
	Tue, 13 Oct 2026 22:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931661;
	bh=o6b23jHIaQtErAaxeJwEWwIMm/kMCMa/21o96c6WYEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WvrWacWpxbCVM8eejwAjGN73ThVHP4KnxeyWzeAnqKdaeJ8pLK2KaRg5pHeZZ3pTh
	 D5hp8cYKwk8HsRx7SKnaMbcsE2pgex43x7RJChbdG1ppnprQdz8Lh13wf9HNdMV90T
	 2w5UHfUxpWCG7sEmdxL7jQXSa3xAlFJ8l6G6rGGaQJvTY7S7RRp2JXFMFkpuGQygXd
	 FT7udzk8dOQ2GjbtX2qwjerVQxKLWjkGw24zHGJsgNdMxhHdd7NyvheHi7ESiqptw8
	 oEtXdoAbBJ20qrBgVAxsxNkx1SVl3B5Qcc8L76eCH3MIQXooWSraLg/dags9GcHYsc
	 iqLyNL4s1Miew==
Message-ID: <sashiko-outbox-170597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] ubifs: sysfs: Use kset_create_and_add() for
 ubifs_kset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013223946.1836757-10-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:47:40 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> ubifs_kset was a static struct kset using a custom ubifs_ktype that
> had no default_groups and no .release callback. With
> CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, unloading the ubifs module while delayed
> kobject release is pending causes a use-after-free on the static kset.
>=20
> Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
> allocated kset via kset_create_and_add().
>=20
> Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D9

