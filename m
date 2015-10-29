From: Alexander Graf <agraf@suse.de>
Subject: Re: [GIT PULL 3/3] KVM: s390: use simple switch statement as multiplexer
Date: Thu, 29 Oct 2015 16:50:28 +0100
Message-ID: <F019A3A7-AE33-4ED8-BF43-CD5DC45753ED@suse.de>
References: <1446131309-176770-1-git-send-email-borntraeger@de.ibm.com> <1446131309-176770-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1446131309-176770-4-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


> Am 29.10.2015 um 16:08 schrieb Christian Borntraeger <borntraeger@de.ibm.com>:
> 
> We currently do some magic shifting (by exploiting that exit codes
> are always a multiple of 4) and a table lookup to jump into the
> exit handlers. This causes some calculations and checks, just to
> do an potentially expensive function call.
> 
> Changing that to a switch statement gives the compiler the chance
> to inline and dynamically decide between jump tables or inline
> compare and branches. In addition it makes the code more readable.
> 
> bloat-o-meter gives me a small reduction in code size:
> 
> add/remove: 0/7 grow/shrink: 1/1 up/down: 986/-1334 (-348)
> function                                     old     new   delta
> kvm_handle_sie_intercept                      72    1058    +986
> handle_prog                                  704     696      -8
> handle_noop                                   54       -     -54
> handle_partial_execution                      60       -     -60
> intercept_funcs                              120       -    -120
> handle_instruction                           198       -    -198
> handle_validity                              210       -    -210
> handle_stop                                  316       -    -316
> handle_external_interrupt                    368       -    -368
> 
> Right now my gcc does conditional branches instead of jump tables.
> The inlining seems to give us enough cycles as some micro-benchmarking
> shows minimal improvements, but still in noise.

Awesome. I ended up with the same conclusions on switch vs table lookups in the ppc code back in the day.

> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> arch/s390/kvm/intercept.c | 42 +++++++++++++++++++++---------------------
> 1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 7365e8a..b4a5aa1 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -336,28 +336,28 @@ static int handle_partial_execution(struct kvm_vcpu *vcpu)
>    return -EOPNOTSUPP;
> }
> 
> -static const intercept_handler_t intercept_funcs[] = {
> -    [0x00 >> 2] = handle_noop,
> -    [0x04 >> 2] = handle_instruction,
> -    [0x08 >> 2] = handle_prog,
> -    [0x10 >> 2] = handle_noop,
> -    [0x14 >> 2] = handle_external_interrupt,
> -    [0x18 >> 2] = handle_noop,
> -    [0x1C >> 2] = kvm_s390_handle_wait,
> -    [0x20 >> 2] = handle_validity,
> -    [0x28 >> 2] = handle_stop,
> -    [0x38 >> 2] = handle_partial_execution,
> -};
> -
> int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
> {
> -    intercept_handler_t func;
> -    u8 code = vcpu->arch.sie_block->icptcode;
> -
> -    if (code & 3 || (code >> 2) >= ARRAY_SIZE(intercept_funcs))
> +    switch (vcpu->arch.sie_block->icptcode) {
> +    case 0x00:
> +    case 0x10:
> +    case 0x18:

... if you could convert these magic numbers to something more telling however, I think readability would improve even more! That can easily be a follow up patch though.


Alex
