Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C947142F;
	Wed, 30 Sep 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798606; cv=none; b=PnamU4TqoEXPsHYXur6tf3cU4FGq5KKu9SV+rSx1mYGhsJmyGKDQFc7zQ2J6Pxo8mHRhEc7RB9/jiH7VM7Eu9zAeuZscW7p0mtPoz4fHFwDDY29+i//aEUY/3i53OQnJ9z7ushwbdlijLO1lvJx3a1SYSLbqOW0b40TB08s19Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798606; c=relaxed/simple;
	bh=b4lHW1LCNl4l977UJji6Vlrq0/XriYozwix9eJ3RPpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKKuMBRSfDuYBgrkq/2j1hXhyi2vfoKzXdO3xDzkI1tQhXdKPv1Acw8R5qxySCl8Ox/njJcnTUoAWxpw8JTlZ3ZAaRg+Ys95xzr+Md0yvFZKUkQZJ9bKd6rymnZTu0VGieSKFEQh/DYt96u/cNbRhieZuIiHUuoqp6NUxrVRQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=1xtseCEV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGukP4+v; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="1xtseCEV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGukP4+v"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9577E1D0003E;
	Wed, 30 Sep 2026 16:03:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 16:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790798602;
	 x=1790885002; bh=gWdnOYP56Gl0Tx2eQVbFmSUVIgLlJCmI0dANqWx97ZQ=; b=
	1xtseCEVDgXcf+h+gjbqlzArwxcUsSzjhMLq/NdmNUFr6vUoZDLPkEOPbg1fYDTy
	i/FkIXiok4RQ4OkJNJbxJFVGBkrIDdDuVH8LPYacL7YkwKgwSbx4M/5NKRGdGc1N
	AHMlZxWJ7Ujxw+xy2fed2Lfxpmauy1oKXZv1W1B/NoHkkiHX42cDAZhv1VWRkEqN
	BA5amCWohPNihbtv75l0MVXFb9c/Fv29ZVs8Kz26xYHePbD3DZ3w4vkadclhSjof
	S6YY7r5rQAEhZQWqaeKyeJaYeRM0S52/OaslQ/hCUE3auJjbK9OrwEQYa9qa1nmd
	03dcE6NGqywfv/g4YPSTFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790798602; x=
	1790885002; bh=gWdnOYP56Gl0Tx2eQVbFmSUVIgLlJCmI0dANqWx97ZQ=; b=Z
	GukP4+vPlMCkS8rn1diT5Qz+FvaYDJeosnh2pOuKGe2B7jFKLNufLDoSBrHo0t5r
	4vexxPHJYDHNWIY/2pdZxALuZEBds8jzPTNa5shCyAIIxq8WlbU1W5kfkG+0SU+k
	OzbfOk+mU9fHrBE6HWu7gsmIoPI+EbZzOlYXCHg/JeVpQdSdX4MPeS0cz9N8iX78
	7wp3jDEKnFegfQ2D4eMBtKQ72o9Vqk+mBLIx0AJyYcVa466Z8PINsxCE0r9SCnbM
	eUSVZ7VhXtGafYwYHr1o8xDeET5mXWd1ANXTBJDlLWTG+OjvcMWYgU+tU0wqIR29
	1DSdnq3VjwU8t6tqqTcyA==
X-ME-Sender: <xms:Cmu9agsZHfiu_B8e2MFIEMZuzOzjRFcBHQer2DjRTHYxOcxnO2XLOg>
    <xme:Cmu9aqriP39C4XW3C4-weDXV55pMeOm21Alc5TDCjeuwVSgkU4Sgf4s43X1hKiS6w
    J736tcFcF9k_iSqGcIElNXYEFAg3zZg0r8vxSmusPDPlOEfYxrodRU>
X-ME-Received: <xmr:Cmu9agS3R-y86mpP0DDLmf2Xj6gxQTX4hL4luGycb5l27DJ9BtETBEbHkn_wfQ>
X-ME-Proxy-Cause: dmFkZTEAjaA7dNJNYMrbcuHxhNuPuquE1rdBeKL1p5Z90FuzyUf82tx0F0N7EiU2DY89jP
    GDkiq0qBlCA9PhvHqVhWyqDppQVMxwviBXlVWRcasolXpP0K5wPm1XQw+wISjkJcSz170i
    E271Pcx/LP4tQsqjyfYbaQ0hBOUoPm7kNOqj2Yg9H/8GKTGV3qy5EHfIO1MDJvkIJg5KVO
    YphtgDzYH4qqV/qw8UWbLYLYrPUsnhNvsjyDik017jzknEO/X2zjItkQBTtA8IEh6CxXbJ
    j19e18ySaPJoaRz+ESyXzDIGC0zhUVDgtWZouvNPN3an9Rq95FM6nVCHdE7kLs6kUEVcHf
    R5Yw2AGa/Pi0QCDaawLTD74q+9rOT/JwRHiR7OtDryf3KdZ4KJ5IQOmKHij461fYw7b77M
    SZwfzBAq7h9Yiswu+6OIbhJ7RL1PTIJyO12X66NzngTGPuEzRbJgZ4vyykBpRV3iYvwNlc
    iKkImF11PXpbPiP91bTbVvAjAho2LFK+zqNd6yCEEMoIXK5pbddmhdW2M4Qo01Di0kOwu/
    v2JXzQJHplmdY6/NfhdAgV943FamFk4J0JtfFcfG5tWkziPiTqv+VsykrkIFK+H3mEM1lb
    GZS72uNaeDlqacGqhzGQSRygWhQt8FETxxg11Ojjd9ilsnBV3BQ1h8bxkliA
X-ME-Proxy: <xmx:Cmu9avaLb06L5uFo3XqGsLJ6FxMA0grRCTqYChJSlOAdsSe38fI5xQ>
    <xmx:Cmu9ah6Bx14onKzs_68rGjaGvssIU2sHYa-vT6WALYs_nHYX9Uaqvw>
    <xmx:Cmu9aqeUrGoNp12QpONshZxXMzYqNlEwn3jkWalP3mVcQA3zm56_EA>
    <xmx:Cmu9aofx9yIJ-H6V5Vk7A8TUUO5afc1ipY1w86HlRg12S68Kc7VZdQ>
    <xmx:Cmu9aqCW5xOuj56xOTo3Bx1sLgwMqSF8uBKEWWfAGsCznO6YOtlG1JGS>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 16:03:21 -0400 (EDT)
Date: Wed, 30 Sep 2026 14:03:19 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v7 4/4] vfio-pci/zdev: Add VFIO FMB device features
Message-ID: <20260930140319.66a27f1c@shazbot.org>
In-Reply-To: <53c94059-fe7f-48e9-9588-ee07a40d45de@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
	<20260922195141.94548-5-oelghoul@linux.ibm.com>
	<20260930125750.7a5bc3a8@shazbot.org>
	<53c94059-fe7f-48e9-9588-ee07a40d45de@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 15:40:40 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:

> On 9/30/26 2:57 PM, Alex Williamson wrote:
> > On Tue, 22 Sep 2026 15:51:41 -0400
> > Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> >> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> >> index f47f36314a1c..b028de8e08a4 100644
> >> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> >> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> >> @@ -219,3 +219,63 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
> >>   	if (zpci_kvm_hook.kvm_unregister)
> >>   		zpci_kvm_hook.kvm_unregister(zdev);
> >>   }
> >> +
> >> +int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, u32 flags,
> >> +				     void __user *arg, size_t argsz)
> >> +{
> >> +	struct zpci_dev *zdev;
> >> +	struct vfio_device_feature_zpci_fmb_enable fmb_enable;
> >> +	int ret;
> >> +
> >> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, sizeof(fmb_enable));
> >> +	if (ret != 1)
> >> +		return ret;
> >> +
> >> +	zdev = to_zpci(vdev->pdev);
> >> +	if (!zdev)
> >> +		return -ENODEV;
> >> +
> >> +	if (copy_from_user(&fmb_enable, arg, sizeof(fmb_enable)))
> >> +		return -EFAULT;
> >> +
> >> +	guard(mutex)(&zdev->fmb_lock);
> >> +
> >> +	if (fmb_enable.enabled)
> >> +		return zpci_fmb_reenable_device(zdev);
> >> +	return zpci_fmb_disable_device(zdev);
> >> +}
> >> +
> >> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
> >> +				   void __user *arg, size_t argsz)
> >> +{
> >> +	struct zpci_dev *zdev;
> >> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
> >> +	struct zpci_fmb fmb_bounce;
> >> +	int ret;
> >> +
> >> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET, sizeof(fmb_read));
> >> +	if (ret != 1)
> >> +		return ret;
> >> +
> >> +	zdev = to_zpci(vdev->pdev);
> >> +	if (!zdev)
> >> +		return -ENODEV;
> >> +
> >> +	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
> >> +		return -EFAULT;
> >> +	if (!fmb_read.data)
> >> +		return -EINVAL;
> >> +
> >> +	mutex_lock(&zdev->fmb_lock);
> >> +	if (!zdev->fmb_enabled) {
> >> +		mutex_unlock(&zdev->fmb_lock);
> >> +		return -ENOMSG;
> >> +	}
> >> +
> >> +	memcpy(&fmb_bounce, zdev->fmb, zdev->fmb_length);
> >> +	mutex_unlock(&zdev->fmb_lock);  
> > 
> > A scoped guard would be preferable for consistency with the enable
> > path.  
> 
> I thought of that too, but then we'd do copy_to_user() while holding the
> mutex for longer than is necessary, which I think was pointed out in an
> earlier version.

Depends how you use it:

	scoped_guard(mutex, &zdev->fmb_lock) {
		if (!zdev->fmb_enabled)
			return -ENOMSG;
		memcpy(&fmb_bounce, zdev->fmb, zdev->fmb_length);
	}

	if (copy_to_user(u64_to_user_ptr(fmb_read.data), &fmb_bounce, zdev->fmb_length))
		return -EFAULT;

Thanks,
Alex
