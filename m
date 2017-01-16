From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 16 Jan 2017 13:18:00 +0000
Subject: Re: [bug report] s390/cio: use cssid for pgid generation
Message-Id: <20170116131800.GE4104@mwanda>
In-Reply-To: <alpine.LFD.2.20.1701161356550.1815@schleppi>
References: <alpine.LFD.2.20.1701161356550.1815@schleppi>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 16, 2017 at 02:06:11PM +0100, Sebastian Ott wrote:
> Hello Dan,
> 
> On Mon, 16 Jan 2017, Dan Carpenter wrote:
> > The patch c8500e120b81: "s390/cio: use cssid for pgid generation"
> > from Jun 17, 2016, leads to the following static checker warning:
> > 
> > 	drivers/s390/cio/css.c:707 css_generate_pgid()
> > 	warn: impossible condition '(css->cssid < 0) => (0-255 < 0)'
> > 
> 
> Thanks for your report. This issue was already known and should be fixed
> by now. What's puzzling me, is that c8500e120b81 actually is the fixed
> version where cssid is a signed int. So with commit c8500e120b81 you
> should no longer see this warning.
> 

Huh.  You're right.  I didn't read the code carefully...  :/  Sorry for
the noise.

I'm not sure how this error was generated either because I can't
reproduce it today.

regards,
dan carpenter
