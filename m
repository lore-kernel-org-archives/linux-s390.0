Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827793;
	b=Fa31buqZKSrLxXc8u67+vjzOT40l9/rB4aBEcQQlxVJiZBFslv3PU7Zoc/sZ5IktYxT8
	 zgPbiob9decQ5Cwv5+g8MFjz76veZDBaglbG0nOgoHdvV5Nzdr0zoEwkDmL84+/ieqVLF
	 2XnpI3azyhSkpiZAl/vZM8QrX2GmSs0kk2CAJFXKkYH/E6GXQE+OFwPi0AOguE903vWqH
	 G5c0L0XEh3WrFat4VEoQSqeGYRkUomRjrbRXPzOvLp+pq5bhYfK/54t22Wlx6a1Yfzwxs
	 68jQ7mi9r1CjyraHnRTRjLCpjHaObYjidcuPOzI0zPOni1lI0bfHu70GxdOKh281zcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7M8UxmVDTlpCWAclU2g5oqS2bikZJs5USyL4P3MhNy8=;
	b=mF1+KZ1sfJdidJbhMMrfkTecPM2VZPhs5o9x+ZFV6+TvlMGnoO/wvfKRwmuBlTo90IQW
	 fjt1uR1ImZHj2Z9drrndu/JtgsfR1O/XjlP3Fxo3bgDqa+LQwoON01v/CbMLuwR2qYALY
	 8M9IubghxXhuGobJ0zl5f2FjDsBbp/1vFoJk96zenJEXSowr8fqeuyTmtrUKZ1V1kiid4
	 Q1zu+9npPAMHk1b4Akpjhj6xXftGcq3HDzMNzgTPASE3ty+18uZogzZ1eoHFEk10wBt7Z
	 gHJZZ82X/A0BJ25fTN8HCI+cRWAcT4CukWpRUewfNnduwxx4iRteC9DebRlTf/6ysYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAM3xwHO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE486606BE3C;
	Mon, 16 Nov 2026 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAM3xwHO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0030E1F000C4;
	Mon, 16 Nov 2026 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827792;
	bh=7M8UxmVDTlpCWAclU2g5oqS2bikZJs5USyL4P3MhNy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aAM3xwHOmra26UcfSVsnj2A8Hns4ATWsFU6ApqRx1anxpVexQ9yKpA0BOarvX1sqW
	 hZUuP8yH9FWZ+14RcAqlVsTVJcIbXTUxenq9pmhn1Hs0x0Xyzj3doSOS3Ohc/lCJXu
	 PWmafy/wdUT5jg6gWEtddSROfZEOYZWBPmMNM70px11L+lNcCRCWIeORxpXAwaoeOW
	 RxBUP90PL9dlDPXDkea1WboWH+f0GkZHkmhOAURuRf/QPnbKxnQTDrX4lmvfwXTG82
	 Mmj/9vssADy6S8PP/JIMfm8ujH0L3kquoRHwcGwjjPKA2RZKE9DFJUjq0saYYmNysT
	 bL6l+RxGoHwxw==
Message-ID: <sashiko-outbox-216869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 09/44] bpf: use fc_init_pseudo() for bpffs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:16:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D9

