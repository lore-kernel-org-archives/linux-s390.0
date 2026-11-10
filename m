Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302781;
	b=CEod2HTV5uWShrIcf9DgZqr7yX7tAzJHOVw3Prob/CwqVJih71eTOw/2GbtEUZBxaFuc
	 6icnTzrJjETghJ0XhLEkbh/hWboJYIRzwlB1XiTyyL4hSes+HtH1wcq7YR9VC+X9ianQo
	 fJbAPTvmksCfjDUeuqOhkdSjG8UvooCYqm5WBJAu9uXcreydc69KmnmqjT++hgse5d/GQ
	 FAFQQhPLbWiZ1Evy87wWWaaYkZzZU53b2qNa6WsfCfhlN1oOrw1prrASZ+TqQg8dZaKqe
	 cYhHuxV2rzg78+sIDCdjTYPw9Of04lAb8+ChWYuF9qqCoAMItl7OPkGCLtpZg0fk/zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GAIgjqUyo1QNvM+fP1k2WNOXPCE5fZtvpJ3rqrrI02A=;
	b=cQnm0hXoTRY8j7qrfK5pzBgPw0e+cuVnhKE77MMTGas+y6nStIKNPW3dYZvDKihqKMNe
	 /rmRZoGJCIDIqeezxfMnZPL8hUckom6zDVhvHReVeRA6hHms/xydDYFdj00KyLgmOTe/+
	 bucb2QUwX+zyLo2H+Yqh7z/7Sedgumx5xoTFMVYYHQHYJhBx/haeAToeKyVkN6ZWC/bDc
	 ivX7+MyFSHbCoWU5pTcp1tEAw3TFrTvjPtNh/Q23sS2gs0aldu78IdUnFE3CyM1Xm91Ym
	 f4A1WNCPQqVFAb0XSqbdvjeDQpjcVWY7HsxrWPt12ePw/ibXKgwxSlO0oQQFCH2Q9AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PR0vvtPV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBEB606B2E4;
	Tue, 10 Nov 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PR0vvtPV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102001F00902;
	Tue, 10 Nov 2026 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302780;
	bh=GAIgjqUyo1QNvM+fP1k2WNOXPCE5fZtvpJ3rqrrI02A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PR0vvtPVPTCzPZc+i/DF7HnuQw2IB7uSfiDdtdD5NHVN5S0powR/vgr8DXJYNnQ7L
	 8+yWH603zx7a3KUyc5e8xU9Tpn6INvSy6kn5sYtzFgVa5kS0hOTqgSA71CMm8lmWIM
	 YHUUeJisqF5INQRysvykQuyqDbTGXAJS0ran7Zrel8z/KoWKml+ovnnvEogIxkoSj7
	 rlH5u5O1nKJ/PZYHYWUh//ZHCUGiQ7xW62GnO+ObCAToScWfAOg8wZ1KYZOAoMnzDb
	 8L6mmvibAHpbARz0kzirtcJXFBBgjgeZ+fB1Y+E58ylsOOIjy7vPvDGopYOV0WVf5s
	 K0YgpULqLXU+g==
Message-ID: <sashiko-outbox-206746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 25/41] pstore: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:26:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize pstore as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. pstore never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D25

