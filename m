Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7841A79E
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693443; cv=none; b=EqkWygnQUrFIO291sNIIa8r4IFBkljQeXMQa7skOv/P6GYvrO7Y6mUONEHHQDphYtRYj5UNblXQk2NqMfEu4hayvKPwZOe4ZnBSQ2xnzGY3WqjnrR0viEZYzr9oWvgd/eqM6UenuxsWVY8E8aWbJva8TWxa3EEV8CFknOuuPydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693443; c=relaxed/simple;
	bh=oQPgTWawwdaTAdg55+RlNs+/eY6FgVAWb62Lkz7Z8+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HVbfWXgp+uOw27J1AdmZJNZ5vBQLAqs53fANAO1D68XnP31a/caezsuHuOOp0GE7kNYjT/FUBD1+GELvmMIHF04mEEY7KRq+8oFDKNJB3JMs3CO9MS1iIXDgCx5we9Rh2cbViIhl24E6TBQsU6aWlSqKVb+3Z297lYS53ikKlRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLH+21tD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLH+21tD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29311F000E9;
	Fri, 14 Aug 2026 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786693426;
	bh=CWS8xIj+XaJiJ25H8TUvJbeZaXV5ie5/XRUkNWWhqJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLH+21tDBwSBlAPb5mHfNn61IYi5MKQ/Ne1DoWyPDCab5tGSeUNszw66moKtrN/qv
	 9xJFhG5f9VMQBBP9UivyKqUGoa4syjYGU77rvc35QrEqlHeB/cs5QQsp1PrJ+WokXc
	 gwJRj23P/Z6feoFv0Uk2TEVGLLo9zUbi7P9xR4CZEzwCThFNfZ2UmbkStujKIBdXvy
	 6Go+LKjqHpnA40csjcVPCTsprR7Ojw4b7om9VMGeCn1a3axw0Lbb6x/w6/i+NAdiL2
	 AlLEbVdN5gb3LxU6cRNOa+cNpcVPjv+MgcpgGi9YkxzzXDoi3GmhAVe+I6xzXq1/QL
	 78PTCRIJ+7JRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: hash socket only after full initialisation
 in smc_sk_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahanta Jambigi" <mjambigi@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260813074315.554926-1-mjambigi@linux.ibm.com>
References: <20260813074315.554926-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:43:45 +0000
Message-Id: <20260814074345.F29311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data Race and Unsafe Publication leading to TOCTOU NULL pointer de=
reference in smc_diag_msg_common_fill
--

--- Patch [1]: [PATCH net] net/smc: hash socket only after full initialisat=
ion in smc_sk_init() ---
commit 86b5da4b01196842fbdd925890a17242339aa010
Author: Mahanta Jambigi <mjambigi@linux.ibm.com>

net/smc: hash socket only after full initialisation in smc_sk_init()

This commit delays hashing the SMC socket to the end of smc_sk_init() to
prevent concurrent hash walkers from observing an uninitialized socket.

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 00403175b7406..5e7560417ec70 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -409,13 +409,13 @@ void smc_sk_init(struct net *net, struct sock *sk, =
int protocol)
>  				      "sk_lock-AF_SMC", &smc_key);
>  	spin_lock_init(&smc->accept_q_lock);
>  	spin_lock_init(&smc->conn.send_lock);
> -	sk->sk_prot->hash(sk);
>  	mutex_init(&smc->clcsock_release_lock);
>  	smc_init_saved_callbacks(smc);
>  	smc->limit_smc_hs =3D net->smc.limit_smc_hs;
>  	smc->use_fallback =3D false; /* assume rdma capability first */
>  	smc->fallback_rsn =3D 0;
>  	smc_close_init(smc);
> +	sk->sk_prot->hash(sk);

[Severity: High]
This is a pre-existing issue, but does moving the hash here fully protect
hash walkers from seeing uninitialized socket state?

Even with this change, the socket is still hashed inside smc_sk_init(),
which is called by smc_sock_alloc() before caller-level initialization
completes. For instance, in smc_create():

net/smc/af_smc.c:smc_create() {
    ...
	sk =3D smc_sock_alloc(net, sock, protocol);
	if (!sk)
		goto out;

	rc =3D smc_create_clcsk(net, sk, family);
    ...
}

Because smc_sock_alloc() hashes the socket, it becomes visible to hash
walkers before smc_create_clcsk() assigns smc->clcsock.

A similar pattern occurs in smc_clcsock_accept():

net/smc/af_smc.c:smc_clcsock_accept() {
    ...
	new_sk =3D smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
    ...
	(*new_smc)->clcsock =3D new_clcsock;
    ...
}

Could this expose the socket to a TOCTOU race in smc_diag_msg_common_fill()?

That function accesses smc->clcsock locklessly without READ_ONCE():

net/smc/smc_diag.c:smc_diag_msg_common_fill() {
    ...
	if (!smc->clcsock)
		return;
	r->id.idiag_sport =3D htons(smc->clcsock->sk->sk_num);
    ...
}

Since the compiler might reload the pointer after the NULL check, a
concurrent update to smc->clcsock (either during initialization or when
smc_clcsock_release() sets it to NULL) could cause a NULL pointer
dereference.

>  }
> =20
>  static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813074315.5549=
26-1-mjambigi@linux.ibm.com?part=3D1
