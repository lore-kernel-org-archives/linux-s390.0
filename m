Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E633B4EA9;
	Tue, 26 May 2026 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779826388; cv=none; b=gGSo9zk4824TJjpMWtQZOuAeeCbLUJpFYODLmNq6UoOscoFw81Nl2vqcoDzvOwJo4dVohqjLT2xIKrIzDVV2MHc3d31PWjW/nlqkHHlovPwkG0k8FUIrElAwA643ZRQ0Wzwqpot1uCTjubE/hLsSxMDlSjlWV2yX1awRcrcvVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779826388; c=relaxed/simple;
	bh=NviVbvUt58nV72tG6TurQve8qkxy/rpSFbMDiksUri4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STlGBbBMiu3nA4ALb23p4hL+RIdS2uYHCDSH0DkK5uyRsmElfSiLEGY91FTKGNljKHZ9GDU5akx/3dRrtdmh7KGBgI6cCfHZ6ZXlBVCdtkf8H2MJjHuVEM/vk7PwqJa8z/hx3AOAhtZL67/aI0NCMy5YAZt5cOJlG1yRypcWu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=pTAqDshU; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="pTAqDshU"
Received: from ncopa-desktop.lan (unknown [IPv6:2001:4646:fb05:0:db93:c1a1:833:ba07])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id 810AF21FFF4;
	Tue, 26 May 2026 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1779826379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swh19O+gG9bAlgK7bIJI72PKJU8aaCLtdwtHQb5/FiY=;
	b=pTAqDshUW/2vEb2uT3/FZoTMK0EuBpenGWGVqEIBmj6E3/dr6Ze6CKqopaRX2uBI0jwfRn
	eeiKc2DETbWc1pHbMDpIn6ED3ji/VZDsSKoj2Gn54CgDvmYgsSVAdGJ6rjZizlRd8yu07N
	IuHXI7yf0c6g4Z4DrdseAMoEUdDvdF0=
Date: Tue, 26 May 2026 22:12:54 +0200
From: Natanael Copa <ncopa@alpinelinux.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com
Subject: Re: [REGRESSION] 6.6.141 s390x build failure in s390/cio due to
 missing driver_override infrastructure
Message-ID: <20260526221254.183e23ef@ncopa-desktop.lan>
In-Reply-To: <20260525231000.agent5-0002@kernel.org>
References: <20260525101635.26090-1-ncopa@alpinelinux.org>
	<20260525231000.agent5-0002@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 07:35:06 -0400
Sasha Levin <sashal@kernel.org> wrote:

> > v6.6.141 fails to build on s390x with
> >
> >   drivers/s390/cio/css.c: error: implicit declaration of function
> >     'device_match_driver_override'
> >   drivers/s390/cio/css.c: error: 'struct bus_type' has no member named
> >     'driver_override'
> >
> > The s390/cio change (c4295487124f, upstream ac4d8bb6e2e1) was queued
> > without its driver-core prerequisite cb3d1049f4ea ("driver core:
> > generalize driver_override in struct device").
> >
> > Could you backport cb3d1049f4ea to 6.6.y, or revert c4295487124f?  
> 
> Thanks for the report and the analysis.
> 
> The driver-core prerequisite (cb3d1049f4ea) is already queued for
> 6.6.y - The companion bdddb54c533f ("driver core: platform: use generic
> driver_override infrastructure") is queued too. Once 6.6.142 ships the build
> error should resolve.
> 
> Newer LTS branches (6.12/6.18/7.0) already have the prerequisite as
> an ancestor, so only 6.6.y was affected.

FYI. We also needed this for the build to pass:

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 93307ca75c10..57cbba03beb8 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1322,7 +1322,7 @@ static int purge_fn(struct subchannel *sch, void *data)
 {
        struct ccw_device *cdev;
 
-       spin_lock_irq(sch->lock);
+       spin_lock_irq(&sch->lock);
        if (sch->st != SUBCHANNEL_TYPE_IO || !sch->schib.pmcw.dnv)
                goto unlock;
 
@@ -1345,7 +1345,7 @@ static int purge_fn(struct subchannel *sch, void *data)
                      sch->schib.pmcw.dev, cdev ? "" : " (no cdev)");
 
 unlock:
-       spin_unlock_irq(sch->lock);
+       spin_unlock_irq(&sch->lock);
        /* Abort loop in case of pending signal. */
        if (signal_pending(current))
                return -EINTR;


-nc
