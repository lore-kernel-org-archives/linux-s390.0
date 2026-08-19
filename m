Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E03B8D70;
	Wed, 19 Aug 2026 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107179; cv=none; b=dpYhwfKQKbmXKhGkcyhSpbDamJNQaPZzIAdr3c1QKdUr8Yk1oagDp3cYglzLmiBXBOnpyDJgo96q6wi9FqBNlSeS8qLj3Xu7khlSzK8dosfnoYyaS0kWczKRokb7QMYy1ZhwVQIm2cMfeScMGCDVIWknOCsdr7gxo04pRVYBXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107179; c=relaxed/simple;
	bh=5xy7sY2sF87uwTu/Gkk96YLrJG3HuPrzftI2rrmKrSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s+q2yQ6whiWOC9qrrv0APYUZyjEejPXYGOKlDnPRI0kuJGfJ5Jp/NfbNBh0LNenPtucnjIDUdEKITwFcb6qgJ9NoohddARKAgyqCTa4ctecNsst88RSOdXUIpry8q6uPhTsSh+wIkHt4UY2CH3SbGQtHInt+YiNLieF/JdxoEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU3Lg2iB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU3Lg2iB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6391F000E9;
	Wed, 19 Aug 2026 02:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107178;
	bh=5xy7sY2sF87uwTu/Gkk96YLrJG3HuPrzftI2rrmKrSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kU3Lg2iBZu6WATaw0YNYSrVsB9FGbucboOW/9AeTyQO9BWpJ+3tLf8ujL2twdD73b
	 PJZQswcreA5E0Lfcg86aeKbtRHpvDcHaWaNiCqejXH9/fZrLVYUUmdk1kuiERC2++M
	 k1So5Xg3s10JUcI4xsMaJkets8nc2Iar/7IXffZ1p8LChwW6DhPZpVizYD3SCLdMiP
	 Vvk0UPi+/f2RKCxDks/rvjF/rPeq231nN6QELQ8d8++UnbsfuYx1n7U9Vn3u1fc84N
	 2ghU4UAYxLMipRVFkulWujPE4aAJXtgXnn8PS50ap676gDuRFEYTGa8HVTqT4CM66U
	 3JpicPa/y1gAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 10/13] sysctl, net: update
 register_net_sysctl_sz() edge case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, mptcp@lists.linux.dev, bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818-sysctl-module-aliases-v2-10-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-10-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:39:37 +0000
Message-Id: <20260819023938.0A6391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Handle the last (edge) case:
> - nf_log.c: ignore sysctl table with template set at run-time.
>=20
> And re-enable the macro.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D10

