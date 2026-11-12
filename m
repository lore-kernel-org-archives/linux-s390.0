Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457905;
	b=U6gr8VYwy08B19W0G7tbENpNyyXTMpXuUPZqrEWpBGeN6cPTVDDdcd6zQ8+b6JKlLJ31
	 KHRPV3RZp/ym/fAGSoTlamT9eF0FBEvVfgWqGzwRADx4UHAW2zRedeAS5zmQG3Dt9NvOG
	 ikgKBh1BvwLJjtNphmg5rVR4oWSA5yVEI84hGCn1Q9rZSiL7Q17ZXdFgNQqgdpLzQIjHL
	 AkTFIdW7wpY77e/b5/NJah70Ri2kFipv1whXNC3vgMxtYNfyKAGVybCth08Uv4a4wxt1m
	 3e1n2+XvpyOVkVN/m9vYR/2txTylbvvDGUdKLJz86MQLcTkI52IO7THGRWRzFKFVYZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457905;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8LeNO8Nc5511EIHZRo2LXniq8L63M6vAncnzQL6ZUbg=;
	b=5a44yCj0gKyjKEKPJuPrJH4dLwK1CQdEMYiBhNav8Tp351SPZgpBK6BMt+vhZMVt88RE
	 SvwGqw8CqMdbFaTqHi/Te3M7yHJM9mLSjytPdF5VWst7f1Y/Pm28uvYNqsemQo2oPEAlK
	 bytTO/h9AElAhbGxUzaUXPFBMXGWJ2A1DknlYTYa8etS/jOR9L5HGdmZQ2pd1Em0awTWk
	 Tips0ghKh6yfVxmjQcaj5PmOg/TV/WjZ8cOed35cE3KPeTgl1TucN/fW79XMcLO9w2ENa
	 r2FrB9QFts9v3CD4eHg8u1mzSUzXRN8u2zWZrAZeAXrQLWTZajWycv1ItL39TRRQajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfIzJ5gl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E8606A8AC;
	Thu, 12 Nov 2026 04:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfIzJ5gl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974FB1F00A07;
	Thu, 12 Nov 2026 04:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457905;
	bh=8LeNO8Nc5511EIHZRo2LXniq8L63M6vAncnzQL6ZUbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZfIzJ5gls7fRvvNyoCQKyzuAQFUTCKLwUsxjOL01s9cRlTdzWkfACO5g7D7LGt1Zp
	 79QIG77NBBvnK6ayFFo4wABsdYskBWvKxKKFWmctt/10OI8UHGF409SjqYNZbEPbqH
	 9sWuV0voMYC+QUtoz6R7Q8lM/WAylHp+hreHfjAvBXxdLV5NjNABwbJYG/Q9XDk8dh
	 ro4GT3Ja7SMxEsCIWbx92Bm8fnV+Krb5XOTGrEmTN49GKeJPAJXyE3J8H46pZcbrSI
	 6QqXvr56LAFEbAu3nrIgWLGOcfw0sSmk8BaPT6Dfz6G2Br8bw6L+rLaCSXVEaw0VKS
	 QgM4f2pXbgRKA==
Message-ID: <sashiko-outbox-210358@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/13] KEYS: Remove key_type_dead
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-13-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-13-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> unregister_key_type() no longer needs to retype live keys as keys and
> restrictions pin the module while they reference it.
>=20
> Remove key_type_dead and associated code from the keyring GC.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D12

