Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730306AbgCaJM2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 31 Mar 2020 05:12:28 -0400
Subject: Re: [kvm-unit-tests PATCH 09/10] s390x: smp: Add restart when running
 test
References: <20200324081251.28810-1-frankja@linux.ibm.com>
 <20200324081251.28810-10-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <363e6571-7cc5-70aa-a70b-98628a5661f4@redhat.com>
Date: Tue, 31 Mar 2020 11:12:22 +0200
MIME-Version: 1.0
In-Reply-To: <20200324081251.28810-10-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

On 24.03.20 09:12, Janosch Frank wrote:
> Let's make sure we can restart a cpu that is already running.
> Restarting it if it is stopped is implicitely tested by the the other
> restart calls in the smp test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 48321f4e346dc71d..79cdc1f6a4b0b491 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -52,6 +52,24 @@ static void test_start(void)
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

Maybe explicitly trigger a stop+start with a dummy here and wait until
it was processed. This make the test independent of the other (previous)
tests.

> +	lc->restart_new_psw.mask = extract_psw_mask();
> +	lc->restart_new_psw.addr = (unsigned long)test_func;
> +
> +	set_flag(0);
> +	smp_cpu_restart(1);
> +	wait_for_flag();
> +	report(1, "restart while running");
> +}
> +
>  static void test_stop(void)
>  {
>  	smp_cpu_stop(1);
> @@ -295,6 +313,7 @@ int main(void)
>  	smp_cpu_stop(1);
>  
>  	test_start();
> +	test_restart();
>  	test_stop();
>  	test_stop_store_status();
>  	test_store_status();
> 


-- 
Thanks,

David / dhildenb
