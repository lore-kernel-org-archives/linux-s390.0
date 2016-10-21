From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC 0/5] cpu_relax: introduce yield, remove lowlatency
Date: Fri, 21 Oct 2016 17:08:54 +0200
Message-ID: <2cf23cb7-05c5-0a2d-2ed5-aa90d582f802@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
	<20161021.105727.140184460493941551.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161021.105727.140184460493941551.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, peterz@infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, virtualization@lists.linux-foundation.org, noamc@ezchip.com, schwidefsky@de.ibm.com, xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 10/21/2016 04:57 PM, David Miller wrote:
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> Date: Fri, 21 Oct 2016 13:58:53 +0200
> 
>> For spinning loops people did often use barrier() or cpu_relax().
>> For most architectures cpu_relax and barrier are the same, but on
>> some architectures cpu_relax can add some latency. For example on s390
>> cpu_relax gives up the time slice to the hypervisor. On power cpu_relax
>> tries to give some of the CPU to the neighbor threads. To reduce the
>> latency another variant cpu_relax_lowlatency was introduced. Before this
>> is used in more and more places, lets revert the logic of provide a new
>> function cpu_relax_yield that can spend some time and for s390 yields
>> the guest CPU.
> 
> Sparc64, fwiw, behaves similarly to powerpc.

As sparc currently defines cpu_relax_lowlatency to cpu_relax, this patch set
should be a no-op then for sparc, correct?

My intend was that cpu_relax should not add a huge latency but can certainly
push some cpu power to hardware threads of the same core. This seems to be
the case for sparc/power and some arc variants. 

Christian
