From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 11/15] target-s390x: New QMP command query-cpu-model
Date: Mon, 30 Mar 2015 16:50:20 -0300
Message-ID: <20150330195020.GD7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
 <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 30, 2015 at 04:28:24PM +0200, Michael Mueller wrote:
[...]
> diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
> index 829945d..1698b52 100644
> --- a/target-s390x/cpu.c
> +++ b/target-s390x/cpu.c
> @@ -37,6 +37,11 @@
>  #define CR0_RESET       0xE0UL
>  #define CR14_RESET      0xC2000000UL;
>  
> +static inline char *strdup_s390_cpu_name(S390CPUClass *cc)
> +{
> +    return g_strdup_printf("%04x-ga%u", cc->proc.type, cc->mach.ga);
> +}
> +
>  /* generate CPU information for cpu -? */
>  void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>  {
> @@ -74,6 +79,30 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
>  
>      return entry;
>  }
> +
> +CpuModelInfo *arch_query_cpu_model(Error **errp)
> +{
> +    CpuModelInfo *info;
> +    S390CPUClass *cc;
> +
> +    if (!s390_cpu_models_used()) {
> +        return NULL;
> +    }

First question is: why you don't want to just return
  { name: "none", accel: ...  }
when TYPE_S390_CPU ("-cpu none") is used?

Now, assuming that you really want to return NULL if -cpu none is used,
why don't you just ask for the first CPU (like you already do below) and
check if it is a named CPU model, instead of adding a new global? e.g.:

    static bool s390_cpu_class_is_model(S390CPUClass *cc)
    {
        return cpuid(cc->proc) != 0;
    }
    
    CpuModelInfo *arch_query_cpu_model(Error **errp)
    {
        S390CPUClass *cc;
        S390CPUClass *cc;

        cc = S390_CPU_GET_CLASS(s390_cpu_addr2state(0));
        if (!s390_cpu_class_is_model(cc)) {
            return NULL;
        }
        [...]
    }


> +    info = g_try_new0(CpuModelInfo, 1);
> +    if (!info) {
> +        return NULL;
> +    }
> +    cc = S390_CPU_GET_CLASS(s390_cpu_addr2state(0));
> +    info->name = strdup_s390_cpu_name(cc);

I don't think the current version of strdup_s390_cpu_name() can ever
return NULL. Do you expect it to return NULL in the future?

> +    if (!info->name) {
> +        g_free(info);
> +        return NULL;
> +    }
> +    if (kvm_enabled()) {
> +        info->accel = ACCEL_ID_KVM;

This could be a CPUState field, added automatically by
cpu_generic_init() using current_machine->accel.

> +    }
> +    return info;
> +}
>  #endif
>  
>  static void s390_cpu_set_pc(CPUState *cs, vaddr value)
> -- 
> 1.8.3.1
> 

-- 
Eduardo
