Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827811;
	b=0l9Zv++OVTtn0dHCGgarpK3ex0pKngSrUQf69QmwBeVLjDCbrfPhmcjDOgZ1hRXthPJn
	 1QgcE4CaSqf9uzniC1APQFIjm2pQVTSF1m3dlMR7RTFhm+KRsgq5eGsFWqInirHpLwxFU
	 WdRwUNj44fA92u2Ih1qUl3zLF23+eiqTO/RhehHIc+qIiQ2+ELKrNCNQ3cpkH/8tgCKLD
	 B0qXCxVCniceKZEvxq0UXfWs+PgsFP//c/ovxgF2tzkC+dPP/J/3/hUIHuiXbb6UuDn2S
	 hzVFsPLOsDq2fvpeLTmbWihBf+L/tBPtNmEyxpYI7dGpZhEv5gRcNCsmMOKlCph1Srw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OE6PaOVOw9XfYD2nJR42t3vGHQ1LDrgx0pA2a8PJZ6Q=;
	b=Fhm1lCP/YdiGWpbqduxmQdEUR5WC4TfNeUTW2JndibaYM8Lx7a7SOMsJa/qlcaSXNptM
	 N66vLSQ3vfVqLalZM9JOOhvmYU8gFZV3sL2QMtyOxfPsMRqtcrkshnThJICur4d+rXboC
	 2711uw6CGL5VHtK5SWMYobNXYv9ItRuChE7caTOXPTK9dOM3XcYZhlk7VovvxbgYngMny
	 hzj9/26FhzF89fX/QcedHZ7wXSCFkEitNP+3iqe13qEMNZQlUltZLZQPqQ9fGC1jRMiO1
	 JmENuhLM4NQ6zMFA5BSzqZKsiG1UqzyIwpV+Z9ytQVnYvcXd9ltQGsJqYY85ii9InrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzI1Ej+J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC43606F1CA;
	Mon, 16 Nov 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzI1Ej+J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9C01F000C4;
	Mon, 16 Nov 2026 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827810;
	bh=OE6PaOVOw9XfYD2nJR42t3vGHQ1LDrgx0pA2a8PJZ6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzI1Ej+JOnMwzotieFG46yd8wDGCsQ0sk2aZwZ/ZtD992o9xkOweBYdlgDnR/Bcx9
	 188dinfGyN3tVxK/hUEUbfUH3kk6yp2NliI9kBM1iqbPbh09m8ielnROkRjdP2BBcy
	 H73dP3orcMXLRkAGpFIqmDCwpLrQ4D2tjE8PVGDocF/GW7ZpceyQ4Il2fgbspJJr0F
	 URJBaCZX+dJPLzgL/6i3+sNb8ueLf+6wzMmpv8nE5S6PxUqXeO5jRCq8ccgN2S6N9k
	 h/MqE0JmhpSFmvcmPtBE2RRIFtTSdUPXasoHBP8JzLWWrj5zpnb4y+7pQB1j6RhRhW
	 V0evzVlqFp3HA==
Message-ID: <sashiko-outbox-216872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 13/44] devpts: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-13-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-13-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:16:49 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super() keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D13

