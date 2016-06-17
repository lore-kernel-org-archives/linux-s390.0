Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 17 Jun 2016 11:08:21 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390/oprofile: Remove deprecated create_workqueue
References: <20160607215912.GA19722@Karyakshetra>
 <20160609090056.GC3250@osiris>
 <20160613162914.GK25086@rric.localdomain>
 <20160614053608.GB3754@osiris>
 <20160614132823.GL25086@rric.localdomain>
 <20160614155609.GG3754@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160614155609.GG3754@osiris>
Message-Id: <20160617090821.GB5273@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Robert Richter <rric@kernel.org>, Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tejun Heo <tj@kernel.org>, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Andreas Arnez <arnez@linux.vnet.ibm.com>, William Cohen <wcohen@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 14, 2016 at 05:56:09PM +0200, Heiko Carstens wrote:
> On Tue, Jun 14, 2016 at 03:28:23PM +0200, Robert Richter wrote:
> > > 
> > >  Documentation/kernel-parameters.txt |    2 -
> > >  arch/s390/oprofile/Makefile         |    1 -
> > >  arch/s390/oprofile/hwsampler.c      | 1178 --------------------------------
> > >  arch/s390/oprofile/hwsampler.h      |   63 --
> > >  arch/s390/oprofile/init.c           |  489 -------------
> > >  arch/s390/oprofile/op_counter.h     |   21 -
> > >  6 files changed, 1754 deletions(-)
> > 
> > Could you send the patch for review anyway?
> 
> Yes, of course. I added it below, hope that's ok.
> [I did not yet add your Ack]
> 
> From 74ab0aefe07573358cc6a0c462ddc62ccba4c0cf Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Fri, 10 Jun 2016 10:40:06 +0200
> Subject: [PATCH] s390/oprofile: remove hardware sampler support
> 
> Remove hardware sampler support from oprofile module.
> 
> The oprofile user space utilty has been switched to use the kernel
> perf interface, for which we also provide hardware sampling support.
> 
> In addition the hardware sampling support is also slightly broken: it
> supports only 16 bits for the pid and therefore would generate wrong
> results on machines which have a pid >64k.
> 
> Also the pt_regs structure which was passed to oprofile common code
> cannot necessarily be used to generate sane backtraces, since the
> task(s) in question may run while the samples are fed to oprofile.
> So the result would be more or less random.
> 
> However given that the only user space tools switched to the perf
> interface already four years ago the hardware sampler code seems to be
> unused code, and therefore it should be reasonable to remove it.
> 
> The timer based oprofile support continues to work.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  Documentation/kernel-parameters.txt |    2 -
>  arch/s390/oprofile/Makefile         |    1 -
>  arch/s390/oprofile/hwsampler.c      | 1178 -----------------------------------
>  arch/s390/oprofile/hwsampler.h      |   63 --
>  arch/s390/oprofile/init.c           |  489 ---------------
>  arch/s390/oprofile/op_counter.h     |   21 -
>  6 files changed, 1754 deletions(-)
>  delete mode 100644 arch/s390/oprofile/hwsampler.c
>  delete mode 100644 arch/s390/oprofile/hwsampler.h
>  delete mode 100644 arch/s390/oprofile/op_counter.h
> 

Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
