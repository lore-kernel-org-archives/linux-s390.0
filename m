From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/2] KVM: s390: use switch vs jump table in intercept.c
Date: Tue, 6 Feb 2018 13:34:10 +0100
Message-ID: <50978772-27fe-2197-4d98-400b7354975b@redhat.com>
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
 <20180206112127.19014-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180206112127.19014-3-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06.02.2018 12:21, Christian Borntraeger wrote:
> instead of having huge jump tables for function selection,
> lets use normal switch/case statements for the instruction
> handlers in intercept.c We can now also get rid of
> intercept_handler_t.
> 
> bloat-o-meter output:
> add/remove: 0/1 grow/shrink: 1/0 up/down: 280/-2048 (-1768)
> Function                                     old     new   delta
> kvm_handle_sie_intercept                    1530    1810    +280
> instruction_handlers                        2048       -   -2048
> Total: Before=5227, After=3459, chg -33.82%
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/intercept.c | 54 ++++++++++++++++++++++++-----------------------
>  arch/s390/kvm/kvm-s390.h  |  2 --
>  2 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 9c7d70715862..047e711d1fd1 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -22,22 +22,6 @@
>  #include "trace.h"
>  #include "trace-s390.h"
>  
> -
> -static const intercept_handler_t instruction_handlers[256] = {
> -	[0x01] = kvm_s390_handle_01,
> -	[0x82] = kvm_s390_handle_lpsw,
> -	[0x83] = kvm_s390_handle_diag,
> -	[0xaa] = kvm_s390_handle_aa,
> -	[0xae] = kvm_s390_handle_sigp,
> -	[0xb2] = kvm_s390_handle_b2,
> -	[0xb6] = kvm_s390_handle_stctl,
> -	[0xb7] = kvm_s390_handle_lctl,
> -	[0xb9] = kvm_s390_handle_b9,
> -	[0xe3] = kvm_s390_handle_e3,
> -	[0xe5] = kvm_s390_handle_e5,
> -	[0xeb] = kvm_s390_handle_eb,
> -};
> -
>  u8 kvm_s390_get_ilen(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s390_sie_block *sie_block = vcpu->arch.sie_block;
> @@ -129,16 +113,34 @@ static int handle_validity(struct kvm_vcpu *vcpu)
>  
>  static int handle_instruction(struct kvm_vcpu *vcpu)
>  {
> -	intercept_handler_t handler;
> -
> -	vcpu->stat.exit_instruction++;
> -	trace_kvm_s390_intercept_instruction(vcpu,
> -					     vcpu->arch.sie_block->ipa,
> -					     vcpu->arch.sie_block->ipb);

With that fixed

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David / dhildenb
