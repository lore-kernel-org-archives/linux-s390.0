Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 23 Jun 2018 15:52:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 08/11] ARM/time: remove read_boot_clock64()
In-Reply-To: <20180621212518.19914-9-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806231549431.8650@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-9-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Jun 2018, Pavel Tatashin wrote:

> read_boot_clock64() is deleted, and replaced with
> read_persistent_wall_and_boot_offset().
> 
> The default implementation of read_persistent_wall_and_boot_offset()
> provides a better fallback than the current stubs for read_boot_clock64()
> that arm has, so remove the old code.

You forgot to say, that this function has no users, so the removal is not
changing anything,

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/arm/kernel/time.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index cf2701cb0de8..0a6a457b13c7 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -83,29 +83,19 @@ static void dummy_clock_access(struct timespec64 *ts)
>  }
>  
>  static clock_access_fn __read_persistent_clock = dummy_clock_access;
> -static clock_access_fn __read_boot_clock = dummy_clock_access;
>  
>  void read_persistent_clock64(struct timespec64 *ts)
>  {
>  	__read_persistent_clock(ts);
>  }
>  
> -void read_boot_clock64(struct timespec64 *ts)
> -{
> -	__read_boot_clock(ts);
> -}
> -
>  int __init register_persistent_clock(clock_access_fn read_boot,
>  				     clock_access_fn read_persistent)
>  {
>  	/* Only allow the clockaccess functions to be registered once */
> -	if (__read_persistent_clock == dummy_clock_access &&
> -	    __read_boot_clock == dummy_clock_access) {
> -		if (read_boot)
> -			__read_boot_clock = read_boot;

That leaves the fn_read_boot argument unused. So this wants to be cleaned
up as well.

Thanks,

	tglx
