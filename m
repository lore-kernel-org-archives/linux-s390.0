Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074B18A6CF
	for <linux-s390@vger.kernel.org>; Sat,  8 Aug 2026 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177005; cv=none; b=CrH2SG0bgTeKXxvaDV+kjEUjLML6M27ngMfThOml9yH8HkGzPXHFn6v8f9io/e+0zNdejKsvUQRq0kSACMhqKF+d8KEATZ5W94fKgwN+oSnZzjfJZjjD4QeeN4XkIBIGxP7XRHcdzCAUyLZyp1pHF/mUTPWLepWM/JVAbM/8g8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177005; c=relaxed/simple;
	bh=6HMp5LrUk9bAryaCnhNpplhKZpjACeemF5DzBzPsg0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=roAjZ8NZNqq3TCLOYEv2lwUJjQe/g0uhu1YwyvmUOne88vIAVBSIg2/LiyaowpJNhNFl27429vLn70zr1qGMNcSfbfOuZrY5SK+QCBOfazrhzrzgbZZHlv5n4T74pU5RzJsTNrc71wXYiWEyeZf652Nrvj/XO2+uZWLDzFXVobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTg+H6tL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTg+H6tL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CA11F000E9;
	Sat,  8 Aug 2026 08:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786177003;
	bh=pkE6r3Tmx8s0FWxRW1fl7W4xyAb6VuDMrV/FJrL/7Ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YTg+H6tLptZ60lOiCzZ0aPTXJRfXWzAHWUXN3/pF3Ar8MbAHW+oUL1F9QY9BYvmii
	 q327IsR2jMhX5E7GVZrTWTibFm0CS1+JyvId96D8HDsbiIwpjYTectVawtc4xCA3NJ
	 TWLDkc9ouDQNtTPSnTMsoNWj6K8BhaLxzAvIy+vDhU4IzhEESRKRmAa46IFeBA0lVl
	 nOTCOJu3aoI9hmrz6uKEYGO2mAOjFmLLCZkxFtM47gG0o6EFCIJOkBNdWHm0vWJGSU
	 2u6HxR4p2SrX3urPWt4y8F0NjW5srKNKBnHPPgGVD/U4Oc/HLm8soi9zIPhzfATghJ
	 2zMOOkLpUulsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in
 smc_diag dump path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahanta Jambigi" <mjambigi@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
References: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 08:16:42 +0000
Message-Id: <20260808081643.35CA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping the hash lock per-socket and unconditionally restarting t=
he list walk from the head using a logical index introduces O(N^2) list tra=
versal complexity and causes active sockets to be skipped in the diag dump.

Pre-existing issues:
- [Critical] The patch attempts to fix a Use-After-Free race on `smc->clcso=
ck` by adding `clcsock_release_lock` in `smc_diag_msg_common_fill()`, but m=
isses a concurrent teardown path in `smc_accept_dequeue()` that frees the s=
ocket without acquiring the mutex.
--

--- Patch [1]: [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in smc=
_diag dump path ---
commit a16d6de2c1851166c340508a037e5292d66a0907
Author: Mahanta Jambigi <mjambigi@linux.ibm.com>

net/smc: fix clcsock and lgr/lnk races in smc_diag dump path

This commit attempts to fix two races in the SMC diag dump path by holding
clcsock_release_lock in smc_diag_msg_common_fill() and lock_sock() in
__smc_diag_dump(). It also modifies the dump iteration to pin sockets, drop
the hash lock, and restart the traversal from the head of the list.

> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index bf0beaa23bdb6..72d77360e504f 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -39,22 +39,34 @@ static void smc_diag_msg_common_fill(struct smc_diag_=
msg *r, struct sock *sk)
>  	memset(r, 0, sizeof(*r));
>  	r->diag_family =3D sk->sk_family;
>  	sock_diag_save_cookie(sk, r->id.idiag_cookie);
> -	if (!smc->clcsock)
> -		return;
> -	r->id.idiag_sport =3D htons(smc->clcsock->sk->sk_num);
> -	r->id.idiag_dst[0] =3D smc->clcsock->sk->sk_daddr;
> +	/*
> +	 * smc_clcsock_release() sets smc->clcsock =3D NULL under
> +	 * clcsock_release_lock before freeing the socket. Hold the same
> +	 * mutex here to make the NULL check and all field reads atomic
> +	 * with that writer. mutex_lock() is safe: this function is called
> +	 * only after the hash spinlock has been dropped by
> +	 * smc_diag_dump_proto().
> +	 */
> +	mutex_lock(&smc->clcsock_release_lock);
> +	if (smc->clcsock) {
> +		r->id.idiag_sport =3D htons(smc->clcsock->sk->sk_num);

[Severity: Critical]
This is a pre-existing issue, but does this mutex fully protect against
concurrent teardowns?

Looking at smc_accept_dequeue() in net/smc/af_smc.c, if an unaccepted socket
is closed (SMC_CLOSED), it unhashes it and frees isk->clcsock without holdi=
ng
clcsock_release_lock or the child's socket lock:

net/smc/af_smc.c:smc_accept_dequeue() {
    ...
    if (new_sk->sk_state =3D=3D SMC_CLOSED) {
        new_sk->sk_prot->unhash(new_sk);
        if (isk->clcsock) {
            sock_release(isk->clcsock);
            isk->clcsock =3D NULL;
        }
    ...
}

If the netlink diag dump thread concurrently iterates the hash table, grabs
the socket reference, and calls smc_diag_msg_common_fill(), could it acquire
the mutex, see a non-NULL clcsock, and dereference it while it is being fre=
ed
by smc_accept_dequeue()?

[ ... ]

> @@ -204,25 +228,43 @@ static int smc_diag_dump_proto(struct proto *prot, =
struct sk_buff *skb,
>  	int rc =3D 0, num =3D 0;
>  	struct sock *sk;
> =20
> -	read_lock(&prot->h.smc_hash->lock);
>  	head =3D &prot->h.smc_hash->ht;
> +restart:
> +	num =3D 0;
> +	read_lock(&prot->h.smc_hash->lock);
>  	if (hlist_empty(head))
>  		goto out;
> -
>  	sk_for_each(sk, head) {
>  		if (!net_eq(sock_net(sk), net))
>  			continue;
>  		if (num < snum)
>  			goto next;
> +		/*
> +		 * Pin sk before dropping the lock. refcount_inc_not_zero()
> +		 * skips sockets already past their last reference.
> +		 * smc_unhash_sk() nulls sk->sk_node.next via sk_del_node_init()
> +		 * so resuming an interrupted sk_for_each() would terminate
> +		 * early if a socket is unhashed while the lock is dropped.
> +		 * Restart from head after each unlock, using snum to skip
> +		 * already-dumped entries.
> +		 */
> +		if (!refcount_inc_not_zero(&sk->sk_refcnt))
> +			goto next;
> +		read_unlock(&prot->h.smc_hash->lock);
> +
>  		rc =3D __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
> +		sock_put(sk);
> +
>  		if (rc < 0)
> -			goto out;
> +			goto out_nolock;
> +		snum =3D num + 1;
> +		goto restart;

[Severity: High]
Does restarting the list walk from the head using a logical index (snum)
introduce an O(N^2) list traversal complexity?

If any previously seen sockets are concurrently unhashed while the lock is
dropped, could stepping over (num < snum) elements skip active sockets that
shifted to earlier positions in the list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807081606.3200=
128-1-mjambigi@linux.ibm.com?part=3D1
