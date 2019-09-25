Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfIYPvn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 11:51:43 -0400
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: Free allocated page in iep test
References: <20190925135623.9740-1-frankja@linux.ibm.com>
 <20190925135623.9740-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fe2c9986-ec98-69a5-2268-5cb2cece3ff9@redhat.com>
Date: Wed, 25 Sep 2019 17:51:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190925135623.9740-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 25/09/2019 15.56, Janosch Frank wrote:
> Let's also clean up
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/iep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/s390x/iep.c b/s390x/iep.c
> index 7da78a3..55c01ee 100644
> --- a/s390x/iep.c
> +++ b/s390x/iep.c
> @@ -43,6 +43,7 @@ static void test_iep(void)
>  	report_prefix_pop();
>  	unprotect_page(iepbuf, PAGE_ENTRY_IEP);
>  	ctl_clear_bit(0, 20);
> +	free_page(iepbuf);
>  }
>  
>  int main(void)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
