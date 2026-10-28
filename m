Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203165;
	b=g6JRA02wLnP2z9LsH4Vz+PgKVMKPHiSn58i1+lNHdBMi1jvXcNP112gtg+8YtgiYGI5V
	 FkjPDo1Be+HD/IN6IliwsFwb7YTIpKp6yFTA2oYrR99/98QH5Uugcrvv9rAfiYeNS9Cb/
	 2aDWDCOqLlQnCG6gKmWwKJMelCaZQ4f/sJEJg2/NWMDau0691NNvUlj4QYglDo/o+Wle/
	 UGI2Rco+goqsZmDC3FF2fCTCHwLltcOdJQPhBijvBYmDtgrBGXapcc/EZWeYlLN4SlioR
	 C/A4nC745iHB78Me5w2ZYb0yt4CbRj/7KM14hMLW8iGxsRyPH3Rz49F83XgFy8UEIvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203165;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yVrRn+kNyHMN16qkTjjCdFdFIshmK/rzY5bBip8I5Z0=;
	b=122lpQK9TvlXmclutnsRAvZJEUSVcInilSe94haRQjWSKSTJTqUpR9ooMooeWLUQYi+p
	 qLNR/2QRtRBezpwT53LYASXsn//KT03PnP9NUQ5ChZUbIxq4sXE2mUsHn/4cJ3FVT/v+L
	 uFortng0HecrLT5mlN0MnrsANa2Quw2f0XYaKwRm58n0IOhYVfKaxi6NjVOg5Lk3NjNtO
	 muhtWm3t3ddVaJ1rqRbx+6En9UXYWyXz83PAaFGr3cSHGwqwv34FzFOO7jEvrw5sJdtyO
	 fc/Gq1lEmoWIijNS5B50SJ20PKUR5KsmaLaCS46UwZ0KaorWLOITtqqIJexZ86DGb0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=haEwZa92;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 99C09606A324;
	Wed, 28 Oct 2026 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=haEwZa92
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A21A11F01829;
	Wed, 28 Oct 2026 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203165;
	bh=yVrRn+kNyHMN16qkTjjCdFdFIshmK/rzY5bBip8I5Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=haEwZa927ysjydVPPZvQacM6MQzUQamA8aF+y/8oZE1NXqZ5v6mecBENbp0DIN5O7
	 dixNmuuLzrhsRhKvn6jagAqSBHBR7wDWR3HRAQrOEykAzgNm5NgqGK4BIihFa5PrE8
	 0eZe7qMiSCTgtvrSgwapjuHUy71kSSIjPNqbIdsnlhih/7ob5CdXGbRbmsy2p39Oz7
	 2R7bXKbCteqlv0sJIBt8rYNaWAicnVLm5JP9GHOlEjIrbfIpppXSAuHLkl9u4T9yyJ
	 B/7ilsOgRpnLLCoLHCN7WDH32TPmT7YgjVSnz/EwPDi6p/ZWEIX0UMEOC7iOuqFfn+
	 ldNZmUV8ncjMg==
Date: Wed, 28 Oct 2026 17:59:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Kees Cook <kees@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Anastasia Eskova <anastasia.eskova@ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cert_store: Hold the keyring->sem while
 invalidating keys
Message-ID: <auIb2VIyDPqcgSgS@kernel.org>
References: <20261024144229.1546151-1-jarkko@kernel.org>
 <20261028153419.8417E3b-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028153419.8417E3b-hca@linux.ibm.com>

On Wed, Oct 28, 2026 at 04:34:19PM +0100, Heiko Carstens wrote:
> On Sat, Oct 24, 2026 at 05:42:25PM +0300, Jarkko Sakkinen wrote:
> > invalidate_keyring_keys() does not hold keyring->sem while calling
> > keyring_read(), which is contrary to what keyring assumes from its callers,
> > and can lead to reoccuring bugs.
> > 
> > KEY_FLAG_KEEP alone does not e.g.,  protect from  the following call path:
> > 
> > 1. keyctl_keyring_move()
> > 2. key_move()
> > 3. __key_unlink()
> > 
> > Address the issue by guarding the critical section.
> > 
> > Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > This came up as a side product while working on assoc_array to
> > rhashtable migration and going through various callers of the keyring.
> > It's made by me but please keep in mind that I don't even have a
> > toolchain for s390 setup so it is based only on reading code and I have
> > not even compiled this.
> > 
> > Just wanted to clarify the background for this fix as I'm not a regular
> > contributor over here. If for any reason it turned out to be false
> > positive, I'm fine with that too.
> 
> It is not a false positive. There seem to be more bugs in the code.
> I'll take your patch and create a series with other fixes.

OK, great :-)

> 
> Thanks a lot!

You're welcome!

Br, Jarkko
