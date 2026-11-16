Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827857;
	b=DcLj1xmjC+cVmb4A/9TEo1QZbMQfHp/iN/CkaiH3M7jrslYY2bj7lBy0JFirkDLRIukT
	 XbtFm+Gs6nxH7JxXXzdsDeWMgr6v7BQYEc2l/TgA+OE/sfZfWwAdyNKzfyrbc2AbGO7S9
	 cWnRwWsgW1sf3E4PqoXaC7kTiWCyG0bothotouRNJR1zFAAOnuMbjYL8NiR9kN7ThngY6
	 E7CfN+JxMnO1ES5E4xJx5TRufPdvOiWeQYRHgEwgAjUKQ6pf8LE6d0QfK8exwB8/BUsY2
	 fNA/lolO8+zgt8vpawIFzithOUH06fwXCfdEjb7XzI5hCOaJ/G3SDbCgbughwhacl4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827857;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SBauyBPn2FVZOekiZcG02x6HRE8A7kIbNUctlR/uiXM=;
	b=j6iv41Wyx67poSsmqXslV+5vBuI9j52Faf7x+mfdUgav0IdFBw/lPYc2oWr9w+rSX5Yc
	 PTr1pksR7enxAxsK5vqxezgWcISuSsDCg1UG+hK7lsTm//B35rtma9QTAuq1UVHxuV+zD
	 WimePTGEFFyJWLWZEXbNpYZRAF3/S9l8a8fkmS/85bWk3LLOlI+GGtdrV9zSS4r9p73jh
	 zAOFKGaumVevm8gfV0boSFygw7OcTI7bs/oCf6/stTL8OthXr1ls7TgWoiWug43BZ3DC4
	 5F0e4Yp35Ww0of/LjRMMZcH55yDTRZH4kOVaXyfZqe+WdzAMtopOyTaDLVwvS5neAuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ll3BVSOD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9249606E487;
	Mon, 16 Nov 2026 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ll3BVSOD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DD31F000C4;
	Mon, 16 Nov 2026 11:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827857;
	bh=SBauyBPn2FVZOekiZcG02x6HRE8A7kIbNUctlR/uiXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ll3BVSODnJnBGA4knfc46fktrTN98S9Uncw1CfIgb5vBg0kh3aLcpR2dofFuotQdn
	 X3vtPeWWX4PoVNb2s2hsuwN0t5WYL54jhCPXJs3OuReep3mZE1BcTgy5e1Vj8RpEvm
	 EOuggV2+lJ7ACjpAGygXE+5TLzQvwbIwAYLOw+fIpLjvY33VULf67bj9fy+9Fs68Bh
	 h9aIUKQch9P3nI25dNGG3aKTUe5prPLRwPPR24jktc5pjxJQmDXI6qNUpzh0akVIBp
	 7VXY70jkEan/9fnxEdj1o7etMc842j96ym6Q2MPmYF54A5XUMvFL72WjdRXwLHlbgp
	 fMy3GvfzAC6Ag==
Message-ID: <sashiko-outbox-216879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 15/44] tracefs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-15-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-15-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:17:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D15

