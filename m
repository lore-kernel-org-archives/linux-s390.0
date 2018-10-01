Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 1 Oct 2018 22:25:38 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: vmlinux.lds: move JUMP_TABLE_DATA into output
 section
References: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
Message-Id: <20181001202538.GB4958@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux@roeck-us.net, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Sep 30, 2018 at 06:49:50PM +0200, Ard Biesheuvel wrote:
> Commit e872267b8bcbb179 ("jump_table: move entries into ro_after_init
> region") moved the __jump_table input section into the __ro_after_init
> output section, but inadvertently put the macro in the wrong place in
> the s390 linker script. Let's fix that.
> 
> Fixes: e872267b8bcbb179 ("jump_table: move entries into ro_after_init region")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/s390/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

I don't think this is very obvious, but this fixes current build breakage
in linux-next and I assume Thomas should pick this up.

> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 4042bbf3f9ad..457713f48734 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -64,9 +64,9 @@ SECTIONS
>  	__start_ro_after_init = .;
>  	.data..ro_after_init : {
>  		 *(.data..ro_after_init)
> +		JUMP_TABLE_DATA
>  	}
>  	EXCEPTION_TABLE(16)
> -	JUMP_TABLE_DATA
>  	. = ALIGN(PAGE_SIZE);
>  	__end_ro_after_init = .;
> 
> -- 
> 2.17.1
> 
