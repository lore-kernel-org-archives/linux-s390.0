Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3170F361941
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236372; cv=none; b=bo0QeUynoksdOSXbEScXA1g7/LtiXFHyQYyVkQET2Wo96Fx6YzTjI2FKNyYcl+t4JzuC+AauRiqESpNmAmg1MWnZvUREK013ikRoct/hu69D40TnzB7UOmlVmuaU3cO6oL+CGTNEjRs1Apt8+o2SBZ5ZxWEbm9trx/yuKd+4RdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236372; c=relaxed/simple;
	bh=v4iovhwEg98bqMqBfs94WkBxbFDEv6Hyf8KOpixHByU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IzJHudopumZw66aN95ksKMiDaQcxA6FGrh4cisueqHc4bWW6E5DRf4oHApJxmXl/FRIqZngKzzSzxH3sGxbPUnSuHm9PiRMp9AJUd+2lfntuEyoecU4KjAPIKA8p1jGs5+mlRhx+yNnh5vebtsN+AaFG+OliWhkBBSLsPdey0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbmC2Gtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbmC2Gtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A621F00A3D;
	Thu, 20 Aug 2026 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236370;
	bh=v4iovhwEg98bqMqBfs94WkBxbFDEv6Hyf8KOpixHByU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TbmC2GtcYhcwgxG4uFc4nLpHNMfOF/7kWIEApR19VKG1GUg4UEUjYsouZvl4rhJLP
	 ycP7CCmVJUWMgUpOSKcpYLiQ2wTikTRuIyNdcUeeRz9g+sny2IXGu5KrH5ng3bi9w1
	 IDpN9lRK+n0cbQAKGxA4+Dug653O0YUehJ4gOQRCHKdQxWeHERolJlVP1OhMgC7WlR
	 6COY2NVaW4P9BToWc0xFZqvSvQictqTNU2GzEKYJf0sSzxkwE7Cjsav5hdjTNQtjHj
	 fMhwy81+34dd9fHdxZQHN1eX0wBq6RckebT5sYLKD44mbU0bmo9oWoXvazf3Ibga8S
	 V4HtPulGsKkAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] s390/crypto: Map EBUSY to EIO when key
 conversion fails repeatedly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260820141957.19091-9-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-9-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:32:50 +0000
Message-Id: <20260820143250.B3A621F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When hardware persistently returns -EBUSY after exhausting retries,
> the error propagates to crypto_finalize_*_request(). The crypto API's
> completion wrapper treats -EBUSY as a queueing status and swallows it,
> preventing the completion callback from firing. This causes callers
> using crypto_wait_req() to block indefinitely.
>=20
> Translate persistent -EBUSY to -EIO after retry exhaustion to ensure
> proper error propagation and callback invocation.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820141957.1909=
1-1-freude@linux.ibm.com?part=3D8

