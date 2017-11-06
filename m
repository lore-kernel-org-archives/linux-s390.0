From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 06 Nov 2017 16:24:36 +0000
Subject: Re: [PATCH] s390: vfio-ccw: Do not attempt to free no-op and test cda.
Message-Id: <20171106172436.0882df47.cohuck@redhat.com>
In-Reply-To: <1509717011-13219-1-git-send-email-jjherne@linux.vnet.ibm.com>
References: <1509717011-13219-1-git-send-email-jjherne@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 6 Nov 2017 16:46:50 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Jason J. Herne <jjherne@linux.vnet.ibm.com> [2017-11-03 09:50:11 -0400]:
> 
> Add Halil in Cc:.
> 
> > Because we do not make use of the cda (channel data address) for test
> > and no-op ccws no address translation takes place. This means cda will
> > contain a guest address which we do not want to attempt to free. Let's
> > check the command type and skip cda free when it is not needed.
> > 
> > Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> > Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_cp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> > index 5ccfdc8..26f6e3e 100644
> > --- a/drivers/s390/cio/vfio_ccw_cp.c
> > +++ b/drivers/s390/cio/vfio_ccw_cp.c
> > @@ -329,6 +329,8 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
> >  {
> >  	struct ccw1 *ccw = chain->ch_ccw + idx;
> > 
> > +	if (ccw_is_test(ccw) || ccw_is_noop(ccw))
> > +		return;
> >  	if (!ccw->count)
> >  		return;
> > 
> > -- 
> > 2.7.4
> >   
> 
> Forward Halil's comment and my reply here:
> > Halil wrote:
> > Oops. The ccw.count = 0 assignment is done only for format 0 TIC.
> > For format 1 TIC we keep what the original count, which is supposed
> > to be 0 (and channel program check is to be generated if a format 1
> > TIC with count != 0 takes control), but actually may or may not
> > be 0.  
> 
> > Do we have a problem here? Am I missing something. Anyway i recall
> > my ack until this is clarified.  
> Good catch! We didn't notice this problem before, I guess it's because
> we always have (ccw->count == 0) and we only have format 1 ccw as the
> input.
> 
> For a TIC ccw, ccw->cda points to either a ccw in one of the existing
> chain, or points to a whole new allocated chain. Whatever the case is,
> we do not need to do cda free fot it - for the second case,
> ccwchain_free() will free the memory.
> 
> So we should also check TIC. E.g.:
> if (ccw_is_test(ccw) || ccw_is_noop(ccw) || ccw_is_tic(ccw))
> 	return;

Yes, I think your reasoning is correct. We really need a tester in the
guest that also tries those cases.

> 
> BTW, we'd also need to update the commit message if do not want a
> separated patch to fix the TIC problem.

I'd be happy to apply a v2 :)
