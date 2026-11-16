Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851335;
	b=nj4BWeQSEFMoW8odO4C7YErzpS9HDdZYrvgz29wdO161No8Ozq3oG2Fx1cK2Hdv8sX5l
	 0OXqteuGN8DR4vhDOkl6to/IqSMR3PCCDqGluBo9BM8aiTua0VEsJPnx3a3ctE9gQmTGc
	 2Jg1rMw4a49jwHfXQokp6zbeD2SOm1ZgTbnKhT+9DACCDHoCAnqADOG1dhsczo8q5jT3F
	 W3w87+B7SM6E1Ukwk5y9PaRwO0VhzwEkxYJ9Jjv1Nyfb0z7f7rU2q/Oac3BIUI1ZfjztQ
	 PSF6sAdeTz07dcUWlwp9DYBC2jghhFc9vrPxHfu5CdL1nq5CeezHQ8EUZ90RmzvBXJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+b3ujps3g/yqdNKxogsevh47lizY/dNMsLFQ/TC5PUk=;
	b=bMCXZUCkQOoAzTU0ZsHieHD/R7rTkjLOKmMV4U5eFbHVo7QMXp3DUjkG3ufcRbVZWlup
	 l8Ng1W3DBHmdCF0GIuEKkJKW6Qn1aURFKS1sCdxh57KvuHlhlBOOLCg7Eip5GeloacIJG
	 ICO56/WBNRVQxoYcWryFZCjM3j/6wkJqF1kbGeQzF+UTgUScPQuXz72fGd9K2sDOwpVsw
	 VuVHqjq/xDA6MuaHV0y881dEgCHCqCk27KQjWHO+Bvf4DDP7/lWRzr2Wc0dcWGpPkUNUd
	 5rFXCE1jEsa9eG7ghfcSXdHE7NGEQa7/FQDK3YTRJOTVU4OEPuY/6/rnvUP5jlXA8iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U6hFU/Uw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C73606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6hFU/Uw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ABA1F000C4;
	Mon, 16 Nov 2026 17:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851334;
	bh=+b3ujps3g/yqdNKxogsevh47lizY/dNMsLFQ/TC5PUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U6hFU/UwZReeJzdxnNSffZZ4aDkodkGQ73D2hGcgT8sscu70W19d3fkynhwuHqP7J
	 Z5mKwC1kBgjKIzHVez7EWdGVS4gL5NF6UkgxxUHKhTKfJCd0JN0F72M9AdZ8ZYTCf0
	 35XZBP/5Qfd1NA2CZ8eykCywCKFbIhcXJseulSYDo69YN1sbEPrCSJcjRadEaPCS72
	 LvogRFLDRRknQb30pHoWcPfrCaipqwy+rgCg4nkm8ku79z2KrTw6Y29g9YukB1q9NX
	 IKiD0m112AM40uUKmSi+FydCbePQeEpa1Cp+z7M6gNpHnfJ3TAuogh3ccb+RwgsB+S
	 ZV1E+nsXtRwkA==
Message-ID: <sashiko-outbox-217440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] s390/cert_store: Remove unnecessary static
 specifier in create_cs_keyring()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-9-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:48:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The local variable cs_keyring in create_cs_keyring() never reuses its
> assigned value, therefore remove the static specifier. Callers are
> serialized by cs_refresh_lock, so this does not fix a bug.
>=20
> Even though this is not a bug fix, this contains a Fixes tag since other
> commits require this as a prereq.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D8

