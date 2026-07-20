Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC4449B09;
	Mon, 20 Jul 2026 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579642; cv=none; b=HBOCXHS4Hch0SMLj4WdQU5Rwgj00NZ5vBzqXEgQZ2utEqjlpeMVJf1h8AyyV3O6E/Z2WAeRtXLs359Zcunb7lAClEEPm53610z3/INz0ySSWyh4yFao1qBLyGL/9XTE6cZxhwAxv4qk2d0hfoBTdk01AI2btNi79oqroM9AaJns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579642; c=relaxed/simple;
	bh=s+v3PKZit5+fE0HORIQquwDOamDPpObEZXWD3aRg8VQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WMZiwpNSUghFRYZcmkm3QJv0RtXzXgM3TGZPRRpdKBg29Lt7I1uMKTiX6t73ASSNrVbwds6mN3/0OBmhVw4bBLxj/zR5oEC7j9c4iC087iKqT9pIy3MNNCuxAkU8smItArY2JwbELDLrzGjgRJ/ATwCXh1dQe09+veiTwQzKk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXCIdCGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXCIdCGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7328E1F000E9;
	Mon, 20 Jul 2026 20:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784579640;
	bh=7mnfEfei9V9M4iYFgbGY4bWANG2fvCVqe+SGkH3oLPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mXCIdCGBk2ayA6bAIj9CBf6TIolYZiiwcp88PuqpVADAnDGcB2BkbEAIOcAh/NPd5
	 QAQLO9koc/o98+njjAPkEujBxL4Y8vqtsPHO8TyapYMqpynT5IUG5mJHNJbqTXuc+6
	 V3mKT+E9X61PwLfBiZ2ahMolTKYggZLATxcENCwc6Z71tg36bRKz+GF0Z+XnXJVeRu
	 DmXokSpgUXvxdhQTMnrR252kgoAcVS2nHC2RCweY9H3LJGfNXu9SwqOViEy3P0vwW+
	 Nzk+pcsAHZK60vRAZ0MK+Y1zZ0L3R42PyBnVktIA3+up2LSkdOh+gLGhtk2tFqfA2J
	 hoCKC70AV8lsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] s390/vfio_ccw: ensure first IDAW remains
 constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260720201931.976660-5-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:33:59 +0000
Message-Id: <20260720203400.7328E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but concurrent e=
xecution of a device reset or DMA unmap with an active I/O request leads to=
 a critical use-after-free and data corruption of the channel program struc=
tures.
- [High] This problem wasn't introduced by this patch, but the IDAL read le=
ngth calculation in `get_guest_idal()` for Format-1 IDAWs incorrectly calcu=
lates the length as if they were 64-bit IDAWs, leading to an out-of-bounds =
read from guest memory.
--

--- Patch [4]: [PATCH v2 4/7] s390/vfio_ccw: ensure first IDAW remains cons=
tant ---
commit d9b51975a2a2546c96fb0396ccf078c5c296fe37
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure first IDAW remains constant

This patch ensures the first IDAW in a list remains constant by verifying
its address between reads, and returning an error if a mismatch is found.
This helps maintain a consistent set of IDAWs for I/O operations.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index ce61858c82eb6..c6f0264fb5d33 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -533,6 +533,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
> +	u64 first_idaw;
>  	int idal_len =3D idaw_nr * sizeof(*idaws);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but the IDAL read length calculation in
get_guest_idal() for Format-1 IDAWs incorrectly calculates the length as if
they were 64-bit IDAWs, leading to an out-of-bounds read from guest memory.

Because Format-1 IDAWs are actually 32 bits (4 bytes) long, this instructs
vfio_dma_rw() to read exactly twice the valid IDAL size.

If the IDAL resides near the boundary of the guest's mapped IOMMU DMA regio=
n,
this over-read spans into an unmapped area, causing vfio_dma_rw() to reject
the read and fail the legitimate channel program.

Does this code need to calculate the length based on the actual IDAW size
instead of the host's 8-byte target struct dma64_t?

>  	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
>  	int idaw_mask =3D ~(idaw_size - 1);

[ ... ]

Additionally, there is another regression present in the state machine:

[Severity: Critical]
This is a pre-existing issue, but concurrent execution of a device reset or
DMA unmap with an active I/O request leads to a use-after-free and data
corruption of the channel program structures.

If an unprivileged guest triggers an I/O operation, invoking
vfio_ccw_mdev_write_io_region() in the host, this function takes
private->io_mutex and pushes VFIO_CCW_EVENT_IO_REQ to the state machine,
invoking fsm_io_request().

Here, private->state is set to VFIO_CCW_STATE_CP_PROCESSING, and
cp_init()/cp_prefetch() are called without holding any locks:

drivers/s390/cio/vfio_ccw_fsm.c:fsm_io_request()
    private->state =3D VFIO_CCW_STATE_CP_PROCESSING;
    //...
    io_region->ret_code =3D cp_init(&private->cp, orb);
    //...
    io_region->ret_code =3D cp_prefetch(&private->cp);

Concurrently, if the guest alters its IOMMU mappings, it triggers
vfio_ccw_dma_unmap() on the host. This callback checks cp_iova_pinned() wit=
hout
holding any locks and then executes vfio_ccw_mdev_reset(), which pushes
VFIO_CCW_EVENT_CLOSE to the state machine without acquiring private->io_mut=
ex:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_reset()
    vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);

Since the state is currently CP_PROCESSING, this routes to fsm_close(), whi=
ch
unconditionally frees the structures concurrently with the active initializ=
ation
routine:

drivers/s390/cio/vfio_ccw_fsm.c:fsm_close()
    cp_free(&private->cp);

Can this sequence actually occur and cause cp_free() to free the ccwchain
memory while cp_prefetch() is actively modifying it? Should these events be
serialized to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720201931.9766=
60-1-farman@linux.ibm.com?part=3D4
