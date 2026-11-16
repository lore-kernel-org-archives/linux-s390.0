Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827908;
	b=l5CFjtTdLr6TzE+j7InP+LD4g2wYFZPxWcu16+YVqJk6Rn5m8abO/wWUVmGO7Wk1Sz9D
	 gmShlScwyCTtXqCtk5jgZFEGTzNEB85+5W5Xvw8CzXLvEBBO2HxsBTJ2ffnYOGo2dpIVE
	 133ef116FngNeMUS0CIWbkwW+Ih/PcN9cNGuL76wMOvZ6Keh7FkhVNlqUX+zCwrduv2k1
	 3JgfUzpIboHpZ0H3S3LZHu3ohtZOqGmgt12dSzfWZ3SAVIks6gmNEaFqsqi3yKWDs8qck
	 Rz+Gi2NlGlSgS8khgB9xN/ZP8VBYtz0aDmetqviDg3v02kwPVvXds5i7TK6uYkstc1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827908;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VroXuZD5u89/TC60Hm7TYZkGQdmBz+hLrnYKNRQ5jM8=;
	b=yQro3IBAhUaZNwuurQEqasoqi4yEAZywcdYj0uK0aCraPPZtN3yha6c9oOYTrCYlwLP3
	 ZLTX5kQe60RzkA+GjxxUgoD21NL9gXy/wVDqMZA9sN120BxxIg71oXL+i1lqPHbNcfl8O
	 cDv/m13Oa1jdF534FbRYbA6r/tWxfQGcumf4V2NoigFU3KOpvmvTPeOqMHNAU9c7VOBHO
	 bpSHBRTEZKOM7zk3JW00lBT4Sn/C9D3ZYpoVCAPYGn7jkb4FGiCFrYbhMi2/Nk/B+I2r0
	 emEU/yFE4tQn00NJq99CFZJVK1prRhge7+hF3jWWQPpb6q7/GeVrMwFzNyKxufmEgVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YAJIA/bv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8FB60703F0;
	Mon, 16 Nov 2026 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAJIA/bv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896281F000C8;
	Mon, 16 Nov 2026 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827908;
	bh=VroXuZD5u89/TC60Hm7TYZkGQdmBz+hLrnYKNRQ5jM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YAJIA/bv+I2pYqA1sPd6HGUqwNbIMVXBXf0F4Bn6xYfXc1cvVGbe6OaTR3IZCkn8k
	 45aGPq3BwOmpBzhMuvorALyZf0UCSvKZQEobLiiGDVdYOq/lYPJAbkTC+JguEdATbh
	 mOcS37yrpwG9DhjjM0PXWZHbzWJVJ9yg1nQVAwjNaOX2o/tVB0CQ39fQzaM9hk2Tcc
	 ohRoWIWorDVasTOscVxy9tT++M7EuFnKLXmcN7/vGHkBnhRnncreZg4EcrBtpkEkan
	 gmhSCE38h4/Xdak3i0UIt+CFHsxpEGLOfQjvfQTonvdKWL7l0AvdP+VHwqQFGGLwhF
	 /Dx9lVK7SgAlQ==
Message-ID: <sashiko-outbox-216882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 19/44] smack: use fc_init_pseudo() for smackfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-19-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-19-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:18:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize smackfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. smackfs never holds executables or
> device nodes.
>=20
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D19

