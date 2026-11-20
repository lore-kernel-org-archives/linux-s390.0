Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173952;
	b=x6hH/AcifgJQg8YzDK5AftED9hhBbS+MHg7k5dC9Man+8lJbIQjeih8QvBv0k51Kf4et
	 4A97dZCJJao/9BgHd2XX53CBX6N4gjN628yipXyjXxSNcSSLiP+6KPEmTfLzWL5iegTMg
	 QUxXl0JeNv8EHeygIT+E/aeYXSCSVUzPsr+396+rrB2L7OGHT/Qeil6wWryjeMN6tP3Ms
	 cjnxH9VEkHvnnRTeHZUofrPzSvw7FnNwc9MGOrsohev0cLLeLzeCCsEsT1g4IQe0WP9Vt
	 RX9JunDlvYYzLsLzVgjvZUaMASSozRS01MR8TVJ3ZJDz6B3m1ORNL2KJ9OH5mVuKVYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NcV0t79NYJ/mK1aZ8pQRTmJ9otnohMh+O0hfCgV3Lfg=;
	b=O3uNUZ2wcuXuT1BZvDVOomujPRkmgJvNyOKKHd3BBHCHcBwzoQOGMD0unG6HFx2JUloh
	 cHhT1qEirdhG9o607P80X0yvjk/tCBlAYxr6y9+2k9xdgUSAZRs3GF42UCmzF3RCHsWI8
	 ON6OWtYNxravm0lys3FlQlPDZ7IMDyKI5pyOnH+05H6+wMAoiKCCg+oCbx8ORlCiaGUV/
	 Euy8oT5UN9n0HR6F7Z8Mnb6WV+jHBNjSdYewnpejQJo/B31QAeo/87ynchyaXw8QEmMsw
	 Z3Yq8CaaR5yKcfAjSDnRF4svCj2RRRA69DySQSAcAgdGlp6DvZ2lBBHYAXtM6uT76lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CiypTjF2;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E237B60A2611
	for <linux-s390@vger.kernel.org>; Fri, 20 Nov 2026 11:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E237B60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CiypTjF2
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso8497915e9.1
        for <linux-s390@vger.kernel.org>; Fri, 20 Nov 2026 03:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795173950; x=1795778750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NcV0t79NYJ/mK1aZ8pQRTmJ9otnohMh+O0hfCgV3Lfg=;
        b=CiypTjF2jy/+DduTc91OBItjPmjWpksDx731Tt8/ASANkcMr1qve4vciEqTA7oaXjS
         Xc1+NzyNM/1DbXQFxqX7HWPOn6ouSdVuX4ofW2to7spZnhnTL9JBforLhr/Dnzua54x+
         dVB1ngsDoIsn8vk6NHMS9eE2JwW0muMQwBMYLUNt/IMxqlhdj5Y2e0tA+MtWKgxPXVpW
         ThSeGhuoKFMCiAvhH6HiHCvM76x1BzJ15t5W0Fr9VLPZrwD8pVVhd2YSms8QQ2AbP1+e
         Pg1GX4IfQf91KCY6EVW1dUwu5e8lYiA9oSsKMy/zisB1TuqrmGv3rBGMzzgwsDwfN2T4
         Injg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173950; x=1795778750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcV0t79NYJ/mK1aZ8pQRTmJ9otnohMh+O0hfCgV3Lfg=;
        b=wIBAfalb+a7iBtghJpd9ASt5MYOCn+ODrj6pDxEoZ+K+IxF08isOEi0aU6VKh6/+sm
         DkLCSoRcuQ7+azYvm4Ml6ayJzldI0VfQJ2Cos/VGmurhanWMehx8TDVUgWsUcUxotq7n
         V6WyRfJmE6INQcRBIP0gPazQZ5M2LlH0Wy6RqikVcmHuXJG+hyfFGz5VueYaEeUTZt/w
         xKzgVTtnFOvcHXTw1JvzrA7xKcY8H9HIr2aQcU6XsNDOmBYvrQf8KG8e8rosSkVFQx0/
         oYRLShJxCpXB0bOjvouIDYvAnfk+p7e3jBABcMQ63dKLmRCAeEDzkOtxY717w5qZrbUS
         t+Ug==
X-Forwarded-Encrypted: i=1; AL+hErE84I1plFqCauyyQoXkiAMmKuejTAFSi4epfHRbtupMbqUlb+SFWSZiBDxad0BB59ilUVUQk1rMEg9k@vger.kernel.org
X-Gm-Message-State: APuU4Z+vP/RvYP0JR2i3Gy3nIPtKVtg8wHRzqjV+YTj/4eWmY7dm6uFr
	f3V0eSZL3rA0j/Y7cCqFGcGC9sOm9w9VwxWeciefwLlNu+ek2u6ks5CdEWZsGGh4+xU=
X-Gm-Gg: AYBFou2lV5pD8/86fVKRW8v2iVofTVAqDtgo3dTgWErJ50jXPMCei0eZ9QgRY3hRnkR
	0kpliJtFMuI7WFZM6J2ZYkOeB5bJzQyMVIxkKt5CMtyc6YfE9ySsf5HRVpCm8eWOaguZKLu5DtO
	QQ565mQk1V/pKS3Pw7ohbhj0aIXkqVNt4K+a9gMJ0sr0kr31Crd9TQpMuEX3KHcDegFEdpk1UCY
	D4pPCuPTs1XcN/EHS3RFcIzdRDiby05xClzTiKFmGHKyNphLWKfreBB9x6wl/JGB2WGpYLiBzDk
	7TzdkVZ5xa2NJreJvgleOqq767hGTMKg82wFAO6hM96KDKdxUot0A0GVnYvD02iCkhndkEZoQqs
	EAGRdi6wpvrqqhkwrKdFVkK6EfGa8Vs32x0VcCSSPeUbfsERYMqtyfWgrmw3+De2SOK0d+CTnJt
	ovuH4pju82aZIhSFGZEI2OKwsi46Ki1oIgoY4Te6uvI7Y2UzNu1Kx0Hqe8tPYGwiFXa2srFzERd
	2xxaE4HzcBo+Wbycs2ERGRR3uFUg4GZwaxoPmtbHo+8KZ8IqbmKHzu50qmHalTdL709sniVs/Gb
	IKZcf6ch0t8I/LFWol+G8bf9rEACBNN2iyaFIIscA5xUTbaX13JTji1ZgeEyxpyEAH0SGW7EcB3
	SQI/ee6dbbP9iElY8
X-Received: by 2002:a05:600c:64c7:b0:4bb:68c4:2044 with SMTP id 5b1f17b1804b1-4bb887fe725mr56451745e9.11.1795173950208;
        Fri, 20 Nov 2026 03:25:50 -0800 (PST)
Received: from localhost (p200300f65f19a904be03815e1634e776.dip0.t-ipconnect.de. [2003:f6:5f19:a904:be03:815e:1634:e776])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884b8429sm117437835e9.14.2026.11.20.03.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:25:49 -0800 (PST)
Date: Fri, 20 Nov 2026 12:25:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Schier <n.schier@fritz.com>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"kernelci.org bot" <bot@kernelci.org>, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH 2/2] devicetable-offsets: Get struct cpu_feature from a
 device-id header
Message-ID: <awAtvSIQeLJq2hvF@monoceros>
References: <179424040477.1704532.18231793404479518924.b4-ty@b4>
 <av8Uv7EV3sLqUBfr@derry.ads.avm.de>
 <20261119194738.GC875856@ax162>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tv3l72rardngbokt"
Content-Disposition: inline
In-Reply-To: <20261119194738.GC875856@ax162>


--tv3l72rardngbokt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] devicetable-offsets: Get struct cpu_feature from a
 device-id header
MIME-Version: 1.0

Hello,

On Thu, Nov 19, 2026 at 12:47:38PM -0700, Nathan Chancellor wrote:
> On Thu, Nov 19, 2026 at 04:24:47PM +0100, Nicolas Schier wrote:
> > So my questions:
> >=20
> >  * Shall we keep it the way it is to keep the original patch order
> >    (bisect might fail on the two commits before this patch)?
> >=20
> >  * Or shall the patch be moved before Uwe's (removing the 'Fixes' tag,
> >    and rewriting the commit msg)?
> >=20
> > I am in favor of the latter.  Are there any objections?
> >=20
> >=20
> > [1]: https://git.kernel.org/kbuild/c/f1dc66c38b7eb4b2fb946a2fd6929250ec=
d2d85a
> > [2]: https://patch.msgid.link/bc9fbf5784f6788e10c749a05d56c42bdb68f3d9.=
1792144769.git.u.kleine-koenig@baylibre.com
>=20
> If history is already being rewritten, I believe it is always good to
> fix potential bisection issues like this. Rewriting the commit message
> (and maybe some of the diff?) and placing it in an order such that the
> build cannot break sounds great to me (but others are free to disagree).

Full ack. I think the danger to hit that point during bisection is
small, but I like the 2nd option as this reduces the small chance to 0
in that case that people yell at me :-)

So from my side: go!

Best regards
Uwe

--tv3l72rardngbokt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsALjoACgkQj4D7WH0S
/k4lAAgAru4huUD6XgX/xEc0md/r2uTYSHfAeG9y3GIzcVC+zkGIzmFUEZ2+X4HN
rc4d07ok+2mGRZ9v9k7dO2SUzjDaoahlVqRd5ldtCwi2b03QrEfGe2Bkte8IiCCM
0vWjLcJWss62UN3gAxmKMHIxKvKcYFle+LjAYqi8dWM+YPc2SXS0gqmTZISLjEXN
HHeBGqcecdsyrFtzxYnMLvmdJ9vefsQNNlLcyy6V/EUtnk2yt1k5ZwXozAUEojXQ
OhiuLXypzkqUPvCXOQKtrqveg6g0hxnDtqlFTZfptssoqxNVMwLsN52Nsic5nzT2
9LO+HiyUPz5SPNVTac2QsyHue4WN2g==
=RzUQ
-----END PGP SIGNATURE-----

--tv3l72rardngbokt--
