Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827831;
	b=TJNL7WBM6MhTuT3D25n6AL7FnXXTFM4CNPh0ErZvEO6/CBccLiLuiEvtm425QSylKR8s
	 bIhWpgx7V1/3z/oHwphXG7ZhkwenREm/DLGh/k/dpKqLRE6VLIngiNcOhb2m1ZlMht8HL
	 zppLPBlvEbrGRpy1gdYce3CG00jwVHsMcrvAgHoE8jgzV9Qiu2gHD1JqjdLzta44Jrwdj
	 To3eMa7x3o319EOKZVaDNdOpRM1v/ySLb8bZisjj30gCK81OojHAL9CTSJop4MMjsPW1g
	 ZOKT07ZWywVS+gb5CV6n2tosAxzHsymVky5mE7ycm5WQtlj12utJNSAzvFeMtzhyxwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827831;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ms0rcXamBpU/6Br0Ovn9fF6lUQ05L75KwoI8UoudBHQ=;
	b=rfES7kw9O8lQfK5NkY1Rdra+QihXavmE0iDUugmYedHiWK5BuFHwQijx8vE+8UqYxHkq
	 RAKPhAOFC5/c6Rhuq/p+dPpUL4+D1zl5h73ntDjo1lQW/nnqLLompQReEloekn43lt3Nq
	 rZKeVqwYgkmast1kqPtWlFiS8DuX6nGJoEPDVq9dnnhDAYwXRhf+V/YlbM7qeFAdluU3T
	 +UQZgIkg+7M5ye0rWA9uX70xpskjzoEbG7ZIk+cy4Auvc5jY6wbtsaGyzOtLfkKuqA2jl
	 ukWIIyNtq5g1mhO+LGokhlGBGCQscWnrZ7GT5b8mmdDuuJ8GQTSriPX4me+eTid5XEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBkysEOZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9F606A339;
	Mon, 16 Nov 2026 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBkysEOZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10CD1F000C4;
	Mon, 16 Nov 2026 11:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827831;
	bh=ms0rcXamBpU/6Br0Ovn9fF6lUQ05L75KwoI8UoudBHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mBkysEOZUmvMGyjZUIJl9LLPhBja7CTNVhRS2GzJVP8Oyb//xRy1gF2FRvLCgY0pq
	 mZVziX/3Fx84CXpBKI4ec/qiuyRLWxQgDvIQuxBMHQM4zG1lC9SBfnx48zFC+oYdEY
	 4mqv3tu2FKSubDce9qsV7mEe9bE4XZVTOSCByBGzFSqu3XGKBWmKt6Uq6imuluUXGd
	 YzuzNTENO9AKgYnA9m04OkDf8QGNiXjWlIOWNVTJhSCF0k6t3uZgccKUYHAdsYK+EC
	 Oo7XJIcD3pOw0zSctBJfwMPN0WBjlOkoGeMW9/bZBsnX7ibKtpyvYWPmYr8RXvBojl
	 llGm1BnqS54gg==
Message-ID: <sashiko-outbox-216876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 11/44] failfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:17:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize failfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D11

