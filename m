Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7142E8C2
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517182; cv=none; b=aXRPfIbVLnH28HdTjvozBSZ+VKoZnTDyY3End4sz9dm4gdSSgiV9CP0O+7vsN3PANnW81g6DiykV5yJk5jccyGw5WI+MWZpNZlypxTiH150ok2VY01rvhLmzIMa09WsoKVYc3oF9TLnP+IsOZUhmqzPwKM2FVzuKrHc4Dm00dts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517182; c=relaxed/simple;
	bh=+TVJE+Js9sZhrj2xFtCTVKEaB9uiAGIs0dlyCkHprx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cb2jWgQi6MZVTywpcsXwWVbi5QFYqBPUbciTV0Z8zRMjmO74QR4DeyxGv5HR+Qt/AaCQDHSw2jHSXukUIzfzA25OS/9MKkeVs4e1TGkbWo3/C2UC6wnSHxqWVg7kLq4/GHv2LdvwJuhbq3nkZgcYDJlbwckedmLsHJnJlTdWEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy1oDdEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy1oDdEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855EA1F00AC4;
	Fri, 31 Jul 2026 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517181;
	bh=+TVJE+Js9sZhrj2xFtCTVKEaB9uiAGIs0dlyCkHprx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gy1oDdEMf8RL9ro8rcrjG2MnAFdhvxAO8hy2A1EQOMObXmgpHKjTXHXuzXRF3BM/Q
	 +HkqnATv+MEyQEz1L2WEij7065XvNfOOdf6aN2QlYPbXfA3ehHYJk3mtKRq1RtgDNE
	 mJ81Eu6IYrnDZTv54Eh3h//6IJRn2oHi3ug4opluQEpCVIrRXHt3F07vs592vbvwB2
	 RASEPet4PlM71dXKqjW0DCslO5Iw9iGC9TnjKvEwiwKLUTEnockymT0LZqS4NQH3vV
	 uDrn4erjt+yhY+0yY/drfGEMCreOMUy+i3PTAYEb/A0H/wsdSBon/gg1Lxkjr3en6n
	 ezG0y2E2gcCSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] s390/cio: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731165004.2758105-5-hca@linux.ibm.com>
References: <20260731165004.2758105-1-hca@linux.ibm.com>
 <20260731165004.2758105-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:59:39 +0000
Message-Id: <20260731165940.855EA1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Since [1] cond_resched() is a no-op on s390. Remove all calls.
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731165004.2758=
105-1-hca@linux.ibm.com?part=3D4

