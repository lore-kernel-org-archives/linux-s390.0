Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20181001202538.GB4958@osiris>
References: <20180930164950.3841-1-ard.biesheuvel@linaro.org> <20181001202538.GB4958@osiris>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 2 Oct 2018 07:48:48 +0200
Message-ID: <CAKv+Gu-T6YLb3gAhNtBmY1SbNovuzKFxJ1A7R0R=CygndvzGYQ@mail.gmail.com>
Subject: Re: [PATCH] s390: vmlinux.lds: move JUMP_TABLE_DATA into output section
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On 1 October 2018 at 22:25, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> On Sun, Sep 30, 2018 at 06:49:50PM +0200, Ard Biesheuvel wrote:
>> Commit e872267b8bcbb179 ("jump_table: move entries into ro_after_init
>> region") moved the __jump_table input section into the __ro_after_init
>> output section, but inadvertently put the macro in the wrong place in
>> the s390 linker script. Let's fix that.
>>
>> Fixes: e872267b8bcbb179 ("jump_table: move entries into ro_after_init region")
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Jessica Yu <jeyu@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/s390/kernel/vmlinux.lds.S | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>
> I don't think this is very obvious, but this fixes current build breakage
> in linux-next and I assume Thomas should pick this up.
>

Indeed.

Thomas, Ingo,

Could you please take this fix for the jump lable changes queued in
-next, and the other one I sent out yesterday [0], through core/core
in tip.git as before?

Thanks,
Ard.

[0] https://lore.kernel.org/lkml/20181001081324.11553-1-ard.biesheuvel@linaro.org/
