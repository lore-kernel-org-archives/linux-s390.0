Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662779;
	b=ZGPMaUEuSMUgT235UYk1CtSnX9NDikjTV65Wf4GnGaTZzUGP03fCRf9XEZVkk5RQZC8f
	 ewe4xP5nEZQiyf4TKOyc4sittjXkdBneyzVg1vXjQPwrsBX0SaCzqg37dQafhyWcorqE9
	 GIh8jWgO72eZjdCrj0BdPSGtHw9LPKXMOkhCAZJpLeCwH2xMKzQD/wVYrYWcRxzSm7z8X
	 655dTo3c4o1DN6lec1IdWF8IFJIQzWoBXWeDZl6rUp59K7UhnnEJo5qvEVOZkdpsdB7l7
	 gjyjZ3WRSp1+pu/5dXNRFKZ6O1yQ5hwrxKqKn/Buo52jy0y0cNOKdQpFRNTNCtcxAvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7rPR1p85cvydH1hs1wSICTtRTXltMx3EEwn5hogIXEA=;
	b=mZjlxjzPOhB2fWBTa7XK0PsJGZkqlyZW0QHcBT0fnbJOtQjEjwoaq5vLZCUpFMmst8ym
	 2eX4MFjNqcvX/GUC74cWi6qhiHbWh6lump39wXBg6frC+IDizAgOEIjAzjX65hLoaNn4i
	 an9UaVw5W7KuZnAAYrJe2+x719VEHqqWgqiFhi2gwAXXnmnqz4tmQiqZUVAXsFCg2eR6y
	 z2FGq8hJzvLHEdo74jlByo3zba8Q2Cpov7CZAjF+GauFOwoz7PbrT6rjq7yNI5aEiloTi
	 rDhS722/ooP9uuxWJE5V6oOUgWUD+cYJSCcQcBF74acAUmuNOAFSoJzYVvu4wYqEShw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRouk5es;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608A606A329;
	Sat, 14 Nov 2026 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRouk5es
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C601F000C4;
	Sat, 14 Nov 2026 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662779;
	bh=7rPR1p85cvydH1hs1wSICTtRTXltMx3EEwn5hogIXEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRouk5esj9Wg1wFugfQi/BQX2xQjuoAU6Ds9wQIuYTSinrihgpWJqZwY9qNBRkAC2
	 siQ4lKu4jLs2J/bCkRfV88Tg44NI6TtMqvZ7ZF4AGjcRTNwJtQVYV11h1nSwBXcvQr
	 2lRssaFIgqJ65n3qjNiNWqGpHCHxEO9T3LhkrDPWdzeQLl0rvu7E76K3/XNVSlcx1K
	 GGo2osjNmGinHOXPLt4Qruf3Pyo5hmyDiSXOvZ2dWCYz9oNd9Z8uRBvFwg7aUNe1A2
	 Vi5E4DkSY5lLkTpKo0qmqvZ94kr5lo5/ANwtvCVlaQ2/Hpm2/qJKnBlrTHo91O0ta5
	 R9ODifSAbSu5A==
Message-ID: <sashiko-outbox-214566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 30/42] powerpc/spufs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-30-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-30-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:26:17 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize spufs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. spufs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The spufs files that can
> be mapped expose local store and problem state areas of the SPU,
> nothing the PPU executes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D30

