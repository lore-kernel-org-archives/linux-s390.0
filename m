Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662331;
	b=xBb58FQEE0WqhY97apekbqzUrSdUwt3cifY0csoYXOUJqcWtaI5d+uiwtmvMtOnIx46V
	 lq/tosPUZHfYA++ZtsXBfwlT7UIM3uJ5oAOLFTzTmkhwNdehINYiG/ZoWpqp6XALw7PtR
	 K2ZeH1vjQc2hsBfUzG0ROuSD8c8dPbBVAvmt2JG+tC0MW5dO1yL+tyyaCu9/2yrSnr+By
	 Ad3epmvCQJhewjPTgGUz8ccouF00ntLPDpiqaT2HBL4D/H3LvVCUbOadgOtjgPMmnNPbI
	 TmMC9r4rWN6fgorH2ASRWJboqmGF7L4PJzWH5CUzvE6zO99Tn5zZxxA8XDkgPCC92DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N/EqmudCtH6pEeVREZ8U/Iw5Eg13s8V11WSIpwRA3TY=;
	b=AZRSR8z7KqhWK4Ft6EI8s88UoZNpUo3souKY42hr8gI42Z+rXO5wbByUzpCZ2bIa53Me
	 ivDJmyI3+LbotSpNVjjH/xFfJA6HPDqMIOxtohASgdXypQ56wfJuQeF9RMFYVbdggEk+A
	 H8p7N/2GXce/aJfFzt8cceFWCeV/U1JV9mTCCfpM98Md1T4nZrMZLi37ogTQhD44g4WAR
	 pbmnC8zLNLDVzl28GDrVvFhaKKi15Ej6l+xsVyQ/Fi1BTxKWaxtBrJuFX+mw9Hr1S8NCL
	 KBDUdvn5tldUbLGM8rIMuKFsESuDQYyjjEgazWQ/jWlqGRS8E0Y6L/QDWNqdMgxI4yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSijTsy9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95F606A323;
	Sat, 14 Nov 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSijTsy9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005E31F000C5;
	Sat, 14 Nov 2026 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662331;
	bh=N/EqmudCtH6pEeVREZ8U/Iw5Eg13s8V11WSIpwRA3TY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PSijTsy9YRXwNacTYuMIpAVlq8qMgGF9yWCgt61+2h+z9S0QV5iDCqea+noKsJM+3
	 JJej3HNeKHG7RflQHrYiWpQKa7nkpIBi2xAuU1flPfSSCAaOvu2kgtD97qybSDHkwv
	 83/9tTG3yGycjJ36A71iGj305blYGqBiCmn3o6jTk/nOFoT0tyugpEOIAQx4PrU4iC
	 2sunIjOfstUNxhb7vIyyUZGMAeXMDozWNuTEKG3d+fXOMsYmy0JOpu5eBFwzutuykY
	 LZKdLXzlsQx3+3DVXe6WUbNnB580l+Ll3n7wLDEUc8kl1RQ9zceO5GX4d9KsizIFEs
	 h4uIWVdHsuTaA==
Message-ID: <sashiko-outbox-214534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 22/42] sunrpc: use fc_init_pseudo() for
 rpc_pipefs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-22-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-22-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize rpc_pipefs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. rpc_pipefs never holds executables or
> device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D22

