Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716084F30D8;
	Fri,  4 Sep 2026 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551874; cv=none; b=KKH1cITpZ+ubyAxozVUMOnZ44BmGPZhy4XwNazmT+JvDg9NcmmdaZ6ezlF++TwyRSQ1QpAxngolxBxRM8ki/FTh+aZoZrAkrlszqLrj79ZFA/R5ESKLxZNKsbOeHPLt3EuzLWJK+YxH6rvMbcXWOMFH+aDDSZfeOhO87zgM4HLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551874; c=relaxed/simple;
	bh=ZcyztBr4wzwLoQbv2OBsHRj30lObM4lDl0BHcHBHuVM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=djTbbZjZRirQvGkbakTLKqxmGjMKZq5hMkRmbLtHmorCbSoTDnotPwsbtZsx38d5Cd6zaAu5LzSA3hmTzvUc4FeOYelrpwWjlD2ZR3lw+IsS7qOWQgW3kW46efGOr/7LP8LOuZ4evgO9jBzqW3Wl0JpEe0vHuYQ3kBxUDNC8NHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs8X0Vda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs8X0Vda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9451F00AC4;
	Fri,  4 Sep 2026 19:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788551864;
	bh=ZcyztBr4wzwLoQbv2OBsHRj30lObM4lDl0BHcHBHuVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cs8X0Vda/JvuB26WmpbmanFQv4TFi4XVDLWvLz7vL9oqM7WZSvBm5GOnvP80F4E06
	 sltN19bcwmIY3GvPOQKtSTMpaD1cc16oSOUmoMI3jBlA1NBH9GavMMGjsCEtv4Bh3V
	 HYj4KLjy3qN8cdoLQCwjCor4RARDiJRo9ScbCOXMECBmuBZwSu159tMpcpa9I4ApuV
	 pNMWNzNmRBi2j85JWYs5y0Ls52zdBVjqNEx4BvaF0HAyDG8yJZW2BloSdwasBossk2
	 xu77l7/51AqyWEoDU/oYrohkmqDhGwl6jX+qxxY5Flrxmfbs99gVw2oS5XaW8KP88h
	 o6MW5aamJ9/rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 5/7] bpf, riscv: Use resolved pointer for
 timed may_goto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260904195132.141068-6-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
 <20260904195132.141068-6-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 19:57:43 +0000
Message-Id: <20260904195743.EE9451F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The timed may_goto fixup now passes the resolved counter pointer through
> BPF_REG_AX instead of a stack offset.
>=20
> Copy the pointer directly into the first argument register rather than
> adding it to the BPF frame pointer again.
>=20
> Fixes: 6ef8ff20c30b ("bpf, riscv: Add support for timed may_goto")
> Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
> Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@os=
s.cyber.gouv.fr/
> Assisted-by: Copilot:gpt-5.6-sol
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904195132.1410=
68-1-sidchintamaneni@gmail.com?part=3D5

