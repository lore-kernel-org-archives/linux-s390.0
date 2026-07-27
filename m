Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281593F0ABE
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171906; cv=none; b=EhN8e/bN+0cYjsYVjHwvaXNPjFy2ZtG0FczoWqH5GWt/VSlc7U/B5QbKCrnZ05SRarNIFIyI9UQM8vPS19u1CGcVEMvtkAQ/uawaAoYx4heeB9OK3e7EghQI6MjnT5MsozHZRhjAzujVa7+/SezuRcpql3aWNJAOe8ItDOtLPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171906; c=relaxed/simple;
	bh=on7wZhJoDDkIOuUTZfaLOa71BgYDvPGDdzM1besQLGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zlho2tQECdUIiGRu6yBPkCLGe6pCBJdIT1hYFlBc7oZhuBu5k0TLDsAG0im37ucoD8GhEZUkfonEyUqt07BHEI70E672JRHVEbTQJspZ10QPYRv++hvUVxB6cAiGxUL8QmS+7xsa/zJpTTY755HM8F35ybPdKHpRBirZYJtfP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6tSBB3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6tSBB3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740371F000E9;
	Mon, 27 Jul 2026 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171904;
	bh=on7wZhJoDDkIOuUTZfaLOa71BgYDvPGDdzM1besQLGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6tSBB3L04cfyKD0UnLl6K42GpTem9Ji77IdjdSkqQntdw6ljzVhReOkanBhvnqJK
	 PlOndwmwp1uBUunJdcAY9gOrSLcU8XDPs5mu/esh5NPcClxgF1ecf7XANwlxRN0lkb
	 d2tVuOozGlH5LAPRybiP6N156yTbb6uwCrytBfQsrSSgDTwsbdVAxkrJhsIXugLijD
	 p89GWHkSu+KIrgUODKtvrQ1thVZDSUnzWuKIATRZCiBXTEw9XgBL2CH8UtusnG7d2T
	 Pd15c1mSsy4KxD3HcKO+Jrpos+pR223pVzV3zpH7SGeQFzkSlV+mRA7n5qPy+fmv5O
	 5dfAYxNI+fg2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] s390/crypto: Replace cond_resched() with schedule()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727162430.1599396-2-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:05:03 +0000
Message-Id: <20260727170504.740371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The comment for all cond_resched() calls in crypto code says that the
> process should be scheduled away to avoid instant re-invocation of a
> callback. This is not what cond_resched() would do or did.
>=20
> Replace cond_resched() with a call to schedule() which comes closer, but
> it looks more like this code wants an msleep() call.
>=20
> Note that with [1] cond_resched() is always compiled away and becomes a
> no-op.
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727162430.1599=
396-1-hca@linux.ibm.com?part=3D1

