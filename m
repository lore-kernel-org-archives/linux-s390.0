Return-Path: <SRS0=A7Pw=TP=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 15 May 2019 15:42:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 7/7] s390/cio: Remove vfio-ccw checks of command
 codes
Message-ID: <20190515154207.3a6f7968.cohuck@redhat.com>
In-Reply-To: <1f0e2084-2e3d-bc97-f8cf-a40f194d7288@linux.ibm.com>
References: <20190514234248.36203-1-farman@linux.ibm.com>
        <20190514234248.36203-8-farman@linux.ibm.com>
        <20190515144305.46a2ecb1.cohuck@redhat.com>
        <1f0e2084-2e3d-bc97-f8cf-a40f194d7288@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 May 2019 09:36:01 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/15/19 8:43 AM, Cornelia Huck wrote:
> > On Wed, 15 May 2019 01:42:48 +0200
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> If the CCW being processed is a No-Operation, then by definition no
> >> data is being transferred.  Let's fold those checks into the normal
> >> CCW processors, rather than skipping out early.
> >>
> >> Likewise, if the CCW being processed is a "test" (an invented
> >> definition to simply mean it ends in a zero), let's permit that to go
> >> through to the hardware.  There's nothing inherently unique about
> >> those command codes versus one that ends in an eight [1], or any other
> >> otherwise valid command codes that are undefined for the device type
> >> in question.  
> > 
> > Hm... let's tweak that a bit? It's not that "test" is an invented
> > category; it's just that this has not been a valid command for
> > post-s/370 and therefore should not get any special treatment and just
> > be sent to the hardware?  
> 
> Agreed, I should've re-read that one before I sent it...  How about:
> 
> Likewise, if the CCW being processed is a "test" (a category defined
> here as an opcode that contains zero in the lowest four bits) then no
> special processing is necessary as far as vfio-ccw is concerned.
> These command codes have not been valid since the S/370 days, meaning
> they are invalid in the same way as one that ends in an eight [1] or
> an otherwise valid command code that is undefined for the device type
> in question.  Considering that, let's just process "test" CCWs like
> any other CCW, and send everything to the hardware.

Sounds good to me!

> 
> >   
> >>
> >> [1] POPS states that a x08 is a TIC CCW, and that having any high-order
> >> bits enabled is invalid for format-1 CCWs.  For format-0 CCWs, the
> >> high-order bits are ignored.
> >>
> >> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> >> ---
> >>   drivers/s390/cio/vfio_ccw_cp.c | 11 +++++------
> >>   1 file changed, 5 insertions(+), 6 deletions(-)  
> >   
> 
