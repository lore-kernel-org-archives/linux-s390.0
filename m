From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 01 Nov 2018 10:23:05 +0000
Subject: Re: [PATCH 1/1] s390/config: Enable CONFIG_PRINTK_TIME in defconfig
Message-Id: <20181101102305.GA22042@dell5510>
In-Reply-To: <20181101100509.GB5757@osiris>
References: <20181101100509.GB5757@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Heiko,

> What does this fix for you? Not having timestamps on the console makes
> life easier for developers, since this wouldn't waste so much line
> space on e.g. a 3215 console.
> While the other configs within the configs directory are supposed to
> be more distro-like.

> So, I'm not willing to apply this one, since it makes my life not
> easier ;)

Thanks for review. I consider timestamps useful even on console.
But sorry, I considered only x3270 and thought that reason, why
it's off is due ring buffer size.


Kind regards,
Petr
