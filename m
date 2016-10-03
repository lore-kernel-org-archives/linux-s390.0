From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] KVM: s390: Use memdup_user() rather than
 duplicating code
Date: Mon, 3 Oct 2016 14:11:18 +0200
Message-ID: <CAMuHMdVX6RKZYQyOrX35D+EKoRH6ZFAkyiC=BKnyKtE1Ph4t8g@mail.gmail.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
 <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com> <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
 <c86f7520-885e-2829-ae9c-b81caa898e84@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <c86f7520-885e-2829-ae9c-b81caa898e84@users.sourceforge.net>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>

Hi Markus,

On Wed, Aug 24, 2016 at 8:40 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 24 Aug 2016 20:10:09 +0200
>
> * Reuse existing functionality from memdup_user() instead of keeping
>   duplicate source code.
>
>   This issue was detected by using the Coccinelle software.
>
> * Return directly if this copy operation failed.
>
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>
> v2: Rebased on source files from "Linux next-20160824".
>
>  arch/s390/kvm/guestdbg.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 70b71ac..d7c6a7f 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -216,20 +216,10 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>         else if (dbg->arch.nr_hw_bp > MAX_BP_COUNT)
>                 return -EINVAL;
>
> -       bp_data = kmalloc_array(dbg->arch.nr_hw_bp,
> -                               sizeof(*bp_data),
> -                               GFP_KERNEL);

Probably not an issue here, but if "sizeof(*bp_data) * dbg->arch.nr_hw_bp"
overflows, kmalloc_array() would have returned NULL here...

> -       if (!bp_data) {
> -               ret = -ENOMEM;
> -               goto error;
> -       }
> -
> -       if (copy_from_user(bp_data,
> -                          dbg->arch.hw_bp,
> -                          sizeof(*bp_data) * dbg->arch.nr_hw_bp)) {
> -               ret = -EFAULT;
> -               goto error;
> -       }
> +       bp_data = memdup_user(dbg->arch.hw_bp,
> +                             sizeof(*bp_data) * dbg->arch.nr_hw_bp);

... while this would continue silently, and corrupt memory.

> +       if (IS_ERR(bp_data))
> +               return PTR_ERR(bp_data);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
