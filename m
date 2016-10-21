From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/9] implement vcpu preempted check
Date: Fri, 21 Oct 2016 07:40:50 +0200
Message-ID: <20161021054050.GX3102@twins.programming.kicks-ass.net>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 20, 2016 at 05:27:45PM -0400, Pan Xinhui wrote:

> 
> This patch set aims to fix lock holder preemption issues.

Thanks, this looks very good. I'll wait for ACKs from at least the KVM
people, since that was I think the most contentious patch.
