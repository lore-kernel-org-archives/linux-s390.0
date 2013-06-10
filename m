From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 10 Jun 2013 14:04:38 +0000
Subject: Re: s390: Implement IRQ functions if !PCI
Message-Id: <20130610160438.237ce20b@mschwide>
In-Reply-To: <20130609.170304.610055126891418919.davem@davemloft.net>
References: <20130609.170304.610055126891418919.davem@davemloft.net>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 09 Jun 2013 17:03:04 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Ben Hutchings <ben@decadent.org.uk>
> Date: Sun, 09 Jun 2013 21:07:31 +0100
> 
> > All architectures must implement IRQ functions.  Since various
> > dependencies on !S390 were removed, there are various drivers that can
> > be selected but will fail to link.  Provide a dummy implementation of
> > these functions for the !PCI case.
> > 
> > Compile-tested only.
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Yeah, this is probably the least painful method to do it. Applied.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
