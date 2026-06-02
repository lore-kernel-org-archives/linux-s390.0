Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2938D403
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780374049; cv=none; b=DAMV6os4ldvF3VIMoRYO20NsCbZgoD9CjFCwV0wu0DjaE5QZcdIT6bliVNQTYOsaXD+EAMoKH2LauMfulM2H4B0qIuelA3tQCylBUtgfV223ywpHEbj0W0AIKUcyu7xWDnl31ELMN+oJjCui/aPZSwj/N5/B9KdLpbJo/vYE5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780374049; c=relaxed/simple;
	bh=5Xm8IPwfY0dyellfnNLjdKdpNFj+MktK6q6JKPEvMiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZsTsP9Wpf7Whn+vdLSbZOoZ92wQ8dA9UuQpDJRh3ku8iGxz8J1MvFwQ6vLEleLtXEHl9QBOksEE+gCaWRDorG1jIKadhn3S+3+9bysRyvgts0Ge98ePDmsNenVT7+rJhmWCwjJkN0iLYgOJyjxXZ6Q1MYlG4Ug61hT3b1Q6OG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II2P7NY7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II2P7NY7"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6128bd9b3so5617911a34.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780374047; x=1780978847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uT7QUUK+LXQxZ5prqCoLyUCjjU+3++St9mdBXfj/SbU=;
        b=II2P7NY7whDL8gSXkA0nJrCaJP0nMQT94ZDscIeBT9DgwHU/V35pqK7uY6yYRa4op8
         Pkriu1woUtnmCkf9dRhaKVkxTDJzkiptqF1cP7S7BEL01TOy353DSAjRyC12WQHMHkQZ
         apk1coIgC8Z70VXwLZzGdVNJQYzrDqFmXnU/GyJDa7TJjr1fnmdXdaVfWID116A2fhDk
         1K/Hg1foLg5ou1H9wOGFIktUQbWDygnupcRp7jXTPCti15nfqZNv5XQ1nO0QOgJO6Kce
         T25RXUKAXg1qu4W9ersVT0vZd9lo8oB/vlmke+FRzkDgzA3jUdFHHG7btfiP9iZgcm6t
         lfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780374047; x=1780978847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uT7QUUK+LXQxZ5prqCoLyUCjjU+3++St9mdBXfj/SbU=;
        b=cs1ENrT6bPUVb42DLiTEfaa1ka5Hch7cjPgOzukhIxmRpbjPabjd8flM7ts7Bjf6YI
         Z9zq14UifOQL+PaAo1euFYOAH2pdF8zsg3Cm52/4u6q1daSTvvfOArAJ+ra0uIT5eeLh
         wvpsKWJtmalxnH4UNbIyvxHMbt85LpYrMR2FXckGA5JCARnKLZ7OP05cdpSvQGZ/b2sC
         4mHZ6UtQxW0gWCm/hZmDjor8ExI9z6f7FxGSrNOimx3zxMDKl21FgWXL7EnKlVs8WkKI
         O9+gzSBCIJsdc/ScrlhskY9/JlL1axo8yu83H7/xZ4SsL4Rlnfn0iB51E3lR9KZ7MFY4
         35Aw==
X-Forwarded-Encrypted: i=1; AFNElJ8DzSmUzgL6V6S/rONuN1D9NVZdrkbrfdB3zBmIHL0wLB04IJX3iaTqbfaTOKaXTXVkW05bFVUj46Gd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2a7YT5n5eahpJjgllBWKInx0HeH/SrWCEmY85gUj6o5vFN9Rw
	iegThgwu7zEmy4ZyF5p4e8242+0FNCCyNfvZIXRPpHw3gClbDGWsj9Pv
X-Gm-Gg: Acq92OGPVIoEDBmoY2bLFr2XRc1VktICAHThZ8ahJ+rbVkT7LIusvEwkYkbcTBDK3Hu
	CVNt/nkchqPbaaP0ZOm6g1z74M8h034xEFVw5v9b4JpCiBgQoxkfbHZSCt4B844yNp2APCDRGkq
	HpJmOXTueZMJBkLD3hOlk5sx7TbupkqzbGJyPQ/nV7U57IzHTl+j5OOSWmRxENx9dJQYRxIBOsi
	+u6RjjIsPBM525+bXczATqG/1rlkQgXkAsK6onBu1uiyVn3CoYXNZqqhwIcuYTVNbxL/0WiwL/A
	LvkIdZSNCGoY+Os6reiylxAg/tzWpiYypMKJAWLqcyCHN+40uSy9dVgMYZtKlHDZw2tcWqsu+Ia
	G8rllyT+DZ7ULXdFjdURPl5+8UCQJHTKVdaTAIBstsnnojX4fcn7nO0c8pwgTWF1eaMoNgbZCdb
	aR+9ejnP5U1eW/yAVd31X3r29+K8lXjUsItMS5Iq0PMrkqTXgDzxuk
X-Received: by 2002:a05:6830:600d:b0:7d9:ad90:5670 with SMTP id 46e09a7af769-7e6a1db34c7mr10067817a34.18.1780374046933;
        Mon, 01 Jun 2026 21:20:46 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d176dasm9333689a34.16.2026.06.01.21.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:20:45 -0700 (PDT)
Date: Mon, 1 Jun 2026 21:20:40 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Wen Gu <guwen@linux.alibaba.com>,
	tglx@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	daniel.lezcano@kernel.org, sboyd@kernel.org,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
	imx@lists.linux.dev, linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
	mani@kernel.org, imran.shaik@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <ah5aGMIxA418sxoj@hoboy.vegasvil.org>
References: <20260412084704.743482ad@kernel.org>
 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
 <20260412095301.4fe1fe65@kernel.org>
 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
 <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
 <ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
 <3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
 <ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
 <0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
 <20260601185226.7f43fa75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601185226.7f43fa75@kernel.org>


Sorry for replying to David here via Jakub's message.  Somehow my
brilliant Gmail doesn't have David's reply...

On Mon, Jun 01, 2026 at 06:52:26PM -0700, Jakub Kicinski wrote:
> On Mon, 01 Jun 2026 17:53:49 +0100 David Woodhouse wrote:
> > On Mon, 2026-06-01 at 08:20 -0700, Richard Cochran wrote:
> > > Sorry, just catching up here, so the idea is to have
> > > 
> > >  linux/drivers/ptp/drivers  ?  
> > 
> > That is my current suggestion.

drivers/../drivers seems a bit silly to me

> > It stems from Jakub's response in
> > https://lore.kernel.org/all/20250815113814.5e135318@kernel.org/ that "I
> > really wish someone stepped up and created a separate subsystem for all
> > these cloud / vm clocks. They have nothing to do with PTP."
> > 
> > There was some further bikeshedding in
> > https://lore.kernel.org/netdev/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com/

The idea of categorizing core, NIC-related, vm, and stand alone clock
devices makes some sense to me.

> > around how to split 'emulated' from other hardware drivers, but I don't
> > much like that taxonomy. Some of these "virtual" clocks could just as
> > easily exist in hardware with PTM too.

So the whole in-kernel API in ptp_clock_kernel.h with ptp_clock_info,
etc, was poorly named (by me) back around Linux 3.0.  After all, the
abbreviation, "PTP", stands for a network protocol.  At the time, Alan
Cox pointed that out and complained, but somehow the code got merged
anyhow.

The term PHC is a better one, since PTP Hardware Clock means clock
device whose purpose is to support network time keeping together with
a NIC.

> > My observation is that with the sole exception of ptp_inet.c, *all* of
> > the actual PHC drivers that live in drivers/ptp instead of drivers/net
> > are "pure clock" drivers,

No, that is not quite right.  The clockmatrix, idt82p33, ines, and
qoriq drivers wouldn't be very useful without an attached NIC.

> > so perhaps we split those all out into
> > drivers/ptp/drivers/ and exclude them from the netdev maintenance?

Originally the idea was that the rate of patches would be low enough
that netdev would be the place to post and review them, and that no
separate tree or mailing list were needed. 

Even though the "PTP" naming was an unfortunate choice way back when,
still I'm not a big fan of moving stuff around "just because".

But moving forward, I would suggest starting a new area for pure
hardware clock devices.  

   "Clock Devices" ?
   linux/drivers/cd

Too short!

   "Time Keeping Devices" ?
   linux/drivers/tkd

Confuses core time keeping!

   "Advanced Clock Devices" ?
   linux/drivers/acd

Let's come up with a fitting name.

Still, I don't understand why these new (non-network related ) device
drivers can't be implemented in their own class using posix_clock_register()
etc.

Any of the useful bits (like sysfs interfaces) can be refactored out
of ptp_clock.c and shared as a common layer.

Thanks,
Richard
