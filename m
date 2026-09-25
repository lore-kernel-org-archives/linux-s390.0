Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9F49B203
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336635; cv=none; b=Jt1wHvr18Ik+OYeeZkwDZv2ytEG0jsPWbIZn/oo8abd0iuUZSlM42gQX1hoHgMiSOcEBcp1cTGqwU9EEqCW6vCAxVo3MgeT5/2V+laFsasMG0kCr7BUjhcosU8F2dR7KxvQx80RvyUEgueoQ+UvY20Zl+sr7inSOgjqXOEsNzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336635; c=relaxed/simple;
	bh=aa15TLl1dkpTyF6L2Ud28Zl/h8vz6WZecX7Z1xPz+Ks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJ/r3WevCrjdqL0v5852GBOJJqIcraxijyf7ff8wIxiUhf8g3nQ11SLaYCE+F7i+r7Gch0ESR3IVU9V1PSztoP0vpu1BgRGI80aIRPxS3Cdr/TOkH1JVRC0XdUTRTEXMuvWtOrTLN3GVxpSiQQI+XQ6G0YTSX1IAYoY5hyIZbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQJ8tQfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQJ8tQfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810761F000FF;
	Fri, 25 Sep 2026 11:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336633;
	bh=aa15TLl1dkpTyF6L2Ud28Zl/h8vz6WZecX7Z1xPz+Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GQJ8tQfEaWhqC5CVkg789oIUD3pjV7EfGI94hrN3njdiW7ccHmAMAdZIRLtX0lQzo
	 9S8g5A7QZakBwesAAK3hSSpuQnnt2G7lQNT72rwO0mlfTLiDMVPe5GUp79hnDDCS9B
	 p6SQRe4CuBPAwhxwc0LQ+jKS148YlMJDPX4jgUnwQz/38j0NSxTnckpaj3/e34+pBS
	 5pldWGHOw5Q5vx0TGWAc8+NzObflKYCSJfSC1e8CY2lP4K+Yi8kKtbQcniPJm/BB3O
	 aEaS/qCgBxlvnuTcA+CQ9rGpcy2mh9aJj+l1v0VH/F5P9wN8wzgwzpQFHNRkXe0M6p
	 7feFIca27CsZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 6/9] lib/lz4: switch the HC compressor to the
 vendored sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260925-lz4-vendor-upstream-v1-6-1c7ffbe21c4b@samsung.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113503eucas1p277003fa5f157d48d4ca114c65952efc1@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-6-1c7ffbe21c4b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:43:53 +0000
Message-Id: <20260925114353.810761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace the forked LZ4HC with thin entry points over the vendored
> lz4hc.c.
>=20
> The HC entry points clamp the level below LZ4HC_CLEVEL_OPT_MIN, since
> upstream routes levels 10 and up to the optimal parser whose ~64K
> workspace does not fit a kernel stack. Levels are clamped rather than
> rejected so existing f2fs and zram settings keep working; they now
> compress as level 9.
>=20
> f2fs and zram both take user levels up to LZ4HC_MAX_CLEVEL, so
> <linux/lz4.h> gains LZ4HC_CLAMP_CLEVEL and says what happens at or above
> it. A later patch ties that constant to upstream's LZ4HC_CLEVEL_OPT_MIN
> with a static_assert, once <linux/lz4.h> is in scope of these files.
>=20
> Levels 1 and 2 change in the other direction. Upstream routes them
> [ ... ]
> This retires one local patch:
>=20
> commit b08918fb3f27 ("lz4: do not export static symbol")
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-lz4-vendor=
-upstream-v1-0-1c7ffbe21c4b@samsung.com?part=3D6

