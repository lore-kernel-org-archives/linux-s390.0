Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263307;
	b=kpe38eqBh9n6PTET0gUlEy7GyBSLW99zie40ebGWUi2bO7J0Ys87O1GMsRTgFcRtpGYX
	 ZjP7zt/dxe/ja7RNrfcIUbjStlCMlOVBF3O68/21xioMN8KCTZFXVPgoKsHuP+W0mr3MM
	 qKEc8JewJjOXqKfT2axc4LjHrDsmOf0TF2vv9jF+NrSkZaOvporKCH+jnyu3g3WaNVG3r
	 qkLIfKUnDXQ0QBhAoJb7adp5eSxng+6uJ6F414itEy+FYuBvoIB3YyPpF9VOhJyOQ6ysn
	 9ppHiNTmfwv8DwNysX7cUpjebNHPUqXaouLwdgI77Lp5DOcl1VK8PkES6OF+PlMXv5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263307;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mxg3OhQx8AZoHSEYn6KyNWNluukwdfeV7gmGGuQfzKU=;
	b=oJe5cAgKwd8CaDt4t/OFwAPue+2MqLlKHW0VQwiXN1QzdcIBj+XiiU+HGOyEGO+i5Vju
	 MUozGgtApuwxAf17H2q3wbNDbwSEHZYqEPSv7AkZe/YtOC4MFdQWidT8Q1UOE/BI1UWpf
	 /T0yAdKmKCXAVGR3kW9XibI4kp0/T+ys1hATwwci1M+sHdAEF/rScCF3B6zQGO4CDaKrl
	 OaYrYDTLics/HJsw9AVyvheK1BJeoxaKRqy+zGZVhEqTDEdWkns8ua2nb2HvoH5aMH5rq
	 v0g0ISr9OfIrRzUBzakdL24hTBh4154mISHwR/mtko4H8WJVDf0rMpoesb/E7OuSi9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0RV0XHM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8AA606A326;
	Mon,  9 Nov 2026 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0RV0XHM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D191F008A1;
	Mon,  9 Nov 2026 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263306;
	bh=Mxg3OhQx8AZoHSEYn6KyNWNluukwdfeV7gmGGuQfzKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R0RV0XHMr4V5PMmu0h9ODlucKr1rpT9knlJgWwjZjvBH50jlpWChNB5ryHXnbxreK
	 mthBX16tvfK8NvISYUzvGONL/Iuy5WtycYtPBfhF0+tsvE42gTJRQs11tBOPT3XRHw
	 0/a5xDFvE0KkCFt3NvX0mGvfR/4HhVXgcDmmO4fmomGNZ2a5WJLRAdZK/DqDbE21XR
	 6PI/zfDcIaa6ty+p5+pZCpquSU47nMvckBu1/ZqCknYtM5iMHS66LlBA/fqPiQ10V5
	 a5JfcMA/c/7YakVea7ExU7gTbGrgzt3UnxD5575aOu3PJbz+2ce1SaZovh137kO2Dz
	 gWwnCWivoLVIw==
Message-ID: <sashiko-outbox-205730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/12] smb: client: Clear idmap/SPNEGO caches when
 the last session is unloaded
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-5-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:26 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> CIFS caches cifs.idmap and cifs.spnego keys in the module-owned keyrings
> that are only destroyed in module_exit().
>=20
> Once keys pin the kernel module of the key type, the cached entries will
> retain CIFS pinned after the last SMB session has been torned down.
>=20
> Serialize the session count transitions with a mutex and clear the idmap
> and SPNEGO cache keyrings when the last session is freed.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D4

