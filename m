From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 10/13] s390x/css: introduce and realize
 ccw-request callback
Date: Tue, 2 May 2017 18:04:07 +0200
Message-ID: <20170502180407.33a8f468.cornelia.huck@de.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
        <20170428130951.44771-11-bjsdjshi@linux.vnet.ibm.com>
        <6a3e0621-9e16-ddd4-c1d9-2a7351ebb9e6@redhat.com>
        <20170502021519.GA27968@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170502021519.GA27968@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Auger Eric <eric.auger@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2 May 2017 10:15:19 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Auger Eric <eric.auger@redhat.com> [2017-05-01 19:28:23 +0200]:

> > >  static void vfio_ccw_io_notifier_handler(void *opaque)
> > >  {
> > >      VFIOCCWDevice *vcdev = opaque;
> > > +    struct ccw_io_region *region = vcdev->io_region;
> > > +    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
> > > +    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
> > > +    SubchDev *sch = ccw_dev->sch;
> > > +    SCSW *s = &sch->curr_status.scsw;
> > > +    IRB irb;
> > >  
> > >      if (!event_notifier_test_and_clear(&vcdev->io_notifier)) {
> > >          return;
> > >      }
> > > +
> > > +    if (pread(vcdev->vdev.fd, region,
> > > +              vcdev->io_region_size, vcdev->io_region_offset) == -1) {
> > is it possible to read less bytes than requested?
> Currently, impossible. The kernel side returns either the full region,
> or an error.
> But we surely could make it more friendly for a partial return. I will
> add a check for that case, and generate a channel program check for it.

I think a channel-control check would be more appropriate here.
