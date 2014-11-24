From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC 6/7] arm64: Replace ACCESS_ONCE for spinlock code
 with barriers
Date: Mon, 24 Nov 2014 19:50:33 +0100
Message-ID: <54737DF9.20009@de.ibm.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com> <1416834210-61738-7-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416834210-61738-7-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, paulmck@linux.vnet.ibm.com, mingo@kernel.org, torvalds@linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-ID: <linux-s390.vger.kernel.org>

Am 24.11.2014 um 14:03 schrieb Christian Borntraeger:
> ACCESS_ONCE does not work reliably on non-scalar types. For
> example gcc 4.6 and 4.7 might remove the volatile tag for such
> accesses during the SRA (scalar replacement of aggregates) step
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
> 
> Change the spinlock code to access the lock with a barrier.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/arm64/include/asm/spinlock.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
> index c45b7b1..f72dc64 100644
> --- a/arch/arm64/include/asm/spinlock.h
> +++ b/arch/arm64/include/asm/spinlock.h
> @@ -99,12 +99,15 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> 
>  static inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  {
> -	return !arch_spin_value_unlocked(ACCESS_ONCE(*lock));
> +	arch_spinlock_t lockval = *lock;
> +	barrier();
> +	return !arch_spin_value_unlocked(lockval);
>  }
> 
>  static inline int arch_spin_is_contended(arch_spinlock_t *lock)
>  {
> -	arch_spinlock_t lockval = ACCESS_ONCE(*lock);
> +	arch_spinlock_t lockval = *lock;
> +	barrier();
>  	return (lockval.next - lockval.owner) > 1;
>  }
>  #define arch_spin_is_contended	arch_spin_is_contended
> 
FWIW,

we could also make this with ACCESS_ONCE, but this requires to change the definition of arch_spinlock_t for arm64 to be a union. I am a bit reluctant to do these changes without being able to test. Let me know if this is preferred and if somebody else can test.

Christian
