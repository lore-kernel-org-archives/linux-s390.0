Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626083D75BC
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448236; cv=none; b=UuB9Vzmzw/hffwDT72PO/uBqLGI0MaIowaM5j550tQruOt4WM3tPHOOAsnAscJ+hxvC3yGPQfhdnrbSor1xJrDhILvJx2ENefmV0Nv0fZhcvIZtltnwfZj+ElCPAg0FJQAU5e6N9qvO1t5q4R/yXSZRn5yAi6wKlVhokP//8Ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448236; c=relaxed/simple;
	bh=+BgyRqNsX12WODVJAIU77gYI3+pNut6TiwacLPqm4sc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=n6RDCeDK45fHHoJI/aNeaC0tBvTFPqbsM8hBRGpNbaZca82X2ClujeqpXhIvho+WoQIAozyX4x3pVQES30ptIptmzMNTM9OZckQcLS2GBLho7ZCvBPrCGj4NwvoEH8/qU5ZBz2Nk2lwcPxLbFcw4eW5vdRE+VAI6Wx5kCMJQGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1WxzQqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1WxzQqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDFA1F000FF;
	Thu,  8 Oct 2026 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791448235;
	bh=eA82Smeb6En1RPiveSYwWnUpujkuzu9AGmKyRg+BzCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M1WxzQqnMrXjpGn8WIRMe4qL3WOxbgI8h8uvtxljtVBU91KqglRR3g7r86BvHS0Lv
	 nL8Q/5LyxIM/ECqR+zuydKWtkpiTeiHOWnT95NWiKwN8kVcRpQpvx1nh+Wb8WZUBVo
	 ySocJ3Vd19TmOy6crK4t0TyxAZDIOH9PQjsxxINUkQ67hhFUDpiDg83CuaJZw2nAGG
	 qZPr4WukokKQddLyTqRMm3WJ94T04T07pb8oXvUpuJ3AX76Owg+aoooVT0o4NyL1Qw
	 jh+BaXClY5DF0zQTfGKnAPrCXTkuLcN356t4HoCG5ZHer8G0JXYaxB477Li6Q1mun9
	 hFWs6IT7PPKNw==
Message-ID: <sashiko-outbox-163841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] dibs: introduce dibs block device peer device
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julian Ruess" <julianr@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261008-console_server-v1-4-636b11ebf191@linux.ibm.com>
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
 <20261008-console_server-v1-4-636b11ebf191@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:30:34 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 15 potential issue=
(s) to consider:
- [Critical] dibs: data corruption due to missing request sequence numbers
- [High] dibs: UAF in worker due to unregistering ring buffer before cancel=
_work_sync
- [High] block: UAF of tag_set and driver data on queue teardown
- [High] block: uninitialized tag_set usage due to early ring buffer regist=
ration
- [High] dibs: race condition on device_add_disk state causes NULL derefere=
nce
- [High] dibs: UAF of blkpd due to media_gone_work scheduled after cancella=
tion
- [High] dibs: UAF / Race condition accessing unregistered ring buffer from=
 queue_rq
- [High] dibs: TOCTOU bounds check bypass via shared memory mutation
- [High] block: deadlock in dibs_blk_peer_dev_remove during teardown
- [Medium] dibs: UAF of blkpd in worker due to missing cancel_work_sync on =
probe error
- [Medium] block: API misuse exhausts dynamic major numbers and overflows m=
inor numbers
- [Medium] block: double-unquiesce warning triggered by unsynchronized stat=
e access
- [Medium] dibs: Out-of-bounds read accessing message payload length fields
- [Medium] block: disk_name truncation causes sysfs naming collisions
- [Low] block: snprintf truncation causes sysfs name collisions
--

commit c8b558951c6dbf245b6e9d1bfed2adc0596fda35
Author: Julian Ruess <julianr@linux.ibm.com>
Subject: dibs: introduce dibs block device peer device driver

This introduces a virtual block device driver that uses the newly added dibs
peer device bus. It allows access to resources like an ISO file hosted on
another system via dibs. A block device is created when a dibs peer device
of type block is announced.

Hello,

Thanks for the patch. I noticed a few potential issues with the teardown
and communication logic that might need a closer look.

> diff --git a/drivers/dibs/dibs_blk.c b/drivers/dibs/dibs_blk.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dibs/dibs_blk.c
> @@ -0,0 +1,798 @@
[ ... ]
> +static blk_status_t dibs_blk_queue_rq(struct blk_mq_hw_ctx *hctx,
> +				      const struct blk_mq_queue_data *bd)
> +{
[ ... ]
> +	blkpd =3D bd->rq->q->disk->private_data;
> +
> +	if (!blkpd->device_add_disk || !blkpd->ring_registered)
> +		return BLK_STS_IOERR;

[Severity: High]
Could concurrent userspace I/O access the unregistered ring buffer here?

In dibs_blk_peer_dev_remove(), the driver calls
dibs_pbd_unregister_ring_buffer() to unmap and free the ring buffer memory
before calling blk_mark_disk_dead() and del_gendisk().

Because the queue is still active, concurrent userspace I/O can enter
dibs_blk_queue_rq() while the ring buffer is being unregistered. This
lockless check might pass before the ring_registered flag is cleared,
causing dibs_pbd_msg_send() to attempt writing to the freed memory.

[ ... ]
> +static void dibs_blk_unquiesce(struct dibs_blk_peer_dev *blkpd)
> +{
> +	if (!blkpd->blk.quiesced)
> +		return;
> +
> +	blkpd->blk.quiesced =3D false;

[Severity: Medium]
Could this unsynchronized state access trigger a double-unquiesce warning?

If dibs_blk_unquiesce() is called concurrently from media_gone_work and
handle_disk_detach, both threads might read quiesced as true and proceed
to call blk_mq_unquiesce_queue().

This second call would drop q->quiesce_depth below zero, triggering a
WARN_ON_ONCE(q->quiesce_depth <=3D 0) in blk_mq_unquiesce_queue().

[ ... ]
> +static enum blk_eh_timer_return dibs_blk_timeout(struct request *req)
> +{
[ ... ]
> +	blk_mq_end_request(req, BLK_STS_IOERR);
> +	schedule_work(&blkpd->media_gone_work);

[Severity: High]
Can media_gone_work be scheduled after it has been cancelled?

In dibs_blk_peer_dev_remove(), cancel_work_sync(&blkpd->media_gone_work)
is called before iterating the tags to cancel inflight requests. Before
those requests are cancelled, a timer could expire, triggering this
timeout handler.

This explicitly calls schedule_work(&blkpd->media_gone_work) after the
cancellation has finished. The newly scheduled work will execute later and
dereference the freed blkpd structure.

[ ... ]
> +static void dibs_blk_handle_data_msg(struct dibs_blk_peer_dev *blkpd,
> +				     void *current_data, u64 data_len,
> +				     u64 total_bytes_of_request)
> +{
[ ... ]
> +	req =3D blkpd->current_request;
> +	if (!req) {
> +		spin_unlock_irqrestore(&blkpd->req_lock, flags);
> +		pr_warn("Received response for unknown request\n");
> +		return;
> +	}
> +
> +	blkpd->last_completion =3D jiffies;
> +	blkpd->first_timeout =3D 0;
> +
> +	if (total_bytes_of_request !=3D blk_rq_bytes(req)) {

[Severity: Critical]
How does the driver guarantee this response belongs to the current request?

The dibs block protocol appears to lack transaction IDs or sequence numbers.
If a block request times out, dibs_blk_timeout() clears current_request
and completes it with an error. The block layer can immediately dispatch a
new request, assigning it to current_request.

When the remote peer later sends the delayed data response for the original
request, this code blindly accepts it for the new current_request because
the lengths often match for identical block sizes. This would cause stale
data from the old request to be copied into the new request's bio buffers,
corrupting filesystem data.

[ ... ]
> +static void dibs_blk_media_change_work(struct work_struct *work)
> +{
> +	struct dibs_blk_peer_dev *blkpd;
> +	int ret;
> +
> +	blkpd =3D container_of(work, struct dibs_blk_peer_dev, media_change_wor=
k);
> +
> +	if (!blkpd->device_add_disk) {
> +		blkpd->blk.gd =3D blk_mq_alloc_disk(&blkpd->blk.tag_set,
> +						  &dibs_blk_lim, &blkpd->blk);
[ ... ]
> +		blkpd->blk.gd->first_minor =3D
> +			blkpd->device_index * MAX_GPT_PARTITIONS;

[Severity: Medium]
Will this multiplication lead to minor number overflow?

In probe(), the driver allocates a dynamic major number per device via
register_blkdev(0, "dibs_blk") instead of doing this once in module init,
which exhausts the small pool of available dynamic major numbers.

Additionally, device_index unconditionally increments via dibs_blk_idx++.
Because the minor number is calculated as device_index * MAX_GPT_PARTITIONS,
after 8192 probes the minor number exceeds the maximum limit, causing
device_add_disk() to fail or overwrite the major number.

[ ... ]
> +		blkpd->blk.gd->minors =3D MAX_GPT_PARTITIONS;
> +		blkpd->blk.gd->events =3D DISK_EVENT_MEDIA_CHANGE;
> +
> +		set_disk_ro(blkpd->blk.gd, 1);
> +		snprintf(blkpd->blk.gd->disk_name, 10, "dibs_blk%d",
> +			 blkpd->device_index);

[Severity: Medium]
Is the size parameter of 10 too small for double-digit indices?

The prefix dibs_blk consumes 8 characters. For any device_index >=3D 10,
the string requires at least 11 characters including the null terminator.
Because the size limit is hardcoded to 10 instead of DISK_NAME_LEN,
snprintf truncates the output to 9 characters plus the null terminator.

This means devices with an index >=3D 10 will be truncated and named
dibs_blk1, guaranteeing sysfs naming collisions and initialization
failures when multiple devices are attached or hotplugged.

[ ... ]
> +		dibs_blk_update_capacity(blkpd);
> +		blkpd->device_add_disk =3D 1;
> +
> +		ret =3D device_add_disk(&blkpd->dpd->dev, blkpd->blk.gd, NULL);
> +		if (ret) {
> +			pr_err("%s: device_add_disk failed: %d\n", __func__,
> +			       ret);
> +			blkpd->device_add_disk =3D 0;
> +			put_disk(blkpd->blk.gd);
> +			blkpd->blk.gd =3D NULL;
> +			return;
> +		}
> +	}
> +
> +	dibs_blk_update_capacity(blkpd);
> +	disk_force_media_change(blkpd->blk.gd);
> +	dibs_blk_rescan_partitions(blkpd);
> +}

[Severity: High]
Could exposing the device_add_disk flag early lead to a race condition?

If device_add_disk() fails, the error path resets the flag to 0 and frees
the gendisk. Concurrently, dibs_blk_handle_disk_detach() reads the flag
locklessly. If it sees the flag as 1 before the failure path resets it, it
calls disk_force_media_change(blkpd->blk.gd).

This would access the pointer while it is being freed or after it is
NULLed, causing a crash.

[ ... ]
> +static void dibs_blk_proc_recv_msg_work(struct work_struct *work)
> +{
[ ... ]
> +	while ((msg =3D (struct dibs_blk_peer_dev_msg *)dibs_pbd_msg_recv(&peer=
_dev->rb))) {
> +		switch (msg->hdr.type) {
> +		case DIBS_BLK_DATA_MSG:
> +			current_data =3D msg->blkdm.data;
> +			data_len =3D READ_ONCE(msg->blkdm.datalen);

[Severity: Medium]
Should the code validate the message bounds before accessing payload fields?

While dibs_pbd_msg_recv() ensures the ring buffer holds at least
msg->hdr.datalen bytes, this code accesses READ_ONCE(msg->blkdm.datalen)
and READ_ONCE(msg->blkmcm.size) without verifying that msg->hdr.datalen is
large enough to contain the full struct dibs_blk_data_msg or struct
dibs_blk_media_change_msg.

If a peer sends a valid message type but a tiny header length, reading
these payload fields accesses memory beyond the validated message bounds,
potentially causing a page fault.

[ ... ]
> +			total_bytes_of_request =3D
> +				READ_ONCE(msg->blkdm.total_bytes_of_req);
> +
> +			if (sizeof(msg->blkdm) + data_len >
> +			    READ_ONCE(msg->hdr.datalen))
> +				break;

[Severity: High]
Is there a TOCTOU vulnerability here when re-reading datalen from shared me=
mory?

Because msg resides in the shared ring buffer mapped to the remote peer, a
malicious peer can concurrently mutate msg->hdr.datalen to a large value
after the initial boundary validation but during this check.

This bypasses the validation, causing dibs_blk_handle_data_msg() to copy
data_len bytes from the shared memory pointer, reading past the end of the
mapped buffer and leaking adjacent kernel memory.

[ ... ]
> +static int dibs_blk_peer_dev_probe(struct dibs_peer_device *dpd)
> +{
[ ... ]
> +	ret =3D dibs_pbd_register_ring_buffer("dibs_blk", dpd,
> +					    DIBS_BLK_PEER_DEV_BLK_RING_SIZE);
> +	if (ret) {
> +		pr_err("%s: failed to register ring buffer\n", __func__);
> +		goto err_free;
> +	}
> +
> +	blkpd->ring_registered =3D true;
> +	dibs_ring_set_rdmb_tok(&dpd->rb, dpd->rdmb_tok);

[Severity: High]
Does activating the remote communication channels here allow the remote
peer to access uninitialized block layer structures?

The remote device can immediately send a DIBS_BLK_MEDIA_CHANGE message,
triggering the IRQ handler which schedules proc_recv_msg_work and then
media_change_work.

Since media_change_work calls blk_mq_alloc_disk(&blkpd->blk.tag_set, ...),
if this runs before probe() reaches blk_mq_alloc_tag_set(), the tag_set is
uninitialized memory, leading to a crash in the block layer.

[ ... ]
> +	blkpd->blk.major =3D register_blkdev(0, "dibs_blk");
[ ... ]
> +err_unregister_ring:
> +	if (blkpd->ring_registered)
> +		dibs_pbd_unregister_ring_buffer(dpd);
> +err_free:
> +	dpd->drv_priv =3D NULL;
> +	kfree(blkpd);
> +	return ret;
> +}

[Severity: Medium]
Is there a missing cancel_work_sync() before freeing blkpd on this error pa=
th?

If a step after ring buffer registration fails (like register_blkdev), the
code jumps to err_unregister_ring and frees blkpd.

Because the IRQ handler could have already scheduled proc_recv_msg_work,
failing to call cancel_work_sync(&blkpd->proc_recv_msg_work) means the
work could execute later on the freed blkpd structure.

[ ... ]
> +static void dibs_blk_peer_dev_remove(struct dibs_peer_device *dpd)
> +{
> +	struct dibs_blk_peer_dev *blkpd =3D dpd->drv_priv;
> +
> +	if (blkpd->list_added) {
> +		mutex_lock(&blkpd_mutex);
> +		list_del(&blkpd->list);
> +		mutex_unlock(&blkpd_mutex);
> +		blkpd->list_added =3D false;
> +	}
> +
> +	if (blkpd->ring_registered) {
> +		dibs_pbd_unregister_ring_buffer(blkpd->dpd);
> +		blkpd->ring_registered =3D false;
> +	}
> +
> +	cancel_work_sync(&blkpd->proc_recv_msg_work);

[Severity: High]
Would tearing down the ring buffer before stopping the worker lead to a
use-after-free?

In both dibs_blk_peer_dev_remove() and dibs_blk_peer_dev_disconnect(), the
driver unregisters the ring buffer before calling
cancel_work_sync(&blkpd->proc_recv_msg_work).

Because the background worker accesses the ring buffer via
dibs_pbd_msg_recv(), if the worker is running concurrently, tearing down
the ring buffer from underneath it causes a use-after-free.

[ ... ]
> +	cancel_work_sync(&blkpd->media_change_work);

[Severity: High]
Can this removal path deadlock by waiting on a work item blocked on the
quiesced queue?

When the device is disconnected, dibs_blk_peer_dev_disconnect() quiesces
the queue but does not cancel media_change_work. If media_change_work
runs, it calls bdev_disk_changed() which issues synchronous read I/O to
scan partitions.

Since the queue is quiesced, these read requests block indefinitely. When
dibs_blk_peer_dev_remove() subsequently calls cancel_work_sync() for
media_change_work, it hangs forever waiting for the blocked work. The
queue is not unquiesced until later in this function, resulting in a
permanent deadlock.

[ ... ]
> +	if (blkpd->device_add_disk) {
> +		blk_mark_disk_dead(blkpd->blk.gd);
> +		dibs_blk_unquiesce(blkpd);
> +		blk_mq_tagset_busy_iter(&blkpd->blk.tag_set,
> +					dibs_blk_cancel_request, blkpd);
> +		del_gendisk(blkpd->blk.gd);
> +		put_disk(blkpd->blk.gd);
> +		blkpd->blk.gd =3D NULL;
> +		blkpd->device_add_disk =3D 0;
> +	}
> +
> +	if (blkpd->tag_set_allocated)
> +		blk_mq_free_tag_set(&blkpd->blk.tag_set);
> +
> +	if (blkpd->blkdev_registered)
> +		unregister_blkdev(blkpd->blk.major, "dibs_blk");
> +
> +	kfree(blkpd);
> +}

[Severity: High]
Is it safe to free tag_set and driver data while the block layer may still
retain a reference to the queue?

This code drops the driver's reference using put_disk(), followed
immediately by blk_mq_free_tag_set() and kfree(blkpd). If a userspace
process holds the block device open, the gendisk and request_queue remain
alive.

When the user later closes the device, blk_release_queue() will attempt to
access the queue's tag_set to free hardware queues. Since tag_set points
to blkpd->blk.tag_set inside the freed blkpd struct, this causes a
use-after-free. The tag set and private data must be managed via the
gendisk's .free_disk callback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-console_se=
rver-v1-0-636b11ebf191@linux.ibm.com?part=3D4
