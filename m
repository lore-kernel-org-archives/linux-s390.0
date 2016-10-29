From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v6 02/11] locking/osq: Drop the overload of osq_lock()
Date: Sat, 29 Oct 2016 09:52:16 -0700
Message-ID: <20161029165216.GA17451@linux-80c1.suse>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1477642287-24104-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477642287-24104-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM
List-ID: <linux-s390.vger.kernel.org>

On Fri, 28 Oct 2016, Pan Xinhui wrote:
> 		/*
> 		 * If we need to reschedule bail... so we can block.
>+		 * Use vcpu_is_preempted to detech lock holder preemption issue
                                            ^^ detect
>+		 * and break. 

Could you please remove the rest of this comment? Its just noise to point out
that vcpu_is_preempted is a macro defined by arch/false. This is standard protocol
in the kernel.

Same goes for all locks you change with this.

Thanks,
Davidlohr

>                * vcpu_is_preempted is a macro defined by false if
>+		 * arch does not support vcpu preempted check,
> 		 */
>-		if (need_resched())
>+		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
> 			goto unqueue;
>
> 		cpu_relax_lowlatency();
>-- 
>2.4.11
>
