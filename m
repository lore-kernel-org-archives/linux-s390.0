Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36793 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725846AbgFQIVH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Jun 2020 04:21:07 -0400
Date: Wed, 17 Jun 2020 10:20:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v9 04/12] s390x: interrupt registration
Message-ID: <20200617102053.47c4a52c.cohuck@redhat.com>
In-Reply-To: <1592213521-19390-5-git-send-email-pmorel@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
        <1592213521-19390-5-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Mon, 15 Jun 2020 11:31:53 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

Subject: "s390: I/O interrupt registration" ?

> Let's make it possible to add and remove a custom io interrupt handler,
> that can be used instead of the normal one.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/interrupt.c | 23 ++++++++++++++++++++++-
>  lib/s390x/interrupt.h |  8 ++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 lib/s390x/interrupt.h
> 
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 3a40cac..243b9c2 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -10,9 +10,9 @@
>   * under the terms of the GNU Library General Public License version 2.
>   */
>  #include <libcflat.h>
> -#include <asm/interrupt.h>
>  #include <asm/barrier.h>
>  #include <sclp.h>
> +#include <interrupt.h>
>  
>  static bool pgm_int_expected;
>  static bool ext_int_expected;
> @@ -144,12 +144,33 @@ void handle_mcck_int(void)
>  		     stap(), lc->mcck_old_psw.addr);
>  }
>  
> +static void (*io_int_func)(void);
> +
>  void handle_io_int(void)
>  {
> +	if (io_int_func)
> +		return io_int_func();
> +
>  	report_abort("Unexpected io interrupt: on cpu %d at %#lx",
>  		     stap(), lc->io_old_psw.addr);
>  }
>  
> +int register_io_int_func(void (*f)(void))
> +{
> +	if (io_int_func)
> +		return -1;
> +	io_int_func = f;
> +	return 0;
> +}
> +
> +int unregister_io_int_func(void (*f)(void))
> +{
> +	if (io_int_func != f)
> +		return -1;

Not sure if we really need these checks, but they don't hurt, either.

> +	io_int_func = NULL;
> +	return 0;
> +}
> +
>  void handle_svc_int(void)
>  {
>  	report_abort("Unexpected supervisor call interrupt: on cpu %d at %#lx",

Acked-by: Cornelia Huck <cohuck@redhat.com>
