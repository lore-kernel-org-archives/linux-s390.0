Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728081AbgFSMrf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jun 2020 08:47:35 -0400
Date: Fri, 19 Jun 2020 14:47:23 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH RFC 1/2] s390/zcore: traverse resources instead of
 memblocks
Message-ID: <20200619144723.01fc99e8@laptop2-ibm.local>
In-Reply-To: <20200610114523.GA5943@osiris>
References: <20200417150151.17239-1-david@redhat.com>
        <20200417150151.17239-2-david@redhat.com>
        <20200610114523.GA5943@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Kirill Smelkov <kirr@nexedi.com>, Alexander Egorenkov <egorenar@linux.vnet.ibm.com>

Hi David,

zcore/memmap is no longer needed and Alexander is preparing a patch to remove
it. You can drop this patch.

Thanks
Philipp

On Wed, 10 Jun 2020 13:45:23 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Fri, Apr 17, 2020 at 05:01:50PM +0200, David Hildenbrand wrote:
> > The zcore memmap basically contains the first level of all system RAM from
> > /proc/iomem. We want to disable CONFIG_ARCH_KEEP_MEMBLOCK (e.g., to not
> > create memblocks for hotplugged/standby memory and save space), switch to
> > traversing system ram resources instead. During early boot, we create
> > resources for all early memblocks (including the crash kernel area). When
> > adding standby memory, we currently create both, memblocks and resources.
> > 
> > Note: As we don't have memory hotplug after boot (standby memory is added
> > via sclp during boot), we don't have to worry about races.
> > 
> > I am only able to test under KVM (where I hacked up zcore to still
> > create the memmap file)
> > 
> > root@vm0:~# cat /proc/iomem
> > 00000000-2fffffff : System RAM
> >   10424000-10ec6fff : Kernel code
> >   10ec7000-1139a0e3 : Kernel data
> >   1177a000-11850fff : Kernel bss
> > 30000000-3fffffff : Crash kernel
> > 
> > Result without this patch:
> > root@vm0:~# cat /sys/kernel/debug/zcore/memmap
> > 0000000000000000 0000000040000000
> > 
> > Result with this patch:
> > root@vm0:~# cat /sys/kernel/debug/zcore/memmap
> > 0000000000000000 0000000030000000 0000000030000000 0000000010000000
> > 
> > The difference is due to memblocks getting merged, resources (currently)
> > not. So we might have some more entries, but they describe the same
> > memory map.
> > 
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: Kirill Smelkov <kirr@nexedi.com>
> > Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  drivers/s390/char/zcore.c | 61 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 48 insertions(+), 13 deletions(-)  
> 
> I'm having a hard time to find any code that ever made use of this
> file. After all this was only meant for our zfcp dumper, but as far as
> I can tell there was never code out there that read the memmap file.
> 
> So the pragmatic approach would be to just change its contents, or a
> more progressive variant would be to remove the file completely.
> But maybe I'm entirely wrong...
> 
> I'm leaving this up to Philipp and Alexander :)
