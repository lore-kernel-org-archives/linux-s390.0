Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28862 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727255AbgAUO24 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 09:28:56 -0500
Date: Tue, 21 Jan 2020 15:28:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 6/9] s390x: smp: Loop if secondary cpu
 returns into cpu setup again
Message-ID: <20200121152844.22fd9e03.cohuck@redhat.com>
In-Reply-To: <20200121134254.4570-7-frankja@linux.ibm.com>
References: <20200121134254.4570-1-frankja@linux.ibm.com>
        <20200121134254.4570-7-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 21 Jan 2020 08:42:51 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Up to now a secondary cpu could have returned from the function it was
> executing and ending up somewhere in cstart64.S. This was mostly
> circumvented by an endless loop in the function that it executed.
> 
> Let's add a loop to the end of the cpu setup, so we don't have to rely
> on added loops in the tests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cstart64.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 9af6bb3..5fd8d2f 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -162,6 +162,8 @@ smp_cpu_setup_state:
>  	/* We should only go once through cpu setup and not for every restart */
>  	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
>  	br	%r14
> +	/* If the function returns, just loop here */
> +0:	j	0
>  
>  pgm_int:
>  	SAVE_REGS

Acked-by: Cornelia Huck <cohuck@redhat.com>
