Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54476 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgANRWV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jan 2020 12:22:21 -0500
Subject: Re: [kvm-unit-tests PATCH 4/4] s390x: smp: Dirty fpc before initial
 reset test
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3a68f0fd-4d62-1487-9896-7398b0e12df0@redhat.com>
Date: Tue, 14 Jan 2020 18:22:10 +0100
MIME-Version: 1.0
In-Reply-To: <20200114153054.77082-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 14/01/2020 16.30, Janosch Frank wrote:
> Let's dirty the fpc, before we test if the initial reset sets it to 0.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 11ab425..cd32342 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -177,6 +177,9 @@ static void test_emcall(void)
>  
>  static void test_func_initial(void)
>  {
> +	asm volatile(
> +		"	sfpc	%0\n"
> +		: : "d" (0x11) : );
>  	lctlg(1, 0x42000UL);
>  	lctlg(7, 0x43000UL);
>  	lctlg(13, 0x44000UL);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
