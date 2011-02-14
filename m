From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Mon, 14 Feb 2011 11:55:07 +0000
Subject: Re: Device table incorrect for drivers/s390/block/dasd_eckd.c: 3880/3390
Message-Id: <4D59181B.9020903@linux.vnet.ibm.com>
In-Reply-To: <955743419.776849.1297563007891.JavaMail.root@md01.wow.synacor.com>
References: <955743419.776849.1297563007891.JavaMail.root@md01.wow.synacor.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> Begin forwarded message:
>
> Date: Sat, 12 Feb 2011 21:10:07 -0500 (EST)
> From: Stephen Powell <zlinuxman@wowway.com>
> To: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: 607416@bugs.debian.org, linux-s390@vger.kernel.org
> Subject: Device table incorrect for drivers/s390/block/dasd_eckd.c: 
> 3880/3390 should be 3880/3380
>
>
> On Mon, 27 Dec 2010 10:43:45 +0100, Christian Borntraeger wrote:
> >
> > Stephen,
> >
> > thanks for your report. I forwarded your report to our DASD 
> developers to
> > handle the report.
> >
> > Christian
> >
> > PS: For bug reports or patches you can also include 
> linux-s390@vger.kernel.org
> > most of our developers are subscribed to that list.
>
> Well, it's been about a month and a half, and I have seen no activity,
> and this is a very simple fix; so I thought I would post directly to
> linux-s390@vger.kernel.org to see if I can generate some activity.
> The details of this bug report can be found at
>
>    http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=607416
>
> -- 
>   .''`.     Stephen Powell
>  : :'  :
>  `. `'`
>    `-
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi,

thank you for the reminder. Fix is checked into our CVS.

Stefan
