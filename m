Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662391;
	b=fs06zTBuKomwMdLSnsrwpMEBmhUSNuZ0Sc7dLPbXgMUExtde+9KKg/gH9NhiO1JrCJsd
	 epVa5P+LiixPdwpyUznl5+rpu7R2yh4OaZz09Cj+ElGZ5C1v7tnPWtcbSzJogWbQDOTcR
	 LxCqTOfNdgBAjPRW+xpDGo2uN7s0xu8o6Vq4fyGIGyShISFCEUTXFsQOmTJIJta5GFCLq
	 9ehnETlikYPO19prlq69PQ59npNr3qH/9hMRGy/G5BIYkisEs+dN1rrbJHdapfq6xJZu3
	 jV23TdGttch4QERFtamrLU/hVda1WMaTridBcY8V5d/2jySJow+fwS8UGWhYOpoEy9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662391;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fha0EjR15qGchPRPWp/JfF3WwbYgGsXg/aTaFZxQH/c=;
	b=wzgmn/rOeEjOmaCdgYz9yC+0QFlt608cBEjxccE1VDx2u/0I3V3RhiPfHDoD9vsuMBDm
	 CYmf/cifd301UYbJGFHI9tM0EEJO8lXepqNJxeY6PN8KojyAJ4BdcHmB+DptguKSpDPik
	 BcwYMTCl4E4bN6vP+r/oawDBBoQXRpJrBGiHzk0ZKk7UlR3J4gO6t+/pZb5Lg12aVsK3c
	 oGdhCZWRZ7bS71VtYqtydaFa03zJAVwImo7XZWRfKkrOynvau3ncc4m6FdlpvFa6E+Qn+
	 BoTcxf9eE+O1UO6yNrVSw0rsPBzHhY36IcDFx8PFXtvMP0SHfg/YLrIbTHFb1yZEBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUvrQXh3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DD606A327;
	Sat, 14 Nov 2026 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUvrQXh3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870821F000C4;
	Sat, 14 Nov 2026 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662391;
	bh=Fha0EjR15qGchPRPWp/JfF3WwbYgGsXg/aTaFZxQH/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nUvrQXh38Zld5VPkj1UrBXCNCWMYCQguaoJSlpcf6zboUO6OSkYz6crxCRG/aomtU
	 qLeveCFqOi04a699x7XaWpjxzloZBuLmeYXFOdRIktU3t23rJEWbiqXL1joJE0X5qs
	 BivK6zhZdcklzqm8g7a8SoYvU6W30LXMKupuNbnXfQY1vlzB9Vi2jKpZi7KJjf9cKr
	 wNdduVQY2mZ2uW/ELQ2QeGs+l7VTNCjAXOAiB2F0iow6HW5pso1kjNuw02cUJzzyOu
	 aCA1yvBmYyy0YHUsilso+C3pIWGEqg26v7PE4iikdyI8rrC6OQYX2JUvu6MnaRRL50
	 cwRGxZMvfn3tw==
Message-ID: <sashiko-outbox-214544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 07/42] binfmt_misc: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-7-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-7-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:19:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize binfmt_misc as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D7

