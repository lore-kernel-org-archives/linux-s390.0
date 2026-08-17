Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2F46C82F;
	Mon, 17 Aug 2026 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988515; cv=none; b=eUXuYIPlcHh5st145OW4tSId532C0BuD+NZ78K0kn8TJCHhb2OioPAwDEflpwpjvK7vl3Pvq4A4TPyu2G3u5fA/slss/6rhj1w2lUMwByJ+zGe2ZFBtR+PVfpbWhVfapXJYNkTnuX1GccYgvZV/gpyoTXLeaa1lXevY2rDDw18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988515; c=relaxed/simple;
	bh=8Equ6s3jma4b4JK0vM+cVWpGaX9fj7tjjGyNtvXPOmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpVjvYfX3qQQb7lD5mjoUoZHhK/52NViWsJKdwx4fWPgrZHuPA/HPZiD90TQTLTHTn2mkO/wLUcb0AQ1w0b2pUQp16PjUXenZX2BFXV7AT8Hf7vKZOiZ4HCpMdEdOjKByGaprzeWzRo90kgiajbeU/Vm3ykTscR2RgcKFtmn7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LygHQ/AW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LygHQ/AW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B631F000E9;
	Mon, 17 Aug 2026 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786988510;
	bh=bun6Ljm8DGOJs1UWkTe3gMY0MXdhrbLswUWPlvlwNek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LygHQ/AWIndUf6HRp1BabUzXLgunWkWGjwYE1opJDL/o4J4L7eLrD+p1JXJpJQ9Ze
	 XHDEY8m3sgTD7gTekejvkOYmPFw0NMIX2cx82hq4BjyRb4kmVD9wMZN/HBTRVF9ZMl
	 XSNQ9LXQDvqqmS2Rx9wUNfDbm0KeXXhFAyWo1zc+tEHUNfNj0BcoW/ewmlRL8hNDqw
	 T7WJQ96FcIs06db1Nwm/S6XEoiT0ZuKxsjQi4i4W6xMhN4mSVU6qYhHrE6ztS6MXlL
	 9K4javdvq0b9zRDGHDr7YJuu9ICpE78+WqhwTF9aj2pqA28La4BmgCBNU9jTNBAGa2
	 FLtR+r8XmiGNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: aswin@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	wintera@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	horms@kernel.org,
	jeff@garzik.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] s390/ctcm: Prevent XID null dereference
Date: Mon, 17 Aug 2026 10:41:48 -0700
Message-ID: <20260817174148.3456594-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809105536.541453-1-aswin@linux.ibm.com>
References: <20260809105536.541453-1-aswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
s390/ctcm: Prevent XID null dereference

This patch adds a NULL check before writing the 0x40 validation-error flag
into grp->saved_xid2->xid2_flag2 in mpc_validate_xid(), and teaches
mpc_action_go_ready() to treat an uninitialized grp->saved_xid2 as a
validation error.

A few questions about the new guards and about the surrounding code they
interact with.

> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> index aeb102537e7f..a5b55fe6b110 100644
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c
> @@ -826,7 +826,7 @@ static void mpc_action_go_ready(fsm_instance *fsm, int event, void *arg)
>  
>  	fsm_deltimer(&grp->timer);
>  
> -	if (grp->saved_xid2->xid2_flag2 == 0x40) {
> +	if (!grp->saved_xid2 || grp->saved_xid2->xid2_flag2 == 0x40) {

[Severity: Medium]
This is a pre-existing issue, but can the new check still be defeated by a
concurrent writer?  The condition performs two separate loads of
grp->saved_xid2 with no lock, READ_ONCE() or barrier:

	if (!grp->saved_xid2 || grp->saved_xid2->xid2_flag2 == 0x40) {

grp->saved_xid2 is stored to NULL by mpc_action_go_inop() without any lock
held, and that path is reachable from ctcm_irq_handler() in hardirq context
via the channel FSM actions in ctcm_fsms.c that raise MPCG_EVENT_INOP, as
well as from the FSM timers.  If the NULL store lands between the two
loads, the guarded dereference still faults.  The only locks in this file
are ch->collect_lock and the ccw device lock, neither of which covers the
group state.

Note also that fsm_deltimer() just calls timer_delete():

drivers/s390/net/fsm.c:fsm_deltimer() {
	timer_delete(&this->tl);
}

so the fsm_deltimer(&grp->timer) above does not wait for an already-running
mpc_action_timeout() -> MPCG_EVENT_INOP callback on another CPU.  Would a
snapshot load, or real group-level locking with spin_lock_irqsave() since
one writer runs in hardirq, be more appropriate here?

>  		priv->xid->xid2_flag2 = 0x00;
>  		if (grp->estconnfunc) {
>  			grp->estconnfunc(grp->port_num, 1,
> @@ -1636,7 +1636,13 @@ static int mpc_validate_xid(struct mpcg_info *mpcginfo)
>  			"The XID used in the MPC protocol is not valid, "
>  			"rc = %d\n", rc);
>  		priv->xid->xid2_flag2 = 0x40;
> -		grp->saved_xid2->xid2_flag2 = 0x40;
> +
> +		/* If xid is NULL (rc=1) or r/w channel pairing mismatch
> +		 * (rc=2) happens, grp->saved_xid2 is never initialized
> +		 * and becomes NULL
> +		 */
> +		if (grp->saved_xid2)
> +			grp->saved_xid2->xid2_flag2 = 0x40;

[Severity: High]
Does skipping this store lose the rejection entirely?

grp->saved_xid2->xid2_flag2 looks like the only place the MPC group FSM
records a failed validation.  The other candidates do not seem to be read
anywhere:

  - both callers, mpc_action_rcvd_xid0() and mpc_action_rcvd_xid7(),
    discard the return value of mpc_validate_xid() and advance the FSM on
    the outstanding-XID counters alone
  - priv->xid->xid2_flag2 is only written, never tested
  - grp->xidnogood is only ever assigned 0 and never tested

So when the first XID for a group is rejected with rc = 2 (r/w channel
pairing mismatch), nothing is latched, and the next XID takes the
initialization branch:

	if (grp->saved_xid2 == NULL) {
		grp->saved_xid2 =
			(struct xid2 *)skb_tail_pointer(grp->rcvd_xid_skb);

		skb_put_data(grp->rcvd_xid_skb, xid, XID2_LENGTH);

which installs the peer record with xid2_flag2 == 0.  At that point the new
!grp->saved_xid2 test in mpc_action_go_ready() no longer fires and the
group is driven to MPCG_STATE_READY despite the earlier rejection.

The rc = 2 early exit also skips the buffer-length negotiation:

	if (xid->xid2_dlc_type == XID2_READ_SIDE) {
		...
		if (grp->group_max_buflen == 0 || grp->group_max_buflen >
						xid->xid2_buf_len - len)
			grp->group_max_buflen = xid->xid2_buf_len - len;

so a peer that first sends an XID with xid2_dlc_type == XID2_WRITE_SIDE on
our write channel (rc = 2, nothing latched, buflen not updated) and then a
well-formed XID2_WRITE_SIDE XID on our read channel gets to READY with
grp->group_max_buflen == 0.  ctcmpc_chx_txdone() then computes the tx copy
budget into a __u32:

drivers/s390/net/ctcm_fsms.c:ctcmpc_chx_txdone() {
	__u32		data_space;
	...
	data_space = grp->group_max_buflen - TH_HEADER_LENGTH;

which underflows to 0xFFFFFFF8, so the collect_queue drain loop keeps
calling skb_put_data() into ch->trans_skb with no effective bound and can
reach skb_over_panic().

Secondary effect: because mpc_action_go_ready() takes the success branch,
priv->xid->xid2_flag2 is never reset to 0x00, and since priv->xid aliases
grp->xid inside grp->xid_skb, which mpc_channel_action() copies into every
channel XID:

		skb_put_data(ch->xid_skb, grp->xid_skb->data,
			     grp->xid_skb->len);

later negotiations keep advertising NOGOOD.  Pre-patch this sequence oopsed
on the NULL dereference instead, so reaching READY after a rejected XID is
newly reachable.  Would latching the rejection, for example in
grp->xidnogood or by forcing MPCG_EVENT_INOP, be preferable to dropping it?

[Severity: Low]
This isn't a bug, but the new comment states an invariant the code does not
have.  "grp->saved_xid2 is never initialized and becomes NULL" reads as if
the rc = 1 and rc = 2 paths clear the pointer.  The pointer is sticky
instead: the only non-NULL assignment is guarded by
if (grp->saved_xid2 == NULL), and it is reset to NULL only by the group
init/inop/alloc/establish paths.  An rc = 2 rejection that happens after an
earlier XID was accepted therefore runs with grp->saved_xid2 non-NULL.

The rc = 1 case named in the comment also does not look reachable.
ctcmpc_unpack_skb() sets mpcginfo->xid unconditionally right before raising
the event:

			mpcginfo->xid = thisxid;
			fsm_event(grp->fsm, MPCG_EVENT_XID2, mpcginfo);

and MPCG_EVENT_XID2 is the only event dispatching
mpc_action_rcvd_xid0()/mpc_action_rcvd_xid7(), the only callers of
mpc_validate_xid().  Could the comment be reworded to say simply that
grp->saved_xid2 may not have been initialized yet?

The same wording appears in the commit message: "If peer XID is NULL or r/w
channel pairing mismatch happens, grp->saved_xid2 is never initialized."

[Severity: High]
This isn't introduced by this patch, but it sits in the function being
modified: is xid->xid2_buf_len validated anywhere before it becomes the tx
copy budget?  In mpc_validate_xid():

	int	len = TH_HEADER_LENGTH + PDU_HEADER_LENGTH;
	...
		if (grp->group_max_buflen == 0 || grp->group_max_buflen >
						xid->xid2_buf_len - len)
			grp->group_max_buflen = xid->xid2_buf_len - len;

The subtraction is done in int and stored into the __u16
grp->group_max_buflen, so a peer advertising xid2_buf_len == 0 yields
65524, and xid2_buf_len == 12 yields exactly 0, which the "== 0" test then
treats as "not negotiated" forever.  There is no clamp against
ch->max_bufsize either.

group_max_buflen == 0 then underflows data_space in ctcmpc_chx_txdone() as
described above, and the MPC tx path queues without a length cap:

drivers/s390/net/ctcm_main.c:ctcmpc_transmit_skb() {
		skb_queue_tail(&ch->collect_queue, skb);
		ch->collect_len += skb->len;

unlike ctcm_transmit_skb(), which checks collect_len against
max_bufsize - 2.  Should mpc_validate_xid() reject xid2_buf_len <= len and
clamp the result to ch->max_bufsize?

[Severity: Medium]
This is also pre-existing, but in the same function the shared pointer is
published before the memory it points at is initialized:

	if (grp->saved_xid2 == NULL) {
		grp->saved_xid2 =
			(struct xid2 *)skb_tail_pointer(grp->rcvd_xid_skb);

		skb_put_data(grp->rcvd_xid_skb, xid, XID2_LENGTH);
		grp->rcvd_xid_skb->data = grp->rcvd_xid_data;

mpc_validate_xid() runs from the read-channel and write-channel tasklets
(separate ch->ch_tasklet instances for the same grp), so can both CPUs see
grp->saved_xid2 == NULL, both publish, and both skb_put_data() into
grp->rcvd_xid_skb while resetting its data/tail/len?  The reader in the
else branch dereferences the pointer with no lock or acquire barrier:

		if (xid->xid2_flag4 != grp->saved_xid2->xid2_flag4) {

so it can compare against a published-but-uninitialized record.  Adding a
NULL check does not make this access safe on its own.

>  	}
>  
>  	return rc;

[Severity: High]
This isn't a bug introduced by this patch, but since the patch writes
through priv->xid in both hunks, the lifetime of that pointer looks wrong.
ctcm_free_netdevice() in drivers/s390/net/ctcm_main.c does:

		dev_kfree_skb(grp->xid_skb);
		dev_kfree_skb(grp->rcvd_xid_skb);
		...
		kfree(priv->xid);
		priv->xid = NULL;

but priv->xid is never a standalone allocation.  The only assignment is in
ctcmpc_init_mpc_group():

	grp->xid = (struct xid2 *)skb_tail_pointer(grp->xid_skb);
	...
	priv->xid = grp->xid;

taken after a TH header was put, so it is an interior pointer into
grp->xid_skb's data buffer, and that skb was already released by
dev_kfree_skb(grp->xid_skb) a few lines earlier.  Is the kfree() therefore
both a use-after-free and an invalid free of a non-allocation-start address?
grp->xid_skb comes from __dev_alloc_skb(MPC_BUFSIZE_DEFAULT), i.e. a large
kmalloc, so kfree() on head plus an offset would try to release the folio
again.  Reachable from ctcm_remove_device() -> unregister_netdev() ->
ctcm_free_netdevice() and from the ctcm_new_device() error path on any MPC
device.
-- 
pw-bot: cr
