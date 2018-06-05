From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 06/10] vfio: ccw: Make FSM functions atomic
Date: Tue, 5 Jun 2018 17:15:40 +0200
Message-ID: <20180605171540.229f69a9.cohuck@redhat.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1527243678-3140-7-git-send-email-pmorel@linux.vnet.ibm.com>
        <20180605133850.3509a3d3.cohuck@redhat.com>
        <46613ac7-3156-7a78-7d49-acbc3f615b76@linux.ibm.com>
        <20180605153539.1eee99f9.cohuck@redhat.com>
        <6c39016f-8125-c5cc-3b9b-0bc517e5f642@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6c39016f-8125-c5cc-3b9b-0bc517e5f642@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 5 Jun 2018 16:21:03 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 05/06/2018 15:35, Cornelia Huck wrote:
> > On Tue, 5 Jun 2018 15:10:11 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  
> >> On 05/06/2018 13:38, Cornelia Huck wrote:  
> >>> On Fri, 25 May 2018 12:21:14 +0200
> >>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> >>>     
> >>>> We use mutex around the FSM function call to make the FSM
> >>>> event handling and state change atomic.  
> >>> I'm still not really clear as to what this mutex is supposed to
> >>> serialize:
> >>>
> >>> - Modification of the state?
> >>> - Any calls in the state machine?
> >>> - A combination? (That would imply that we only deal with the state in
> >>>     the state machine.)  
> >> yes to all  
> > But wouldn't that imply that you need to either take the mutex if you
> > do something dependent on the state, or fire an event in that case?  
> 
> Yes, if it is not I forgot something important (like I did in patch 10)
> vfio_ccw_fsm_event(private, event) takes the mutex on firering an event.
> 
> I have some cases where I do not respect this.
> This is false and I must handle this with a new private variable,
> this is where I test the state after having fired an event.
> I will need to change this, in quiesce, reset, probe and open (others?).

But isn't that inherently racy? Even if you check the return code from
the state machine change, it might have changed in the meantime again.
