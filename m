Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Jun 2016 15:28:23 +0200
From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] s390/oprofile: Remove deprecated create_workqueue
Message-ID: <20160614132823.GL25086@rric.localdomain>
References: <20160607215912.GA19722@Karyakshetra>
 <20160609090056.GC3250@osiris>
 <20160613162914.GK25086@rric.localdomain>
 <20160614053608.GB3754@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160614053608.GB3754@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tejun Heo <tj@kernel.org>, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Andreas Arnez <arnez@linux.vnet.ibm.com>, William Cohen <wcohen@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 14.06.16 07:36:08, Heiko Carstens wrote:
> On Mon, Jun 13, 2016 at 06:29:14PM +0200, Robert Richter wrote:
> > Heiko,
> > 
> > On 09.06.16 11:00:56, Heiko Carstens wrote:
> > > However I'm wondering if we shouldn't simply remove at least the s390
> > > specific hwswampler code from the oprofile module. This would still leave
> > > the common code timer based sampling mode for oprofile working on s390.
> > > 
> > > It looks like the oprofile user space utility nowadays (since 2012) uses
> > > the kernel perf interface instead of the oprofile interface anyway, if
> > > present. So the oprofile module itself doesn't seem to have too many users
> > > left.
> > > 
> > > Any opinions?
> > 
> > yes, the kernel driver is not necessary for oprofile userland for a
> > while now. There is no ongoing development any longer, most patches
> > are due to changes in the kernel apis.
> > 
> > So if there is code that needs a larger rework due to other kernel
> > changes and there is no user anymore, I am fine with removing the code
> > instead of reworking it. I still would just keep existing code as long
> > as we can keep it unchanged (some like the lightwight of oprofile,
> > esp. in the embedded space). If there is a user of the code, a
> > Tested-by would be good for new code changes.
> > 
> > If there are users of the hwswampler, speak up now. Else, let's just
> > remove it.
> 
> Ok, so I'll wait a week or so and remove the code if nobody speaks up. Is
> it ok for you if I add the patch to the s390 kernel tree?

Yes, pass it through your tree.

> The patch would only remove s390 specific architecture code.
> 
> I have this pending:
> 
>     s390/oprofile: remove hardware sampler support
>     
>     Remove hardware sampler support from oprofile module.
>     
>     The oprofile user space utilty has been switched to use the kernel
>     perf interface, for which we also provide hardware sampling support.
>     
>     In addition the hardware sampling support is also slightly broken: it
>     supports only 16 bits for the pid and therefore would generate wrong
>     results on machines which have a pid >64k.
>     
>     Also the pt_regs structure which was passed to oprofile common code
>     cannot necessarily be used to generate sane backtraces, since the
>     task(s) in question may run while the samples are fed to oprofile.
>     So the result would be more or less random.
>     
>     However given that the only user space tools switched to the perf
>     interface already four years ago the hardware sampler code seems to be
>     unused code, and therefore it should be reasonable to remove it.
>     
>     The timer based oprofile support continues to work.
>     
>     Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: Robert Richter <rric@kernel.org>

> 
>  Documentation/kernel-parameters.txt |    2 -
>  arch/s390/oprofile/Makefile         |    1 -
>  arch/s390/oprofile/hwsampler.c      | 1178 --------------------------------
>  arch/s390/oprofile/hwsampler.h      |   63 --
>  arch/s390/oprofile/init.c           |  489 -------------
>  arch/s390/oprofile/op_counter.h     |   21 -
>  6 files changed, 1754 deletions(-)

Could you send the patch for review anyway?

Thanks,

-Robert
