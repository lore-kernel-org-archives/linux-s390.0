Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140949;
	b=FKQw6l1a0vX93e3i5S3o20tPI7brCRqWwtxBeA2VXPHaGlXYXFc4cRUsjhsAEhO55Zup
	 N4oksLzoBSgzdJnz7vLYCtPUX0jpiaFSjxaFLWPRDHwaF/i/Loq+dVANkwOMYAJL83zAO
	 rP2hWzY8Y3qstngk3o0RnBabcdku06a3yGy0mcYIM0PslYbSrcJD1GPFfyeFZzCayRjn8
	 aEj8ldOfX9vnvbbat4QaIRab3H30UTREXxYMmX12WzdIz9zrqo01pnFGDmkjn+T6Ph33d
	 LsCqOzXhKd/rW5Hu5JoXzyumME0PlW+iUhYr4PJwCErc9DwERpdQsxTwbg/XuYx7rLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140949;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gp6uC/n5yBazVfPq9/szWD69XAgKFcosax5SlSX6k5s=;
	b=XTbgHdxEBofYMPxxM0kOppvTt2C31ZBGSR8KuU3Atl4cX8yS+X9ORuWn8DtpSVJMYcpE
	 VsK/msF1xLPO2qtwFfeO5Fb9F3PfG11+nCtxAz8UIk0HpiZFPAFvOSKqFVyWMoJcRYo5s
	 lybBEeT06D8OvhH3gYwG1ezWOuwxk7lMN/54CTTTDA8Tf0Sfgr17TFmep8ieqKAYhWLpu
	 oDu0Wvm/Xcn9T2Wwe6GbEdwqngGzCzxxccBKIhyNuYUh6Hz6b1qW5HqC+URLP696jIOP9
	 t+VEph8Tf3mLDLxTDzG+mTi9ukpvjVfdGuKJb4sWXa7dirWVqZRXaG9v6cNLdDJHaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNhMba+j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0647606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNhMba+j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F5A1F01825;
	Tue, 27 Oct 2026 22:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140949;
	bh=gp6uC/n5yBazVfPq9/szWD69XAgKFcosax5SlSX6k5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNhMba+je7Ab8iE3oW+KQLm+fhpElrK0EMQDVoJr1FiqVmJQF+obHhyoAw6sv1eaK
	 e3Qoqc1dDTmMZUNj0nCYIxEqg3WKahLX71PpHG3YgLvYjjNbt6LitzNIAeQAZqeuyW
	 hzUgQe+KiuMPctoRxd+avno4Qq3nvNbFhQcBJVlBFTAoYfCwYSTa2JNwhZxG/8MnjK
	 6ij1rsoPIavyoP3JsBcW8NuVHNyUaQGnMO3RRQ3fY4YuyW3aB2u/Tyo+I3Bk8couyR
	 1Xm5t4OZ2z3/C9UhDhYc/68grhoZnDAp2GtklyDP1/58J3wcOso2w9zLGMQQ0Syc35
	 QMsl8yFyNlUzA==
Message-ID: <sashiko-outbox-187172@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] powerpc/secvar: Add missing kobject release
 callback to secvar_ktype
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027223847.652884-3-irogers@google.com>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:42:28 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> In add_var(), a struct kobject is dynamically allocated with
> kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
> sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
> However, secvar_ktype does not define a .release callback, which results
> in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
> when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).
>=20
> Provide a secvar_release() callback that calls kfree(kobj).
>=20
> Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via s=
ysfs")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027223847.6528=
84-1-irogers@google.com?part=3D2

