From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [GIT PULL v2 1/5] processor.h: introduce cpu_relax_yield
Date: Tue, 15 Nov 2016 12:30:30 +0000
Message-ID: <20161115123029.GT1041@n2100.armlinux.org.uk>
References: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
 <1477386195-32736-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477386195-32736-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>, sparclinux@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 25, 2016 at 11:03:11AM +0200, Christian Borntraeger wrote:
> For spinning loops people do often use barrier() or cpu_relax().
> For most architectures cpu_relax and barrier are the same, but on
> some architectures cpu_relax can add some latency.
> For example on power,sparc64 and arc, cpu_relax can shift the CPU
> towards other hardware threads in an SMT environment.
> On s390 cpu_relax does even more, it uses an hypercall to the
> hypervisor to give up the timeslice.
> In contrast to the SMT yielding this can result in larger latencies.
> In some places this latency is unwanted, so another variant
> "cpu_relax_lowlatency" was introduced. Before this is used in more
> and more places, lets revert the logic and provide a cpu_relax_yield
> that can be called in places where yielding is more important than
> latency. By default this is the same as cpu_relax on all architectures.

Rather than having to update all these architectures in this way, can't
we put in some linux/*.h header something like:

#ifndef cpu_relax_yield
#define cpu_relax_yield() cpu_relax()
#endif

so only those architectures that need to do something need to be
modified?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
