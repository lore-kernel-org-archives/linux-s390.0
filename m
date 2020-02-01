Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46055 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726487AbgBASzt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 13:55:49 -0500
Subject: Re: [kvm-unit-tests PATCH v5 3/7] s390x: Stop the cpu that is
 executing exit()
References: <20200201152851.82867-1-frankja@linux.ibm.com>
 <20200201152851.82867-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a2c462d4-c27c-2da5-b168-016a063d17c7@redhat.com>
Date: Sat, 1 Feb 2020 19:55:38 +0100
MIME-Version: 1.0
In-Reply-To: <20200201152851.82867-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 01/02/2020 16.28, Janosch Frank wrote:
> CPU 0 is not necessarily the CPU which does the exit if we ran into a
> test abort situation. So, let's ask stap() which cpu does the exit and
> stop it on exit.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/io.c b/lib/s390x/io.c
> index 32f09b5..e091c37 100644
> --- a/lib/s390x/io.c
> +++ b/lib/s390x/io.c
> @@ -46,6 +46,6 @@ void exit(int code)
>  	smp_teardown();
>  	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
>  	while (1) {
> -		sigp(0, SIGP_STOP, 0, NULL);
> +		sigp(stap(), SIGP_STOP, 0, NULL);
>  	}
>  }

Right, smp_teardown stops already all CPUs except for the current one,
so this is the last one running here.

Reviewed-by: Thomas Huth <thuth@redhat.com>
