From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Feb 2016 16:27:11 +0000
Subject: Re: [libseccomp] Re: [PATCH] arch: update s390/s390x system call tables
Message-Id: <1623819.nA2UEgrD8A@sifl>
In-Reply-To: <20160211121239.GB4020@osiris>
References: <20160211121239.GB4020@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thursday, February 11, 2016 01:12:39 PM Heiko Carstens wrote:
> On Tue, Feb 09, 2016 at 10:55:08AM -0500, Paul Moore wrote:
> > On Tue, Nov 10, 2015 at 8:05 PM, Paul Moore <pmoore@redhat.com> wrote:
> > > On Monday, November 09, 2015 01:15:39 PM Heiko Carstens wrote:
> > >> s390 and s390x gained quite a few new system calls:
> > >> - numa related system calls
> > >> - the separated socket system calls
> > >> - two more s390 specific pci mmio system calls
> > >> 
> > >> All architectures got the new membarrier and userfaultfd system calls.
> > >> 
> > >> This patch updates the s390 specific system call tables and updates
> > >> other
> > >> architectures where needed.
> > >> 
> > >> Also remove some extra whitespace from the s390 specific system call
> > >> tables.
> > >> 
> > >> Both 'make check' and './regression -T live' still work for s390 and
> > >> s390x
> > >> after this update.
> > > 
> > > Thanks for the patch, I'm still reviewing it so it's not yet merged (got
> > > tangled up in some other 4.3 related updates) but I didn't want you to
> > > think I was ignoring you.
> > 
> > My apologies for taking so long - the fixes needed for 4.3 were quite
> > complex - but your patch is now merged, if you could verify that
> > everything is still working on s390/s390x that would be helpful.
> 
> Hi Paul,
> 
> I just verified that both s390 and s390x still pass all test cases.

That's great, thanks for your help!

-- 
paul moore
www.paul-moore.com
