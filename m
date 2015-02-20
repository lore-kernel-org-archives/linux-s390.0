From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH v2 09/15] cpu-model/s390: Add KVM VM attribute interface
 routines
Date: Fri, 20 Feb 2015 14:59:20 +0100
Message-ID: <54E73DB8.20902@suse.de>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com> <1424183053-4310-10-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-10-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>



On 17.02.15 15:24, Michael Mueller wrote:
> The patch implements routines to set and retrieve processor configuration
> data and to retrieve machine configuration data. The machine related data
> is used together with the cpu model facility lists to determine the list of
> supported cpu models of this host. The above mentioned routines have QEMU
> trace point instrumentation.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> ---
>  target-s390x/cpu-models.h |  39 ++++++++++++++++++
>  target-s390x/kvm.c        | 102 ++++++++++++++++++++++++++++++++++++++++++++++
>  trace-events              |   3 ++
>  3 files changed, 144 insertions(+)
> 
> diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
> index 623a7b2..76b3456 100644
> --- a/target-s390x/cpu-models.h
> +++ b/target-s390x/cpu-models.h
> @@ -45,6 +45,45 @@ typedef struct S390CPUAlias {
>      char *model;
>  } S390CPUAlias;
>  
> +typedef struct S390ProcessorProps {
> +    uint64_t cpuid;
> +    uint16_t ibc;
> +    uint8_t  pad[6];
> +    uint64_t fac_list[S390_ARCH_FAC_LIST_SIZE_UINT64];
> +} S390ProcessorProps;
> +
> +typedef struct S390MachineProps {
> +    uint64_t cpuid;
> +    uint32_t ibc_range;
> +    uint8_t  pad[4];
> +    uint64_t fac_list_mask[S390_ARCH_FAC_LIST_SIZE_UINT64];
> +    uint64_t fac_list[S390_ARCH_FAC_LIST_SIZE_UINT64];
> +} S390MachineProps;

What are those structs there for? To convert between a kvm facing
interface to an internal interface?

I don't think they're necessary. The internal layout is visible from the
KVM code. Just either spawn the class straight from the kvm file or if
you consider that ugly, pass the values of that struct that you need as
function parameters to a function in cpu-models.c.


Alex
