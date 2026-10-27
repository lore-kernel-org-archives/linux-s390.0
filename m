Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122684;
	b=WAIMYbPnd4fOl5Uzjp5J4YxSSXjni8im8ODq9eDDOPm4OCv0Bp2Jpx6ZUJFQ90fxPdWW
	 zzKl98ChLS7qa85tBsHqH79XCie6MH2Jya/iVjXroEMirQ01r5OGbdw1P4MsODDWROptU
	 iCR9E168Gjw2q+ghKT25TCy2p9md88a9w1hwLD9xb49ZmC3rtCzRTFspGgTNOR0nZ9g6D
	 JYiVOTVfUW0ULS7TMv9EEHUxZokunzulscCCW7giu4gY5Mecv0vjcq3VjeRP5Bzzou7bl
	 ralWfFmWB9wdnws3bJlRRhP3aR78yXss/7eG+9ExJP6JeQq8hVj8spdBJDLGgOg1NcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WDNm0SzdTtyAkZfW1eQnU5K/TcIXy24LuPuhl20DRnM=;
	b=iVKgMWM5yNDCbEoolIkYqFHDSwy2ecAR1kVEGqmBTF7rEY26uZQFItWeSA8HszEJ7kq7
	 zaFMaUU3TpiDO98yotwhwid6CYXq8kAoOBg8BbBQqonyBnKLnjg8IfxgFdJGrGQ0UnnSS
	 3sEJZJP1Dy9E8npqRGDxpS7Ka4cCsPe7pB73Kh8+0eAesJXdxovZ3vWgHbl7I0CBEcEBA
	 atfsrYa5CJ+OuXdjRJdcjCvgVHBhW/76UK1MfQwwmHzKxP2puBGOltRGMK9vRaG6+YPDb
	 DQSKJAlKWUFpzaORO0ZKoy6CPtdy4DXymBfYLwIMBtgvDthEVkQHJz0lY4UvqhbzSjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvWj3wj5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512D606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvWj3wj5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C091F01825;
	Tue, 27 Oct 2026 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122683;
	bh=WDNm0SzdTtyAkZfW1eQnU5K/TcIXy24LuPuhl20DRnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LvWj3wj5wJdzDKaMqWV76yZAOcok+0Trg4nwte/8z3rxGHK1hGONeZqi9EPhLXmiG
	 aNjP0N1STov7wNkO0LXwxvfXGaickOi6zPa8nDKCx/0sscWlj7SVE5pmPA9kBkm58s
	 eURyJanj9POam94hI+Zfi6xRWFgkMeJA0rsfUC5HP2xPvPmDiLrdcyrpljATE3tPcF
	 iu9gB/9DX1mOodXoBdxyYDm4N9oSd/iCEtDQyCSxCTzncWtrvvbvcl9+QqGqEkMrHk
	 ddCP2dlX4zMJ4/BtylZ8v+x9Me8412WqcQpf9uhsZVxKxKaINE6153/BMuHcq39RrF
	 qnpN+dZ9/zVMQ==
Message-ID: <sashiko-outbox-186990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] KVM: s390: vsie: Fix pinning using the wrong
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027173239.224849-5-imbrenda@linux.ibm.com>
References: <20261027173239.224849-1-imbrenda@linux.ibm.com>
 <20261027173239.224849-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:38:02 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027173239.2248=
49-1-imbrenda@linux.ibm.com?part=3D4

