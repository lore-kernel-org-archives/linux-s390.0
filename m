Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25023 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726988AbgH0KdF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 06:33:05 -0400
Date: Thu, 27 Aug 2020 12:32:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 01/16] s390/vfio-ap: add version vfio_ap module
Message-ID: <20200827123240.42e0c787.cohuck@redhat.com>
In-Reply-To: <ca016eca-1ee7-2d0f-c2ec-3ef147b6216a@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-2-akrowiak@linux.ibm.com>
        <20200825120432.13a1b444.cohuck@redhat.com>
        <ca016eca-1ee7-2d0f-c2ec-3ef147b6216a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Wed, 26 Aug 2020 10:49:47 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 8/25/20 6:04 AM, Cornelia Huck wrote:
> > On Fri, 21 Aug 2020 15:56:01 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> Let's set a version for the vfio_ap module so that automated regression
> >> tests can determine whether dynamic configuration tests can be run or
> >> not.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_drv.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> >> index be2520cc010b..f4ceb380dd61 100644
> >> --- a/drivers/s390/crypto/vfio_ap_drv.c
> >> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> >> @@ -17,10 +17,12 @@
> >>   
> >>   #define VFIO_AP_ROOT_NAME "vfio_ap"
> >>   #define VFIO_AP_DEV_NAME "matrix"
> >> +#define VFIO_AP_MODULE_VERSION "1.2.0"
> >>   
> >>   MODULE_AUTHOR("IBM Corporation");
> >>   MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
> >>   MODULE_LICENSE("GPL v2");
> >> +MODULE_VERSION(VFIO_AP_MODULE_VERSION);
> >>   
> >>   static struct ap_driver vfio_ap_drv;
> >>     
> > Setting a version manually has some drawbacks:
> > - tools wanting to check for capabilities need to keep track which
> >    versions support which features
> > - you need to remember to actually bump the version when adding a new,
> >    visible feature
> > (- selective downstream backports may get into a pickle, but that's
> > arguably not your problem)
> >
> > Is there no way for a tool to figure out whether this is supported?
> > E.g., via existence of a sysfs file, or via a known error that will
> > occur. If not, it's maybe better to expose known capabilities via a
> > generic interface.  
> 
> This patch series introduces a new mediated device sysfs attribute,
> guest_matrix, so the automated tests could check for the existence
> of that interface. The problem I have with that is it will work for
> this version of the vfio_ap device driver - which may be all that is
> ever needed - but does not account for future enhancements
> which may need to be detected by tooling or automated tests.
> It seems to me that regardless of how a tool detects whether
> a feature is supported or not, it will have to keep track of that
> somehow.

Which enhancements? If you change the interface in an incompatible way,
you have a different problem anyway. If someone trying to use the
enhanced version of the interface gets an error on a kernel providing
an older version of the interface, that's a reasonable way to discover
support.

I think "discover device driver capabilities by probing" is less
burdensome and error prone than trying to match up capabilities with a
version number. If you expose a version number, a tool would still have
to probe that version number, and then consult with a list of features
per version, which can easily go out of sync.

> Can you provide more details about this generic interface of
> which you speak?

If that is really needed, I'd probably do a driver sysfs attribute that
exposes a list of documented capabilities (as integer values, or as a
bit.) But since tools can simply check for guest_matrix to find out
about support for this feature here, it seems like overkill to me --
unless you have a multitude of features waiting in queue that need to
be made discoverable.
