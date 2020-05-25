Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43032 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389225AbgEYIq2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 May 2020 04:46:28 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: stsi: Make output tap13 compatible
References: <20200525084340.1454-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <da72e09e-8e38-38b5-01f7-05e96a121f27@redhat.com>
Date: Mon, 25 May 2020 10:46:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200525084340.1454-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, stzi@linux.ibm.com, mhartmay@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 25/05/2020 10.43, Janosch Frank wrote:
> In tap13 output # is a special character and only "skip" and "todo"
> are allowed to come after it. Let's appease our CI environment and
> replace # with "count".
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/stsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/s390x/stsi.c b/s390x/stsi.c
> index 66b4257..b81cea7 100644
> --- a/s390x/stsi.c
> +++ b/s390x/stsi.c
> @@ -129,11 +129,11 @@ static void test_3_2_2(void)
>  	}
>  
>  	report(!memcmp(data->vm[0].uuid, uuid, sizeof(uuid)), "uuid");
> -	report(data->vm[0].conf_cpus == smp_query_num_cpus(), "cpu # configured");
> +	report(data->vm[0].conf_cpus == smp_query_num_cpus(), "cpu count configured");
>  	report(data->vm[0].total_cpus ==
>  	       data->vm[0].reserved_cpus + data->vm[0].conf_cpus,
> -	       "cpu # total == conf + reserved");
> -	report(data->vm[0].standby_cpus == 0, "cpu # standby");
> +	       "cpu count total == conf + reserved");
> +	report(data->vm[0].standby_cpus == 0, "cpu count standby");
>  	report(!memcmp(data->vm[0].name, vm_name, sizeof(data->vm[0].name)),
>  	       "VM name == kvm-unit-test");

Reviewed-by: Thomas Huth <thuth@redhat.com>
