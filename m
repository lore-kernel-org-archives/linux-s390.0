Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756C37F330
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779599; cv=none; b=G5cXjzF6lNeYYB2OUAfK4HVwcB+qJ0tuH/Xvb0X9ijc8eCIYfAwPH7rMrJ7IP/14jn1EESLOtzL13Di0iwYrzfSO7p+a+66WRA4EEmE8yxmAan8HY4//ar26h01BjTztkDxza/xhBX186WBBVqxE3kJIIbL482pSMBaMn2umrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779599; c=relaxed/simple;
	bh=64fIxgakqcTi/KImqmAHFbVnAO8/PXWMjNGEzV5iDgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KyT4b0yEiYhZliGFt+KANAh7hEyJ3/lYJ2ODQlRbvYQbOAQYd7KgMJ8MQYkNmhgznQ+hM4gPW5P9TJBdSYWwBF1xOG6Jxy9wauRRWEyhEpQiEhFD/+7db+u9rDhwa60EsEoUNtbVnV1FnjeeoLsgjYzDrm5yjVwrLRLIu1DcrBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD+bmZUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD+bmZUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CFB1F000FF;
	Sat, 19 Sep 2026 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779584;
	bh=64fIxgakqcTi/KImqmAHFbVnAO8/PXWMjNGEzV5iDgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iD+bmZUMVC41TRzslGANgHxfELTgedPMaClU5Koe/JH4It4pOH7l0dzAGHMI/TctJ
	 pc14ABANsIh4VInU/vqw/aSY+0x/uVibP7h7PFrw7ohfs0nuG14K4LZz0fUGG6bmd0
	 67WAeweJVub43Pt4lmIBCfQ+YEjoMcclzNk3YZVOf14NzBWqQgYMAA/anxHQvbHj//
	 6ZjWF6P14PTYntD2pYSDW+E15JPeZ9lvQh4d/QFbV4dO3430dGMpC6ckl0l319Hcd0
	 CbNenm9asZbRs1dIEFR4SJrY+RVjApqNO0IVAb3QbwnAJ7H/YIUf57EwX88AL6O+X6
	 VRkSz/pUFB9Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/12] alpha: Remove alpha_ prefix from custom
 syscall entries
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-11-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-11-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:59:43 +0000
Message-Id: <20260919005943.E1CFB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Some architectures need special entry points for some syscalls (like
> clone3). The current approach is, instead of having a special name like
> arch_syscall, to name if as __syscall. This is enough to different the
> common entry point to the architecture specific entry point.
>=20
> Change alpha special syscall entries to do the same. This makes easier to
> join the syscall tables. Leave alpha_syscall_zero because this syscall on=
ly
> exists in alpha anyway.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D11

