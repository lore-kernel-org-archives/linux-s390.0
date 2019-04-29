From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next] system hangs likely due to "modules: Only return -EEXIST
 for modules that have finished loading"
Date: Mon, 29 Apr 2019 07:55:20 +0200
Message-ID: <20190429055520.GA3665@osiris>
References: <20190426130736.GB8646@osiris>
 <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
 <20190426150741.GD8646@osiris>
 <20190426160956.GA3827@linux-8ccs>
 <2e047a7e-bf08-be8c-bdd0-429464fa133d@redhat.com>
 <52c293e9-ddfa-426a-a8f1-2106e250e78d@redhat.com>
 <f74996cb-3e0a-ab23-00b9-85ac782583d1@redhat.com>
 <20190427102440.GA28889@osiris>
 <6a69074a-e913-3b67-feef-9b62a7400f8a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a69074a-e913-3b67-feef-9b62a7400f8a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Cathy Avery <cavery@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Apr 27, 2019 at 06:42:51AM -0400, Prarit Bhargava wrote:
> On 4/27/19 6:24 AM, Heiko Carstens wrote:
> 
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 410eeb7e4f1d..48748cfec991 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -3585,6 +3585,7 @@ again:
> >  					       finished_loading(mod->name));
> >  			if (err)
> >  				goto out_unlocked;
> > +			cond_resched();
> Heiko, I'm testing on 2-cpu systems which appear to show the problem ~10% of the
> time.  On another system I backed out my original patch to set a baseline, and
> noticed that occasionally the time to boot the system doubles from ~4 seconds to
> 9 seconds.  Is this something you're also concerned with?

This _could_ be an issue, since I see the problem much more likely to
happen on systems with many devices (where many means only something
like 10 block devices). As far as I can tell it looks like
systemd/udevd tries to modprobe at the s390-trng module for each(!)
device.
I have no idea why it is doing that... however given that (failed)
module handling now sometimes takes more time, this might become a
real issue on system with several 1000s of block devices, which is a
realistic scenario at least on s390.
