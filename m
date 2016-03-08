From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 08 Mar 2016 13:16:05 +0000
Subject: Re: [PATCH] s390: Fix misspellings in comments.
Message-Id: <20160308131605.GC3869@osiris>
In-Reply-To: <1457119204-15188-1-git-send-email-adam.buchbinder@gmail.com>
References: <1457119204-15188-1-git-send-email-adam.buchbinder@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Mar 04, 2016 at 11:20:04AM -0800, Adam Buchbinder wrote:
> Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
> ---
>  arch/s390/include/asm/perf_event.h | 2 +-
>  arch/s390/include/asm/rwsem.h      | 2 +-
>  arch/s390/kernel/perf_cpum_cf.c    | 2 +-
>  arch/s390/kernel/perf_event.c      | 2 +-
>  arch/s390/kvm/guestdbg.c           | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)

[...]

> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index d697312..88e118f 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -17,7 +17,7 @@
>  /*
>   * Extends the address range given by *start and *stop to include the address
>   * range starting with estart and the length len. Takes care of overflowing
> - * intervals and tries to minimize the overall intervall size.
> + * intervals and tries to minimize the overall interval size.
>   */
>  static void extend_address_range(u64 *start, u64 *stop, u64 estart, int len)
>  {
> @@ -72,7 +72,7 @@ static void enable_all_hw_bp(struct kvm_vcpu *vcpu)
>  		return;
>  
>  	/*
> -	 * If the guest is not interrested in branching events, we can savely
> +	 * If the guest is not interrested in branching events, we can safely

"interested" would be correct, I think.

Changed and applied, thanks!
