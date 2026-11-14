Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662404;
	b=C2P6butA7nHUBttCvkIkgfm8jTYIckbuSXBKWh26RsNwwX0zqTqBi4cPkvC9UrlHzJtg
	 nM7S3+HIawz/RULaQhn/iQXcsmNA81YsT9h0Sh0DhEzxGDtp4cL+LRg2Z5qaUnMqPgkL5
	 IaSTvQSdGhOsLViX4ZK5YuHX8SGCWHEBdM2vNTKUzj35OnG+6MqWTvSfiBlAwyNXlAatU
	 0wLiFnPglWDjflY90bQ0Jaw4u/jBawNiCRenHlAdbSTVnA/qszwiMNDYgXfhpLme+rf2a
	 t0DX0d/uUpISlk6XttKz1WgfzyfKOGSMlHpTEBst4K3CX/0MIqYls+zYNioWS5pmCRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662404;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UgGsLmeFudFNMOA+Tu/BQ5i82I6dl8sq1MniAco0Xvs=;
	b=A5mnBAGwUGe775J0cDaZfu57va1gYdRsD3Yp4zd2vrEG9HFoWkSpOOHxt11J5GZWxOTF
	 2UWJiwzyY16QpNhPWkOuqJ288+PCUS8zu2wzzPxU1xVhFrkPz6UPWOZ5xvbFZx4JMRAsR
	 B1RE69/jKrxvQTeWDhGJRlw9qGKHzazez9cfy3seUXE+u8A6hW7vMzNewlKIBYDtKbvbt
	 cS8/TjEoM6oviYo9cwjuzNRjWcbzjO+KtBkxsm3vS6ybtofk0G0FKaVf8dpanRrF8yVp0
	 4LI2nYrpRsGa+GlaJqPU22ZuIfnVTow0HNUMRN521rZh3E0WErJcsD6oy18BaaDaviw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bmg8GoAB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B9606A330;
	Sat, 14 Nov 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bmg8GoAB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D315A1F000C4;
	Sat, 14 Nov 2026 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662404;
	bh=UgGsLmeFudFNMOA+Tu/BQ5i82I6dl8sq1MniAco0Xvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bmg8GoABc1ntod5YCxSYN9+gUznXUit2LGLZ/atdMRA6yu8FQ66YyPTD7KQcn+oK4
	 kQ2Zpok/+Lov9T2dnm2nKxK+CASzfcrv18ejmjZUins/S3VqHswBF73LY3v6e1YsM/
	 zKdGLXrMHdNKeGS58MJWt85aACVDPdwN9AjBf4Hj5Rk3UIjqmMJmw9W0GlocnSBZz/
	 Uq9RW+p98D6SOk5D2ixKUiQaWXsdrJCzd7vAM6OPL2E+qo5keo14qEZ5uaFsZOBUZZ
	 8ux/iOitbKsKhMAmwF3Sy4GdV6ZzeLaHI/B1X0BHimqvMqxOZQfBpVNphzcEHEZpOK
	 jTM7RcJJDL1MQ==
Message-ID: <sashiko-outbox-214547@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 29/42] s390/hypfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-29-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-29-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:20:03 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D29

