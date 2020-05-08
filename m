Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52044 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgEHKzt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 06:55:49 -0400
Date: Fri, 8 May 2020 12:55:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: document possible errors
Message-ID: <20200508125541.72adc626.cohuck@redhat.com>
In-Reply-To: <55932365-3d36-1629-5d65-06c71e8231f9@linux.ibm.com>
References: <20200407111605.1795-1-cohuck@redhat.com>
        <55932365-3d36-1629-5d65-06c71e8231f9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, 17 Apr 2020 12:33:18 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 4/7/20 7:16 AM, Cornelia Huck wrote:
> > Interacting with the I/O and the async regions can yield a number
> > of errors, which had been undocumented so far. These are part of
> > the api, so remedy that.  
> 
> (Makes a note to myself, to do the same for the schib/crw regions we're
> adding for channel path handling.)

Yes, please :) I plan to merge this today, so you can add a patch on
top.

> 
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  Documentation/s390/vfio-ccw.rst | 54 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
> > index fca9c4f5bd9c..4538215a362c 100644
> > --- a/Documentation/s390/vfio-ccw.rst
> > +++ b/Documentation/s390/vfio-ccw.rst
> > @@ -210,7 +210,36 @@ Subchannel.
> >  
> >  irb_area stores the I/O result.
> >  
> > -ret_code stores a return code for each access of the region.
> > +ret_code stores a return code for each access of the region. The following
> > +values may occur:
> > +
> > +``0``
> > +  The operation was successful.
> > +
> > +``-EOPNOTSUPP``
> > +  The orb specified transport mode or an unidentified IDAW format, did not
> > +  specify prefetch mode, or the scsw specified a function other than the

'did not specify prefetch mode' needs to be dropped now, will do so
before queuing.

> > +  start function.
> > +
> > +``-EIO``
> > +  A request was issued while the device was not in a state ready to accept
> > +  requests, or an internal error occurred.
> > +
> > +``-EBUSY``
> > +  The subchannel was status pending or busy, or a request is already active.
> > +
> > +``-EAGAIN``
> > +  A request was being processed, and the caller should retry.
> > +
> > +``-EACCES``
> > +  The channel path(s) used for the I/O were found to be not operational.
> > +
> > +``-ENODEV``
> > +  The device was found to be not operational.
> > +
> > +``-EINVAL``
> > +  The orb specified a chain longer than 255 ccws, or an internal error
> > +  occurred.
> >  
> >  This region is always available.  
> 
> Maybe move this little line up between the struct layout and "While
> starting an I/O request, orb_area ..." instead of being lost way down here?

Good idea, that also would match the documentation for the async region.

> 
> But other than that suggestion, everything looks fine.
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>

Thanks!

> 
> >  
> > @@ -231,6 +260,29 @@ This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
> >  
> >  Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
> >  
> > +command specifies the command to be issued; ret_code stores a return code
> > +for each access of the region. The following values may occur:
> > +
> > +``0``
> > +  The operation was successful.
> > +
> > +``-ENODEV``
> > +  The device was found to be not operational.
> > +
> > +``-EINVAL``
> > +  A command other than halt or clear was specified.
> > +
> > +``-EIO``
> > +  A request was issued while the device was not in a state ready to accept
> > +  requests.
> > +
> > +``-EAGAIN``
> > +  A request was being processed, and the caller should retry.
> > +
> > +``-EBUSY``
> > +  The subchannel was status pending or busy while processing a halt request.
> > +
> > +
> >  vfio-ccw operation details
> >  --------------------------
> >  
> >   
> 
