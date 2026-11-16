Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828053;
	b=d6pUkzXs/kFIO+lWzqA/dWwm/r3PsdM93ejnZ8xXEAQrN7RjHlJF76T8g9Sxcr+kq2Mi
	 cv+vbqUds2ZlGx1vclo1m01faNdW8R/nJpq7aouUtkVFagR4y6OawJWpkXTAO5KKDx7sf
	 hHar6HSsDfiVWjmR4BeJ+IOoGnRaVjnY7FS8volaM6m5AWrbCHHmW4kwalKy55/l67NJs
	 zCS3z1IDPiYKaMT+jKL+thA9iiJArOOZu62PJ76q1IvLPWqlQQI327bH2ZCeL43DGd94F
	 iDmABdRac5AY3jtkbBuoPDVyPVFZEXeYr87sw8Zf0wVnU1QEpflLUiSQG9v/fOn1HuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B7NuuYxQOc0AtF7+A4vgNBgbREzjCDlGgwfAsMkKTEQ=;
	b=Ocs1n2mKKULViFEwZJc3T+HI/vWLtNFzCeHXO/uYv3wDXUYhTIemFtp6WMA7QZqepeZQ
	 AIIH5yXaC2LqCaXLSdFSKvWWsGLN6QzZqwvwsHG1hWKriH3PP3Ta6r+us3aykz7ulQr6R
	 KGNfpvn+u51UiblZXhfPr9DKBHBJh8eg3CqUHrNBx+s5EqDQiYmv008TUvWOGVGDygU7/
	 DFFLP8Cq4F7BxDlaq0mu7aLTRh/OkO68Ul2W5grvdaTB+QcU6HDW4AkiZkzOYwEwnAVsN
	 7BIFGbqKA3ZCLWHxXFN+vcSwXDWVU/Imrg+MyfBWfrcUJzP7YiIbq9E1n/353pQOgzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnamgicS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24929607181B;
	Mon, 16 Nov 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnamgicS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D611F000C7;
	Mon, 16 Nov 2026 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828053;
	bh=B7NuuYxQOc0AtF7+A4vgNBgbREzjCDlGgwfAsMkKTEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UnamgicSS7iR8o28L+dRRItb651lEgg9O2LLD16lay7s6UUVWXEP1HhdR6kbs0Rft
	 fxC0dJwSSho4vEKgMKOY0t5BTn2KqsjJQuaFSNIWD2eecchCiYScuGAmX/XhaK9PmZ
	 gi1Xjq/YA6AhNGyZ95veSXRRnD3mDTV7ekiYBqIMw6OjiYnx/IBmLxXcokpEE4imjX
	 Fn8iVuiIJsm2c92bNfUycbVQ0I+x8r0uvU9GO7V3kLIQt8EPZBtsGq3YesJXDNl5Io
	 ddWmXc+c71iwl//ju3ua3Xq/yJWc5ffONA4FH3Wx/o8CApmwMbh2v1tWd/7btaulIc
	 +FDK+H8mHG0iA==
Message-ID: <sashiko-outbox-216898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 26/44] xenfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:20:52 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize xenfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. xenfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. xenfs maps the xenstore
> page and guest memory through privcmd, both data.
>=20
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D26

