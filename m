From: Avi Kivity <avi@redhat.com>
Subject: Re: question about arch/s390/kvm/interrupt.c
Date: Sun, 12 Jul 2009 11:22:41 +0300
Message-ID: <4A599D51.8030506@redhat.com>
References: <Pine.LNX.4.64.0907101344350.9598@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0907101344350.9598@ask.diku.dk>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: kvm@vger.kernel.org, =?ISO-8859-1?Q?Christian_Borntr=E4ger?= <borntrae@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

(copying some s390 people)

On 07/10/2009 02:47 PM, Julia Lawall wrote:
> In a recent version of linux-next, the function kvm_s390_handle_wait
> contains the following code:
>
>          add_wait_queue(&vcpu->arch.local_int.wq,&wait);
>          while (list_empty(&vcpu->arch.local_int.list)&&
>                  list_empty(&vcpu->arch.local_int.float_int->list)&&
>                  (!vcpu->arch.local_int.timer_due)&&
>                  !signal_pending(current)) {
>                  set_current_state(TASK_INTERRUPTIBLE);
>                  spin_unlock_bh(&vcpu->arch.local_int.lock);
>                  spin_unlock(&vcpu->arch.local_int.float_int->lock);
>                  vcpu_put(vcpu);
>                  schedule();
>                  vcpu_load(vcpu);
>                  spin_lock(&vcpu->arch.local_int.float_int->lock);
>                  spin_lock_bh(&vcpu->arch.local_int.lock);
>          }
>          __unset_cpu_idle(vcpu);
>          __set_current_state(TASK_RUNNING);
>          remove_wait_queue(&vcpu->wq,&wait);
>
> It seems a bit odd that the first argument to add_wait queue is
> &vcpu->arch.local_int.wq but the first argument to remove_wait_queue is
> &vcpu->wq.  I don't see any obvious evidence that they are the same thing,
> but perhaps I am missing something.  Should either call be changed?
>
> julia
>    


-- 
error compiling committee.c: too many arguments to function
