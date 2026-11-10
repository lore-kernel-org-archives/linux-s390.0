Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302737;
	b=KlAOsJibreqiuZvP0x9ZZQxvG2aF+5jEyzWKoifFSmDXLGgPvclPXxja9fIBdARNr//4
	 H6+9N+r19dSEuJMcMRZ0QQHM4W76c11pS7qvMkUkqSkJEr+wMrpBVnFpY9uFyqcIekCe6
	 tGl8At9JXVE/VSEHA8nnA1l1rk+ghDr1qMPBoA7zxSh1Lu+Mh+tdFPmCRb9EzrX+B/2tC
	 AArRs1c4XXm+Uq9JWDVBznLx4j1c0bngXgvf7NaQ5ajjfG0RmfgQ8E4egYIJpIvw3Kgho
	 ENBwgQ4Vbp6wt9Ib5jq3WDGFTty44/SbTpJhWovtBlQS+lRW2ZSFiu7W1YhxI9LyiZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302737;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ei0Nac/7OpJT3HJNSHolBFGJUc5DhDgjuYGi2QWDpFk=;
	b=lt/lmdHD42D/GBiWI1EY7sPB1R3FjRqgSZJu7QwdHWDiPX7cPQjZXfXC008ZSuN+w3oi
	 KqCRyB3KjxmozGbMFTD7SlBXS32tFV0FXTneM/aIMf8kH4Qw5dp4N307agFYZZTUMXcBs
	 WgVs/5Hzs49sxAO2XehwcqeAFuKGQwB//nJ7I7GmCzvoHjJgVp9ts5R9NqOOQ0yeLzov/
	 iiJgQpGQCr3HgQys9N3e1nhyrUCvjea3XHWP4b8a35ZWduKIvMUvNzGD+r7P2DMfnhcBR
	 8uUrZqrlytMwGEk6FRV60hR5pOn0xuy5gRv3XfRY6PSZfaMQaqtWMEhlYBLwC56Yl9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gea06Cjd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D02606B2D9;
	Tue, 10 Nov 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gea06Cjd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203701F0089F;
	Tue, 10 Nov 2026 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302736;
	bh=ei0Nac/7OpJT3HJNSHolBFGJUc5DhDgjuYGi2QWDpFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gea06CjdTAbxuMqRBOPp/hV/PWBhpS9/lyqAiI5MvEu692F7RzBsOa9iw7KS7hmX5
	 7OjNbIXVMo1H8rLmvc0EPzFrQLWLznVfMQQw6G7KPogUM7Pz1rKysCT0VkUnSnNAy4
	 1pibEqJ1JvnBVmRQU4sR8QHf1BZRCviCBlAEm+8gi7bdND08RnCiXt8x58DbIgnCoF
	 Y0+3YYCB4RoMLIOYAZnqUJd3zq+HYO+jrhGm4PZKPO1TRtOcNj8PWFd8/01t2qZ2df
	 d1qykVQm6NOByLn0mby6mF0wgvScRUO32CRR7vI9JySxianyW4b96aqDjM7+1skKF7
	 vlgvsrRmM0gqQ==
Message-ID: <sashiko-outbox-206740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:25:35 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D24

