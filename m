From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Date: Mon, 03 Feb 2014 13:17:26 +0000
Subject: Re: linux-3.10+: unable to boot 31bit builds
Message-Id: <alpine.LFD.2.11.1402031409460.10713@denkbrett>
In-Reply-To: <201401221330.30404.vapier@gentoo.org>
References: <201401221330.30404.vapier@gentoo.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello,

On Tue, 21 Jan 2014, Heiko Carstens wrote:
> On Tue, Jan 21, 2014 at 12:22:52PM +0100, Heiko Carstens wrote:
> > On Tue, Jan 21, 2014 at 04:57:39AM -0500, Mike Frysinger wrote:
> > > hmm, doesn't seem to work for me.  don't get a crash, just a "virtual machine 
> > > is placed in CP mode due to a SIGP initial C".  whatever that means :).
> > 
> > Ah, that probably happened because the kernel failed to mount the
> > root file system and killed all CPUs before printing a nice error message.
> 
> Ok, that's not correct. Just bisected it down to:
> 
> commit 14556b33f2a5d6a3bc75cd33b709452a31555b25
> Author: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Date:   Sat Apr 13 13:03:54 2013 +0200
> 
>     s390/css: introduce cio_register_early_subchannels
>     
>     Use cio_register_early_subchannels to register early subchannels
>     which are already in use. Call this function before we do the
>     actual subchannel scanning loop. This helps us to get rid of some
>     more special cases regarding the console subchannel.
>     
>     Reviewed-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
>     Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
>     Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> For some non-obvious reason this kills 31 bit with your config under z/VM.
> 

The patch to address this is scheduled for upstream inclusion. Thanks to
both of you for reporting/debugging this!

Regards,
Sebastian
