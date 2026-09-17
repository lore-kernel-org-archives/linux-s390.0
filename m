Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3DF30F924
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689568; cv=none; b=UI6lN/REAbfQQNq9nglUFggpXSUYwbpX0IFpXRs1xo5qpuvXT8pKE+cBx4R0sFpLA323ygQG/a772mBKuDYhyO5TIbW/nuia63K1eEJolqCE8/mszCM3TkMe0OyZVnrpY3vCl1lny19ukBh3CdD4w73lORTAI4KDGORYZIx8VjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689568; c=relaxed/simple;
	bh=DYTDjmoSVL0Y5vpIuf6VaxA3FI98YvH21StFlDOANE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TyIFmogXLQJf/4n0YvhupXwCckviox9SCWt7ju3BhTy18ZGf8vw74KLgICy/o4adYw4zcoGXSEV3CCE3qiw3Ty55UU6eDWxp1Foc3B2iDvnsFJ7FJiYsIAg0zsxawyfVqUZlylTZGhVJGcKQS/aRHvxwseubVJJA1KqKCUUShcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxQkYJ+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxQkYJ+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4441F000FF;
	Thu, 17 Sep 2026 23:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689567;
	bh=DYTDjmoSVL0Y5vpIuf6VaxA3FI98YvH21StFlDOANE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nxQkYJ+A0YPkuy+Nw2qYfD0B03bUqBKvXJLFnWGbYHfIZasMaVftPszFao2mXTjY2
	 rS+ZSG6AlqSqVJ4FgAPcdljt8UxC2i+p5kubYJInb3ce1hYevTLvMxEj3tgkqbxpDY
	 tbuW+0wjJWUy94ur10mn4RQM/vAi0Zd0krMUn+hy0nTACMTsNqjeKuYbPWqzFfxFhH
	 74IMlSQr48PHm8MwIPHDLZ21+608h5fkSfMzc6Fe12Srckvjp7Um9Y76Zs/G6bLxaY
	 ffxIDAfbWLtCH7e8bIJxTNklT0mV+JRJ5QsWaGSEXNQ6tPPqvwCPhjP7LjXMCExzCt
	 qkJCU9Zwfh6Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/13] alpha: Define entry point for
 set_mempolicy_home_node syscall
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-11-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-11-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:59:26 +0000
Message-Id: <20260917235927.3B4441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Instead of explicitly defining set_mempolicy_home_node as sys_ni_sycall in
> the syscall table, define it as the real syscall entry point,
> sys_set_mempolicy_home_node. As per commit fdb7d9b7acd0 ("alpha: remove
> DISCONTIGMEM and NUMA"), alpha doesn't have NUMA support, so none of the
> mempolicy sycalls will ever be compiled for alpha, resulting in the
> COND_SYSCALL() fallback being used to result in the sys_ni_syscall.
>=20
> There's no function change here, but this step helps to unify the syscall
> tables and create a common table to rule them all.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D11

