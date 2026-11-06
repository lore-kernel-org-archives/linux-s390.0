Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997222;
	b=0mw/mFbr95n1EDCkiA6My3Gt29+u/sxy7M4G+EE+3d6YEtGVxOrltb+FyaWSHpaKCMbH
	 7croB67XbpuOBE7/B1n/7qXGQPjDm6KbR35t07PBoEaSc7yxK66T1/Koj0gGaO/ch6EMQ
	 I0G39VtGQCi+wKM1S2O06EphAGRnXmgK3RmwxUNG5Du8PpzwBOOmQvwuBjKYa+iLCDJ61
	 DHH8fbltGPNqGtGMWp9DbLkrx9xAT6+sIPHWFuIHygjN9nlu+GY8bYEjXzx0X/O/+B0b0
	 RSosZtlKkUvvpuR8u/Xr2I4I51MLBTBkPh3ubkd/sVK+B6zirIHevbkA7pA1bK4ZkWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997222;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ix5x7gyIRjl0pRmVCh95u4dHZ3L/vRBBw4y6ZTxhHiY=;
	b=Zy0EizjhEnwE+YTJZPyIKZdcopqElmwPtcdBldlZEk1RE+RiqPDhup640187d9Pt9Vwh
	 pZekKONRCM+moA3dYb3OlibJff9y6A3X7gP6B+XtO/mKhEprOz01j2qW/DZWK8wFWhpY6
	 9h1fQ6Wk7OP8uWQQ3CSd8WVrjJMoHhnt9MxF/wlm0qQWQrdGa+p5ZFi6PTpNMg7QBE/Fj
	 rrPuhxO30eiPNw1FxBpvjOtkJhWXpdH6XgLsnG5pGdC1OMEVxde0HxwTNLc5P30w+ST8D
	 Jn5Op/om90qQVCyxLCZsER+UV2wro+/r93QFUPtNf7PX6MpkzC7K6anwalrb2VImpCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiu4HzXs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36276606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiu4HzXs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDA31F008A1;
	Fri,  6 Nov 2026 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997221;
	bh=ix5x7gyIRjl0pRmVCh95u4dHZ3L/vRBBw4y6ZTxhHiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aiu4HzXsvP3s8X4x1zN/4+CXQCG48tmCPlLEHz0RSjivYFE3yNM8LYUPFDRaKi+I9
	 0pYJmdzWY0F77ZC8cUUyRwzF9w2CJyNkR/wi9+HqSSFXcQqhn3fp+RswpI4isuIfBz
	 GrwsaOfMZPEHXagS7H/Z/NlIn3UWqmAePSDrWjDzmOrvpRs5D1RfACG6Exm9d1x0GB
	 n0uTzYSAIi+FwzZAJ+Y9ELupliCBdQrnPPBvKFBBJtry4kCIjNsd0VxfkXtp5z90dn
	 D3LURUlXHB8C0izDNeZOrP9FCtrU9YkJ9sqOutChLDCQcUaFXpw+xBtb1O+z645mBC
	 mwI9OcJeGcdMQ==
Message-ID: <sashiko-outbox-202223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/15] alpha: Define entry point for
 set_mempolicy_home_node syscall
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-10-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-10-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:41 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Instead of explicitly defining set_mempolicy_home_node as sys_ni_sycall in
> the syscall table, define it as the real syscall entry point,
> sys_set_mempolicy_home_node. As per commit fdb7d9b7acd0 ("alpha: remove
> DISCONTIGMEM and NUMA"), alpha doesn't have NUMA support, so none of the
> mempolicy sycalls will ever be compiled for alpha, resulting in the
> COND_SYSCALL() fallback being used to result in the sys_ni_syscall.
>=20
> There's no function change here, but this step helps to unify the syscall
> tables and create a common table to rule them all.
>=20
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D10

