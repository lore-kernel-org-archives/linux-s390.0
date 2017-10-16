From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC 19/19] s390/facilities: enable AP facilities needed by
 guest
Date: Mon, 16 Oct 2017 11:25:10 +0200
Message-ID: <20171016112510.39e9c330@mschwideX1>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-20-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-20-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Oct 2017 13:39:04 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Sets up the following facilities bits to enable the specified AP
> facilities for the guest VM:
>     * STFLE.12: Enables the AP Query Configuration Information
>                 facility. The AP bus running in the guest uses
>                 the information returned from this instruction
>                 to configure AP adapters and domains for the
>                 guest machine.
>     * STFLE.15: Indicates the AP facilities test is available.
>                 The AP bus running in the guest uses the
>                 information.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/tools/gen_facilities.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 70dd8f1..eeaa7db 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -74,8 +74,10 @@ struct facility_def {
>  			8,  /* enhanced-DAT 1 */
>  			9,  /* sense-running-status */
>  			10, /* conditional sske */
> +			12, /* AP query configuration */
>  			13, /* ipte-range */
>  			14, /* nonquiescing key-setting */
> +			15, /* AP special-command facility */
>  			73, /* transactional execution */
>  			75, /* access-exception-fetch/store indication */
>  			76, /* msa extension 3 */

With this all KVM guests will always have the AP instructions available, no?
In principles I like this approach, but it differs from the way z/VM does things,
there the guest will get an exception if it tries to execute an AP instruction
if there are no AP devices assigned to the guest. I wonder if there is a reason
why z/VM does it the way it does.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
