Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827907;
	b=IxVBZ86hN3XAOi7dLliVmotuJMP4NpKzvEnd4QKNqbNLL7doxuXiQyNBpdQUasvXjyXp
	 VF/uxpxiM85RYF3QKehckvUjYf4o7GXA6GmcAyZd9UgSASXsLF97txbv66XOeQ/tqiuFd
	 jsa7ymXCNtCZbjM1N6mhv1p7SZv+TR9+eKzHNqFM2IlTFQ6Ave3fUe88SlUY1OdxPK5PJ
	 HqtHzBD9gUO2GbRmD+W9mlOID0ZGfP2zBwqOTGuDnv/libJ13BQ2beldh4JbajbRFl/CP
	 CNynsCCO3762iHZCznuq/tJJoqxqKXUw2h3DAhqz5jU7dnxG9tDx27hvv/YqaTbnsKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GM645HGkSnZRitYenB9XsDlJQhtktwOGcfE3lPZ7TsI=;
	b=cBWDMy1VbxkhcQ2RJImc2Dcdsnw+LClxm9AvHWc/ONB5g5Aq3VZzZdDlLe8+dlLsjJSw
	 5sUehrYfuhzvIufzCmrdYyHIlnQZmgJDFqJz8NT48iXYUEu6bI7Yi0tazj83TVLeCRP2R
	 mZodm2AdI73Faj4obnpViT2SAhVkIbArihJ197rGSScqh8TPz7qM4SCVitvILkupe5ZR5
	 Mvu8K3plTCxdUBH9UwB3nSpx/rdAYsUi/pmHvRXOCbIY0IdYFXpviAiNshiOeJaL3cH5C
	 RhftK85IiVccwszZMujX08q8vElDu4YY35kl4PH9ezWvAzELdBIEN3nwt8hC/bn5wvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGrN0X+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01A60703DA;
	Mon, 16 Nov 2026 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGrN0X+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAA61F000C5;
	Mon, 16 Nov 2026 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827907;
	bh=GM645HGkSnZRitYenB9XsDlJQhtktwOGcfE3lPZ7TsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nGrN0X+UeeHc4wIjJUZy8g3ngMm2zsJ3ap4Mi4GaGMGw9WgEQ9Oubb56jMs0Kl/i4
	 vVjkw5PXD0rinMxHrLiwCas65RQT6VF5Mq6PfUDWI2T5ol1x1mVecbRh3yOpFPedJR
	 jgXMguNoLIndx/22s58dBBhvsIEzL9qp9bUvptIyJBvSAoVdv7sY2wJuvY+1aK3+rL
	 +0hff0FIY52dvQW6jgodbs/G8avrKHWFDfLobHdL/y8BSJsZ6QZiuzYR4AR3yhEBzP
	 Or4oNDP4t4/J4XTu9JtRUegTg5d6Le86Y8Ko49aKi1Ub3iOFYyo8rPmUueSzy9jdE+
	 TazfDKCUgE/Cw==
Message-ID: <sashiko-outbox-216881@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 16/44] configfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-16-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-16-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:18:26 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D16

