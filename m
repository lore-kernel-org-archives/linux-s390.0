Return-Path: <linux-kernel-owner+w=401wt.eu-S1759054AbXKPPoj@vger.kernel.org>
Date: Fri, 16 Nov 2007 16:09:42 +0100
From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [patch 3/6] sclp: call sclp_init() from start_kernel().
Message-ID: <20071116150942.GA5748@wavehammer.waldi.eu.org>
References: <20071116142942.978412023@de.ibm.com> <20071116143321.502691250@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20071116143321.502691250@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 16, 2007 at 03:29:45PM +0100, Martin Schwidefsky wrote:
>  #else
>  static inline void acpi_early_init(void) { }
>  #endif
> +#ifdef CONFIG_S390
> +extern int sclp_init(void);
> +#else
> +static inline int sclp_init(void) {return 0;}
> +#endif
>  #ifndef CONFIG_DEBUG_RODATA
>  static inline void mark_rodata_ro(void) { }
>  #endif
> @@ -643,6 +648,7 @@ asmlinkage void __init start_kernel(void
>  	check_bugs();
>  
>  	acpi_early_init(); /* before LAPIC and SMP init */
> +	sclp_init();

What happens if sclp_init fails? The other early init calls explicitely
returns void and handels the error internal.

Bastian

-- 
Time is fluid ... like a river with currents, eddies, backwash.
		-- Spock, "The City on the Edge of Forever", stardate 3134.0
