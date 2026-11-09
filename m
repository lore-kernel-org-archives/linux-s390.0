Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263306;
	b=RxJ6dkoubztNMRKACHwBxDA+h2mDlZGWIb4urJzcFT1bXT3FlZOaAc1wYM1l7JslPPz6
	 GH5a8XZrPCI9cdZW64s5mQVe5tbEnWNWZKj2qlJuAR2PftOY76vCjxu+QqzZV6Rs0t56e
	 4+B2LoPxnHO5Ct6TZMQBrztKo25nLMpEFGn1+bM/ajyiJeDzF1AN2cBpVzhFb2e59fVCc
	 GOJOkGQ0rJD6/BWiCkcnM0MeM2Tcqlo07sF+JqifxyBVhvaz+72Jr1yEV//GZvSyOIQs0
	 4CXQKpd31tEY6cA+XQM5MskoaieOFzU7xRNQX15O3K+8zEkNp0RQW+4wE4NJPjA6GEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lW7LvFHsWvzVYUMaoh46UljRlVflNwb+JdupuISiayw=;
	b=cTiu6lDinwdKsg1eB7DuHDsbCXhhoUnyPCAP1urieC9M0mM7mRUmnXsp8QJXLe0JswoB
	 HoiT/tDoFPLltoz8u33YqGB8L+GswZ4BJUVD2oOe9M2MKf7Ek1FAAsOySxMQKaYLVH7yF
	 54hAqALTXZW0yh4GD/qRgOXFOulu4OkQBt8k04Jkn3iufkvUdof2bOg/Gr0qQgmovYOud
	 4Onp+ZXv/6VxaC8ehO77vYKwWv5N1yWGMqoTpAPP4L4m3Uro9+o/X1EdmO+K8ZpcgvS+o
	 xzUkqw1NeFOzy83qX1bTkmf67qy0NHsITpTkZSMVhpnBCDXW5Zaw6z5yMz/y9Ne9oVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjvW6cAs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39692606A330;
	Mon,  9 Nov 2026 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjvW6cAs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCFC1F008A2;
	Mon,  9 Nov 2026 22:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263305;
	bh=lW7LvFHsWvzVYUMaoh46UljRlVflNwb+JdupuISiayw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HjvW6cAsMg4jSbd9P6dZrlK/kkhF//Gs83TqLyJ0F73I1EGL93jzt9c8e+yuhAfIp
	 UVkQixUfMAGipsfUbSAi6AHbgPBxkEZ7sipH3sCHxNK2iZcuTvQW6vsnejfAzxBfZo
	 HQJhWtYbKz4cu/fU4plnpSgoYgUEIdzftz1XtprP9hUMP3iC4TLbN9osjsZIkm46IJ
	 LQcD+m2FGkn5ypyVHrPUPBm+6SF++MFM+KGL3zD1eYhR0MoSf7mtZ7LBIdAJh+5ci7
	 aA0W9Qsup73F4irfCOM84sjyhWWu9GtcAR9EwFoxlpoEpxG/BVWOvup9cQRrsxnDbG
	 HIRzv4IfDjuZg==
Message-ID: <sashiko-outbox-205729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/12] NFSv4: Clear idmap keyring cache when the last
 client unloads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-4-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> id_resolver_cache->thread_keyring caches id_resolver_legacy keys up until
> nfs_idmap_quit() tears down the keyring.
>=20
> Once keys pin to the kernel module of their key type, the cached keys
> prevent module_exit() from ever happening.
>=20
> Track the active idmap instances under a mutex and clear the idmap cache
> keyring once the last client has been destroyed.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D3

