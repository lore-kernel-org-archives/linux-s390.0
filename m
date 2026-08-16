Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB2222590
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786894990; cv=none; b=llNfEI//AhHQTk2xN0M4+X4vyDWosWUHr/HJtSLMVKmiYNQjr0NpWdTm2STM4lKi+kdE+ZVMeb1mVgmeG02/5uSr/ExhGaCFq8/jj3XUdvfUjC8IhqobgQPDotFugPYhuaBxsvvLKeWvSGfEkXsklFuuh53dmFX5Fh92yalED1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786894990; c=relaxed/simple;
	bh=n/TVkn6z3PQ1MgDkxkSi2qfCosaPP9XR+Wt7U6uPSAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ynh/tf6lhJ2I1fK59QmP35weflEMdeWoPbiolIptm0yQ58CPzkKu8vz0E1ARy5eTboX8ZXcEDEj0VddZ1htR4zz47E98bKUaPiKy9q6dP5v73JfAkiR6hHKkehGDofsz027ZBrqxDzDYINV17BGF+0sA2EUKnEgfXN/eFnpnHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwHEXzpU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwHEXzpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACAB1F000E9;
	Sun, 16 Aug 2026 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786894988;
	bh=1A6f3aRFWDp0P+00Mkr8Rxx4T1fedb1C58eHMDfELqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwHEXzpUTPc3kt7eDrCCxrf/dsdRo1MvH/DbGCKT82z71vgwmWf3k8kOSTUdpcC6P
	 tKyisCL98+6SVSLbgAff56tWPOU0FbvoEfExDoBGv58eGF2W/b+3MHTXyGetDsVWup
	 DixllJwJsULd0+J7KVp/JCY+pjm4DgGV3cE3bWqTqEi2ASG+s1wN7ppD/wiGS/s6FD
	 RWCwx/IoCqoba0Z5eAWpyOaO1uU7qI2wvxcKbiiBniGQEcHMg3mSWJRVVFYOJh3T1w
	 2X8pmXr4SZ1aPpAjePaCmeVeqP/T+1l0Mr1nrqml6uYI4g9C+IkjSsDCziXvmu5aAh
	 OLIE4XrGW9rnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/iucv: reconcile the socket state when connect()
 severs the path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260815-b4-disp-e1faf4b7-v1-1-2a8a143a0055@proton.me>
References: <20260815-b4-disp-e1faf4b7-v1-1-2a8a143a0055@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 15:43:08 +0000
Message-Id: <20260816154308.7ACAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The IUCV tasklet callback `iucv_callback_connrej` ignores sock=
et ownership, leading to asynchronous nullification and freeing of `iucv->p=
ath` while process-context socket functions (like `iucv_sock_sendmsg`) are =
concurrently dereferencing it, causing a Use-After-Free or NULL pointer der=
eference.
--

--- Patch [1]: [PATCH net] net/iucv: reconcile the socket state when connec=
t() severs the path ---
commit 8d8ee46f28106e54c267f0a51094885740ee5c07
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: reconcile the socket state when connect() severs the path

This commit ensures a failed connect properly returns the socket state to
disconnected. This prevents a race where a connack lands between the wait
and sever, causing a later sendmsg() to dereference a NULL path pointer.

Cc: stable@vger.kernel.org

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7c..6fb0041c4c987 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -778,8 +778,16 @@ static int iucv_sock_connect(struct socket *sock, st=
ruct sockaddr_unsized *addr,
>  	if (sk->sk_state =3D=3D IUCV_DISCONN || sk->sk_state =3D=3D IUCV_CLOSED)
>  		err =3D -ECONNREFUSED;
> =20
> -	if (err && iucv->transport =3D=3D AF_IUCV_TRANS_IUCV)
> +	if (err && iucv->transport =3D=3D AF_IUCV_TRANS_IUCV) {
>  		iucv_sever_path(sk, 0);
> +		/* A connack may have landed while the wait was unwinding; the
> +		 * path is gone, so the socket must not still claim it.
> +		 */
> +		if (sk->sk_state =3D=3D IUCV_CONNECTED) {
> +			sk->sk_state =3D IUCV_DISCONN;
> +			sk->sk_state_change(sk);
> +		}
> +	}

[Severity: Critical]
This is a pre-existing issue, but looking at how the iucv tasklets interact
with the socket state, can a remote sever cause a NULL pointer dereference
while process context holds the socket lock?

The tasklet callback iucv_callback_connrej() acquires the spinlock via
bh_lock_sock(sk) and calls iucv_sever_path(sk, 1) unconditionally. It does
not check sock_owned_by_user(sk) to defer execution if the process context
currently holds lock_sock():

net/iucv/af_iucv.c:iucv_callback_connrej() {
        ...
        bh_lock_sock(sk);
        iucv_sever_path(sk, 1);
        sk->sk_state =3D IUCV_DISCONN;
        sk->sk_state_change(sk);
        bh_unlock_sock(sk);
        ...
}

Since lock_sock() enables bottom-halves (setting owned=3D1 but releasing
slock), a tasklet can interrupt it. If iucv_sock_sendmsg() is running in
process context, it checks the socket state and then dereferences iucv->pat=
h:

net/iucv/af_iucv.c:iucv_sock_sendmsg() {
        ...
        if (((iucv->path->flags & IUCV_IPRMDATA) & iucv->flags) &&
            skb->len <=3D 7) {
        ...
}

Similarly, if the tasklet interrupts iucv_below_msglim() right after the
state check but before the dereference:

net/iucv/af_iucv.c:iucv_below_msglim() {
        ...
        if (sk->sk_state !=3D IUCV_CONNECTED)
                return 1;
        if (iucv->transport =3D=3D AF_IUCV_TRANS_IUCV)
                return (atomic_read(&iucv->skbs_in_xmit) <
                        iucv->path->msglim);
        ...
}

Could the tasklet free and nullify iucv->path concurrently, resulting in a
use-after-free or NULL pointer dereference in these cases?

> =20
>  done:
>  	release_sock(sk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-b4-disp-e1=
faf4b7-v1-1-2a8a143a0055@proton.me?part=3D1
