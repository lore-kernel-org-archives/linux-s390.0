Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB733D9DD7;
	Wed, 26 Aug 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757262; cv=none; b=AYduMlM7IIlvtwrUu0Ilevm5DC59GdAOY/rwgYJ589xUV1KGWdcjvbg+pGC7tX1nX9oGTmnk9thzBruCNJqiIlO3BiW0411fu9fYRZ3+DeOdbV7kw5UZCe5v2MegWb9VLG9Ridujz2CNHXFmVFtGrQ6thvfykJ794OElclladEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757262; c=relaxed/simple;
	bh=Lny5mBP2sM0IK4Sug4FVPXgu7iIaXrxxtH3j0HipiE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iRV7S9fmg7E7eV4uiUUyh76AbclLbnKQx/3HwfSXifPz/M9gg9orrvEQUiEL2EZQpbPAKvgsaPj+tx4FQC69tPuMec26YuTm/NCyeXi3lk88DzRO7Vsd8w8Pg9lrT0b5XZ4UWovBcTqgmKXYgWMGMy1HHzYtQfKixaswbtJ78BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQji/zfI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQji/zfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1151D1F000E9;
	Wed, 26 Aug 2026 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757261;
	bh=Lny5mBP2sM0IK4Sug4FVPXgu7iIaXrxxtH3j0HipiE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQji/zfIgcVaVSScXSTypoDmtvyNxT8md/gB7UgQJXnfff0r2u4q8WZYe+HeRc+ZK
	 b2dUw+pG4Ou2/+cGNfNVdkv+nlB3f/4YtNLCPUm077NqdaItMGDucWRx3TsnlVWPC0
	 AUN/1YrnUZCA7mapyQrHShfnJChhBI9bCJ/LKxJknGUj2DhfuJ6E+y2Hg9Wjf4SI1Q
	 mPUxkuxQu+cJOl8QqcGHccuIqVthi3czIGAnYHrw+wvWHMuRO5h1UYwlrYro5+BXSG
	 iuJODRyLCnRNts2XJDE8ZO9JHU8YkEV+HKsaSY0azHZ35y/gb+mT/8gNTxTmySKuAe
	 X9ENyeoznlBhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/21] KVM: s390: vsie: Replace radix_tree with
 xarray addr_to_page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-9-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-9-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:14:20 +0000
Message-Id: <20260826151421.1151D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The underlying implementation of radix_tree is xarray since v4.20.
> Changing to the xarray API directly relaxes some of the locking
> obligations and provides more symmetry with the next vsie changes in
> the series.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D9

