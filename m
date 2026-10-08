Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB103C37A3
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447997; cv=none; b=RimZ0PYB3JDIwDRu7D5QbocTRlLPzHJDJNr8keoFGwp+McCQ1kISbfIvlMhx0xf9VCEVITb4uL+IkGUAwenvDwZDOrMSWeQa5vtuIyrGQ9Nf1wePpTjHqiO9YerlDlrug9VXT2vRpUcV1nYNjdeE5ySDWr8sYK6yb2uYELzOvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447997; c=relaxed/simple;
	bh=MCJStkqgMGeTec9SYxMR+COFiNWP+MdsCvL0YFpHtPg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UM+Z/5CYTu5iWSMNVmVQkJHbragHTPlKSlzbcz0S8bimtb+L3xeWAkJPTu7T9DlDxYN/2hou4+w6dblW0LswzkST30Od0C2Hpqi5JgQDpVKFul9awmYZu7w16jy24uCx3AvOOz9Y1Xbxplp0c9CQJYmkZF3/j1OaKiP1U8VoWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1Krtgyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1Krtgyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA51C1F000FF;
	Thu,  8 Oct 2026 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447995;
	bh=38dceeJnUi1x+raG+9nQyLvyF2QpP5RA5NXnxI76tWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h1KrtgykEWxFgvR1LtLln5UklEsv0ZpBcPSfoaO7VSy0ll85VIc7NUf8MZ6Lv7CWJ
	 +MpLAFXNkh87pKIwj8BJWvjFd4wxhQ6jsCsTt9grdQBE9o2PngAVggr8CRvpFEQjMr
	 8uiSuFslcuRFmnwRGQ+7Zii5H1LT7RvDXsddMe4YuAODKCrZSr38rTKshTEZi4GJ7I
	 exIbJQA1oJK0oN2YM8gvup1QIo2U/SYzFc1f18Z+DrBGqiONokFgv+bsPxbMbocXNQ
	 FLhtiVqNjsOPNUwvEwkOxp1KAfCyrqwd/8jyQOxkTrcX655m0mP+IsbVBCBBd+qS7K
	 +8EH11eH4crsw==
Message-ID: <sashiko-outbox-163831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] dibs: introduce dibs console peer device driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julian Ruess" <julianr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261008-console_server-v1-3-636b11ebf191@linux.ibm.com>
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
 <20261008-console_server-v1-3-636b11ebf191@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:26:35 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] tty: uninitialized spinlock mr_spinlock in dibs_console
- [High] tty: UAF in IRQ handler due to inverted teardown in dibs_con_peer_=
dev_remove()
- [High] tty: racy hvc_instantiate() usage during hotplug corrupts global s=
tate
- [High] tty: dibs_console: use-after-free of hvc in termid_show()
- [High] dibs: kernel stack information leak in dibs_con_put_chars()
- [High] dibs: TOCTOU double-fetch in IRQ handler leading to OOB read
- [High] dibs: UAF of dcpd in dibs_con_get_chars() racing with device remove
- [Low] tty: sysfs attribute named 'termid' instead of documented 'hvc'
--

commit 1fe9a43373bccffcc93521015b20907f33642f67
Author: Julian Ruess <julianr@linux.ibm.com>

dibs: introduce dibs console peer device driver

This introduces a virtual console device driver over the dibs peer device
bus, allowing tty access across systems in a dibs fabric without requiring
a network setup. A /dev/hvcN device is created for each detected peer.

> diff --git a/drivers/dibs/dibs_console.c b/drivers/dibs/dibs_console.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dibs/dibs_console.c

[ ... ]

> +static void dibs_con_peer_dev_handle_irq(unsigned int dmbno,
> +					 struct dibs_peer_device *peer_dev,
> +					 u16 dmbemask)
> +{
> +	struct dibs_con_peer_dev *dcpd;
> +	struct dibs_con_pd_msg *msg;
> +	struct winsize winsize;
> +	size_t count;
> +	u16 datalen;
> +
> +	dcpd =3D peer_dev->drv_priv;
> +
> +	if (!dcpd->connect_msg_enqueued)
> +		dibs_con_peer_dev_send_connect_msg(peer_dev);
> +
> +	while ((msg =3D (struct dibs_con_pd_msg *)dibs_pbd_msg_recv(&peer_dev->=
rb))) {
> +		switch (msg->hdr.type) {
> +		case DIBS_CON_DATA_MSG:
> +			datalen =3D min_t(u16, READ_ONCE(msg->hdr.datalen),
> +					DIBS_CON_PEER_DEV_DATA_MSG_MAX_DATALEN);
> +			count =3D kfifo_in(&dcpd->fifo, &msg->tdm, datalen);

[Severity: High]
Can a malicious peer concurrently modify msg->hdr.datalen between the bounds
check in dibs_pbd_msg_recv() and this second read?

The double fetch could allow a larger size to be used, meaning kfifo_in()
would read past the end of the mapped ring buffer memory, resulting in an
out-of-bounds read.

This also applies to the DIBS_CON_RESIZE_MSG case below where msg->rm.ws
is read. If datalen was initially 0, accessing the 8-byte payload can cross
the ring buffer boundary.

[ ... ]

> +static ssize_t dibs_con_get_chars(u32 vtermno, u8 *buf, size_t count)
> +{
> +	struct dibs_con_peer_dev *dcpd =3D NULL;
> +
> +	dcpd =3D hvc_peer_devs[vtermno];
> +	if (!dcpd)
> +		return 0;
> +
> +	spin_lock(&dcpd->mr_spinlock);

[Severity: High]
Is the mr_spinlock properly initialized before it is acquired here?

In dibs_con_peer_dev_probe(), dcpd is dynamically allocated using kzalloc_o=
bj().
This zero-initializes the memory, but the lock is never properly initialized
with spin_lock_init(). Acquiring a zero-initialized spinlock will cause ker=
nel
crashes on PREEMPT_RT systems or trigger warnings when lock debugging is en=
abled.

[Severity: High]
Is this pointer dereference safe from concurrent teardown?

In dibs_con_peer_dev_remove(), dcpd is freed without waiting for the khvcd
polling thread to exit. The hvc_remove() function temporarily takes and dro=
ps
hp->lock to clear console metadata, but it does not clear the hp->ops point=
ers.

Meanwhile, __hvc_poll() inside khvcd drops hp->lock to call cond_resched(),
allowing hvc_remove() to proceed and dibs_con_peer_dev_remove() to free dcp=
d.
When __hvc_poll() reacquires the lock, it jumps back and unconditionally ca=
lls
hp->ops->get_chars(), leading to a use-after-free here.

[ ... ]

> +static ssize_t dibs_con_put_chars(u32 vtermno, const u8 *buf, size_t cou=
nt)
> +{
> +	struct dibs_con_peer_dev *dcpd =3D NULL;
> +	struct dibs_con_peer_dev_rbe dcpdr;
> +	size_t max_cnt;
> +
> +	dcpd =3D hvc_peer_devs[vtermno];
> +	if (!dcpd)
> +		return 0;
> +	if (!dcpd->connect_msg_enqueued)
> +		return 0;
> +
> +	max_cnt =3D dibs_pbd_msg_max_payload(&dcpd->dpd->rb);
> +	if (!max_cnt)
> +		return 0;
> +
> +	count =3D min(count, max_cnt);
> +	dcpdr.pdm.hdr.version =3D DIBS_CON_PEER_DEV_HDR_VERSION;
> +	dcpdr.pdm.hdr.type =3D DIBS_CON_DATA_MSG;
> +	dcpdr.pdm.hdr.datalen =3D count;
> +	memcpy(&dcpdr.pdm.tdm.data, buf, count);
> +	if (!dibs_pbd_msg_send(&dcpd->dpd->rb, &dcpdr.pdm.hdr))

[Severity: High]
Does this leak uninitialized stack padding to the remote peer?

The dcpdr struct is allocated on the stack and is not zero-initialized.
The memcpy() only writes count bytes into the data buffer.

When dibs_pbd_msg_send() calculates the transmit size using dibs_pbd_msg_si=
ze(),
it rounds the total size up to a 4-byte boundary. This will cause
dibs_ring_send() to read and transmit up to 3 bytes of uninitialized stack
memory adjacent to the valid data over the dibs fabric.

[ ... ]

> +static int dibs_con_alloc_hvc(struct dibs_con_peer_dev *dcpd)
> +{
> +	int vtermno;
> +	int ret;
> +
> +	for (vtermno =3D 0; vtermno < DIBS_CON_MAX_VTERMNOS; vtermno++) {
> +		ret =3D hvc_instantiate(vtermno, vtermno, &dibs_con_ops);
> +		if (ret)
> +			continue;

[Severity: High]
Is it safe to use hvc_instantiate() dynamically during device probe?

This function is a lockless API designed strictly for sequential early boot
console initialization. If multiple dibs peer devices are probed concurrent=
ly,
they will race to read and write the global vtermnos and cons_ops arrays,
leading to corruption where multiple devices claim the same slot.

Additionally, if the subsequent hvc_alloc() call fails, the claimed slot
is never un-instantiated, permanently leaking the console slot.

[ ... ]

> +static ssize_t termid_show(struct device *dev, struct device_attribute *=
attr,
> +			   char *buf)
> +{
> +	struct dibs_peer_device *dpd;
> +	struct dibs_con_peer_dev *dcpd;
> +
> +	dpd =3D to_dibs_peer_device(dev);
> +	dcpd =3D dpd->drv_priv;
> +	if (dcpd->dpd =3D=3D dpd)
> +		return sysfs_emit(buf, "hvc%d\n", dcpd->hvc->index);

[Severity: High]
Can this dereference a freed pointer during concurrent device teardown?

In dibs_con_peer_dev_remove(), hvc_remove(dcpd->hvc) is called and can
immediately free the hvc_struct if no references are held. The sysfs file is
not removed via sysfs_remove_file() until later, leaving a window where
concurrent readers to the sysfs file can access freed memory here.

> +	return 0;
> +}
> +static DEVICE_ATTR_RO(termid);

[Severity: Low]
This isn't a bug, but the commit message states the hvc device number can be
accessed by reading /sys/bus/dibs_peer/devices/<rgid>/hvc.

The macro DEVICE_ATTR_RO(termid) defines a file named termid instead,
creating an undocumented API mismatch.

[ ... ]

> +static void dibs_con_peer_dev_remove(struct dibs_peer_device *dpd)
> +{
> +	struct dibs_con_peer_dev *dcpd =3D dpd->drv_priv;
> +
> +	if (dcpd->hvc)
> +		hvc_remove(dcpd->hvc);
> +	hvc_peer_devs[dcpd->vtermno] =3D NULL;
> +	kfifo_free(&dcpd->fifo);
> +
> +	if (dcpd->ring_registered) {
> +		dibs_pbd_unregister_ring_buffer(dcpd->dpd);

[Severity: High]
Does this teardown ordering create a use-after-free window in the IRQ handl=
er?

The kfifo resource is freed before the ring buffer (which is the interrupt
source) is unregistered. If a message arrives from the peer between these t=
wo
calls, the interrupt handler dibs_con_peer_dev_handle_irq() will fire and
call kfifo_in() on the already freed dcpd->fifo buffer, resulting in memory
corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-console_se=
rver-v1-0-636b11ebf191@linux.ibm.com?part=3D3
