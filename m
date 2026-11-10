Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302735;
	b=UYLnkn5mxfirGmIJWUtV/d788N7+yg/SD5ZOUx0VwbqBXBk530ebMIywrf8mL1TETa+O
	 Hc3zrjCQfUV3BW3dOY8or/JF/Est02XrcBnZ0yji+qy5wLe6CLf8Pp5i/yvX8dNe+vYoO
	 6en5x7x0rJ+AmYsvijlrO5mV4XDbR2/01PX3eDq3cHioPRaFWD2bMjrnoYAu0oJAiv97T
	 siRl4HgVtjmGmgKz/BNrV4hD75gh1GVotCCZUJkKK0PluKmtksOpwTsg0DbgBFl2MDiMI
	 PMeYVOl72ZT+I2caMovjDc6EsfStbFEutUC48Na7iFgeGaSEzqqOAjydWgPJxiRqhSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qb01gZa4UDDHFaDARPrPc/1LaN2c/WFT/Z9hFlKikaY=;
	b=XKchzM10tdUWsu6m5C8dPpf2cMhnUidi/O3P38UFHdo+v9/tf8FFgmyB7HfZTZIxZ5Xu
	 Yhs+Sh82L8k7IrOh0hWAIEIfkFpCB6lAnSB/ZGTli6RBhQZU/xcEy7g+B7H0E8k1wq/Yy
	 mf9oijWeeJkJJSv0i4A99/fI2PIgbE8Y3ViOn2YnMkCNY8knovfta9Awq3tT716KndCTw
	 lg1v7ddCGZVT6LkWPVutx+/+8sGNXZnSZflRa1XRFQg53Rb6c7vYLvIm/EMksR9VNskLD
	 Zdob39M6RSkDWpCt/wYzH3dwJ5fGIP6TgddwecA5bijeJT879AElKmEoLkUiwa6Iunw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J21A1BDW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B86606B14F;
	Tue, 10 Nov 2026 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J21A1BDW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1961F0089F;
	Tue, 10 Nov 2026 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302734;
	bh=qb01gZa4UDDHFaDARPrPc/1LaN2c/WFT/Z9hFlKikaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J21A1BDWMzvmEJh0pfaT0/t0F57cPT+tyVhMcQphDbNSL1DjIW8+9XlY4I5ASp8/i
	 u0ahIBS2JebMuBLbuCT7Q1JkAVynzJxXPRv+yB6KAdHygXA6cP06Bohcsfzd3kIheu
	 Jx8s9YV/4Nd/qwWlsU1H/HJ0/7lMoKRfyxwJz8tdB9N12ccXWPUa1qcrHnvbEq+kYA
	 WZNcWiktFoeLMt5MVxmMaEkapU2/fx/UEUk9P7y5TMVbqQ9ciHcYZOXdJg8nJRgAQq
	 W71uHGiCQZaHfkhgZQiURRmIMEVW91GSClRzLG+bMwglKXrEaRsgIUWjNGu4p3YQ5q
	 0zZW6HEg9EX1g==
Message-ID: <sashiko-outbox-206738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 23/41] fuse: use fc_init_pseudo() for fusectl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:25:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D23

