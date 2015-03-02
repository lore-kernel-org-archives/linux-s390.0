From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 01/16] Introduce probe mode for machine type none
Date: Mon, 2 Mar 2015 16:17:33 -0300
Message-ID: <20150302191733.GK3513@thinpad.lan.raisama.net>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
 <1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 02, 2015 at 01:43:53PM +0100, Michael Mueller wrote:
> QEMU now switches into "probe mode" when the selected machine is "none" and no
> specific accelerator(s) has been requested (i.e.: "-machine none").
> 
> In probe mode a by "<ARCH>_CONFIG" defines predefined list of accelerators run
> their init() methods.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> ---
[...]
>  int configure_accelerator(MachineState *ms)
>  {
> -    const char *p;
> +    const char *p, *name;
>      char buf[10];
>      int ret;
>      bool accel_initialised = false;
>      bool init_failed = false;
>      AccelClass *acc = NULL;
> +    ObjectClass *oc;
> +    bool probe_mode = false;
>  
>      p = qemu_opt_get(qemu_get_machine_opts(), "accel");
>      if (p == NULL) {
> -        /* Use the default "accelerator", tcg */
> -        p = "tcg";
> +        oc = (ObjectClass *) MACHINE_GET_CLASS(current_machine);
> +        name = object_class_get_name(oc);
> +        probe_mode = !strcmp(name, "none" TYPE_MACHINE_SUFFIX);
> +        if (probe_mode) {
> +            /* Use these accelerators in probe mode, tcg should be last */
> +            p = probe_mode_accels;

I don't fully understand the purpose of this patch yet (I will discuss
it in a reply to the cover letter). But if you really want -machine none
to trigger different behavior, why you didn't add a probe_mode field
to MachineClass, so you can set it in the mahine_none class code?

> +        } else {
> +            /* Use the default "accelerator", tcg */
> +            p = "tcg";
> +        }
>      }
[...]

-- 
Eduardo
