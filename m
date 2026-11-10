Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309846;
	b=gPLbMfdSraLI32asiv+aKIJ5W8tcVuaBgHPVrWguf3vkwFsBxLCWZiKMwSZKN7Bm3r2P
	 VxJ5kKogzpOSPI4ZP2+ug7xgi0MSMsqP+m8JClsycf+mH+COC6PT2XafVAu9CSutSro2z
	 XsMg0LrGWSX1vgf24y5RqDAQENtRygmkdWE8xzNnxWifWt3RBrlxu4qQtkbazO2UpeXyZ
	 Ohd3/ogqYpYHLHvwLwaTIETAhvtb826B7viKviyM+GRIUuPlYe8lbfWqsIT+EDof5yrzN
	 sYTJQWLO8CC/RCExBwbfa49qPTjWYywB0KbhR8/+CDjVva+yh8PAnVPf+gAO5Z0pDwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309846;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YBlfSb8ITFIIMTEPFBPMog+42JpCIyEsl/coGD791rI=;
	b=U+9KBa0oqA51Yqlxv8BJr80tR2piaeZe3KNRUgqRLMfgxTRUIFmzUUfZcXhix4bTQ1ot
	 3SDObvzxPolxf9aSY6rY0HVrJmk1dz2Q9vEBaeCLmd8j0n2yWJuqkCKeANNUSKGHBelMA
	 79OzepnPorqpAU0WKkc1D0xKr6S0CsvRRQHFM1ffx5YIgwTLVHih6z9R8GGksHBiomP1W
	 kmOjsyJ8z9mWrhpMK7POn0IouaXs3vk76wV/m/rTupyoctIJAuQpmvD4fn0ShHlPD48Ur
	 eJeJonPjeFg+V2XB+PdsF9TRMZtQU45OuLx9ehk9rNUvEU7VCJPzIMevGCtsRmhwnOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dp8yAIIp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357A60A2621
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dp8yAIIp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C071F008A2;
	Tue, 10 Nov 2026 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309845;
	bh=YBlfSb8ITFIIMTEPFBPMog+42JpCIyEsl/coGD791rI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dp8yAIIpvGb5UoWxqHY3lA6Ua2Dufxd4tuVK72zlICgg2kOSU/zBb7XW5RuMnu+X5
	 YHD1KZApZ7snGkqFocMS0w16910Xffe1Un7o8ALRB9CzS2Tcw40bc3A8BsJPUbHVTH
	 HWpYCWXprlNKVb5RsNn2lqVqGMlMScd2Eh5ry3K+gPbo9qKY4ACkJ6QfvJUvSjHj00
	 9lXfpPv34WlyCkxqTfzI6Dost+Ezs9m3qbye3vE9OodbTAn7vqQeUtn478ULOPondm
	 2/W5Oybi6IZ/ka/sFFYXJ1SyP9MX8lzdfgD4LtHV9YQSfI9NSOGczeHbn6oNacewTk
	 gFh2IsXWArZlw==
Message-ID: <sashiko-outbox-206932@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] KVM: s390: selftests: Add SIGP and program
 exception tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110111619.61760-3-aaronmbr@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-3-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:24:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add tests for:
>=20
> - SIGP: a second vCPU stops vCPU 0. Both vCPUs are set to operating
>   first, as KVM ignores a stop order sent to a stopped vCPU. Check for
>   ICPT_STOP.
> - Addressing exception (DAT off): check for program code 0x05.
> - Segment translation exception (DAT on): check for program code 0x10.
>=20
> The program new PSW is set to a disabled wait so the guest exits
> deterministically.
>=20
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110111619.6176=
0-1-aaronmbr@linux.ibm.com?part=3D2

