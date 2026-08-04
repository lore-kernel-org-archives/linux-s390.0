Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812541A5B8C
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827268; cv=none; b=JJNOyqzysX3kge0RAcQg6ZVcg0b9vczMVSyFsJsmWxG0bN8ZbAFeCItxgbqv8n+53acyxd4R1x8679bBtXlzLsiTJhp9jNanvG7AbsMOaufZMHLlvdTnOPU6cK4iR74fv2UieAlaywdYD8Ii0HEYx0ZqQwnAmw3IuNgDFcCyihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827268; c=relaxed/simple;
	bh=8QQAThqTcfc8ZDze7d60dU4CEcZVBH5SFqW/Oxk8UZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SrVq7vwlB0lm+I08i5OyAXowXe9cxVAtWDHCH8YzJRQ4WF1cVmBYDwbwxW+tPDRCoLToieQNvcEx3jiCLglgkIjA+xE43CoMRcdI9M9vFVP3WHqmibBWi9F5tAHhoeQMHzqVYF8WsB5VH2A1gZNGKTZlyl7KMsCi4GFmaZqwlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2gG1162; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2gG1162"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1CD1F000E9;
	Tue,  4 Aug 2026 07:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785827267;
	bh=mBghnwchpsJmYipmQMkg5igPBOpPQscfS+CfMTK4thk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2gG11621KTm0vMme0SXURpTR6OO9rDhnxfDrrchU66L3EwHAWVlGhqXbwFxnlmH9
	 7I6RXDgAsPyZmPDUbLfEftJdPKrEgZ/C6mEczkwCHMNkawabn0fH5shVwTEUdwhpGn
	 5y+JrGA/uxMvcMG3TEmwpGO6nx9oztKUbMU7/svlt71CJqw7CC5ALuXNhoDfPup6aC
	 353a+ehS1uWfTpJtV+8Z9FomUaePP9g/h+OIaHuSfxWB0uNoQB21pu4++mVmwOQFWZ
	 p4NHo59YYuZKY4pBP44uOwCD1dOm4nFFvaeq6rGTTiVx/zgsvMI9lHNdf9TTpsnfew
	 jkIRoMXc0ZX+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: fix TOCTOU race between smc_listen_out()
 and listener close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sidraya Jayagond" <sidraya@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803070701.126339-1-sidraya@linux.ibm.com>
References: <20260803070701.126339-1-sidraya@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:07:46 +0000
Message-Id: <20260804070746.DB1CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> smc_listen_out() reads lsmc->sk.sk_state without the listener lock,
> then acquires lock_sock_nested() only after the check passes. This
> opens a window where smc_close_active() can transition the listener
> to SMC_CLOSED, call smc_close_cleanup_listen() to drain the accept
> queue, and release the lock, all between the lockless read and the
> delayed lock acquisition:
>=20
>   smc_listen_work (smc_hs_wq)          smc_close_active()
>   -------------------------------      -------------------------
>   release_sock(child)
>   if (sk_state =3D=3D SMC_LISTEN) TRUE
>                                         lock_sock(listener)
>                                         sk_state =3D SMC_CLOSED
>                                         smc_close_cleanup_listen()
>                                         release_sock(listener)
> [ ... ]
> and the enqueue are atomic under the listener lock.
>=20
> Fixes: fd57770dd198 ("net/smc: wait for pending work before clcsock relea=
se_sock")
> Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Signed-off-by: Sidraya Jayagond <sidraya@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803070701.1263=
39-1-sidraya@linux.ibm.com?part=3D1

