From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 13/15] target-s390x: Extend QMP command
 query-cpu-definitions
Date: Mon, 30 Mar 2015 16:54:27 -0300
Message-ID: <20150330195427.GE7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
 <1427725708-52100-14-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427725708-52100-14-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 30, 2015 at 04:28:26PM +0200, Michael Mueller wrote:
[...]
>  CpuDefinitionInfoList *arch_query_cpu_definitions(bool has_machine,
>                                                    const char *machine,
>                                                    bool has_accel,
>                                                    AccelId accel,
>                                                    Error **errp)
>  {
> -    CpuDefinitionInfoList *entry;
> -    CpuDefinitionInfo *info;
> +    S390MachineProps mach;
> +    GSList *classes;
> +    uint64_t *mask;
> +    CpuDefParm parm = {
> +        .list = NULL,
> +        .showFullEntry = false,
> +    };
>  
> -    info = g_malloc0(sizeof(*info));
> -    info->name = g_strdup("host");
> +    if (!s390_cpu_models_used()) {
> +        return qmp_query_cpu_definition_host();
> +    }

Why exactly are you returning different results depending on a global
set by machine initialization? I expect query-cpu-definitions to always
return the same data, no matter what were the QEMU command-line options
used to initialize the machine.

>  
> -    entry = g_malloc0(sizeof(*entry));
> -    entry->value = info;
> +    if (!has_accel || !has_machine) {
> +        goto out;
> +    }
> +
> +    switch (accel) {
> +    case ACCEL_ID_KVM:
> +        if (kvm_s390_get_machine_props(NULL, &mach) < 0) {
> +            return qmp_query_cpu_definition_host();
> +        }
> +        break;
> +    default:
> +        goto out_empty;
> +    }
> +
> +    mask = s390_fac_list_mask_by_machine(machine);
> +    if (!mask) {
> +        error_set(errp, QERR_INVALID_PARAMETER_VALUE, "machine",
> +                  "a valid machine type");
> +        goto out_empty;
> +    }
>  
> -    return entry;
> +    s390_setup_cpu_classes(ACCEL_TEMP, &mach, mask);
> +    parm.showFullEntry = true;
> +out:
> +    classes = object_class_get_list(TYPE_S390_CPU, false);
> +    classes = g_slist_sort(classes, s390_cpu_class_asc_order_compare);
> +    g_slist_foreach(classes, qmp_query_cpu_definition_entry, &parm);
> +    g_slist_free(classes);
> +out_empty:
> +    return parm.list;
>  }
>  

-- 
Eduardo
