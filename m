Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828088;
	b=MzzEYP1Kaq25xi0OQ1/qabcZzvXBuGpY7gN3fTvFQ4H/0ZDnuEEoTbPbULW2zw+vCMDn
	 6IaJ0lkcb1VNNFNoMNdfiDtfZ63hYDFu83nI14YjB2yowiAvBdURk9ts+m9+iI0OX1UC8
	 uIi7PTebvu3vjGdCxAQ9c6OrE4kOits2XxGaPMTBKft/a8JVPToeQ37VgrI0pdx7C3adx
	 yuAHOeB8u0fq3CxWFAhGWFiZqUVn8oKK9/sLk4E+hSqJf0iI9Ff2g4QRkjUud7zLnluQn
	 +A3kSrv7o9PQB/xJSB53vYI1JiX1jbvGm/lsp7cbTA1RgdsWPmkmYaOumXSVqmCg1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828088;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1INHzJOuXgXnCthtZpG/mtseQ43cTZ2j1X0zO+Tcj4o=;
	b=clIFD+wGBFyEzZyHUfljP25DMdkm5koIttP6I6qr0WSqi8ZbWM5pgZ9rXe70sSW+yvDF
	 NG1PcO1FZgfHav48VCOnyry8VcRbp/Zj6YWPdQMB4u1BU94D6plYLwQHGJpOUM+1NibY1
	 09H0IO01hjGaqkNTh6I1/2IyZb5M2hbqZgM9cgtMIWaKegp8LEDHFymT4vMYwx9R0Blta
	 4VKlOUXGNUQx7Xc6Fvryn/uYkrr9ON4kgkB38Soqfw0J1nhnpfUGp57huf7KL5raUdByN
	 BZUV7i/MOhkve8L100Y+UIkicy1/dTiPP/KxPlVdTs3TqMPIvjMQ26aYcsxmY+Rcg1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvhIMRVw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD26071B02;
	Mon, 16 Nov 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvhIMRVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917591F000C4;
	Mon, 16 Nov 2026 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828087;
	bh=1INHzJOuXgXnCthtZpG/mtseQ43cTZ2j1X0zO+Tcj4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NvhIMRVwAnbgdQyGnF65AfbcTg+CjKbdkc0iiV/3E37v15n8ZWABV2YP00qZqtyCi
	 fussoTCSaUukoZBbA7CCuAxluDYKT7CgvDSAWhg70eMaDJELU3xVpt0T1ykkHfbU3z
	 hfKkNec4MvR6OUU2MKhzETbrFkFp56B40mDgPCsnQqaTUhTqjJta1hQ+TeKiVFvCyv
	 3cpAKii2V/JOPAjC+4Gcc1bIukwaa0cE9uUAXPDkrAx4nFqW63qo90KYCJZ49dgZpg
	 GFMOBlXpdlDCS4/pbQGN76kaqTpT9jSyCJPkzsQesAM2Xg73bvW1YFQkXSBu3++UTf
	 7pUeHcqofcJKw==
Message-ID: <sashiko-outbox-216901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 31/44] usb: gadget: f_fs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-31-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-31-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:21:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize functionfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. functionfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D31

