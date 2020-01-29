Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgA2ENf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Jan 2020 23:13:35 -0500
Subject: Re: [PATCH v1 1/1] vfio-ccw: Don't free channel programs for
 unrelated interrupts
From: Eric Farman <farman@linux.ibm.com>
References: <20200124145455.51181-1-farman@linux.ibm.com>
 <20200124145455.51181-2-farman@linux.ibm.com>
 <20200124163305.3d6f0d47.cohuck@redhat.com>
 <50a0fe00-a7c1-50e4-12f5-412ee7a0e522@linux.ibm.com>
 <20200127135235.1f783f1b.cohuck@redhat.com>
 <eb3f3887-50f2-ef4d-0b98-b25936047a49@linux.ibm.com>
 <20200128105820.081a4b79.cohuck@redhat.com>
 <6661ad52-0108-e2ae-be19-46ee95e9aa0e@linux.ibm.com>
Message-ID: <9635c45f-4652-c837-d256-46f426737a5e@linux.ibm.com>
Date: Tue, 28 Jan 2020 23:13:30 -0500
MIME-Version: 1.0
In-Reply-To: <6661ad52-0108-e2ae-be19-46ee95e9aa0e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 1/28/20 9:42 AM, Eric Farman wrote:
> 
> 
> On 1/28/20 4:58 AM, Cornelia Huck wrote:
>> On Mon, 27 Jan 2020 16:28:18 -0500

...snip...

>>
>> cp_init checking cp->initialized would probably be good to catch
>> errors, in any case. (Maybe put a trace there, just to see if it fires?)
> 
> I did this last night, and got frustrated.  The unfortunate thing was
> that once it fires, we end up flooding our trace buffers with errors as
> the guest continually retries.  So I need to either make a smarter trace
> that is rate limited or just crash my host once this condition occurs.
> Will try to do that between meetings today.
> 

I reverted the subject patch, and simply triggered
BUG_ON(cp->initialized) in cp_init().  It sprung VERY quickly (all
traces are for the same device):

366.399682 03 ...sch_io_todo state=4 o.cpa=03017810
                             i.w0=00c04007 i.cpa=03017818 i.w2=0c000000
366.399832 03 ...sch_io_todo state=3 o.cpa=7f53dd30 UNSOLICITED
                             i.w0=00c00011 i.cpa=03017818 i.w2=85000000
366.400086 03 ...sch_io_todo state=2 o.cpa=03017930
                             i.w0=00c04007 i.cpa=03017938 i.w2=0c000000
366.400313 03 ...sch_io_todo state=3 o.cpa=03017930
                             i.w0=00001001 i.cpa=03017938 i.w2=00000000

Ah, of course...  Unsolicited interrupts DO reset private->state back to
idle, but leave cp->initialized and any channel_program struct remains
allocated.  So there's one problem (a memory leak), and an easy one to
rectify.

After more than a few silly rabbit holes, I had this trace:

429.928480 07 ...sch_io_todo state=4 init=1 o.cpa=7fed8e10
                             i.w0=00001001 i.cpa=7fed8e18 i.w2=00000000
429.929132 07 ...sch_io_todo state=4 init=1 o.cpa=0305aed0
                             i.w0=00c04007 i.cpa=0305aed8 i.w2=0c000000
429.929538 07 ...sch_io_todo state=4 init=1 o.cpa=0305af30
                             i.w0=00c04007 i.cpa=0305af38 i.w2=0c000000
467.339389 07   ...chp_event mask=0x80 event=1
467.339865 03 ...sch_io_todo state=3 init=0 o.cpa=01814548
                             i.w0=00c02001 i.cpa=0305af38 i.w2=00000000

So my trace is at the beginning of vfio_ccw_sch_io_todo(), but the
BUG_ON() is at the end of that function where private->state is
(possibly) updated.  Looking at the contents of the vfio_ccw_private
struct in the dump, the failing device is currently state=4 init=1
instead of 3/0 as in the above trace.  So an I/O was being built in
parallel here, and there's no serializing action within the stacked
vfio_ccw_sch_io_todo() call to ensure they don't stomp on one another.
The io_mutex handles the region changes, and the subchannel lock handles
the start/halt/clear subchannel instructions, but nothing on the
interrupt side, nor contention between them.  Sigh.

My brain hurts.  I re-applied this patch (with some validation that the
cpa is valid) to my current franken-code, and will let it run overnight.
 I think it's going to be racing other CPUs and I'll find a dead system
by morning, but who knows.  Maybe not.  :)
