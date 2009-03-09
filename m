From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 09 Mar 2009 12:34:27 +0000
Subject: Re: [BUG,2.6.27] "fixpoint divide exception" while creating
Message-Id: <20090309133427.41faac38@osiris.boeblingen.de.ibm.com>
In-Reply-To: <200903091223.19930.elendil@planet.nl>
References: <200903091223.19930.elendil@planet.nl>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 9 Mar 2009 12:23:18 +0100
Frans Pop <elendil@planet.nl> wrote:
> Thanks Heiko. With that patch I can no longer reproduce the problem with 
> 2.6.27.19, so it looks good to me.

Ok, just sent the hopefully final version. Thanks for testing and reporting!

> I do wonder why no one else has hit this problem before. Could it be 
> because the emulator is a relatively (very) slow system?

Yes, I think that's the reason. We still do some daily kernel build on
31 bit kernels, but have never seen the crash you reported. Seems only
to happen if the system is running slow.
