From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH/RFC 0/5] cpu_relax: introduce yield, remove lowlatency
Date: Fri, 21 Oct 2016 11:12:19 -0400 (EDT)
Message-ID: <20161021.111219.988688105971081562.davem@davemloft.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
        <20161021.105727.140184460493941551.davem@davemloft.net>
        <2cf23cb7-05c5-0a2d-2ed5-aa90d582f802@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <2cf23cb7-05c5-0a2d-2ed5-aa90d582f802@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: peterz@infradead.org, npiggin@gmail.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, noamc@ezchip.com, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 Oct 2016 17:08:54 +0200

> On 10/21/2016 04:57 PM, David Miller wrote:
>> From: Christian Borntraeger <borntraeger@de.ibm.com>
>> Date: Fri, 21 Oct 2016 13:58:53 +0200
>> 
>>> For spinning loops people did often use barrier() or cpu_relax().
>>> For most architectures cpu_relax and barrier are the same, but on
>>> some architectures cpu_relax can add some latency. For example on s390
>>> cpu_relax gives up the time slice to the hypervisor. On power cpu_relax
>>> tries to give some of the CPU to the neighbor threads. To reduce the
>>> latency another variant cpu_relax_lowlatency was introduced. Before this
>>> is used in more and more places, lets revert the logic of provide a new
>>> function cpu_relax_yield that can spend some time and for s390 yields
>>> the guest CPU.
>> 
>> Sparc64, fwiw, behaves similarly to powerpc.
> 
> As sparc currently defines cpu_relax_lowlatency to cpu_relax, this patch set
> should be a no-op then for sparc, correct?
> 
> My intend was that cpu_relax should not add a huge latency but can certainly
> push some cpu power to hardware threads of the same core. This seems to be
> the case for sparc/power and some arc variants. 

Agreed.
