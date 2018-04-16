From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: process ssch with interrupts disabled
Date: Mon, 16 Apr 2018 11:35:57 +0200
Message-ID: <20180416113557.25d4fbbb.cohuck@redhat.com>
References: <20180413140509.9042-1-cohuck@redhat.com>
        <20180416021312.GO12194@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416021312.GO12194@bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 16 Apr 2018 10:13:12 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-04-13 16:05:09 +0200]:
> 
> > When we call ssch, an interrupt might already be pending once we
> > return from the START SUBCHANNEL instruction. Therefore we need to
> > make sure interrupts are disabled until after we're done with our
> > processing.  
> Sounds right.
> 
> > 
> > Note that the subchannel lock is the same as the ccwdevice lock that
> > is mentioned in the documentation for ccw_device_start() and friends.  
> I think this is helpful hint for me to understand the correct way of
> using sch->lock in our context, but not sure if the word "same" brings
> confusion to the others. There are many difference between them,
> considering the fact that sch->lock exists in the CSS driver for a long
> time already, and it is not external interface like ccw_dev->lock, and
> its usage is different with ccw_dev->lock in the existing code.
> It's because vfio-ccw are offering interface to the external world based
> directly on the css driver level, it makes the purpose of protecting
> what should be protected with it becomes the same.
> 
> Not a problem for me, but better with a better rewording?

Huh, my intention was to clarify things, not to make them more
confusing :)

The documentation for ccw_device_start() and friends seems to be the
only place where we explicitly state locking requirements, so that's
where I came from. Maybe simply reword the first paragraph to mention
the lock?

"When we call ssch, an interrupt might already be pending once we
return from the START SUBCHANNEL instruction. Therefore we need to make
sure interrupts are disabled while holding the subchannel lock until
after we're done with our processing."

Or maybe things are already clear enough from the code?
> 
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_fsm.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)

> LGTM:
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
> 

Thanks!
