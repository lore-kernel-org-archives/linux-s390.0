From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v1 1/7] vfio: ap: Add AP Queue Interruption Control
 facility
Date: Fri, 2 Nov 2018 10:45:01 -0400
Message-ID: <5104b04e-5b2c-b8d0-eed5-c83c71cbd5e1@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-2-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541009577-29656-2-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 10/31/18 2:12 PM, Pierre Morel wrote:
> AP Queue Interruption Control (AQIC) facility gives
> the guest the possibility to control interruption for
> the Cryptographic Adjunct Processor queues.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   arch/s390/tools/gen_facilities.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index fd788e0f2e5b..18d317da02f5 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -108,6 +108,7 @@ static struct facility_def facility_defs[] = {
>   		.bits = (int[]){
>   			12, /* AP Query Configuration Information */
>   			15, /* AP Facilities Test */
> +			65, /* AP Queue Interruption Control */
>   			156, /* etoken facility */
>   			-1  /* END */
>   		}

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

> 
