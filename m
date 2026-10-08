Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96346E019
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448038; cv=none; b=jUhc5FpzL0TMEnTM9YBqf4yiGoAH546l0mY/IRvRQJSz5+BxODLsquoijY4lh532Xkw87l0ueX4Jdv3EILNlWMuC5NKWljzdExjo2TS/LPJQy1BbDawEgxgUW4CRlTG4fiZJcXko1aLIJmKKWpMQdO6wohl0XPVk6E5u7nUwrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448038; c=relaxed/simple;
	bh=mVcx6f01lCOALTcK6JrigKenaUEYTb9Ni4UxSZY+NxA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HxrHaFJa6ittQ91Wpo3TMx8kV/Klq322yGWNzqMLmzL0ODJMr8yA/a8zWXwyIEQcuSUPd0OXQxYyjT5mQGKZ0YLNVR3LvPiODHViQhQPwHwkXvvpfvEJkP+Kge8uz93RLOMiJEajbB9Qy4BlKKSPLimMltrwQUiNMLafshvZn8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV6+QoJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV6+QoJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24D31F000FF;
	Thu,  8 Oct 2026 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791448033;
	bh=KNQukZ/KD4/8AKP5cnGf5zx3LzdR3B7tOdW28JLfJK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XV6+QoJuACJH8i2vBB95DoPwdxrYgBJIyslO/q/ET75FFBq0BGu0Ja6J9bC0uNC2F
	 vYLeMLENzm1DcyfSFrd4mCDKn3ezYwxbUYp8Xy4O1ZVA/o8CCjhHhWuvb8a5Sk6YAV
	 S7fYJzdPJ93HWZHViSnpQrt2s6O1Hdp5pKfP8Dko2UXqX73NpW4VN9kWv3Bb9FSNLB
	 oSC7wVxrZMDcKL9/rsyagT2isIkcoDOAWnwJSVfhdFIVRqHHodzJwKFoaprTYdmW6V
	 mTGRmpA2ZK38tiqYqV0SP6CEkdBDCRWmSPk6T+SP3H9IvDCYD+Ewq9PtKbkmSmLckU
	 ZZce10MRsUR0A==
Message-ID: <sashiko-outbox-163839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] dibs: introduce dibs peer device bus driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julian Ruess" <julianr@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261008-console_server-v1-2-636b11ebf191@linux.ibm.com>
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
 <20261008-console_server-v1-2-636b11ebf191@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:27:12 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 19 potential issue=
(s) to consider:
- [High] dibs: NULL pointer dereference after dibs_pbd_drv_add_dibs allocat=
ion failure
- [High] dibs: UAF of remote_endpoint due to dangling pointers in dds->dmb_=
state
- [High] dibs: Unbounded memory leak of access_token objects leading to DoS
- [High] dibs: UAF of dibs_peer_device due to event handling race with tear=
down
- [High] dibs: UAF of parent dibs device due to uncancelled handle_irq_work
- [High] dibs: UAF of dibs_peer_device from re-arming timeout_work during t=
eardown
- [High] dibs: UAF on module exit due to unflushed dibs_pbd_event_work items
- [High] dibs: Out-of-bounds read due to missing payload length validation
- [High] dibs: Kernel stack info leak via uninitialized msg_to_send struct
- [High] dibs: Integer underflow in dibs_pbd_msg_max_payload()
- [High] dibs: use-after-free of remote_endpoint in IRQ handler
- [High] dibs: unbounded memory leak of access_token objects (remote DoS)
- [High] dibs: reconnected peer devices are incorrectly destroyed by uncanc=
elled timeout
- [Medium] dibs: Ring buffer permanently wedges on unknown message types
- [Medium] dibs: Data race from unlocked modification of rd_meta_dmb.idx st=
ate
- [Medium] dibs: Device matching ignores rgid, breaking discovery for ident=
ical IDs
- [Medium] dibs: Integer truncation in send_padding_msg wedges ring buffer
- [Medium] dibs: UAF in dibs_pbd_peer_dev_create error path due to uncancel=
led works
- [Low] dibs: TOCTOU race in remote_endpoint creation creates duplicate ent=
ries
--

commit c1ec605f331a2f74f0e89eba64870a407cc1570c
Author: Julian Ruess <julianr@linux.ibm.com>

    dibs: introduce dibs peer device bus driver

    Introduce a dibs peer device bus driver that represents remotely
    emulated dibs peer devices as kernel devices. The driver handles
    discovery and lifecycle management of remote peer devices and provides
    the foundation for dibs peer device drivers that operate on top of dibs.

> diff --git a/drivers/dibs/dibs_peer_bus_drv.c b/drivers/dibs/dibs_peer_bu=
s_drv.c
> new file mode 100644
> index 0000000000000..99eb0a6f8164d
> --- /dev/null
> +++ b/drivers/dibs/dibs_peer_bus_drv.c

[ ... ]

> +size_t dibs_pbd_msg_max_payload(struct dibs_ring_buffer *rb)
> +{
> +	size_t space =3D dibs_ring_space_to_end(rb);
> +
> +	if (space =3D=3D 0)
> +		return 0;
> +
> +	if (space =3D=3D sizeof(struct dibs_msg_hdr)) {
> +		space =3D dibs_ring_space(rb) - space;
> +		if (space =3D=3D 0)
> +			return 0;
> +	}
> +
> +	return ALIGN_DOWN(space - sizeof(struct dibs_msg_hdr),
> +			  DIBS_PBD_MSG_ALIGNMENT);
> +}

[Severity: High]
Does this calculation safely prevent integer underflow?

If the ring buffer is nearly full and `space` is less than
`sizeof(struct dibs_msg_hdr)` (for instance, 3 bytes), subtracting the head=
er
size will underflow, causing this function to return an extremely large val=
ue
(e.g., `SIZE_MAX - 3`). This could lead to memory corruption or out-of-boun=
ds
writes in callers that rely on this size.

[ ... ]

> +static int dibs_pbd_send_padding_msg(struct dibs_ring_buffer *rb)
> +{
> +	int ret;
> +	struct dibs_msg_hdr padding_hdr;
> +
> +	padding_hdr.version =3D DIBS_PBD_HDR_V1;
> +	padding_hdr.type =3D DIBS_PBD_PADDING_MSG;
> +	padding_hdr.datalen =3D
> +		dibs_ring_space_to_end(rb) - sizeof(struct dibs_msg_hdr);

[Severity: Medium]
Could this assignment truncate the padding size?

The result of `dibs_ring_space_to_end(rb) - sizeof(struct dibs_msg_hdr)` is=
 a
`size_t` that could potentially be up to 1MB, but `padding_hdr.datalen` is
a `u16`. If the required padding space exceeds 65539 bytes, the assigned
value will be silently truncated. This could cause the sender to lose
synchronization with the physical ring boundaries, wedging the connection.

[ ... ]

> +struct dibs_msg_hdr *dibs_pbd_msg_recv(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_msg_hdr *msg;
> +	u32 msg_size;
> +
> +	while ((msg =3D dibs_ring_recv(rb))) {
> +		msg_size =3D dibs_pbd_msg_size(msg);
> +		if (!msg_size || msg_size > dibs_ring_cnt_to_end(rb)) {

[Severity: High]
Is it possible for a remote peer to send a message where the payload size
is too small for the actual message type?

This size validation verifies that the message fits within the ring buffer,
but it does not enforce a minimum structural size for specific message type=
s.
If a peer sets `datalen` to 0, subsequent casts and assignments in handlers
like `dibs_pbd_re_dev_msg()` could read out-of-bounds memory.

[ ... ]

> +static void dibs_pbd_re_access_tok_msg(struct dibs_msg_hdr *msg_hdr,
> +				       struct dibs_pbd_remote_endpoint *re)
> +{
> +	struct dibs_pbd_remote_endpoint_access_tok_msg atmsg;
> +	struct dibs_pbd_remote_endpoint_msg msg_to_send;

[Severity: High]
Can uninitialized stack memory be leaked here?

The `msg_to_send` structure is allocated on the stack without `{0}`
initialization. Later, `strscpy()` is used to populate fields like
`system_name` and `hostname`, leaving the trailing bytes of these fixed-size
arrays uninitialized. When `dibs_pbd_msg_send()` transmits the struct, this
raw kernel stack memory is sent over the bus.

> +	struct dibs_pbd_remote_endpoint_msg *msg;
> +	struct dibs_system_info sysinfo;
> +	struct access_token *at;
> +	int ret;
> +
> +	msg =3D (struct dibs_pbd_remote_endpoint_msg *)msg_hdr;
> +	atmsg =3D msg->atmsg;
> +
> +	if (re->trusted) {
> +		at =3D kzalloc_obj(*at);
> +		if (!at) {
> +			pr_err("%s: failed to allocate access token\n",
> +			       __func__);
> +			return;
> +		}
> +		at->access_tok =3D atmsg.access_tok;
> +		mutex_lock(&dibs_pbd_access_token_list_mutex);
> +		list_add_tail(&at->list, &dibs_pbd_access_token_list);
> +		mutex_unlock(&dibs_pbd_access_token_list_mutex);

[Severity: High]
Is there a risk of an unbounded memory leak on this list?

Every received token is unconditionally appended to the global
`dibs_pbd_access_token_list`, but there appears to be no mechanism to ever
remove or free them. A remote endpoint could send these messages indefinite=
ly,
leading to a memory leak and a potential Denial of Service.

[ ... ]

> +static int dibs_pbd_peer_dev_match_id(struct device *dev, const void *da=
ta)
> +{
> +	struct dibs_peer_device *dpd =3D to_dibs_peer_device(dev);
> +	const u8 *id =3D data;
> +
> +	if (dpd && dpd->id =3D=3D *id)
> +		return 1;
> +	return 0;
> +}

[Severity: Medium]
Should this matching function also check the remote GID (`rgid`)?

By only checking the device ID, this ignores the endpoint it originated fro=
m.
If two different endpoints provide a device with the same ID, the search
will return the first one found regardless of endpoint.

[ ... ]

> +static void dibs_pbd_dibs_event_dev_disabled_work(struct work_struct *wo=
rk)
> +{
> +	struct dibs_peer_dev_driver *dpdd;
> +	struct dibs_peer_device *dpd;
> +
> +	dpd =3D container_of(work, struct dibs_peer_device,
> +			   event_dev_disabled_work);
> +
> +	device_lock(&dpd->dev);
> +	if (dpd->dev.driver) {
> +		dpdd =3D to_dibs_peer_dev_driver(dpd->dev.driver);
> +		dpdd->disconnect(dpd);
> +	}
> +	device_unlock(&dpd->dev);
> +
> +	schedule_delayed_work(&dpd->timeout_work, dpd->timeout);
> +}

[Severity: High]
Does this safely interact with `dibs_pbd_peer_dev_destroy()`?

During teardown, `dibs_pbd_peer_dev_destroy()` cancels
`event_dev_disabled_work`. If `event_dev_disabled_work` is already running
concurrently, teardown waits. But as seen here, the work ends by
re-arming `timeout_work`. Since `dibs_pbd_peer_dev_destroy()` skips
cancelling `timeout_work` if it is the current work context, the newly
re-armed timer remains active after the device is freed, causing a
use-after-free when it fires.

[ ... ]

> +static int dibs_pbd_peer_dev_create(struct dibs_dev *dibs, uuid_t *rgid,
> +				    u64 rdmb_tok, u8 server_dev_id, u8 type,
> +				    u128 tok)
> +{

[ ... ]

> +	ret =3D device_register(&dpd->dev);
> +	if (ret) {
> +		put_device(&dpd->dev);
> +		return ret;
> +	}
> +	ret =3D sysfs_create_link(&dpd->dev.kobj, &dpd->parent->dev.kobj, "dibs=
");
> +	if (ret) {
> +		device_unregister(&dpd->dev);
> +		return ret;
> +	}

[Severity: Medium]
Are background work items properly cancelled on this error path?

Between `device_register()` and the potential `sysfs_create_link()` failure,
the device is visible on the bus and could have events dispatched to it (e.=
g.,
`event_dev_disabled_work`). If this path calls `device_unregister()` without
first cancelling the workqueue items, it could lead to a use-after-free.

[ ... ]

> +static void dibs_pbd_re_dev_msg(struct dibs_msg_hdr *msg_hdr,
> +				struct dibs_pbd_remote_endpoint *re)
> +{

[ ... ]

> +	if (dev) {
> +		dpd =3D to_dibs_peer_device(dev);
> +		if (dpd->tok !=3D redm.peer_dev_tok) {
> +			put_device(dev);
> +			return;
> +		}
> +		if (dpd->rdmb_tok !=3D redm.dmb_tok)
> +			dpd->rdmb_tok =3D redm.dmb_tok;
> +
> +		device_lock(&dpd->dev);
> +		if (dpd->dev.driver) {
> +			dpdd =3D to_dibs_peer_dev_driver(dpd->dev.driver);
> +			ret =3D dpdd->reconnect(dpd);
> +			if (!ret)
> +				dpd->status =3D PEER_DEV_CONNECTED;
> +		}
> +		device_unlock(&dpd->dev);
> +		put_device(dev);

[Severity: High]
Does a successful reconnect cancel pending teardown timers?

If a peer device was recently disabled, `event_dev_disabled_work` and
`timeout_work` may already be scheduled to destroy the device. If the device
reconnects here, those timers are never cancelled, meaning the newly
reconnected device will still be destroyed shortly after.

[ ... ]

> +static void dibs_pbd_remote_endpoint_release(struct kref *kref)
> +{
> +	struct dibs_pbd_remote_endpoint *re;
> +
> +	re =3D container_of(kref, struct dibs_pbd_remote_endpoint, kref);
> +
> +	dibs_ring_unregister(&re->rb);
> +	kfree(re);
> +}

[Severity: High]
Does this safely clean up all endpoint references?

When `re` is freed here, the pointers to this endpoint stored in
`dds->dmb_state[...].remote_endpoint` are never cleared. A subsequent or
concurrent IRQ might fetch this dangling pointer from the `dmb_state` array
and use it, causing a use-after-free.

Additionally, this function is called when the reference count drops. If
`peer_bus_drv_remove_dibs()` drops the initial reference while
`handle_irq_work` is still running, the endpoint won't be freed until the
work finishes. However, the parent `dibs_dev` may be freed immediately. When
the work eventually finishes and invokes this release function,
`dibs_ring_unregister(&re->rb)` will access the already freed parent device.

[ ... ]

> +static void dibs_pbd_handle_irq_work(struct work_struct *work)
> +{

[ ... ]

> +	while ((msg =3D dibs_pbd_msg_recv(rb))) {
> +		switch (msg->type) {
> +		case DIBS_PBD_REMOTE_ENDPOINT_ACCESS_TOKEN_MSG:
> +			dibs_pbd_re_access_tok_msg(msg, re);
> +			break;
> +		case DIBS_PBD_DEV_MSG:
> +			if (re->trusted)
> +				dibs_pbd_re_dev_msg(msg, re);
> +			break;
> +		default:
> +			pr_warn("%s: Received unknown message type: %d\n",
> +				__func__, msg->type);
> +			kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
> +			return;
> +		}
> +		dibs_pbd_msg_ack(rb);
> +	}

[Severity: Medium]
Does returning early on unknown messages wedge the ring buffer?

If an unknown message type is received, the early return skips calling
`dibs_pbd_msg_ack(rb)`. Since the message is never acknowledged, the read
pointer doesn't advance. The next IRQ will read the exact same message,
looping infinitely and permanently wedging the channel.

[ ... ]

> +static void dibs_pbd_drv_handle_irq(struct dibs_dev *dibs, unsigned int =
dmbno,
> +				    u16 dmbemask)
> +{
> +	struct dibs_pbd_dibs_dev_state *dds;
> +	struct dibs_pbd_remote_endpoint *re;
> +	struct dibs_peer_dev_driver *dpdd;
> +	struct dibs_peer_device *dpd;
> +	unsigned long flags;
> +
> +	dds =3D dibs_get_priv(dibs, &dibs_pbd_drv);
> +
> +	spin_lock_irqsave(&dds->dmb_state[dmbno].dmb_state_lock, flags);

[Severity: High]
Is it possible for `dds` to be NULL here?

In `dibs_pbd_drv_add_dibs()`, if the allocation for `dds` fails, it returns
early without setting `dibs->priv`. This leaves the context pointer NULL.
When an IRQ fires, `dibs_get_priv` returns NULL, and this unconditionally
dereferences it.

[ ... ]

> +static int dibs_pbd_peer_dev_event(struct device *dev, void *data)
> +{
> +	struct dibs_peer_device *dpd =3D to_dibs_peer_device(dev);
> +	struct dibs_event *event =3D data;
> +
> +	switch (event->subtype) {
> +	case DIBS_SW_EVENT_REDISCOVER:
> +		dpd->rgid =3D event->gid;
> +		cancel_delayed_work(&dpd->timeout_work);
> +		break;

[Severity: High]
Should this also cancel `event_dev_disabled_work`?

This attempts to abort teardown by cancelling `timeout_work`, but fails to
cancel `event_dev_disabled_work`. The pending disabled work will run and
simply reschedule the timeout anyway, defeating the recovery event.

> +	case DIBS_DEV_DISABLED:
> +		if (uuid_equal(&dpd->rgid, &event->gid))
> +			schedule_work(&dpd->event_dev_disabled_work);
> +		break;
> +	}

[Severity: High]
Is there a race condition with device destruction here?

This work is scheduled without checking if the device is currently being
destroyed (e.g., via `dpd->destroying`). If `dibs_pbd_peer_dev_destroy()`
runs concurrently, the `bus_for_each_dev()` iterator used to dispatch this
event might hold a transient reference. Once dropped, `dpd` is freed, and
the workqueue will execute on the freed memory.

[ ... ]

> +static int dibs_pbd_remote_endpoint_create(struct dibs_dev *dibs,
> +					   const uuid_t *rgid,
> +					   const bool trusted)
> +{
> +	struct dibs_pbd_remote_endpoint *re, *tmp;
> +	struct dibs_pbd_dibs_dev_state *dds;
> +	bool existing_re_found =3D false;
> +	unsigned long flags;
> +	int ret;
> +
> +	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
> +	list_for_each_entry_safe(re, tmp, &dibs_pbd_remote_endpoint_list,
> +				 list) {
> +		if (uuid_equal(&re->rgid, rgid))
> +			existing_re_found =3D true;
> +	}
> +	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
> +
> +	if (existing_re_found) {
> +		pr_warn("%s: remote endpoint already exists for rgid: %pUb\n",
> +			__func__, rgid);
> +		return 0;
> +	}
> +
> +	re =3D kzalloc_obj(*re, GFP_KERNEL);

[ ... ]

> +	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
> +	list_add(&re->list, &dibs_pbd_remote_endpoint_list);
> +	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);

[Severity: Low]
Could dropping and re-acquiring the list mutex create duplicates?

Because the `dibs_pbd_remote_endpoint_list_mutex` is dropped after confirmi=
ng
no endpoint exists, two concurrent invocations could both see an empty list
and proceed to allocate and add duplicate endpoints for the same `rgid`.

[ ... ]

> +static void dibs_pbd_drv_handle_event(struct dibs_dev *dev,
> +				      const struct dibs_event *event)
> +{
> +	struct dibs_pbd_event_work *ew;
> +
> +	ew =3D kzalloc_obj(*ew, GFP_ATOMIC);
> +	if (!ew)
> +		return;
> +	ew->dibs =3D dev;
> +	ew->event =3D *event;
> +
> +	INIT_WORK(&ew->work, dibs_pbd_drv_handle_event_work);
> +	schedule_work(&ew->work);
> +}

[Severity: High]
Are these queued works flushed during module exit?

`dibs_pbd_exit()` unregisters the driver but fails to flush `system_wq` to
wait for dynamically allocated items like `ew->work`. If an event is schedu=
led
just before module unload, it could execute after the driver's code is
unmapped, causing a panic.

[ ... ]

> +static void dibs_pbd_drv_add_dibs(struct dibs_dev *dibs)
> +{
> +	struct dibs_pbd_dibs_dev_state *dds;
> +	const char *gid_str;
> +	int max_dmbs;
> +	uuid_t gid;
> +	int ret;
> +
> +	max_dmbs =3D dibs->ops->max_dmbs();
> +	dds =3D kzalloc(sizeof(*dds) +
> +			      max_dmbs * sizeof(struct dibs_pbd_dmb_state),
> +		      GFP_KERNEL);
> +	if (!dds) {
> +		dev_err(&dibs->dev,
> +			"Failed to allocate memory for dibs dev state\n");
> +		return;
> +	}

[Severity: High]
Does this error path leave subsystem state inconsistent?

Returning early on allocation failure leaves `dibs->priv` set to NULL for
this client. A later IRQ delivery will trigger a NULL pointer dereference in
`dibs_pbd_drv_handle_irq()`.

[ ... ]

> +static void peer_bus_drv_remove_dibs(struct dibs_dev *dibs)
> +{
> +	struct dibs_pbd_remote_endpoint *re, *tmp;
> +	struct dibs_pbd_dibs_dev_state *dds;
> +
> +	bus_for_each_dev(&dibs_pbd_type, NULL, dibs,
> +			 dibs_pbd_destroy_matching_peer_dev);
> +
> +	dds =3D dibs_get_priv(dibs, &dibs_pbd_drv);
> +
> +	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
> +	list_for_each_entry_safe(re, tmp, &dibs_pbd_remote_endpoint_list, list)=
 {
> +		if (re->dibs =3D=3D dibs) {
> +			list_del(&re->list);
> +			kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
> +		}
> +	}
> +	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);

[Severity: High]
Should active endpoint work items be cancelled before destruction?

This path drops the initial reference to the endpoints but does not explici=
tly
call `cancel_work_sync(&re->handle_irq_work)`. As discussed previously,
if the work is running, it will outlive the parent `dibs_dev` and eventually
cause a use-after-free when `dibs_pbd_remote_endpoint_release()` touches the
freed parent device.

[ ... ]

> +int dibs_pbd_register_ring_buffer(char *name, struct dibs_peer_device *d=
pd,
> +				  u32 size)
> +{

[ ... ]

> +	spin_lock_irqsave(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
> +			  flags);
> +	dds->dmb_state[dpd->rb.dmb.idx].peer_dev_driver =3D dpdd;
> +	dds->dmb_state[dpd->rb.dmb.idx].peer_dev =3D dpd;
> +	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev_driver =3D dpdd;
> +	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev =3D dpd;
> +	spin_unlock_irqrestore(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
> +			       flags);
> +
> +	return 0;
> +}

[Severity: Medium]
Does modifying `rd_meta_dmb.idx` state here create a data race?

The code acquires the spinlock specifically for the `dmb.idx` slot
(`dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock`), but proceeds to modify
the state for the `rd_meta_dmb.idx` slot. Since these indices can differ,
the modification to the `rd_meta_dmb.idx` slot is unprotected, which can ra=
ce
with the IRQ handler.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-console_se=
rver-v1-0-636b11ebf191@linux.ibm.com?part=3D2
