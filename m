Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775C3B7B9D
	for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359368; cv=none; b=X4lFQPo3fu/jNwe8fLjnSi7WoUGeUz4Mm7SHz1JFY2+78TR1tsXgwulKyTOKiPyOFnFGJe18aQq7vaUVlwzv5sljRr1vsAj/x+ApaI5uLPn/iUSvffQAyzXQ272L5d4mLU8QFiY7Xf0GupmYQiQ7eVFOc0EC1TWaofLUCPqur5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359368; c=relaxed/simple;
	bh=3XJuS1zJZghLe6cvepipcunHvSHlmm6kBCnnioMmGsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Of+55TgA0A2Go++HhobOB69zwiYYpi75+oBpvT4VGyyDunAufLYqVrY/GRRIs8W31fUTOyCycMoh7EUu3TEi1MeulWLyqSKr/onqoEb/w8hsg/98+pqzN6JWO9GOurWeTxk1PuOxFmY048fVP1JIQWK5uvlc67F1hxVIAqpiVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVQYU0bE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVQYU0bE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0E51F000E9;
	Mon, 10 Aug 2026 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359367;
	bh=0MfB6rws/efGLwRkrofynejxh/vaHHECQvNhANUSRI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UVQYU0bE8/INexTPTDScRfxR+JhgRyOLeennQL33vfs8G1flFf7Cq2Q8MZ8ovr/j0
	 8b2C0CwJxTCntGXRockSALXyStNRfaV0dg11QQOsJIxM6uGobCcj7upM2GCeP0r2n2
	 1j1YVGZ27CzevvRWSQLnFCFErhRBlOCKnxOIbu9furDDH2WE5o7IdoDK9d02Rxph+4
	 kLFlenGYtqx3vdJTUi3GtP8kfmi9fGKLh53vbfPUW/vG191ed7t1yh9camLODlIdos
	 66kF+hXNaE9+uGB76w2pLJw/jIy/ORxO4qiwCe9Bc56U4rDWupIV1ldR5C2cu4T+uI
	 esqdNSO9pA21w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] s390/ctcm: Prevent XID null dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aswin Karuvally" <aswin@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260809105536.541453-1-aswin@linux.ibm.com>
References: <20260809105536.541453-1-aswin@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:56:06 +0000
Message-Id: <20260810105606.CB0E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The XID validation logic creates an asymmetric error handling flaw=
 where a failure on the first processed channel is silently ignored if the =
second channel succeeds, allowing the group to incorrectly transition to th=
e READY state.

Pre-existing issues:
- [High] Calling `kfree()` on an interior pointer to a previously freed sk_=
buff data buffer during device teardown.
- [High] An integer underflow when calculating `group_max_buflen` from untr=
usted network input can lead to a massively oversized buffer limit, potenti=
ally causing an `skb_put` panic during transmission.
- [High] Device teardown frees core structures without synchronously cancel=
ling FSM timers, leading to a Use-After-Free.
- [High] Group FSM state is accessed concurrently without locks, leading to=
 data races on shared variables.
--

--- Patch [1]: [PATCH net] s390/ctcm: Prevent XID null dereference ---
commit eba778bf6c3c6c80501b99041bb51b27ad5c49b6
Author: Aswin Karuvally <aswin@linux.ibm.com>
Subject: s390/ctcm: Prevent XID null dereference

The mpc_validate_xid() function sets grp->saved_xid2->xid2_flag2 to 0x40
to signal XID validation error. This commit updates it to prevent a null
dereference if the peer XID is NULL or an r/w channel pairing mismatch
occurs. It also updates mpc_action_go_ready() to handle the uninitialized
structure.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c
> @@ -826,7 +826,7 @@ static void mpc_action_go_ready(fsm_instance *fsm, in=
t event, void *arg)
> =20
>  	fsm_deltimer(&grp->timer);

[Severity: High]
This is a pre-existing issue, but I am curious about the teardown sequence
when cancelling timers here and during interface removal.

fsm_deltimer() wraps timer_delete(), which doesn't wait for concurrent
timer callbacks to finish.

If a timer expires concurrently during device teardown (ctc_mpc_dealloc_ch)
while the driver proceeds to free grp and grp->fsm, could the executing
timer callback dereference freed memory when it calls fsm_event()?

> -	if (grp->saved_xid2->xid2_flag2 =3D=3D 0x40) {
> +	if (!grp->saved_xid2 || grp->saved_xid2->xid2_flag2 =3D=3D 0x40) {

[Severity: High]
If the first channel fails validation (e.g., mismatched direction) and sets
priv->xid->xid2_flag2 to 0x40, grp->saved_xid2 remains NULL.

If the second channel then succeeds, it initializes grp->saved_xid2 with a
valid xid where xid2_flag2 is 0x00.=20

Since this check only evaluates grp->saved_xid2->xid2_flag2, could this
allow the state machine to falsely bypass the check and transition to the
ready state, completely ignoring the earlier failure stored in
priv->xid->xid2_flag2?


[Severity: High]
This is a pre-existing issue, but does this state machine implementation
have data races on shared group state variables?

The read and write channels are separate ccw_device instances, so their
irq handlers use different locks. Because fsm_event() dispatches actions
without internal synchronization:

fsm_event()
    state =3D atomic_read(&fi->state);
    // executes action directly

Can concurrent irq handlers from different channels execute read-modify-wri=
te
operations on shared fields (like grp->outstanding_xid2--) simultaneously,
corrupting the state?

>  		priv->xid->xid2_flag2 =3D 0x00;
>  		if (grp->estconnfunc) {

[ ... ]

> @@ -1636,7 +1636,13 @@ static int mpc_validate_xid(struct mpcg_info *mpcg=
info)

[Severity: High]
This is a pre-existing issue, but could the buffer calculation earlier in
mpc_validate_xid() underflow?

mpc_validate_xid() receives an untrusted xid2_buf_len from the network:

    if (grp->group_max_buflen =3D=3D 0 || grp->group_max_buflen > xid->xid2=
_buf_len - len)
        grp->group_max_buflen =3D xid->xid2_buf_len - len;
   =20
If xid->xid2_buf_len is less than len, does the subtraction underflow to a
huge value?

Since data_space is calculated as grp->group_max_buflen - TH_HEADER_LENGTH
in ctcmpc_chx_txdone(), and skb_put_data() relies on it, can this trigger
an skb_over_panic when packing data into the transmit sk_buff?

>  			"The XID used in the MPC protocol is not valid, "
>  			"rc =3D %d\n", rc);
>  		priv->xid->xid2_flag2 =3D 0x40;
> -		grp->saved_xid2->xid2_flag2 =3D 0x40;
> +
> +		/* If xid is NULL (rc=3D1) or r/w channel pairing mismatch
> +		 * (rc=3D2) happens, grp->saved_xid2 is never initialized
> +		 * and becomes NULL
> +		 */
> +		if (grp->saved_xid2)
> +			grp->saved_xid2->xid2_flag2 =3D 0x40;
>  	}
> =20
>  	return rc;

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the lifecycle of
these pointers during teardown.=20
   =20
When the group is initialized:

ctcmpc_init_mpc_group()
    grp->xid =3D (struct xid2 *)skb_tail_pointer(grp->xid_skb);
    ...
    priv->xid =3D grp->xid;
   =20
During device teardown:

ctcm_free_netdevice()
    dev_kfree_skb(grp->xid_skb);
    ...
    kfree(priv->xid);

Does this sequence cause a use-after-free and an invalid free by passing an
interior pointer of the already freed sk_buff data buffer directly to
kfree()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809105536.5414=
53-1-aswin@linux.ibm.com?part=3D1
