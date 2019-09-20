Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31585 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393188AbfITIKr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Sep 2019 04:10:47 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix stsi unaligned test and add
 selector tests
References: <20190920075020.1698-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9dd9362d-f8e2-a573-3833-376039dbc570@redhat.com>
Date: Fri, 20 Sep 2019 10:10:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190920075020.1698-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 20.09.19 09:50, Janosch Frank wrote:
> Alignment and selectors test order is not specified and so, if you
> have an unaligned address and invalid selectors it's up to the
> hypervisor to decide which error is presented.
> 
> Let's add valid selectors to the unalignmnet test and add selector
> tests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/stsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/stsi.c b/s390x/stsi.c
> index 7232cb0..c5bd0a2 100644
> --- a/s390x/stsi.c
> +++ b/s390x/stsi.c
> @@ -35,7 +35,7 @@ static void test_specs(void)
>  
>  	report_prefix_push("unaligned");
>  	expect_pgm_int();
> -	stsi(pagebuf + 42, 1, 0, 0);
> +	stsi(pagebuf + 42, 1, 1, 1);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>  	report_prefix_pop();
>  
> @@ -71,6 +71,8 @@ static inline unsigned long stsi_get_fc(void *addr)
>  static void test_fc(void)
>  {
>  	report("invalid fc",  stsi(pagebuf, 7, 0, 0) == 3);
> +	report("invalid selector 1", stsi(pagebuf, 1, 0, 1) == 3);
> +	report("invalid selector 2", stsi(pagebuf, 1, 1, 0) == 3);
>  	report("query fc >= 2",  stsi_get_fc(pagebuf) >= 2);
>  }
>  
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
