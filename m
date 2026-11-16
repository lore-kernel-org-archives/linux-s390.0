Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828022;
	b=JVP4A9gU8RLOmHRtDEIdjSzlsWyBRAUSEitXdtKqdjLE/Z0YBIqgso0URDi+lV9ZgNfU
	 iK+hY+0fsrsQ5dcBSTDDRIQO1Rtvt5ZkNiG5I04Shy4OwN7pgTaO7iy05qvzz51mR45qF
	 zHkloF7Pd4ZmFMsMCgZqakaf5SXmf/Ejvkn4wA0Al+fflB86+FJO2C5BpCSDZ0gFRBLwv
	 B3Y8CxBzaorozba+ahD/B6Hf9W2pqdz7Axx5MUnoM73fbV2UqJJPVMfJJD5qsyP9QKjfy
	 9CLRLE0wBdvSmcvoMWWC8KKc08mlh4d+9XOob3KSebe+jbn2u6bGPlyhK5y3k84LjRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=czoh+c4ignseMGQfCwTnUKbqDtNEfeVlm6iHUo3Ytfk=;
	b=dvkV2wiDVdt62o3IIpFj/x8YirQnEH1qk01MT0m2d/PWjNzD90nqwQ84wgPsygXRSjr3
	 3b9I6e0AS41jbwKL3nx+8S7V9Hbrk0QlQq7hOMosb7GWWErBhfxohseiX/DgdMnSzUUGG
	 v4I4FUr5PqbvOqYV9NsprZfStjPZoEl2gsIcP7M/d4mAFzIRpB1q9jSQ0cIyrLeHquf6u
	 /UA+BilitX07Z+bNGW56nMofn5++rH17UBJ1oZH7q+gWq4jvP0DY+DjFYuS4PaH9+Ui7a
	 hjGZpHoIJDQgLGI9BOgqlUkc5P8Z2meKTHh+pUOJKQg8RB+caz2hBobW+hr19Dn77mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDNYVE29;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870CD607101E;
	Mon, 16 Nov 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDNYVE29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8643B1F000C4;
	Mon, 16 Nov 2026 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828022;
	bh=czoh+c4ignseMGQfCwTnUKbqDtNEfeVlm6iHUo3Ytfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LDNYVE29sIWkr7GZNS7syEad/6l0OFJW5jQNNaeYi7a48rRhnpiUG5HvQBLteg0Ux
	 SSGz3sFJ7C8vM3bD5sF1WG0+QzNP2Ex3jWkKPdhlkgg38TuU4IBXhrOy4K+uljdifZ
	 9/6KMXoea/bhz3OKGGgkX9LGTCgCi/K6lm06rUj9rm3nPvph035P1DPqLV+lNuD8SK
	 mNBdnmbGeFuHir1KPxYdanrMk1NdK43Q8HO+ie1E1jRc1VAMNypwQOJzj7dJOqtBmJ
	 tzKdDcOOZGVryWNcp2RaW4LG/9Zk9iLn4KUwYRAbTMJqdPfG8PraM08ICGEMfMGboY
	 8FL7x2GSqtPGA==
Message-ID: <sashiko-outbox-216893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:20:21 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize binderfs as a pseudo filesystem instead of raising SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D12

