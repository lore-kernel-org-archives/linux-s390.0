From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] KVM: s390: add vcpu stat counters for many
 instruction
Date: Wed, 24 Jan 2018 16:27:22 +0100
Message-ID: <20180124162722.688d058a.cohuck@redhat.com>
References: <20180124113235.31485-1-borntraeger@de.ibm.com>
        <20180124113235.31485-2-borntraeger@de.ibm.com>
        <20180124154510.02481cc6.cohuck@redhat.com>
        <1570f253-f499-06dd-c869-5f8e422ea85b@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1570f253-f499-06dd-c869-5f8e422ea85b@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 24 Jan 2018 16:20:49 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 01/24/2018 03:45 PM, Cornelia Huck wrote:

> > If your goal is to catch all instructions, shouldn't you add a counter
> > for diagnose functions that don't have a kernel handler as well?  
> 
> Will add that on top.
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 913c8ac849206..c8b3c1aee7b5c 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -367,6 +367,7 @@ struct kvm_vcpu_stat {
>         u64 diagnose_258;
>         u64 diagnose_308;
>         u64 diagnose_500;
> +       u64 diagnose_other;
>  };
>  
>  #define PGM_OPERATION                  0x01
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 89aa114a2cbad..45634b3d2e0ae 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -257,6 +257,7 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
>         case 0x500:
>                 return __diag_virtio_hypercall(vcpu);
>         default:
> +               vcpu->stat.diagnose_other++;
>                 return -EOPNOTSUPP;
>         }
>  }
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 35e18d84e6828..648c6943cdfed 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -138,6 +138,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>         { "instruction_diag_258", VCPU_STAT(diagnose_258) },
>         { "instruction_diag_308", VCPU_STAT(diagnose_308) },
>         { "instruction_diag_500", VCPU_STAT(diagnose_500) },
> +       { "instruction_diag_other", VCPU_STAT(diagnose_other) },
>         { NULL }
>  };

Looks good.
