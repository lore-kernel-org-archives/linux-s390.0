Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772361;
	b=BxR/zTvu+NFv6Wyqv9kLYObL5wC9beMyfTiNe763tjTNBb10XIGV1sHTEIKBfNORDwjZ
	 Ob1T5DOVjDxaumbDyLysx/7vTWsPygXfvxk4H60uKmfUTRut9CJ+lx/11lerTRcIIa+Du
	 jz1MeH91jHhhL9iF+z3JWXhHbpRZOnY8Rem7LIZm6c0ciSNbLAEhR+RTxVBY/+K/6I3OL
	 FDNPmPdjwz2XlfkC4pvdqkTNxtxVEA91d+/aWlaDkYE7gvVzfNEJpM0Q9gNFE4daib1L9
	 2rpiPCV6k5TlCS4qAkrloiqtfDLNNTD/65cK3cnnTvAAw8VBoAcnRURe/B+cEmhdNWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yyKUA9bKUjv9tJnQVhC50Aa/PV7RKUYWzT76A0EFBp4=;
	b=26bBXovCM0otv2ph2iva57iOJtwsWVw8ySH0nR8y2ojwAXTsrU1KUIYkKn/33rQ78tIz
	 5Ss7MnQuLFWho+ZjcqvdVRiNmfnlCpmB9o3dybzMXBFVX1AFRTVLlgmhdpHqTNeMvT7qg
	 8uhPOfh8O6+j6iZkgugJcEUkbwq1k30+pc3VkfbMUIlOEqIpyyoedoozHrxBQzhT3vF5v
	 CVUm1l/CIshibcWr9CMjc3hQfbFzl4m61GWqsm3xKgFUwB/hN2RJoyJMX5bpuXu1NGbW8
	 5etOIAf6vbHc1jDQZXEhyZWdxs4CepyryMwJ4jsIqPQOtJM4joDcP6VQc9Y0d9W2inw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOQqWiqD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C74606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOQqWiqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDA11F01825;
	Fri, 23 Oct 2026 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792772360;
	bh=yyKUA9bKUjv9tJnQVhC50Aa/PV7RKUYWzT76A0EFBp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iOQqWiqDxnJjot5vUdSLovVcqADpVVAiwj/ehzCDf8zYUkj+7YVDvYMo7W3dSNq/t
	 IETU1RCLyPOwWU3eAick3fIz8FiYi7smJcgP63HiT8bF9yiykVzZQDe/cFEhvWTXsS
	 yjNUBgZWSMscdBCtjUVo35OjuWx7Cl2U0xj080sP2Vcwwa+8R9EUAxmyOc547SnH2b
	 KWcpojvZKMJ8zXb7jtNCLDQNZs/Edxo2Q/5hP9v8/g0/yucTnqNOu0TvcLhxhrJgGh
	 kJzooBBNUHgTnk7n9YbNrcu2WMAddq1sWRjRQO9stl6+cAjBCrA48Bqa7e+C3dDwjL
	 F+6jdXA2j4GAg==
Message-ID: <sashiko-outbox-182944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] KVM: s390: vsie: Fix pinning using the wrong
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-10-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:19:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When pinning guest memory using pin_blocks(), gfn_to_page() was used,
> which under the hood uses FOLL_GET, which is the wrong type of flag for
> memory that is accessed directly by hardware.
>=20
> Fix by using kvm_vcpu_{,un}map(), which uses FOLL_PIN and is the
> correct thing to do.
>=20
> While technically a bugfix, the previous behaviour can only lead to
> guest corruption in extremely convoluted test scenarios that cannot
> happen in real/production systems.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D9

