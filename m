Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727525AbfFXLbP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Jun 2019 07:31:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OBRfbh013100
        for <linux-s390@vger.kernel.org>; Mon, 24 Jun 2019 07:31:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2taw5k9dr9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 24 Jun 2019 07:31:13 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 24 Jun 2019 12:31:12 +0100
Date: Mon, 24 Jun 2019 13:31:07 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC v1 1/1] vfio-ccw: Don't call cp_free if we are processing
 a channel program
In-Reply-To: <20190624114231.2d81e36f.cohuck@redhat.com>
References: <cover.1561055076.git.alifm@linux.ibm.com>
        <46dc0cbdcb8a414d70b7807fceb1cca6229408d5.1561055076.git.alifm@linux.ibm.com>
        <638804dc-53c0-ff2f-d123-13c257ad593f@linux.ibm.com>
        <581d756d-7418-cd67-e0e8-f9e4fe10b22d@linux.ibm.com>
        <2d9c04ba-ee50-2f9b-343a-5109274ff52d@linux.ibm.com>
        <56ced048-8c66-a030-af35-8afbbd2abea8@linux.ibm.com>
        <20190624114231.2d81e36f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20190624133107.791601be.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon, 24 Jun 2019 11:42:31 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> > > It can issue whatever it wants, but shouldn't the SSCH get a CC2 until
> > > the halt/clear pending state is cleared?  Hrm, fsm_io_request() doesn't
> > > look.  Rather, it (fsm_io_helper()) relies on the CC2 to be signalled
> > > from the SSCH issued to the device.  There's a lot of stuff that happens
> > > before we get to that point.

Yes CC2 would be the correct thing to do in this situation. Doesn't QEMU
do some sort of logic of this kind already. AFAIR QEMU should reject the
SSCH because it knows that the halt/clear function is in progress or
pending. Or am I worng?

Even if QEMU does it, the kernel must not rely on QEMU or
whatever userspace doing it correctly. What I'm trying to say, if QEMU
can do it vfio_ccw should do it as well.

I'm almost always in favor of sticking close to what PoP says.

    
> > 
> > Yes, and stuff that happens is memory allocation, pinning and other 
> > things which can take time.
> >   
> > > 
> > > I'm wondering if there's a way we could/should return the SSCH here
> > > before we do any processing.  After all, until the interrupt on the
> > > workqueue is processed, we are busy.
> > >     
> > 
> > you mean return the csch/hsch before processing the ssch? Maybe we could 
> > extend CP_PENDING state, to just PENDING and use that to reject any ssch 
> > if we have a pending csch/hsch?  
> 
> I'd probably not rely on the state for this. Maybe we could look at the
> work queue? But it might be that the check for the intparm I suggested
> above is already enough.

PoP says function control bits are what matter here:
"""
Condition code 2 is set, and no other action is
taken, when a start, halt, or clear function is currently
in progress at the subchannel (see “Function Control
(FC)” on page 13).
"""

Regards,
Halil
