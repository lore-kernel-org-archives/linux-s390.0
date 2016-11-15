From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL v2 1/5] processor.h: introduce cpu_relax_yield
Date: Tue, 15 Nov 2016 14:52:03 +0100
Message-ID: <7ebfbdba-02bb-e837-dbce-6a5acaf3a374@de.ibm.com>
References: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
	<1477386195-32736-2-git-send-email-borntraeger@de.ibm.com>
	<20161115123029.GT1041@n2100.armlinux.org.uk>
	<7f7850e4-c7bb-9cc1-2d65-a1555e97988a@de.ibm.com>
	<20161115133758.GV1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161115133758.GV1041@n2100.armlinux.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org, sparclinux@vger.kernel.org, Noam Camus <noamc@ezchip.com>, Catalin Marinas <catalin.marinas@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 11/15/2016 02:37 PM, Russell King - ARM Linux wrote:
> On Tue, Nov 15, 2016 at 02:19:53PM +0100, Christian Borntraeger wrote:
>> On 11/15/2016 01:30 PM, Russell King - ARM Linux wrote:
>>> On Tue, Oct 25, 2016 at 11:03:11AM +0200, Christian Borntraeger wrote:
>>>> For spinning loops people do often use barrier() or cpu_relax().
>>>> For most architectures cpu_relax and barrier are the same, but on
>>>> some architectures cpu_relax can add some latency.
>>>> For example on power,sparc64 and arc, cpu_relax can shift the CPU
>>>> towards other hardware threads in an SMT environment.
>>>> On s390 cpu_relax does even more, it uses an hypercall to the
>>>> hypervisor to give up the timeslice.
>>>> In contrast to the SMT yielding this can result in larger latencies.
>>>> In some places this latency is unwanted, so another variant
>>>> "cpu_relax_lowlatency" was introduced. Before this is used in more
>>>> and more places, lets revert the logic and provide a cpu_relax_yield
>>>> that can be called in places where yielding is more important than
>>>> latency. By default this is the same as cpu_relax on all architectures.
>>>
>>> Rather than having to update all these architectures in this way, can't
>>> we put in some linux/*.h header something like:
>>>
>>> #ifndef cpu_relax_yield
>>> #define cpu_relax_yield() cpu_relax()
>>> #endif
>>>
>>> so only those architectures that need to do something need to be
>>> modified?
>>
>> These patches are part of linux-next since a month or so, changing that 
>> would invalidate all the next testing. If people want that, I can certainly
>> do that, though.
> 
> It's three weeks since you posted them.  For one of those weeks (the
> week you posted them) I was away, and missed them while catching up.
> Sorry, but it sometimes takes a while to spot things amongst the
> backlog, and normally takes some subsequent activity on the thread to
> bring it back into view.

Absolutely no need to apologize. Thank you for doing the review and the proposal. 
I will do whatever is consensus, but since this looks like tip/locking material
I will wait for Peter or Ingo to decide about the if and how.

Christian
