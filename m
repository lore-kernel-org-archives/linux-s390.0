Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FF34BA49;
	Mon, 22 Jun 2026 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159740; cv=none; b=WG+QltCsL7aQOlV+wRWtSWhbR82FBhXYgjGEyNkK+D09cVqg9LD+57wBziiMKR/75a995vsrwJHwaqt5UZLinP6Wz3DqEfdHXO/bH2z2HB69kO2P0XkoyouoOaMMseaStFeP8VFkWrzmPK08A9b5SUSdnIh4c2dT66TzQ8deyKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159740; c=relaxed/simple;
	bh=mBh4tOjGf3YdcuVaSsP/xt8FVXO1dJq9vXwmsdJ/K78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DS8MzZaHrxyAnUFQOzDWSTa0BaOg0bM9GfghUoZ6RtkGZXtIDplRnkoWdlG4Jd76kuu4r2rrj+hgfNEX6QQd0ORUxMOXOfn24v2+1jSQX5cq2K3kPx5tuKGR8QrsPA45Rj5rLAwrsB2LXkS796Vip4whC1VQsVyAZWLIEONrtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=OFXdMoes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ILCCOKJb; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="OFXdMoes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ILCCOKJb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E869D1D00023;
	Mon, 22 Jun 2026 16:22:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 22 Jun 2026 16:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782159737;
	 x=1782246137; bh=FAL8dhxtWWHEyHTTSbbz9HNANOHRDrNII3W7xSFk9a4=; b=
	OFXdMoes4RR63io6xlt1HkGQLTn8w6O/FPS5OObUBWP9fQKmEJuKRVAfL5Sf/8Sk
	3sUhEuPwqhAekbzYMrTRd6jEK3DS2wVYd6KTuj5A1Y5eJqRwhuT1yBMEURMvSqEC
	JUGyZoXVBKrNRBupd35AIaGV8xEmhdrzveedNmSXTimwFcH9dDDNo+0mq7fUmOqy
	C4SDOE3HCzwx46pLhNrMcZBV5BEaCNfX9QCXc/0/7rf8Q9de/1HnQsgZQ86SAta1
	FZHzcd9leeYeWh1pKheQxY3wYg0cF8S0bzM8VWvATOJeNTthY0Io5IO7uGEKSGcF
	q9GiwCN11/R3jDSsMr+1Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782159737; x=
	1782246137; bh=FAL8dhxtWWHEyHTTSbbz9HNANOHRDrNII3W7xSFk9a4=; b=I
	LCCOKJbOHIeBhU7pgDL4uSS2TaOrPd32Ql6PW4fQZKarbqKNK+otPnCo65xRDuN2
	UCp96cMa0xf6bGMkqUV8eSue+7jhrqPnm+sXqY2lb811hQidaydLIpAJ/wP8kx2O
	4ny/h4uWdbPjUzBJTLxorwcgDt0bJ/QUmJkid/SRZBRjMvCgYGjcq5ABLzO6HwnR
	jrM43HGBMyBpKbm8DXwYpJM8ysHNrE9/8A7KcxVZd7fgc3EHSkfskX8fD2NTKefu
	2GI22d3FMMxnk/5fENWB93hTFE2X/AflAAafQCe6nZZDFDwWmhIAkr/H19Dv/nMv
	BRSFgy5QmP2tGjspMATlw==
X-ME-Sender: <xms:eZk5at-YDSTmkH203cI6bsL2nfdH7SRSMI8IakVAQb17W-vwI2GFLg>
    <xme:eZk5ajEI0UIN92rsdMwKNbQSfQrV-E6HyrvnBbZmikfpiz4gh00YXS8TWfsddM1IO
    mj2oz08axE72R1IgTSwySG6F-RjCBn49GcK_2CZNO5lJ41EytkC2Q>
X-ME-Received: <xmr:eZk5akRCP-fyJyYRP3IrLwD-Oo_2EbXxoe2cQ7AW-bgO2hc-q4Y2HHFdXKE>
X-ME-Proxy-Cause: dmFkZTGkjo92nJiVUshrgMAFTRCUY1gJfONNyQjyZ0s04zPW9OqQKj2Iug6vqz7+57aCzP
    3bmGyjaFS5OlkQsJdJFM7bwyGbDqdt0WdUy+o7YVTy2btnhAztQASYt/5DD2uqG+FKp496
    jMoV4vOKbym2mPzzwENlMy26X+CW6zh9WCnwghsPL57VHHWIixAT+DbaTxJX7YYa148vqO
    jsvaIbj0wIdrceWmFeTOJdor1DXP6ywxIrcDhbkErBLpUX40qlykvhByxl7fXzBhiphYT2
    Oz46MbsdJuyfE5UPPazsR2LEJM082U9DJiL2h6CzFDLNcaJHK0a5oaNnZ3cSyrleSihtHK
    9IGIurn4csbYmPw6IHgWs1XjrKMayL/fyvcp1YC3ps4nFk6/zbZhkC/IQyFOAXBIcKarXQ
    hu4JwQ7ZfEQPLey50H8uWcXZ9usC0ycu/07ipmI+vdum7rrnxo1u5iFtAvy3irE5t5arok
    tPQ0964oMZq5oKPFCrDk45l6NbNjSncXRfANLfh7WcvXcT+wxL8r5rDPhPB9l7JGWkpt0c
    748mX9MhuNR7E0z+fHZCOEUZt7wCzCJmnGpK05AJ5vQIqjssD6o6IjDu5DStsxIifcXPEz
    WzhzhT5OcNFotqXtWPJgX0+pZvbTdhHpO7rD2547vr82g/QVfRrlzFW7iTFg
X-ME-Proxy: <xmx:eZk5apsFH16KpNHSvW0YeTlkVrds--ZOYNMtUTVPLJy89f2XebPoZA>
    <xmx:eZk5apCuyJzklTvXOB4t-v6TEBJxQkV5RQ4dsWpbSb7WlEuaxthWwQ>
    <xmx:eZk5aucQ6--a_I0_jCvWpJjOufHWMU01UFcH_4q_F5t5CmjRTrUJnQ>
    <xmx:eZk5apoOKfHU8R7KrA088h_kCYlPVF3UB6WS3zsrplhSB2ZYymV5Dg>
    <xmx:eZk5arM_uwvpf0HlGsLnTlR_o6sWWKaNJgTt_RZ8deLMQ49bufO4wbK2>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 16:22:16 -0400 (EDT)
Date: Mon, 22 Jun 2026 14:22:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v4 3/4] vfio-pci/zdev: Add VFIO FMB device features
Message-ID: <20260622142215.2446486e@shazbot.org>
In-Reply-To: <20260612181048.91548-4-oelghoul@linux.ibm.com>
References: <20260612181048.91548-1-oelghoul@linux.ibm.com>
	<20260612181048.91548-4-oelghoul@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 14:10:47 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
> +				   void __user *arg, size_t argsz)
> +{
> +	struct zpci_dev *zdev;
> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
> +	int ret;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET, sizeof(fmb_read));
> +	if (ret != 1)
> +		return ret;
> +
> +	zdev = to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	guard(mutex)(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb)
> +		return -ENOMSG;
> +	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))

No need to do this or the test below under mutex.

> +		return -EFAULT;
> +	if (!fmb_read.data)
> +		return -EINVAL;
> +
> +	if (copy_to_user((struct zpci_fmb __user *) fmb_read.data, zdev->fmb, zdev->fmb_length))

The v3 comment noted we could do this, but really keeping the buffer
and doing the copy_to_user after dropping the mutex is really the
better option.  Sashiko also notes[1] this as a high severity issue.

Should also use a u64_to_user_ptr() on the user data pointer.

[1]https://sashiko.dev/#/message/20260612182854.97E641F000E9%40smtp.kernel.org

> +		return -EFAULT;
> +
> +	return 0;
> +}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..97e0f857fe4f 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,35 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  

These next feature indexes are in contention, so we need to think about
how this gets merged; the whole thing through the vfio tree, the s390
bits through s390 tree with a branch exposed for me to merge to vfio
before applying this change, or the whole series applied to a clean
branch and merged into both the s390 and vfio next branches.  The first
two options give me the most leniency in adjusting feature indexes
based on what's already been merged at the time.

> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
> + *
> + * enabled is treated as a bool, so any non-zero value evaluates to true. This
> + * feature fails on attempt to double enable/disable.

Same inconsistency noted on patch 2, it seems that it starts out
enabled.

> + *
> + * Returns: 0 on success, -1 and errno set appropriately on error.
> + */
> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE 13
> +
> +struct vfio_device_feature_zpci_fmb_enable {
> +	__u8 enabled;
> +};
> +
> +/**
> + * Upon VFIO_DEVICE_FEATURE_GET, provide FMB passthrough for VFIO zPCI devices.
> + *
> + * The user-provided buffer must be at least fmb_length large, where fmb_length
> + * is reported in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.

Is there a spec reference for the opaque data blob provided, or at
least reference to kernel structure documenting the layout defined by
some firmware reference?

> + *
> + * Returns: 0 on success, -1 and errno set appropriately on error. errno==ENOMSG
> + * when the FMB is not enabled.

This sounds like a user sequencing error, so should it simply be EINVAL
or ENXIO?  ENOMSG almost sounds like we're tracking the samples field
to make sure the user hasn't already read the current sample.  Along
those same lines, should this document some mechanism for dealing with
torn samples since we might be relaying the sample structure mid-update?
Thanks,

Alex
