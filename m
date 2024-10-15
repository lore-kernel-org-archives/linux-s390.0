Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4FF1EABC6;
	Tue, 15 Oct 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994573; cv=none; b=oMEMjLWVAl7VhQD656mQbasvXayS9iLceUlYZ5WkHmi6qVfuMq1Csf0r78DQ0VgG0ZF2tsNyLWH3yq6HjzatZBePuyqBvfhzFOPW+6Zycflnx8zMKHOK/jRp6gN3PhaLQLw+doQnWHUJSKOK7j7OpFC/XR1jnqAeTIHEPgXY6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994573; c=relaxed/simple;
	bh=sdbX0S0NB+46Vx7HJphg85Y7GQXTkDsx9c2KykXd9C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsTaV7Wz9s902/FEYkZZBIJbBgdKvz1k/BMhZcIag+g1/049m1xntm8sDz8atGYslvff/1mBk9Ad6RK0MveYvH1Z8kFohK4AFeiCoEsDOipzFQw/DcL07EXubymgpCm+8pdm++GoXkoxd+Gb9Dt+Iq7fSRMCJokDm5gsUvfb6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UYN/PYWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UYN/PYWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AC5C4CED0;
	Tue, 15 Oct 2024 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728994572;
	bh=sdbX0S0NB+46Vx7HJphg85Y7GQXTkDsx9c2KykXd9C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYN/PYWnjVAz1/Xuie8aKA2yLkRalK1Rofne/TFnZaf11+IuVDQquqx1SX2Eu7a/H
	 HTO3TONeW78BNnfGxDK+fjBENBstM99/7ouqh7t7t+CeyfFGzg1HXiNFAhDj/hJzHx
	 tzd+TztG+PHdQSAmNwtjC1WpqEWXCWHgRyDLlk7s=
Date: Tue, 15 Oct 2024 14:16:09 +0200
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
Message-ID: <2024101549-bungee-dodge-057d@gregkh>
References: <20241015105414.2825635-1-svens@linux.ibm.com>
 <20241015105414.2825635-3-svens@linux.ibm.com>
 <2024101532-batboy-twentieth-75c4@gregkh>
 <yt9dmsj5r2uu.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dmsj5r2uu.fsf@linux.ibm.com>

On Tue, Oct 15, 2024 at 02:02:17PM +0200, Sven Schnelle wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Oct 15, 2024 at 12:54:13PM +0200, Sven Schnelle wrote:
> >> To allow users to have stable device names with the help of udev,
> >> add the name to the udev event that is sent when a new PtP clock
> >> is available. The key is called 'PTP_CLOCK_NAME'.
> >
> > Where are you documenting this new user/kernel api you are adding?
> >
> >> 
> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >> ---
> >>  drivers/ptp/ptp_clock.c | 11 ++++++++++-
> >>  1 file changed, 10 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> >> index c56cd0f63909..15937acb79c6 100644
> >> --- a/drivers/ptp/ptp_clock.c
> >> +++ b/drivers/ptp/ptp_clock.c
> >> @@ -25,9 +25,11 @@
> >>  #define PTP_PPS_EVENT PPS_CAPTUREASSERT
> >>  #define PTP_PPS_MODE (PTP_PPS_DEFAULTS | PPS_CANWAIT | PPS_TSFMT_TSPEC)
> >>  
> >> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env);
> >>  const struct class ptp_class = {
> >>  	.name = "ptp",
> >> -	.dev_groups = ptp_groups
> >> +	.dev_groups = ptp_groups,
> >> +	.dev_uevent = ptp_udev_uevent
> >>  };
> >>  
> >>  /* private globals */
> >> @@ -514,6 +516,13 @@ EXPORT_SYMBOL(ptp_cancel_worker_sync);
> >>  
> >>  /* module operations */
> >>  
> >> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env)
> >> +{
> >> +	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
> >> +
> >> +	return add_uevent_var(env, "PTP_CLOCK_NAME=%s", ptp->info->name);
> >
> > Why is this needed?  Can't you get the name from the sysfs paths, the
> > symlink should be there already.
> 
> You mean the 'clock_name' attribute in sysfs?

Great, yes, it's right there.

> That would require to
> write some script to iterate over all ptp devices and check the name,
> or is there a way to match that in udev?

Yes there is.  Please use that :)

thanks,

greg k-h
