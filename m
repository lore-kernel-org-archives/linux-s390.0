Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3F3749E8
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787898868; cv=none; b=EIZx9SkFsx1Xh9NO9ryYQcSTKUndfYlr2n4e1Jn3P0cbbr2e2ei+9vUGrBWji9d53dbH3rJMhvSAzPXHUW0GWJ5IrdOfJZnglpEm7E2lmoXwDZacCD8eRBOxp7IRouaWHxLGdksXgZebr7c3pGk/TTBFu1fYu6BPt3u4ydF+fsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787898868; c=relaxed/simple;
	bh=Z9v0s0DECC35iyjVL/msr9CJmJ9WC7sgJLU6YPXEx5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dlkdk8Q7I/LUUcza3OWRoq5nYtNXv0UzhOEouPsi/ro1jwbQkrNp+FXLe3I9H1GSxg4XlfFIzmp1VkX2OKCoXD1awN4tCJ2or8Uqg0cApeyj2q1hvXmJlPVSlvJB7k9PWC0DblagGpkOvOnRZ1imuk3nvN2darkz6yOvNr5/VV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuBLqvz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuBLqvz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6745F1F000E9;
	Fri, 28 Aug 2026 06:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787898866;
	bh=2BD1wAUrqsj+qVkoS0m5nIYRdDq1c8Dsubd/v4TCIYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HuBLqvz7qEiSjdAUGx19sVMsC3nAW3nmljL7h32u33j96SoQFPWvWI+BecXDMlwlT
	 MQFV7QLk87DciKGpRscXB7CUf8HZxtUqPjPQn3AyAEqRtigjQbfzzbRAGl7dcxQvR6
	 LvgVeySjQfD61UTiV9ANRkgSrohA2FNiu2odZM9Rp16cJlc86/8oQRIKsx/AmJMMbN
	 +iNpmB+kMuIKJgvZoGiBxGm/8bh9UwWkhBhDros8BVi22M2RfQ7T1Gjbx4gTFjUtRW
	 OavkHhW1Js+E/uv/sytySlVRnS6ji9+/BaNUdDWdOragtSCHJCngzAmbFb3+XgfnEx
	 iD6afU8/EQkpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] s390/ctcm: Prevent XID null dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aswin Karuvally" <aswin@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260827063408.2168914-1-aswin@linux.ibm.com>
References: <20260827063408.2168914-1-aswin@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:34:25 +0000
Message-Id: <20260828063426.6745F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer underflow when parsing XID buffer length in `mpc_valid=
ate_xid()` leads to bounds check bypass and an erroneously large maximum bu=
ffer size, causing `skb_over_panic` DoS.
- [High] Calling kfree() on `priv->xid` causes slab allocator corruption be=
cause it is an interior pointer to an SKB data buffer.
- [High] Active timers are not safely canceled during device removal, leadi=
ng to Use-After-Free.
- [High] The MPC group finite state machine (grp->fsm) and its associated s=
tate are accessed and modified concurrently from multiple contexts without =
any locking, leading to data races.
- [Medium] The `ch->xid_skb` buffer is leaked during MPC device removal/shu=
tdown.
- [Medium] Copying uninitialized channel receive buffer memory into a new S=
KB when receiving short packets.
--

commit a7c53ce617cb2637fa08d34df71dac23170822fd
Author: Aswin Karuvally <aswin@linux.ibm.com>

s390/ctcm: Prevent XID null dereference

This commit fixes a NULL pointer dereference in mpc_validate_xid() by
using priv->xid instead of grp->saved_xid2 for error signaling.

> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> index 08e36685e5788..61c88fe853c55 100644
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c
[ ... ]
> @@ -1636,7 +1636,6 @@ static int mpc_validate_xid(struct mpcg_info *mpcgi=
nfo)
>  			"The XID used in the MPC protocol is not valid, "
>  			"rc =3D %d\n", rc);
>  		priv->xid->xid2_flag2 =3D 0x40;

[Severity: High]
This is a pre-existing issue, but I noticed this lockless write to
priv->xid->xid2_flag2. Since FSM events for the group (grp->fsm) are
dispatched via the lockless fsm_event() function and can be triggered
concurrently from different tasklets or timer softirqs, can this
modification race with other contexts reading or writing this state?

A similar pattern occurs when grp->outstanding_xid7 is decremented
locklessly in mpc_action_rcvd_xid7().

> -		grp->saved_xid2->xid2_flag2 =3D 0x40;
>  	}
> =20
>  	return rc;

While reviewing this subsystem, I also noticed a few other pre-existing
issues in the surrounding code:


drivers/s390/net/ctcm_mpc.c:mpc_validate_xid() {
    ...
    if (xid->xid2_dlc_type =3D=3D XID2_READ_SIDE) {
        ...
        if (grp->group_max_buflen =3D=3D 0 || grp->group_max_buflen >
                        xid->xid2_buf_len - len)
            grp->group_max_buflen =3D xid->xid2_buf_len - len;
    }
    ...
}

[Severity: Critical]
This isn't a bug introduced by this patch, but does this buffer length
calculation suffer from an integer underflow?

The len variable is an int evaluated to 32. If a peer sends a small
xid2_buf_len (e.g., 16), the subtraction evaluates to a negative int.
Since grp->group_max_buflen is a __u16, the comparison bypasses the
bounds check, and the assignment casts the negative integer to a large
positive value (e.g., 65520).=20

Could this cause an skb_over_panic later in ctcmpc_chx_txdone() by
enqueuing more data than the allocated SKB can hold?


drivers/s390/net/ctcm_main.c:ctcm_free_netdevice() {
    ...
        if (grp->xid_skb)
            dev_kfree_skb(grp->xid_skb);
    ...
    if (priv->xid) {
        kfree(priv->xid);
        priv->xid =3D NULL;
    }
}

[Severity: High]
This is a pre-existing issue, but does calling kfree() on priv->xid
cause slab allocator corruption?=20

In ctcmpc_init_mpc_group(), grp->xid is initialized via
skb_tail_pointer(grp->xid_skb) which is an interior offset within the
SKB's data buffer, and priv->xid is assigned this value. Passing a
pointer that aliases the interior of an already-freed SKB to kfree()
appears to be an invalid free and a use-after-free.


drivers/s390/net/ctcm_main.c:channel_remove() {
    ...
        fsm_deltimer(&ch->timer);
        if (IS_MPC(ch))
            fsm_deltimer(&ch->sweep_timer);

        kfree_fsm(ch->fsm);
    ...
        kfree(ch);
}

[Severity: High]
This isn't a bug introduced by this patch, but are active timers safely
canceled here during device removal?=20

The fsm_deltimer() routine uses an asynchronous timer_delete(). If the
timer handler is executing concurrently on another CPU, would immediately
freeing the fsm and ch structures lead to a use-after-free?=20

Similarly, in ctcm_free_netdevice(), grp is freed without canceling
grp->timer.


drivers/s390/net/ctcm_main.c:channel_remove() {
    ...
        if (IS_MPC(ch)) {
            tasklet_kill(&ch->ch_tasklet);
            tasklet_kill(&ch->ch_disc_tasklet);
            kfree(ch->discontact_th);
        }
        kfree(ch->ccw);
        kfree(ch->irb);
        kfree(ch);
}

[Severity: Medium]
This is a pre-existing issue, but does this teardown path leak the
ch->xid_skb buffer?=20

For MPC devices, ctcm_shutdown_device() calls ctcm_close(), which is a
no-op, and channel_free() does not trigger DEV_EVENT_RXDOWN. Because the
event isn't sent to the device FSM, mpc_channel_action() isn't called to
properly free the MPC structures, and channel_remove() appears to leave
the SKB leaked.


drivers/s390/net/ctcm_fsms.c:mpc_action_dopacket() {
    ...
    default:
        len =3D TH_HEADER_LENGTH + XID2_LENGTH + 4;
        ...
        skb_put_data(new_skb, skb->data, len);
}

[Severity: Medium]
This isn't a bug introduced by this patch, but does unconditionally
copying ~270 bytes into the new SKB cause an out-of-bounds read when
receiving short packets?=20

If the actual received length from the CCW is shorter, this would copy
uninitialized channel receive buffer memory or stale data from previous
packets into the new SKB.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827063408.2168=
914-1-aswin@linux.ibm.com?part=3D1
