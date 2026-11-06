Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926453;
	b=uCp/iYEaPIriHRRbWbJC33j/L71UsrerRwjhMbDBuYjyeyl4Ge9xJdnGhkRgK6GFKj4S
	 XvZz61+LCh4V6HM64IvG8DTwbp6Y0L8dczOS4efQvDhAIVmXcv3EXZK5mmBCwFfg/UHLa
	 sAhsHSPkr45JcRJf3l3NUhK9KhVOhe4jjeI0JHl2Ymp0i2aiwVTvytQf46Qllnep14U68
	 Y9ThiFYf2kXphsQ5vKUFgo7+HQyh3B7iLq+JkPjNujeZmuQ4cDQFvygu1nvo2wpeB3qGN
	 cZAFg3FvhzwROkIFMSgmweeZZwYqYXmQz9GXTIosGS2KLmy5GWzIy2iQauQ2NGynq3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eLMqWZ5zqX5yn9HI33iCtD+6kEC8KuIRrsN9qbOhCk4=;
	b=yQk21tLMLNkjj//JwWlfk1yxPwPPSKjcIYeMbLsoWY7WoSA5Z0xvzXv7sOVNUVAwU+8v
	 FPSVjHtjEXgSh2h7tf1Pijxh7GqebXg48ycFhOyImThD/lycYw8U74zgzECHqiTAjwiRO
	 kZatlVATLLwiFoW3jReWbgMm7kgcP/pezbAiVBwXvo/6b3qYR5kMn4uKgfQzmOWfcqNPL
	 +tCTMlclhpR43eJ96lVb9ZnsnUGxRU8m34Xlt7zsYlVVK3guMLujnbeHzMAaQiymwQcUf
	 huXPXfRMs1xxE8j3CVx7c93H6/0SElwvXQX2hE23laMI5nYcdWlJr2xECtYf+SZNlAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpWUgC7n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895D8606A32E;
	Fri,  6 Nov 2026 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpWUgC7n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135AB1F008A5;
	Fri,  6 Nov 2026 00:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926453;
	bh=eLMqWZ5zqX5yn9HI33iCtD+6kEC8KuIRrsN9qbOhCk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MpWUgC7nDcsaiAv/LpeHmub4ky4VnWLMo+XkWNvKgM3QNT1UH3GiIKWDuXrco5XyG
	 +0O+dr16yL2bmw4sLtXVkGt1xi5wm9qO9qv4mSXup/4MUfYJZTsLRhert4WZNFGWKZ
	 wRt96jzsrWfJVXj5eWk9pEAbKn9EokqRUeoLStvuIkKZCYjCNl7nUQr5jGbBrVpRu1
	 JxzMMSDdJRrRXqB3M2290phxcjadkOjsFaePr4V7Pt+VxPeRhzARCnxNNVhfxIZ3N1
	 k/KcR8sX+oa1HxMK+E2ItoQxNOFszxrc4S3MaTyO872IIB1dq+cJfhPf/6fRXSXO/F
	 J91i6HfxEWsKg==
Message-ID: <sashiko-outbox-200465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 10/11] KEYS: Remove key_type_dead
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105005311.804098-11-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-11-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:12 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D10

