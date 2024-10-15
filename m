Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E01E9082;
	Tue, 15 Oct 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989954; cv=none; b=L9XGiymjgCplmqGSD+VeLXyHPEDcP/W4fWg7JWMpivR/jQU2GnVFqqhBF0mFUJTqTUoAZ0G9sZjAK0xaT13R+Oc9BWWZMyG3afGGN3h9uUsD2KHlOBdBoSqjNbs4XH9yVKhe9ggZr6HN5BTIALCjbHz2wvgQ4EgFgjLYlwKVwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989954; c=relaxed/simple;
	bh=A7b36Qe+jBmoRqJT42Uq3hba5sAV9MjZtFPwQ8Tz9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnvoBEPv9vzNhoUGyw9Y7rKNsSp2W9+rLqDCixUDP8X7qtOqChCL0oMGhP1MShFdOq/sdYFR9XLf8nspBqBQ2KDRbyyr6qvUwjOdJaRlozSN9Kk09HfOd1qqESHEI+Z0szU7ZmycwpiEwznHMJbqxndpw8oOWPa4sMAHyfzfGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iw+gT87b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iw+gT87b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F740C4CEC6;
	Tue, 15 Oct 2024 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728989953;
	bh=A7b36Qe+jBmoRqJT42Uq3hba5sAV9MjZtFPwQ8Tz9Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iw+gT87bhV7efFNMhRGEidJ6phxJ+kNTWKFZumBng4uiKMeJoDrim2/jmDluAYsvT
	 p5z6M95J2WY8ETQhdGkuhBzTDUZTpXLq6kFx5c0G2ZKlwBzrv60C4sQiYCXw9k/eUK
	 +04gegmLeYWK1Hl8sEJU1PTxPVH+SR8Xzl6W4d5s=
Date: Tue, 15 Oct 2024 12:59:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] ptp: Add clock name to uevent
Message-ID: <2024101532-batboy-twentieth-75c4@gregkh>
References: <20241015105414.2825635-1-svens@linux.ibm.com>
 <20241015105414.2825635-3-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015105414.2825635-3-svens@linux.ibm.com>

On Tue, Oct 15, 2024 at 12:54:13PM +0200, Sven Schnelle wrote:
> To allow users to have stable device names with the help of udev,
> add the name to the udev event that is sent when a new PtP clock
> is available. The key is called 'PTP_CLOCK_NAME'.

Where are you documenting this new user/kernel api you are adding?

> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  drivers/ptp/ptp_clock.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index c56cd0f63909..15937acb79c6 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -25,9 +25,11 @@
>  #define PTP_PPS_EVENT PPS_CAPTUREASSERT
>  #define PTP_PPS_MODE (PTP_PPS_DEFAULTS | PPS_CANWAIT | PPS_TSFMT_TSPEC)
>  
> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env);
>  const struct class ptp_class = {
>  	.name = "ptp",
> -	.dev_groups = ptp_groups
> +	.dev_groups = ptp_groups,
> +	.dev_uevent = ptp_udev_uevent
>  };
>  
>  /* private globals */
> @@ -514,6 +516,13 @@ EXPORT_SYMBOL(ptp_cancel_worker_sync);
>  
>  /* module operations */
>  
> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
> +
> +	return add_uevent_var(env, "PTP_CLOCK_NAME=%s", ptp->info->name);

Why is this needed?  Can't you get the name from the sysfs paths, the
symlink should be there already.

thanks,

greg k-h
