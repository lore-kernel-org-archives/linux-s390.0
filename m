Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926444;
	b=hGNPGDkjseGGNpux4UFqoR22xBr5wSPj7YRe2EkNIaIzGxKlLOvHGjDgA7tx8Vw52Nfq
	 qXhNlsbSYCwgFUvWrnqXS2mvOtvtpeGW2n8gUjbRphqKt49ai1iAEscuuGu5q3itPOdnJ
	 jQwRouA3jcF/nVLLH8JlhmICCnKlRHw3gZLPxkEoEbSZdDNTXf2wpv6+jQB9lnoUfzu+4
	 6WoMZ5maHk6/bfK+V77r6QWM1S1yVPQ8qp70t1BfdRJqth+p+N+BvLTr6ItSCRCc+krWX
	 oor563zx4pOAA/LHNkT7Q4dusk0DLiSa355K55xTLInmu3dMR3dDCKpcTiANvz729dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926444;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rouYHY92xNkFd4x+88QX9zYJ/Mqn2MU5VBHqaRikNLQ=;
	b=BCxzd08bfvJyc8llFbgWq6gAvmGo1ovYqzkNl7SGfdjpwORVHPJTFPjFn+Pf3hFIzgzt
	 6bY9eNFzT8Vk0PgkxSBYQt0KL3zhHi4TVvIthKfgnkDYHwbYOyltQNRr6E9O1l7V91vpW
	 UWgIUCZgbrUqVCmjRhmjha7XzMWktgnAXa8i9bRgdz7/F72qyaOhTcCEVkSCorL9DXkjU
	 9MFAJYJRyeUDhr5cszr+51EzjYZE9NrFIe/FAJnwKik+9FXHOTGfh6uG8N9DQx64AR+db
	 eKRb/8HuyfyZMZ8pmAiei/yKvD+nAtzX4rfIDTgiNjujLzXLHpM7r25FZw5xmsK0btQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuNFYF5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA71606A31B;
	Fri,  6 Nov 2026 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuNFYF5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFFE1F0089F;
	Fri,  6 Nov 2026 00:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926443;
	bh=rouYHY92xNkFd4x+88QX9zYJ/Mqn2MU5VBHqaRikNLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BuNFYF5MZIvaCXib+jQ7prt3pPMcy8I7vBakqsQiqiJot9LuY7hVKu1IN9F6GhX+T
	 AIfK1qMDYt6uA38BTNEvTbOQsFBgJWVzUmgiYp/KYk+KOE+5BLexB4/2vY9ExmdeZC
	 kctZRFt+PY1QJKDoPY8fS/tamC3trc78G61tBXOrrtajDFIwRbS7K39TG5BC3E/va3
	 qlohfAiSPnQQgJlRjvb1HZ8t1aCFi64LQpaTPA/gHF0zX8j/0WSt/2/QrXITV2yLph
	 e4FGEV5+WCMHN7QMoAlAq5R9m4gKCFrSaFkF1WlpxH1ozp3T8bR7hAB1YH8bd+Poke
	 BsRuxJ5ux03PA==
Message-ID: <sashiko-outbox-200456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 01/11] KEYS: Add key_gc_flush() for draining RCU
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105005311.804098-2-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> keyring_clear() and key_invalidate() release keyring links via call_rcu(),
> and key_put() defers final key destruction to key_gc_work.
>=20
> Once keys pin their type, callers that clear an internal cache before
> module unload need a synchronous barrier so module references can be
> dropped before delete_module() checks the refcount.
>=20
> Add key_gc_flush() for flushing the remaining key_gc_work passes.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D1

