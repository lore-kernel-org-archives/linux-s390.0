Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32D3DB626
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963863; cv=none; b=jWg6jffbFb3YMhtO91O0COyGHBhMntxuWy1U61gk/i+DslH6axmKwoFVAO7OyDtuwTMTpwwaUWfjeCs3GsPpHciXVG9gzOW6+C3YDo8CpdDPCqTUn2O1l+kOTi9cIyDnd39OL4OQsX6U8mOG5gB53MS/s2IkZeN740LrUH5Z//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963863; c=relaxed/simple;
	bh=m0gh7Pdbq/kejsybHFH60EW+3TmknR3Ei82UgVuSXt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJfjvqGspMdgPDvTo6sDtIUMsNZwr5cEavadsSP9sUIIyf4IFqUm1J3gXSdJKryLZ+LAxWdK3+VUuIN/VXQELSoLgKyOtZpxemTOdGvnXV0R0U5fUI1RZbgB5Y8Kv6HiDn5MV2GHwfeR135CkXmtk99xL44fFJm5loiqPAb7Skk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAXpLNS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAXpLNS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658DF1F00A3A;
	Mon, 17 Aug 2026 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786963859;
	bh=YEbHgR2psmMH62T6e7Zdft4T3AxduRyK2j7Sv+fUXoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAXpLNS5Zm8KOL0a16lxX99RMkUkTrD9AoaxQP/Zjfb8RdsPSj+wX8FEZvI9VJLKw
	 fo5xnH/d1upGhPA/enYx42jk+3UYN4G4N0yrR+uuE4njvcoHtehNRYJC/zhofroi0U
	 IToQ5PTrFfuC8t6boeBO7pOiAo2atCOKNvHwZhmsiUaNewiAdLqvQ9OLZa5Ss2+gxM
	 LdKaY+jUcL5Nef6ZcnImTbM5lJeXp0rHsoWFqRHRvx0Nxc/WXPRxR1BCQCM0zBoT1c
	 RvUtTIEjeGyNGDj8rAzCQuhNwZBD3yK80ZFvmsyenvA9siA81TqTcTxPo55DaX4OVb
	 KCSVRmSrrpq3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] s390/crypto: Fix use of mutex in atomic context
 in PAES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260817104203.74033-4-freude@linux.ibm.com>
References: <20260817104203.74033-1-freude@linux.ibm.com>
 <20260817104203.74033-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 10:50:59 +0000
Message-Id: <20260817105059.658DF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The exact same `mutex_trylock()` in atomic context bug fixed by th=
is patch in PAES is also present in standard AES CTR (`arch/s390/crypto/aes=
_s390.c`) but was left unpatched.
--

--- Patch [3]: [PATCH v2 3/6] s390/crypto: Fix use of mutex in atomic conte=
xt in PAES ---
commit e6433be4cd856ce7a9d00fbe2d231629541a50c3
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix use of mutex in atomic context in PAES

This commit replaces a mutex with a binary semaphore in the PAES CTR
implementation. This prevents panics or lockdep warnings when the CTR
processing is called from atomic or interrupt contexts.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index d075b0241f1f5..e8bbfc376ebb1 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
[ ... ]
> @@ -971,7 +972,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ct=
x,
>  	if (rc)
>  		goto out;
> =20
> -	locked =3D mutex_trylock(&ctrblk_lock);
> +	locked =3D down_trylock(&ctrblk_sem) =3D=3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but does the same fix need to be
applied to the standard AES CTR implementation in
arch/s390/crypto/aes_s390.c?

Looking at ctr_aes_crypt() in that file, it uses the exact same locking
pattern:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
    locked =3D mutex_trylock(&ctrblk_lock);
    ...
    if (locked)
        mutex_unlock(&ctrblk_lock);
    ...
}

Since skcipher algorithms can be called from atomic or softirq contexts
during operations like ipsec network packet processing, could this similarly
trigger a panic or lockdep warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817104203.7403=
3-1-freude@linux.ibm.com?part=3D3
