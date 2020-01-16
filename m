Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20661 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726088AbgAPMOE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 07:14:04 -0500
Subject: Re: [kvm-unit-tests PATCH v2 1/7] s390x: smp: Cleanup smp.c
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6eba828e-7bb8-e917-a21f-eaf7aa725ac4@redhat.com>
Date: Thu, 16 Jan 2020 13:13:54 +0100
MIME-Version: 1.0
In-Reply-To: <20200116120513.2244-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 16.01.20 13:05, Janosch Frank wrote:
> Let's remove a lot of badly formatted code by introducing the
> wait_for_flag() function.
> 
> Also let's remove some stray spaces.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  s390x/smp.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index ab7e46c..02204fd 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -22,6 +22,13 @@
>  
>  static int testflag = 0;
>  
> +static void wait_for_flag(void)
> +{
> +	while (!testflag) {
> +		mb();
> +	}
> +}
> +
>  static void cpu_loop(void)
>  {
>  	for (;;) {}
> @@ -37,13 +44,11 @@ static void test_func(void)
>  static void test_start(void)
>  {
>  	struct psw psw;
> -	psw.mask =  extract_psw_mask();
> +	psw.mask = extract_psw_mask();
>  	psw.addr = (unsigned long)test_func;
>  
>  	smp_cpu_setup(1, psw);
> -	while (!testflag) {
> -		mb();
> -	}
> +	wait_for_flag();
>  	report(1, "start");
>  }
>  
> @@ -98,6 +103,7 @@ static void test_store_status(void)
>  	report(1, "status written");
>  	free_pages(status, PAGE_SIZE * 2);
>  	report_prefix_pop();
> +	smp_cpu_stop(1);

This hunk does not seem to belong into this patch.

Apart from that, looks good to me.


-- 
Thanks,

David / dhildenb
