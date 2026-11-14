Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662319;
	b=vOSSmIDzUxZBeRRM4mzSbY6DMxJLmbQBejtqLOBA8uHi1MRpyUBLgvUvsfbFxPgfFXfc
	 BBTEJa0FLA374rnFmBOQWd7ggMUDn0ZqFaAXzZ0j/FyfbYJ9zkNTj+0hukVMNKrYSdZ1U
	 svKydEBTJIxuqnpM/TYBfLhMmgf7sJjC9nsYEHqkDRBG2+c4TtltiXB3aIFAkNI81LPDp
	 920gbBOFgB9iz0mUmCksmIhG+SnS9thilnN1H6rNydAaM72eKdN1/XlOHpQ3wfxVWvQsV
	 zBVSVdiSn2PWjtVT/i1E2OzjPlYbe02yJD335qmJI5NBS55efaigRbn2+LLnX2mSvKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jM5HIS63dIfazyLpr7gxeGQDJS/Bg1l5LybPbVO7WIk=;
	b=JLn4DLgIGSoB1DwBbO7UwwoB1JQh3ZTWfQMIJBM8oU4qyMtrxoIWNKcXXIhDfDsBd12S
	 I1FdcKGzMSly8euUAC5aaDnVNFgXF44ulrnH+k3SSXpQcOKU8HDtEVxLT3tNBXLDGoZug
	 +P7cULoGYjCMHn57wXX9+Ek5m7gMTigkBAcm0+DuElO1hDQpOFtCJSvkhIXqyx4E3RxYZ
	 luiK6EpAkGKUhS6ZVdd8GtiHtU4upKKcH6fv9RT+vXmYJHRpew5ZzujQtFDXUKemsRBl+
	 Sm8ojEo+XYrqgDZVVzGD0d5aH4+bN76d4DZHCBqZ7cUgOu8UYHPtqoJKuv9Jp/T/Csg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHq6K3ru;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D43606A33E;
	Sat, 14 Nov 2026 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHq6K3ru
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60011F000C4;
	Sat, 14 Nov 2026 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662319;
	bh=jM5HIS63dIfazyLpr7gxeGQDJS/Bg1l5LybPbVO7WIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHq6K3rul/WtwlkHdGDS6+Gg3Ma33kOysXI6/1MHwJ+t59SkyGBrCQ9pc0/97rYZ5
	 DqQ+96GkM7PBhhWLR3AYgTb7sXZBIdoL3TkK//nfBClrVDHGoFPJwZa0zhyE0fLuRu
	 9Up/idFsIYDtqrG0d2oWBo5sZkaVjOcrN7d/+ZAp7KJoL0h0OpVEMaMyTRHNtnM3sO
	 NSKh/aS/1IjGVa0cKvOQPAZlGKzQA6FIyLtVPlAhr3D/mMuGEYLqGHlQZuew1MhIbP
	 mvtrXwuqeC79RHdm1M4ndw3U0uYKCbDh3R02B2VLvsLx5atfj/YYXGo4WkVRpTrcR9
	 j0THgzMYkB+sQ==
Message-ID: <sashiko-outbox-214532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 10/42] nullfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-10-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-10-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:38 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize nullfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D10

