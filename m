Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302595;
	b=1g1RsRD36d2B/lju1ao7GgFj0M85TGkWTQfZ9afD4A8P9VAkwHx7B2WgF0ShvF6gCh35
	 /EoaxADcA2dtjtqCNt+TKO0Sl0RORwECs6lNAdFp4uLZqwvEbW8+dOA0AZOjz7KVUsb8c
	 c9stPs6GMNNi6SLCdfdeb3fO6mITbay3RI55e4hcxLntK9fVfDgPMcfAO2NdZ9NbC/NiQ
	 LRKWiZGiUFI2R3pJOh0leWKCDHfRFWEmG4NRUqc+WJ1ldVhj7wjekUC3zieFVlW2LQod9
	 ZtMqbWWXJmkjMJ23nRZiy1vNnLFzZlgfAxngRT+uEldnAO58guOstWxjWX1nkQDMk6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hBZujGA5D33C2SUOFLLWw9cAnCHubC8waqoDlHqySSM=;
	b=jGs1//v3foO45Zql8X5wInBgYP3HTHKW1dJMZj5t/rJZkCgQe4ASNZ6BmllpkDkOZ+4w
	 7K6xUuyvuGcVmAdjySHD8pogMJLNu94fPjGmN3TyITEsLRDht0UIHuDcl12AdSwEhws1R
	 7nm3jcRXoh6RlguLHrbzuKPoxjx72pizOAZ3VUxJ9+YgjwCBLRy7qAUU1wJbAJec7hv32
	 AMbz7kPyPSuiEjpq/U52x1w3P2hJmHwsjn0xAi9H9Uu8PtsZM87Xtk4Ys4H2rIqVu3kmq
	 XA1pcfS80T0V8Gz6IsvKuSwx3GVhTep9q1PWqN4A6L2wU1opGj/E5NTnmNK0aNu8+Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSPhmk1M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC0606A98B;
	Tue, 10 Nov 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSPhmk1M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9E21F008A1;
	Tue, 10 Nov 2026 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302594;
	bh=hBZujGA5D33C2SUOFLLWw9cAnCHubC8waqoDlHqySSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSPhmk1MLUWqeVurY1BYSp29VnaBWzqXW1COIQxYGJ1SlIzYZPUL9E80DJ3zpth+W
	 uio//k8SOT1FuPKrq/21OJppN11YvMN3cJQymGgRvb+6WhV7q38arrCH+/poTOq5+M
	 U04/F1cZU+i6X65BwG+l+aq8Yn4ShPWjWeC79VUWCNWH5hmxsLDZCDypvwHkVFads4
	 MHhlLO48jalAIq4owqPSV9WtyU5NvTkDZRVHb3svUptirT5JtA3qCN4LYCvtjOZm8J
	 E++due8ryHdAdm75b35EpwkQYhhPno/HlWJY0fLa/Fg+bmgGl8hL22e971rb420mkk
	 ufGYc6ZnKsQpQ==
Message-ID: <sashiko-outbox-206723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/41] nvmet: check that the file backend supports
 ->{read,write}_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-2-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-2-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:23:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The file backend calls ->read_iter() and ->write_iter() of the backing
> file directly but never checks that they exist. Everything that isn't a
> block device ends up in the file backend. So a namespace pointing to a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such files.
>=20
> Refuse them when the namespace is enabled the same way zloop does since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D2

