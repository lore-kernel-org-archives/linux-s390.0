Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39479 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726220AbgAQKUm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Jan 2020 05:20:42 -0500
Subject: Re: [kvm-unit-tests PATCH v2 7/7] s390x: smp: Dirty fpc before
 initial reset test
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-8-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0ddfb1ce-16e4-017f-078b-80146bfa29a6@redhat.com>
Date: Fri, 17 Jan 2020 11:20:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200116120513.2244-8-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 16.01.20 13:05, Janosch Frank wrote:
> Let's dirty the fpc, before we test if the initial reset sets it to 0.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  s390x/smp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index ce3215d..97a9dda 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -179,6 +179,9 @@ static void test_emcall(void)
>  /* Used to dirty registers of cpu #1 before it is reset */
>  static void test_func_initial(void)
>  {
> +	asm volatile(
> +		"	sfpc	%0\n"
> +		: : "d" (0x11) : );

FWIW, I'd make this one easier to read

asm volatile("sfpc %0\n" :: "d" (0x11));

or sth like that

Reviewed-by: David Hildenbrand <david@redhat.com>

>  	lctlg(1, 0x42000UL);
>  	lctlg(7, 0x43000UL);
>  	lctlg(13, 0x44000UL);
> 


-- 
Thanks,

David / dhildenb
