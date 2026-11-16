Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827997;
	b=k3c75ouPom00z35S9BBHc/5QlKfsUm0bbGT2Z+rh+dm37hKi6xFMue9mmkj5CnChVgl8
	 lzoFmUV+wDGuELF9ggtAMZc1annkgxDheIKDn8yN8PDLuRLH/bDAuHaBFjtfdjA4+krCj
	 BbSMtFQP1gzlRiSQPKI0MW+s6/rJsPH1Q2YZGg9jEydyCOeAEDC8SoGjTnt+gXM4Fbzj/
	 n5XC+vlLCJlLTz0TrZpHigc+jS9MqtQEWpCQiWn6pue+awxW2nXQXAewyF8LzyjDvUb6r
	 bbhjm01wrVtfLutTQACt8va/sfEHk8iGqGduuQVQTjv+8FseRB7BRhMA16jBioV58+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a8aXXWL+IjJrForyUtjpJa6x0sS0etzkCisHUemYKBI=;
	b=3UyoS1VCpkqoH26lpyDI9wOJg27w9wF4RzHwuyxR+npautXCgojAjH/Kc3KvXd0248lU
	 fgG4ynp6hDvjPdt5gJ84JVABCw35XSK4Cs+552FvKiNFZ/X4v1ctxUqhllTTfG3P1/ntn
	 4wtEYbEWv8kJWb+lmf6AyR7cusXk2Pg5f+SYU5VwoZjZQFMVpHxkFNSPmH4hTdLacvfzU
	 B9/6AsuBfQ8cEPOEV3R9+oeYh1Y3GmefHiZLPpJuWRZksYRvgoru/kvy5MuAfxg6R/UcM
	 seS5o40tfbARtz0UT+m/0efzZN1Hhtw0DtR2acurUKe9rWwOAStIizWHnSbzf5JTPfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAztVMvE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0C606A330;
	Mon, 16 Nov 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAztVMvE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B751F000C4;
	Mon, 16 Nov 2026 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827997;
	bh=a8aXXWL+IjJrForyUtjpJa6x0sS0etzkCisHUemYKBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HAztVMvETAjQ08yTEArwmD5Ut0MlBSL5ZDv50gN4Bl18khyympdTM6q18FJDx92xJ
	 zi+tyAw5vjn/H54zAfizspz/1Q4Yc6Xv+NwEqcBOnmlQ42NeS1DZoaDFUuODzu/EOk
	 Jfh5SsT28ZmMWqV8xTB31Xa8Z7ILxmKnAA1OFil7QMslMqx7ohap+2//GQpGCIPMoY
	 4Q9wCjnflqEo9c3a7BP8evqxQc7Wj57pdjD83xG8Uuu34TsXf+m0Xo4A2n/EKLKk51
	 mqvt1uEEpufafOYR9zujlWAddVAMZtKu+NztQz9PxLTtPaPwFHw7+I3dv8udIMYs0f
	 quVmSBhpT6MEg==
Message-ID: <sashiko-outbox-216889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 20/44] apparmor: use fc_init_pseudo() for
 apparmorfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-20-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-20-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:19:56 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D20

