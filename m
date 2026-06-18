Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515F2459EA
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796566; cv=none; b=GihzOF2s6wDomTNxlZMkPTn0JwwaZ9N9idRvl/6g7NlY6O1x46G8NLM/nbSVi2E+nuuRLWsRB1PZPXbgdZDXP0KYe3GsmHpslQln4bNrkWaGu7aM/te+Rc+FBpmF4v3mqyAPRiD/0+5qUr0nG8eXQ8Qopz57t3NGp6FyXYmpJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796566; c=relaxed/simple;
	bh=P3pC/6jPGmU5weIMaxvVzTmC+ntWQwLEup5XZfVu6WA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bvdmAT8m3VLu+5mnGcXl0gijvLqPftzAA5UCV1XaDoC9D3A4Rr6R0H6ttpNlvJn+akE1BI2J/a93XuXTMSJeQigsdSOkZInQaD9dM+wwc3Q89N+flXcUtgDnInaZlgfVY645WmZu+uVbr8I/Uu2njlA1aYQ5V54Z59kuzU/YCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP3eeBSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP3eeBSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F6B1F000E9;
	Thu, 18 Jun 2026 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781796565;
	bh=WyvJ1wV7BJiwjBLMOKLajPMIz0p/MqSLXMTv2j7k1bA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JP3eeBSmHhLskxGq/97e4onTanmBM/mD/+Pc/DDj/dmkDMhgJrgWPpNY4hk9jMewy
	 APwGZj9j+Pep0RNL39eSXuQIAuZDvDsyPB0DBk64QZf2gQgdZZ/tmoE3bZQLt/stfi
	 vei4wVX2+ZZFKvo/3Xnv265E9tcD4ys3yReKrre14DVPranSHcNWwtcao10uAtOfq6
	 okivUctSYZFcS6aYHG/tuT3/trMYUML0vg1VXzTkcdZW9lWZJnp0lQf2x7wmpcCCSE
	 jSn59HkRMYb0TbgOmUtdhKef2PfDOWszGET9tLfXZa2OyzqMdF0mZtcNNldXKqQRbT
	 AQ9JwW1B+FH7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: avoid recursive sk_callback_lock in listen
 data_ready
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
References: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 15:29:24 +0000
Message-Id: <20260618152925.16F6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error path in smc_listen() fails to restore icsk_af_ops, which=
 leads to infinite recursion if listen() is retried.
--

commit e36405ff19adb1bf696672be6024d5801fec608d
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

net/smc: avoid recursive sk_callback_lock in listen data_ready

smc_listen() installs smc_clcsock_data_ready() as the TCP listen
socket's sk_data_ready callback. This patch adds a state check
to smc_clcsock_data_ready() to avoid acquiring sk_callback_lock
recursively when the TCP socket is leaving TCP_LISTEN.

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index b5db69073e20f..4c638765611ce 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2630,6 +2630,9 @@ static void smc_clcsock_data_ready(struct sock *lis=
ten_clcsock)
>  {
>  	struct smc_sock *lsmc;
> =20
> +	if (READ_ONCE(listen_clcsock->sk_state) !=3D TCP_LISTEN)
> +		return;
> +
>  	read_lock_bh(&listen_clcsock->sk_callback_lock);
>  	lsmc =3D smc_clcsock_user_data(listen_clcsock);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes
around the listen callback, I noticed a potential infinite recursion issue
in the error path of smc_listen().

When kernel_listen() fails (e.g., due to port exhaustion), the error path
rolls back the callback hooks but omits the restoration of icsk_af_ops:

net/smc/af_smc.c:smc_listen() {
    ...
	/* save original ops */
	smc->ori_af_ops =3D inet_csk(smc->clcsock->sk)->icsk_af_ops;

	smc->af_ops =3D *smc->ori_af_ops;
	smc->af_ops.syn_recv_sock =3D smc_tcp_syn_recv_sock;

	inet_csk(smc->clcsock->sk)->icsk_af_ops =3D &smc->af_ops;

	if (smc->limit_smc_hs)
		tcp_sk(smc->clcsock->sk)->smc_hs_congested =3D smc_hs_congested;

	rc =3D kernel_listen(smc->clcsock, backlog);
	if (rc) {
		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
		smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
				       &smc->clcsk_data_ready);
		rcu_assign_sk_user_data(smc->clcsock->sk, NULL);
		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
		goto out;
	}
    ...
}

Does this leave the internal socket with a corrupted state?=20

If userspace retries the listen() call on the same socket after a failure,
smc_listen() reads the currently active icsk_af_ops into smc->ori_af_ops.
Since the previous cleanup was missed, wouldn't smc->ori_af_ops become a
pointer to its own wrapper structure (&smc->af_ops)?

If the socket eventually successfully listens and accepts a connection,
when smc_tcp_syn_recv_sock() is invoked, it calls:

smc->ori_af_ops->syn_recv_sock(...)

Could this result in smc_tcp_syn_recv_sock() calling itself infinitely and
causing a stack overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617152855.1039=
151-1-runyu.xiao@seu.edu.cn?part=3D1
