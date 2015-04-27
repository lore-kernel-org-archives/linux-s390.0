From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 10/17] target-s390x: Add S390 CPU model
 alias definition routines
Date: Mon, 27 Apr 2015 10:11:33 +0200
Message-ID: <553DEF35.5000901@de.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com> <1428933396-37887-11-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-11-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Am 13.04.2015 um 15:56 schrieb Michael Mueller:
> --- a/target-s390x/cpu-models.c
> +++ b/target-s390x/cpu-models.c
> @@ -88,3 +88,85 @@ S390_PROC_DEF("2827-ga2", CPU_S390_2827_GA2, "IBM zEnterprise EC12 GA2")
[...]
> +int set_s390_cpu_alias(const char *name, const char *model)
> +{
> +    S390CPUAlias *alias;
> +
> +    if (!name || !model) {
> +        return -EINVAL;
> +    }
> +    if (!strcmp(name, model)) {
> +        return -EINVAL;
> +    }
> +    if (!s390_cpu_class_by_name(model)) {
> +        return -EINVAL;
> +    }
> +    alias = g_try_malloc0(sizeof(S390CPUAlias));
> +    if (!alias) {
> +        return -ENOMEM;
> +    }
> +    alias->name = g_strdup(name);
> +    alias->model = g_strdup(model);
> +    s390_cpu_aliases = g_slist_append(s390_cpu_aliases, alias);
> +    return 0;
> +}
> +

Applying: target-s390x: Add S390 CPU model alias definition routines
/home/cborntra/REPOS/qemu/.git/rebase-apply/patch:96: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
