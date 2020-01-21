Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54434 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729108AbgAURhB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jan 2020 12:37:01 -0500
Subject: Re: [kvm-unit-tests PATCH v4 7/9] s390x: smp: Remove unneeded cpu
 loops
References: <20200121134254.4570-1-frankja@linux.ibm.com>
 <20200121134254.4570-8-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a6ad0ea1-f6de-208e-86e3-6818144be33f@redhat.com>
Date: Tue, 21 Jan 2020 18:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <20200121134254.4570-8-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 21.01.20 14:42, Janosch Frank wrote:
> Now that we have a loop which is executed after we return from the
> main function of a secondary cpu, we can remove the surplus loops.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 3e8cf3e..45f1d80 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -35,15 +35,9 @@ static void set_flag(int val)
>  	mb();
>  }
>  
> -static void cpu_loop(void)
> -{
> -	for (;;) {}
> -}
> -
>  static void test_func(void)
>  {
>  	set_flag(1);
> -	cpu_loop();
>  }
>  
>  static void test_start(void)
> @@ -241,7 +235,7 @@ int main(void)
>  
>  	/* Setting up the cpu to give it a stack and lowcore */
>  	psw.mask = extract_psw_mask();
> -	psw.addr = (unsigned long)cpu_loop;
> +	psw.addr = (unsigned long)test_func;
>  	smp_cpu_setup(1, psw);
>  	smp_cpu_stop(1);
>  
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
