From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCHv2 04/10] x86/spinlock: Replace ACCESS_ONCE with READ_ONCE/ASSIGN_ONCE
Date: Tue, 25 Nov 2014 21:29:01 +0100
Message-ID: <5474E68D.4010707@de.ibm.com>
References: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com> <1416919117-50652-5-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1416919117-50652-5-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, paulmck@linux.vnet.ibm.com, mingo@kernel.org, torvalds@linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Howells <dhowells@redhat.com>, Russell King <linux@arm.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

Am 25.11.2014 um 13:38 schrieb Christian Borntraeger:
> ACCESS_ONCE does not work reliably on non-scalar types. For
> example gcc 4.6 and 4.7 might remove the volatile tag for such
> accesses during the SRA (scalar replacement of aggregates) step
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
> 
> Change the spinlock code to replace ACCESS_ONCE with READ_ONCE
> and ASSIGN_ONCE.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/x86/include/asm/spinlock.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
> index 9295016..af6e673 100644
> --- a/arch/x86/include/asm/spinlock.h
> +++ b/arch/x86/include/asm/spinlock.h
> @@ -92,7 +92,7 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>  		unsigned count = SPIN_THRESHOLD;
> 
>  		do {
> -			if (ACCESS_ONCE(lock->tickets.head) == inc.tail)
> +			if (ASSIGN_ONCE(inc.tail, lock->tickets.head))

As Mike pointed out: this should be 
			if (READ_ONCE(lock->tickets.head) == inc.tail)
of course.
