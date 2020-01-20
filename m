Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54705 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726573AbgATMCm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 07:02:42 -0500
Subject: Re: [kvm-unit-tests PATCH v3 1/9] s390x: smp: Cleanup smp.c
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7b41b492-efb0-b695-0cd7-4f82bc2db143@redhat.com>
Date: Mon, 20 Jan 2020 13:02:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200117104640.1983-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 17.01.20 11:46, Janosch Frank wrote:
> Let's remove a lot of badly formatted code by introducing the
> wait_for_flag() function.
> 
> Also let's remove some stray spaces.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  s390x/smp.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index ab7e46c..8d8e3a5 100644
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

No need for the {}


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
