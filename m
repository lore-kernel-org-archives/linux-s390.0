Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728060AbgJSKSV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Oct 2020 06:18:21 -0400
Date: Mon, 19 Oct 2020 12:18:11 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: Is OS_INFO_VMCOREINFO unimplemented?
Message-ID: <20201019121811.2fd4c598@ibm>
In-Reply-To: <20201016172419.3abfdeda@ezekiel.suse.cz>
References: <20201013145303.6f99fe89@ezekiel.suse.cz>
        <20201016161125.2fcf494d@ibm>
        <20201016172419.3abfdeda@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: linux-s390@vger.kernel.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>

Hi Petr,

On Fri, 16 Oct 2020 17:24:19 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> Hi Philipp,
> 
> On Fri, 16 Oct 2020 16:11:25 +0200
> Philipp Rudo <prudo@linux.ibm.com> wrote:
> 
> > Hi Petr,
> > 
> > sorry for the late reply.  
> 
> No problem. ;-)
> 
> > It's an interface for non-Linux systems for the stand-alone kdump.
> > 
> > But that's all I'm sure of. I'm afraid only Michael knows the full history
> > behind the implementation. Unfortunately he left IBM ~2 years ago so this piece
> > of knowledge is lost...
> > 
> > My theory is that originally it was planned to use this mechanism for the
> > "normal" kdump as well. But for kdump common code "corrupts" the vmcoreinfo by
> > adding the CRASHTIME shortly before kexec'ing the crash kernel. So the crash
> > kernel would refuse to load the os_info anyway and thus it is never set.  
> 
> Sure, the checksum would have to be recalculated after setting CRASHTIME. But that's perfectly possible.

True. But it's not working out of the box and there's a working workaround. So
let's live with the workaround and implement the proper solution at a later
date. You know, the usual stuff... 

> > Hope this helps you at least a little  
> 
> Yes, to some extent. The reason I asked was that I also implemented parsing of OS_INFO_VMCOREINFO in libkdumpfile a few years ago, but it has no test coverage. So, I looked around a bit and to my surprise all dump files contained a NULL pointer there, which looked somewhat suspicious.
> 
> Anyway, if nobody knows for certain, then my plan is to add the necessary code to the Linux kernel. Patch coming soon on the mailing list. ;-)

Not to discourage you, but my long term goal was to remove the mechanism.
Anyhow I'm willing to revisit this plan. You definitely got me curious :)

Thanks
Philipp


> Thanks,
> Petr T
> 
> > Philipp
> > 
> > 
> > On Tue, 13 Oct 2020 14:53:03 +0200
> > Petr Tesarik <ptesarik@suse.cz> wrote:
> >   
> > > Hi all,
> > > 
> > > I've been looking into kernel crash dump analysis for some time now,
> > > and I've noticed that none of my sample dumps for z/Architecture sets
> > > OS_INFO_VMCOREINFO.
> > > 
> > > Commit 4857d4bbe9821c8d732cb84455e18e12b3d79add suggests that the
> > > "os_info" structure should contain vmcoreinfo, but it seems that the
> > > corresponding fields are always zero, and a quick grep for
> > > OS_INFO_VMCOREINFO finds only code that tries to read this entry in the
> > > panic kernel, but no code that would initialize it in the old (crashed)
> > > kernel.
> > > 
> > > In short, the panic kernel always prints an informational message that
> > > entry 0 is not available and falls back to get_vmcoreinfo_old().
> > > 
> > > Is this a bug, or is this interface used by a non-Linux operating
> > > system that I'm not aware of?
> > > 
> > > TIA,
> > > Petr Tesarik
> > > SUSE HW Enablement    
> 
