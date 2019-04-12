Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 12 Apr 2019 10:14:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe to access
 channel programs
Message-ID: <20190412101430.05c80db5.cohuck@redhat.com>
In-Reply-To: <571b9f8c-cfb0-704e-ded4-8661a8136876@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
        <20190301093902.27799-2-cohuck@redhat.com>
        <9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
        <20190408190747.12e3618b.cohuck@redhat.com>
        <20190410013434.7cea1971@oc2783563651>
        <4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
        <571b9f8c-cfb0-704e-ded4-8661a8136876@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 11 Apr 2019 17:27:42 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 4/10/19 10:59 PM, Eric Farman wrote:
> > 
> > 
> > On 4/9/19 7:34 PM, Halil Pasic wrote:  
> >> On Mon, 8 Apr 2019 19:07:47 +0200  
> 
> ...snip...
> 
> >> I'm just running fio on a pass-through DASD and on some virto-blk disks
> >> in parallel. My QEMU is today's vfio-ccw-caps from your repo.
> >>
> >> I see stuff like this:
> >> qemu-git: vfio-ccw: wirte I/O region failed with errno=16[1811/7332/0 
> >> iops] [eta 26m:34s]  
> > 
> > Without knowing what the I/O was that failed, this is a guessing game. 
> > But I encountered something similar just now running fio.
> > 
> > qemu:
> > 2019-04-11T02:06:09.524838Z qemu-system-s390x: vfio-ccw: wirte I/O 
> > region failed with errno=16  
> 
> ...snip...
> 
> >  From the associated I/O, I think this is fixed by a series I am nearly 
> > ready to send for review.  I'll try again with those fixes on top of the 
> > two series here, and report back.  
> 
> So, I've run enough combinations to feel comfortable saying that the 
> error (EBUSY) I saw last night (and presumably the one Halil saw) exists 
> in today's code and is not introduced by this series.  It also appears 
> to be addressed by one of the patches in a series I'm working on, but 
> which that series still has some further problems.  Sigh, there are too 
> many branches and too many interrupts.

Great, thanks for checking! I know that feeling of being tangled in too
many branches...
