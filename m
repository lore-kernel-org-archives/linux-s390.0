Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47004 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726717AbgDXKNZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Apr 2020 06:13:25 -0400
Subject: Re: [PATCH v2 09/10] s390x: smp: Add restart when running test
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-10-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <89fbb3c2-9dfc-818e-3442-4aa102ff0705@redhat.com>
Date: Fri, 24 Apr 2020 12:13:17 +0200
MIME-Version: 1.0
In-Reply-To: <20200423091013.11587-10-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 23.04.20 11:10, Janosch Frank wrote:
> Let's make sure we can restart a cpu that is already running.
> Restarting it if it is stopped is implicitely tested by the the other
> restart calls in the smp test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  s390x/smp.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 48321f4..35ca9c7 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -52,6 +52,34 @@ static void test_start(void)
>  	report(1, "start");
>  }
>  
> +/*
> + * Does only test restart when the target is running.
> + * The other tests do restarts when stopped multiple times already.
> + */
> +static void test_restart(void)
> +{
> +	struct cpu *cpu = smp_cpu_from_addr(1);
> +	struct lowcore *lc = cpu->lowcore;
> +
> +	lc->restart_new_psw.mask = extract_psw_mask();
> +	lc->restart_new_psw.addr = (unsigned long)test_func;
> +
> +	/* Make sure cpu is running */
> +	smp_cpu_stop(0);
> +	set_flag(0);
> +	smp_cpu_restart(1);
> +	wait_for_flag();
> +
> +	/*
> +	 * Wait until cpu 1 has set the flag because it executed the
> +	 * restart function.
> +	 */
> +	set_flag(0);
> +	smp_cpu_restart(1);
> +	wait_for_flag();
> +	report(1, "restart while running");
> +}
> +
>  static void test_stop(void)
>  {
>  	smp_cpu_stop(1);
> @@ -295,6 +323,7 @@ int main(void)
>  	smp_cpu_stop(1);
>  
>  	test_start();
> +	test_restart();
>  	test_stop();
>  	test_stop_store_status();
>  	test_store_status();
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
