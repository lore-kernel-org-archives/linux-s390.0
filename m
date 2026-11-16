Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827750;
	b=P30Aml97J6Y88N3BLfTM/5YqPgVGfOin0gbzgaxOOJDxd/pioxMU3xpuUSR018Ka8PbP
	 /cpRcs7PQeOPXuRSH1VDEVdkHES3aYb8qikqn8BansXn27Z0pnD3uPEibhKHEYgX+kMWg
	 UYD6z6SB95tQxAt4sCRsTd01PTvDymONkrc2rbc3FomcWzB4v3pGyjOoNWneUHonc9I9U
	 9evt4iKJ9E/Y+ZVcFfpjD9i3EB6uktGDMrtke17/F0i7OPrFEgeVa/5p8tY7zCG7QL/L9
	 FFh3xosghDswMy9HVmYerzdy+hKNYkPXhJrPfpQq+9ZfYp7uTtfoY7QkEeXIxdXVvkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827750;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yoac3m+tegvG0b16l8WXVXJwIj8xsXQvLQnJoKq1B3w=;
	b=y5g37u37FqJT9QeelHCWsuUHQGf5AkKAWxl9Jnl88MhVB3DTP3Tz8wGXzJd4TXEIixyQ
	 X/sy4ieP/euI3PUNUbtJKO232hWFBFOrIXx4FbOPjEa7MX6qnHd2nl1RSDJDxcnnJtpCP
	 6o1lFInqot3Wz8C5T3ZTOSDacZ0fRUktZQRDx6WXatAcdLcWC4cdNiAw50v8tjqQxUsPx
	 gA84VR2cHGAePPoA9fCunDXlrahqMTb4Zu5crELxXgeeMAJNmZM8zOqjRsH6ACX5x6bhn
	 NjQaou1xNo46YhxvpDlwGtKMg5Fjt/UMr5AMMJUfYYqgZf6TCqTtgGo2ifwV5W5Jzjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esftsN8a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79507606BE2D;
	Mon, 16 Nov 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esftsN8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1121F000C4;
	Mon, 16 Nov 2026 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827750;
	bh=yoac3m+tegvG0b16l8WXVXJwIj8xsXQvLQnJoKq1B3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=esftsN8aKad59kaFNUhXu9++PDmUleBXdYsgXkASoam7LDuQDSVUrqXRsSW7AcB7g
	 yhOGOyTLx+PZBAQjCjjbsQVBR9sqxM4DfFKWZbfys6HdTmhUa3kiWgAyoPVTJ+5aNd
	 8IfgVa/cukHPZsq+CJTs0yUwdW6xhda+UUUzOkxE06q1GKJdhhAeGfj1otmtSdF+q7
	 7k0+aOf4FYhVeK9shOra362WhspStsyXwNtIfTfcZL5rdEx2WYx6s9wbWtLd4+kO6G
	 3SLgePoE6yoszv8HDkTcGq4E4PYtimQTHFel/cUoLJ8zo74/flzmV18+I3hbuS0udm
	 QU7YJXPrFeTZg==
Message-ID: <sashiko-outbox-216867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 14/44] debugfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-14-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-14-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:15:49 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize debugfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. debugfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The debugfs files that
> can be mapped, kcov, relay channels and powernv's memtrace, map data.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D14

