From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: question about arch/s390/kvm/interrupt.c
Date: Mon, 13 Jul 2009 09:55:14 +0200
Message-ID: <20090713095514.50c08ed4@cotte.boeblingen.de.ibm.com>
References: <Pine.LNX.4.64.0907101344350.9598@ask.diku.dk>
	<4A599D51.8030506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4A599D51.8030506@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Julia Lawall <julia@diku.dk>, kvm@vger.kernel.org, borntrae@linux.vnet.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> (copying some s390 people)
> 
> On 07/10/2009 02:47 PM, Julia Lawall wrote:
> > In a recent version of linux-next, the function kvm_s390_handle_wait
> > contains the following code:
> >
> >          add_wait_queue(&vcpu->arch.local_int.wq,&wait);
> >          while (list_empty(&vcpu->arch.local_int.list)&&
> >                  list_empty(&vcpu->arch.local_int.float_int->list)&&
> >                  (!vcpu->arch.local_int.timer_due)&&
> >                  !signal_pending(current)) {
> >                  set_current_state(TASK_INTERRUPTIBLE);
> >                  spin_unlock_bh(&vcpu->arch.local_int.lock);
> >                  spin_unlock(&vcpu->arch.local_int.float_int->lock);
> >                  vcpu_put(vcpu);
> >                  schedule();
> >                  vcpu_load(vcpu);
> >                  spin_lock(&vcpu->arch.local_int.float_int->lock);
> >                  spin_lock_bh(&vcpu->arch.local_int.lock);
> >          }
> >          __unset_cpu_idle(vcpu);
> >          __set_current_state(TASK_RUNNING);
> >          remove_wait_queue(&vcpu->wq,&wait);
> >
> > It seems a bit odd that the first argument to add_wait queue is
> > &vcpu->arch.local_int.wq but the first argument to remove_wait_queue is
> > &vcpu->wq.  I don't see any obvious evidence that they are the same thing,
> > but perhaps I am missing something.  Should either call be changed?
Good catch! It's broken, I'll send a fix later today.

so long,
Carsten
