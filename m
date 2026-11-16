Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828104;
	b=HVWzWbjET9PaPPR3P0UfeNGqUUaAOwRawyO4QoDha4cuyu9w6rzQCF9FH+j/571slJXV
	 FmHMhLrCCvJv5Oa/wE0CwbWNzBuzk6djfqlv0Y/GkuRVZLSYwMdyZ9tOyg34B0twOX/oo
	 tdZt2OHEpw6QYXIOifK4uxWa2W8LzMXo0KbkzMdwI5hL0C+UyLN2ylJa7ppykHI2GyNu8
	 dpwd/HCsF02MmmIGCT+aES0Xrk39ro97fMD2uqTWvVBP2HWFfOpMsCswm+IRg0ONKU6yd
	 n5vDqTGIDUFFArDtNV4BxOKbj7YL6uyNLICPu7uWcGLqCZZh0AkGIP2HmDfoqDxGDkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828104;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2J+zkSlyVoLZFnBhR+TMysUj/KZwErp+CeZxuC9Fuwo=;
	b=sVseuezl4RSgkN2tbWTXxcdQ66JNyz+hzRI+G7VcnqWHvLCQPxdPOBRVha2sCpkSmCgj
	 gZWcRSugnJRChpDTPPNugM1mP9l36bjXDmE9ha1k2huO8J6EKJbUH1dL0FNFDGRc0H9/b
	 lxZs5pc2Uo0hMbui2fzRlfA/zPVQs1/JLGs0QiYJr+6UF2M8iagL19NeVOUojfKvN6Pz5
	 pwl3Sl/pegxKqq/mAqR3cwSEmxSlD8iYw1/o7q58zDuMXm9cJ4oMW+0vaHIrjyO0i2zPx
	 FY25uD0F51AKHbG74SI5csq/Wrw0Et9UActHlFgtjLm3QTbqpiwRgAdnJiY5yqams0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9YtmyHG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D639606A8BE;
	Mon, 16 Nov 2026 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9YtmyHG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BC51F000C4;
	Mon, 16 Nov 2026 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828103;
	bh=2J+zkSlyVoLZFnBhR+TMysUj/KZwErp+CeZxuC9Fuwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9YtmyHGI5UP2Okj1M5VMQ+bXp4hQOCOMCdtMiTBklG1uhtpyP2E8JmMs5S6Ue04q
	 q3HYsCsXQr91xfTQyBuRuW6Mf7LBTbD+pbHbT/A5ZOUyB4f9QTwPjTCpwBsocGbh5J
	 BqiRmDAQfF0YljpyBbnntivazk4MonI4yTaTwXs5QSJwpsprqmMbuuB6CDKSZnLXje
	 7UckcXsvBjt7dH8ZYn3Tlg46jDUVgG5kufNn9k5/m16JohRceRrLon2p9IuEJilPVO
	 8scYzzEpJmwiSasV4rqJKh5uwI1Pl6nIAyYb+nLuWJ8EcgQGfIiQyMPa5OaiJ7xpZe
	 jZzCrBhe247HQ==
Message-ID: <sashiko-outbox-216902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 32/44] usb: gadget: gadgetfs: use
 fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-32-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-32-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:21:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize gadgetfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. gadgetfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D32

