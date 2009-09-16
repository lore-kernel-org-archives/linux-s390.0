From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 16 Sep 2009 06:15:54 +0000
Subject: Re: asynchronous page fault question
Message-Id: <20090916061554.GA4870@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20090914132458.GC30746@redhat.com>
References: <20090914132458.GC30746@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Sep 14, 2009 at 04:24:58PM +0300, Gleb Natapov wrote:
> Hello,
> 
>  pfault_interrupt() puts tsk task to sleep (in case real page is
> missing), but wait if asynchronous page fault interrupt happens
> in non sleepable context? Can this even happen?

No. A (synchronous) pfault interrupt for a missing page happens only if
user space accesses a page.
Thats what the comparison and selection masks in the diag 0x258 parameter
list are good for. 

If a page is present again an interrupt is presented. But the context
doesn't matter in this case.
