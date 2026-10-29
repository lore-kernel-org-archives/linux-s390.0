Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279160;
	b=fd8FK4gSkb28AJ4fSjnHQG7eCcccbzqF45ZHcIeRtHFQfhMnQRb5V85W1o3GjrICU39+
	 Fq83T10L6gnJGEO8b5XX0KIVGsGd3jtKuGnf53RJEHJtI8KkKalUVmYDtaqmIvPr0K3U5
	 LRxuVgIdMew9B+46K4NJ+z98uF0GWUng0VhOaPza3qd9s5ZR6Tn6JTZpZFiS5sHARiMjl
	 91VWPkGUCeE6ut1pL+Ruu6qP6tR8U+WwjyRrAq2pYv0sVooBomkTBhbbKMBUaZMweCh6R
	 kb2L2oaWSmvKZvRQ+kwGhoIZs8D/pSvjQmrcEJnfUuPSWP6mHS4kTV3LI2Tm0BMhJeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279160;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XSPgnaFKpRAeTVCIE4Ylb1qa/hLU0547+Ld2qF2MyV4=;
	b=BZqMlYng/JYgbX2h2XIjlbL3L3LTHxCvsT+BSFN5W4NOd40y7Mpke+h7PQChaHGXsGUd
	 5qTXb3N7n5VxhUs+A2gPTOs3VRXONW782S3uM761hsWKEkn/1esHp0itH0abW6vG2EliC
	 IXa45NbP9/4bhrcE6Ykv6kcItz02HjDixmE0i29riTeUmtPDi8ZXnHl9FB7jViUOpt4kv
	 Crnt3wxXXM6fvmXSbjtl0NYefOpKVMHAN8QaA4SVffXNVJ7s0njVS9WTuRdW2YkRi4p4M
	 F9k41ErCoP5uCQhO2e719MSXGPnlpF/QuWxWvRyxrct6GGOFn+dGu7d1OEWmiJkmJKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ+xjOHz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE8606A31A
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ+xjOHz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6FC1F01828;
	Thu, 29 Oct 2026 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279159;
	bh=XSPgnaFKpRAeTVCIE4Ylb1qa/hLU0547+Ld2qF2MyV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fJ+xjOHzh3vt8C+0DePWgiHQWbiKuYeGqBzZetsgPgc3FL7/kx3XeBBPL40eOg4fK
	 QwWLKlac0qQl6ALx3eWtSytUzN44TzeoGP7sZ4jUDGRz7JwuMInfxB0mEhPEGaOabl
	 eQ83n6kKVY4G9j/jkGf/AmTBD3sKiVM8Q57M1HtpE2aTrd+n/eR3BVDfw/KhAjP3UV
	 DxQJ2pf/g2AfHrc1c+wGThdckbW4raFyL4YqXUdRy6ottoz9+9ogBF855q0C9cmwUM
	 J1/1YKQ2rMVt5EU/uPKGKTTTM5aeWL7qtYYgyLZnJclRDKKNuuHa5rgMvvPcrK2hR9
	 l4+gcpLhL0Igg==
Message-ID: <sashiko-outbox-189349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] KVM: s390: vsie: Fix pinning using the wrong
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029130044.125032-6-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
 <20261029130044.125032-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:05:58 +0000
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
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029130044.1250=
32-1-imbrenda@linux.ibm.com?part=3D5

