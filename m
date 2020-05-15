Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgEOSib (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 14:38:31 -0400
Date: Fri, 15 May 2020 20:37:59 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/4] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
Message-ID: <20200515203759.4ffc6f31.pasic@linux.ibm.com>
In-Reply-To: <931b96fc-0bb5-cdc1-bb1c-102a96f346ea@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
        <20200514154601.007ae46f.pasic@linux.ibm.com>
        <4e00c83b-146f-9f1d-882b-a5378257f32c@linux.ibm.com>
        <20200515165539.2e4a8485.pasic@linux.ibm.com>
        <931b96fc-0bb5-cdc1-bb1c-102a96f346ea@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, 15 May 2020 14:12:05 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> >>> Also why do we see the scenario you describe in the wild? I agree that
> >>> this should be taken care of in the kernel as well, but according to my
> >>> understanding QEMU is already supposed to reject the second SSCH (CPU 2)
> >>> with cc 2 because it sees that FC clear function is set. Or?  
> >>
> >> Maybe for virtio, but for vfio this all gets passed through to the
> >> kernel who makes that distinction. And as I've mentioned above, that's
> >> not happening.  
> > 
> > Let's have a look at the following qemu functions. AFAIK it is
> > common to vfio and virtio, or? Will prefix my inline   
> 
> My mistake, I didn't look far enough up the callchain in my quick look
> at the code.
> 
> ...snip...
> 

No problem. I'm glad I was at least little helpful.

> > 
> > So unless somebody (e.g. the kernel vfio-ccw) nukes the FC bits qemu
> > should prevent the second SSCH from your example getting to the kernel,
> > or?  
> 
> It's not so much something "nukes the FC bits" ... but rather that that
> the data in the irb_area of the io_region is going to reflect what the
> subchannel told us for the interrupt.

This is why the word composition came into my mind. If the HW subchannel
has FC clear, but QEMU subchannel does not the way things compose (or
superpose) is fishy.

> 
> Hrm... If something is polling on TSCH instead of waiting for a tap on
> the shoulder, that's gonna act weird too. Maybe the bits need to be in
> io_region.irb_area proper, rather than this weird private->scsw space.

Do we agree that the scenario you described with that diagram should not
have hit kernel in the first place, because if things were correct QEMU
should have fenced the second SSCH?

I think you do, but want to be sure. If not, then we need to meditate
some more on this.

I do tend to think that the kernel part is not supposed to rely on
userspace playing nice. Especially when it comes to integrity and
correctness. I can't tell  just yet if this is something we must
or just can catch in the kernel module. I'm for catching it regardless,
but I'm even more for everything working as it is supposed. :)

Regards,
Halil
