Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F239768D;
	Fri,  9 Oct 2026 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546989; cv=none; b=N59Gh2f49U8nOm03/IneX0FItO4oVEkcntEQtfUyTRWNTXw+6cIb/mIxS5RvR+HWDROIuVY/OsteEu+zBxTYlL8XavoQ2N+umXKpLAt0X3ryIOapzhmALuiLPdKwmd6qr4f9tpr4ko6Xbbwchvh7vZDZ97j7sc0TFMB93X5p57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546989; c=relaxed/simple;
	bh=slqPRQImuto2oBmbTvhxjcMQGFiHlVNs/kuuxqb8ijs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MEyJ4ZImuCwti/dAKoyWAB0nzVDsSSbkFxFEOFtaJGrlGX3aPM9+R3THvntkMCm+03Stwc/MLdg4RZNPDQdieb4xG337GxBNRdYobAU4lHFsHHr5/5fihOnAoNByCs65dcjzRu25M8pZ10irMpvpyMsk8BT1t1p4rFBhqI1Zd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp5SB4RV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp5SB4RV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E881F000FF;
	Fri,  9 Oct 2026 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546982;
	bh=aQNHhT1+rbqZi89Wi2rMYnVG/ly0PTVUx2q0iAIjBvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kp5SB4RVQzhhZbysUSbDPiSxe5UEpgF6+8zhlKdUNlGIqpYv65CvMusWd67sRJeAb
	 0Wt0VLJjHTqrrKgeLsvY8xtsj5Qd9trSEcfmGOagUr+/N4C6OgSYlJT9oDtIsEG3gN
	 ZKHLVurlZOF7L3hSth21XTXk0iUyk7B7JHnsCMpfL3lne8XJ8YndgehKAv1f9Op9Ib
	 ciDsZWZ7nz/k/Hhyyc9xCkwLpaPNaSnH+XnUUOqVC1r9439yPpog5S42i/LOTEANdG
	 K0/IWz6LuqPeoiz1NoZFr5vpMzR1ybqqQKpl3gaNnWxhhYOLeoi0lEsJAXF/RKZ1Z9
	 sgjLef7T1bT4w==
Message-ID: <sashiko-outbox-165452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/15] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-12-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:56:21 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] locking: DoS via userfaultfd stalling under global mutexes in vfio=
_ap_resuming_write()
--

commit 0439535c7d2f8e78d7863822666908892163a421
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: File ops called to resume the vfio device migration

This commit implements the write callback for the file stream used to
restore the vfio-ap device state on a destination system during the
RESUMING migration phase. It copies the source guest's AP configuration
from userspace, validates its compatibility with the destination host,
and applies it if compatible.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 7b9851b79ec5f..caae95b47a9aa 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -448,11 +504,644 @@ static struct file *vfio_ap_open_file_stream(struc=
t ap_matrix_mdev *matrix_mdev,
>  	return filp;
>  }
[ ... ]
> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
> +				      size_t len, loff_t *pos)
> +{
[ ... ]
> +	/*
> +	 * Hold ap_attr_mutex for the full duration of the write, just as
> +	 * (un)assign_adapter_store() and (un)assign_domain_store() do.  This
> +	 * prevents the AP bus apmask/aqmask attributes from being changed
> +	 * while the guest's AP configuration is being updated.
> +	 *
> +	 * get_update_locks_for_mdev() then acquires guests_lock, kvm->lock,
> +	 * and mdevs_lock in the correct order. This serialises
> +	 * the entire operation against concurrent AP attribute writers
> +	 * while the guest's AP configuration is being changed.
> +	 *
> +	 * Holding these locks for the full duration of a potentially chunked
> +	 * write could in theory affect performance, but this is acceptable for
> +	 * several reasons: migration is an infrequent operation; real-world
> +	 * guest AP configurations are small (each CEX8 card has 2 adapters and
> +	 * up to 16 domains, and the 85 cards in a system are shared across all
> +	 * LPARs and guests); and each chunk write completes quickly.
> +	 */
> +	matrix_mdev =3D filp->private_data;
> +	mutex_lock(&ap_attr_mutex);
> +	get_update_locks_for_mdev(matrix_mdev);
> +	pos =3D &filp->f_pos;
> +
> +	ret =3D validate_resuming_write_parms(filp, len);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ap_config =3D matrix_mdev->mig_data->resuming_mig_file.ap_config;
> +
> +	if (copy_from_user((char *)ap_config + *pos, buf, len)) {

[Severity: High]
Does this code allow a malicious userspace process to stall the kernel
indefinitely using userfaultfd?

Holding global subsystem mutexes (ap_attr_mutex, matrix_dev->guests_lock,
matrix_dev->mdevs_lock) and the VM's kvm->lock during copy_from_user()
allows a compromised userspace process (such as a QEMU instance) to stall
execution by mapping the buffer with userfaultfd and never resolving the
page fault.=20

This would freeze all AP bus attribute changes and vfio_ap mdev lifecycle
operations globally across the host, and lock up the affected KVM instance.
Even without userfaultfd, normal page faults from swap or network
filesystems could cause unpredictable and severe global latency spikes.

> +		ret =3D -EFAULT;
> +		goto out_unlock;
> +	}
> +
> +	*pos +=3D len;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D11
