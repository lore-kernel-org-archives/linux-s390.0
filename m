Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595357F72E
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931963; cv=none; b=XjmV1l6NHazeElt7IPtz0dTFzUcFNWz40oI6k7VkFLaudCOmjL79fW2EF2pjBkakQgVOl61IXDsTXDtodOYJWMUmdkFYr7Cp7Xgx0t8MybK4yXskfd5LGMPeorIWprz+i54ZEXhW+5EqgPVTaR0kIU2/wRVknB6DQMLyfp6qIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931963; c=relaxed/simple;
	bh=aGVzOy4T54mNvZFMG1ha7YBKdjht2zr4LFpxbyWxg9k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qB1bFG60fo9Tp68yx+foC5rEMyD88+s/EqkIT+0q1JSCIgPu3e/EKoYpzNKVWmBsKOl0ZWddhaNhfl3nuuoQB96FZMF11hlcI8IOfWYZh2ow7B0HmqsLdFiXkbtWyvnk+HJ5gtQs6t/iZ5+BR0MfpVajfjFVwJafbUpBJxr3sH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4+JZX/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4+JZX/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D3E1F0089C;
	Tue, 13 Oct 2026 22:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931959;
	bh=aGVzOy4T54mNvZFMG1ha7YBKdjht2zr4LFpxbyWxg9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4+JZX/G9z+ArZzkTK3rjAVmsPeynsqE+vizBCd3uMOSQTiypTybZWRS1GK0gYCi/
	 nFOF+oAI8lVbS1s4zubCkfVV7vIO35OeYAuuPadmwVLeV/zSNnKrhZeCEmtCLrjmec
	 eS9Vbde/+nu7upHYZ4swyGj4aENcyRh3Omd+gbC2dSU96VjgkrcOtF8AiWYrFdNTho
	 dUB0W0Dqj1Cg3R36ZaCmudBZ6RWAqz1ux5s+aKoZQNT4hg9/hZz14GzYkr9bskfofM
	 Y2nRvnuooZyAYZB8xr8/A7lHP/t7x4aDWSzxUcG+MJT5FUukl3XeVvY6+hfGv3p8JX
	 I1rG2mgkdBwPw==
Message-ID: <sashiko-outbox-170605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] cpufreq: Initialize kobj_type release callback in
 ondemand and conservative governors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013223946.1836757-5-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:52:39 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Export cpufreq_dbs_data_release() and set .kobj_type.release in the
> ondemand and conservative governors so their gov_attr_set kobjects have
> a valid release callback, matching cpufreq_ governor_dbs.
>=20
> This prepares for annotating struct kobj_type::release with
> __require_explicit_initialization.
>=20
> Fixes: c4435630361d ("cpufreq: governor: New sysfs show/store callbacks f=
or governor tunables")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D4

