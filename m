Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726982AbgATLaJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Jan 2020 06:30:09 -0500
Date: Mon, 20 Jan 2020 12:29:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 7/9] s390x: smp: Remove unneeded cpu
 loops
Message-ID: <20200120122956.6879d159.cohuck@redhat.com>
In-Reply-To: <20200117104640.1983-8-frankja@linux.ibm.com>
References: <20200117104640.1983-1-frankja@linux.ibm.com>
        <20200117104640.1983-8-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Fri, 17 Jan 2020 05:46:38 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Now that we have a loop which is executed after we return from the
> main function of a secondary cpu, we can remove the surplus loops.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 555ed72..c12a3db 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -29,15 +29,9 @@ static void wait_for_flag(void)
>  	}
>  }
>  
> -static void cpu_loop(void)
> -{
> -	for (;;) {}
> -}
> -
>  static void test_func(void)
>  {
>  	testflag = 1;
> -	cpu_loop();
>  }
>  
>  static void test_start(void)
> @@ -234,7 +228,7 @@ int main(void)
>  
>  	/* Setting up the cpu to give it a stack and lowcore */
>  	psw.mask = extract_psw_mask();
> -	psw.addr = (unsigned long)cpu_loop;
> +	psw.addr = (unsigned long)test_func;

Before, you did not set testflag here... intended change?

>  	smp_cpu_setup(1, psw);
>  	smp_cpu_stop(1);
>  
