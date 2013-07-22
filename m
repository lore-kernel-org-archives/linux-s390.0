From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 22 Jul 2013 00:43:44 +0000
Subject: Re: [PATCH] s390: replace strict_strto*() with kstrto*()
Message-Id: <002801ce8674$8511aee0$8f350ca0$@samsung.com>
In-Reply-To: <002701ce8672$385632d0$a9029870$@samsung.com>
References: <002701ce8672$385632d0$a9029870$@samsung.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Friday, July 19, 2013 11:44 PM, Steffen Maier wrote:
> 
> Hi, it would have been nice to also CC all affected driver maintainers.
> I only saw this by accident and noticed that it might collide with my
> patch queue. Even more so since much of your patch touches code which
> usually goes through different upstream contributors than the core s390
> architecture code.

I will be CC'ing affected driver maintainers.

[.....]

> >
> >> --- a/drivers/s390/net/qeth_l3_sys.c
> >> +++ b/drivers/s390/net/qeth_l3_sys.c
> >> @@ -208,11 +208,10 @@ static ssize_t qeth_l3_dev_sniffer_store(struct device *dev,
> >>   		goto out;
> >>   	}
> >>
> >> -	rc = strict_strtoul(buf, 16, &i);
> >> -	if (rc) {
> >> -		rc = -EINVAL;
> >> +	rc = kstrtoul(buf, 16, &i);
> >> +	if (rc)
> >>   		goto out;
> >
> > This hunk e.g. changes the behaviour of a user space interface. Before
> > your patch -ERANGE was mapped to -EINVAL. Now it is not true anymore.
> > This may or may not be a problem, however I'd like to keep the behaviour
> > as is in order to not risk any user space breakage.
> >
> > So if you could resend a new version which just mechanically replaces
> > strict_strtoul() witch kstrtoul() that would be great.
> 
> For zfcp we have exactly such a patch from Martin in my zfcp upstream
> queue which I would send to James in the near future.

I see.

I will NOT modify 'zfcp'.
I will send v2 patch which excludes 'zfcp'.

Best regards,
Jingoo Han
