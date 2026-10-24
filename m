Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792810847;
	b=XHwFJsq2/Z5xjRryK8HBPkjSiRfLO4lwU14aEGuxB5bkRivmfvwA4QLX6DoR+w5gWSzm
	 oFpKiGOO0WxCEYnXszHsxGaPsqrn97HfjVxkbi6T2d7OEnNYslRgZTvw2Sjs+F3fIJb7z
	 iI0iPFNMLen3wIP31IVdJ8wP9SS6qU9TAvtUvAyTUdQ3Svgq+xLY4lEFd2p5nDwrfoVo4
	 AX6lSiqen/9BgAdsIBvRBnLiMcDYx2MAqV4SZdSIvd/2T0Cn4+Ffc15cfNcO+yR6zFyTH
	 Qw0nuvoGyT6doIW3ZCfJXDAEqwaN+g8fI8bVuywlIBqId4v56M/6YuUKeUkxpPcnekA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792810847;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gbDYafjdxJDmY++nAzl5AEx/HaYmIAKE+6yhUgfk7YM=;
	b=FRYLwbMrDNk9puG1nmkhQtnW8Zkt1s0PNu/IHb1vBX6btmj/ehwnOT1ZGy2qioswqTTs
	 qb1LSbL4wnRD6dH8sevn+k04T+iFp6ey+PI/7+jCsDQta5m9S6zn74K7Aj92/CQ+ZBGoN
	 RbjlTXom66BU8cW+4Mfh9SvpSSEQ2CM+FyL8nOaGOQ5749iRMNrt9oTF1+/xhKMxj/kfc
	 rwB9DaeMJakNLpxbbX6YS7jWzcfzohH+lDzwgFp5r131Hv6tjaldWLUedn/DXOGUtKHIZ
	 Gj9SBDdxDOkzyIQ6/+lS8IDFedOLgJrmaT4UQox15aZQ92FQ1nqZ7txa7kGBM/8Hc0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtXpFtWD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D990606A31D
	for <linux-s390@vger.kernel.org>; Sat, 24 Oct 2026 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtXpFtWD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3C61F01828;
	Sat, 24 Oct 2026 03:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792810846;
	bh=gbDYafjdxJDmY++nAzl5AEx/HaYmIAKE+6yhUgfk7YM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BtXpFtWDR0DIvJuI8xjgKGTCdRLFCWtKQRMoo2WzdUCA/4akMH+3OK7j5CH52nUyX
	 Z+X3/6TgaIwtnKHK6x4Z6scq450PVqbSzPpSSyPULHTJjDOwMz1uCk8YDwTO8PehYE
	 nJwCMUIDyHvjCXB5n0oNT5cuVr6Gt4VfdIV/z+UrHjm2qqbFJd8mEdLp2eqZnSlNGy
	 1/IgpbXA+ms0pWL8BlVBIaG6ub5M1HRo9g974oaXE0oqAH09vCdfcg3cfiXN/DLcLw
	 6qiqBcy/ivcC3VUINNg4fmyUlScV++4OWt60Ezii8631bNGAdUL9uCDsrcTk1M8cPv
	 Q0lf3+Es4LuLw==
Message-ID: <sashiko-outbox-183528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v2 2/2] net/iucv: return EOF to a reader
 parked at the HiperSockets peer's FIN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-b4-disp-1d26b87a-v2-2-7ee1264d812a@proton.me>
References: <20261022-b4-disp-1d26b87a-v2-0-7ee1264d812a@proton.me>
 <20261022-b4-disp-1d26b87a-v2-2-7ee1264d812a@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 03:00:46 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Bryam Vargas <hexlabsecurity@proton.me>
>=20
> After the peer's FIN only sk_state says the receive side is done.
> Before the previous patch a reader parked at the FIN returned -ENOTCONN
> (Hidayath Khan: 14151 of 14151 cycles between two z/VM guests); it now
> returns 0 by the IUCV_DISCONN test, while poll() still reports no
> EPOLLRDHUP for the peer's close.
>=20
> Set RCV_SHUTDOWN where the FIN is applied, as TCP does: poll() reports
> EPOLLRDHUP, and recvmsg() ends the stream by the test it already uses
> for the peer's SHT.
>=20
> Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
> Closes: https://lore.kernel.org/netdev/82691101-92d7-4838-b16e-2e41a83f65=
d0@linux.ibm.com/
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-disp-1d=
26b87a-v2-0-7ee1264d812a@proton.me?part=3D2

