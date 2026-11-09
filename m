Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263305;
	b=h0i9aotWI2dS4EDYPj7wBj2VQAn+qx65GwXgwbywl5lMOp3620M/K0m6RybqjqtsIuVA
	 LWHTuCD4dtQdjSpEYO7ao9aXxcP/FnjRuqKTozL6PBSQpSF93OT0urYT7JY5oB6YBUt7g
	 W0YHahJZ+xl3buf09jxTR2UPlSLPyNcF2snAGk2foFol1HsGxkOIVIAYLsm1b+FYcA7xI
	 i6jkaQ3Cik9+UfLWc6tKwn1xsFD+chfNgeGTJ1Sf5J5z/eF3ejxsHVB93d9CJYOhGZFPy
	 PGh6/ZSdblAeDbJ2nWpuJDGgvJFQrNLwYj8EVstpYBLmynziqxMveK7JVa9U1xuze6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263305;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DY9ITW2PfNjFa9RbgppBtq2Pa/Awklt7s2xnqyaXZh0=;
	b=PM/LSSfTXHO1k2CKMEEIaShvGao+w9FwexO20kGATK8en8Df+WLmp3ku1eraEcUOP2tM
	 yvXa6dwr4lClBv2NiWEqsxjjQ0WH/elRd/B6A7p4FgeQpH8xBrRJ6a1cDRST6xv3bnaXp
	 jPTRnBWrZk8PX8Mxu6H1xuRm5EGAu+t4H4+BLlggwBGn41MP7bWYDJeUAo1rCcVI5nUKT
	 2dXVLYGacfO+ESjiYBEqUzOYESfEjozE+wGOgcYpHbHJYlsrc5J9ZDJIKkB2kD7yuMdZY
	 oSdhMKL1xorYxpga5wpDRbKFXcAYKF260YnBmeXjtUG4f5w2SUJlOpxWPyEAKNahg/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J896idHo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C1606A321;
	Mon,  9 Nov 2026 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J896idHo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0CD1F0089F;
	Mon,  9 Nov 2026 22:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263304;
	bh=DY9ITW2PfNjFa9RbgppBtq2Pa/Awklt7s2xnqyaXZh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J896idHobKJlC9khIOlRs0lx30AA+r+5guSnFkhLlXQZasRfoPQask3YpWJP0PsZO
	 ZDF8/Njaaryakc/L+VOvsP7a+DYfJV6iqSl7Js3WgyGa2oBBwKEYgX3qFBxsIfyn3R
	 JNh+kEgGCQtzd6C/LzmF8+XKu7SMJXdrwxT5sN2PIUrmUGIHNB502xwgNBRUbMFwIr
	 LhZEuMLqJTNvuV0Xho3JaDlxoc3iFQS/lt6xjfEAcZABs95YlWsnMZPSHJHQKkFoaf
	 voK/Uy8XSZ1PgW+dV4xVy+j35yDmagbVmS0zeiEOuMpW6ptzmlfH8tRDO/KcHbCoXA
	 gfRY6K5avvJWg==
Message-ID: <sashiko-outbox-205727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/12] KEYS: Add key_gc_flush() for draining RCU
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-2-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:23 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D1

