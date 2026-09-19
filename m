Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD42248AF
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789826120; cv=none; b=kIlaUTFEFKdETy0fq188C9EqIZvHxOC0KhRpDg2PkLzf/cFhCRjVc0XQiBx706SGmtujw8B5sAgH4+MMpWgY2lysKBOCxe9sWAucpMo4Clpo4lQul/Lrzg5uaRD2ZGu2PA7QZZCV/nzm8DFY1lpg7a/LSqQhOJKEXBUEsiuINhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789826120; c=relaxed/simple;
	bh=t8MmyoaKH31RJLtVfyGbQfsLtFLSDgXiPvCkrkS3Y1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LSrARi9xmc0ZsEF0W6lknkrZoN6iLXp56zOpAaLNXvoHgOqfclHp2TPnBmyU4pTCxys7dPoR71fPveuUdycNIHeFhHijP0gk7DXC9HIck18peLYQcSo2cYnxx/xeg24iZ3YpitXVZWHItRcdCakA5duBrX4mUBHWnCLed7qaYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2AlnAuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2AlnAuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDA01F000FF;
	Sat, 19 Sep 2026 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789826119;
	bh=t8MmyoaKH31RJLtVfyGbQfsLtFLSDgXiPvCkrkS3Y1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n2AlnAuhwDKoN/9HiwJQjkbpMrDkM+egIBRbxW7/sPOiV/W1NGCJVvs7Hf2csdm18
	 xmy6MNRpyMBVawBEydsGJT8IPtE0ukHoqlH1SW0xR2+BP9xPjXej4XdBzMS8jcUgAD
	 94WG3cg5MEgWWLyztTXw/Z50Jq+6xDBzO9RNUAvbGKbzQeMmANFeE++F10JdCJYVN4
	 SjZhg7yiL7Hnja4nzLBwydjqvGm6bQuP5aZdJebY1oM3lcMAkybC+ouJvKCHRFH6/V
	 1luZhH+vDSt6zn96rtzfQK6LCHBBc5/3HtnSKRK0sc2idicJnldvFgUvjOu1pwlUor
	 sOZ9SzccyuE6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: bridge: fail link info that does
 not fit in a netlink attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Lytkin" <iprintercanon@gmail.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260919134333.49379-3-iprintercanon@gmail.com>
References: <20260919134333.49379-1-iprintercanon@gmail.com>
 <20260919134333.49379-3-iprintercanon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 13:55:18 +0000
Message-Id: <20260919135519.1EDA01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> nla_len is a u16, and a port with enough VLANs, tunnels or MST entries
> makes the IFLA_AF_SPEC nest wrap, so userspace reads garbage. Same for
> the inner MST and CFM nests.
>=20
> Use nla_nest_end_safe() for all three and return -E2BIG with an extack
> on overflow. Dumps end with that error, notifications go through
> rtnl_set_sk_err() so listeners resync.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919134333.4937=
9-1-iprintercanon@gmail.com?part=3D2

