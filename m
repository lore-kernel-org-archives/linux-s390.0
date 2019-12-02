Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727391AbfLBOap (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 09:30:45 -0500
Date: Mon, 2 Dec 2019 15:30:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 7/9] s390x: css: msch, enable test
Message-ID: <20191202153016.382e3fa8.cohuck@redhat.com>
In-Reply-To: <1574945167-29677-8-git-send-email-pmorel@linux.ibm.com>
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
        <1574945167-29677-8-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 28 Nov 2019 13:46:05 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> A second step when testing the channel subsystem is to prepare a channel
> for use.
> 
> This tests the success of the MSCH instruction by enabling a channel.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/css.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/s390x/css.c b/s390x/css.c
> index 8186f55..e42dc2f 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -62,11 +62,38 @@ static void test_enumerate(void)
>  	return;
>  }
>  
> +static void set_schib(void)
> +{
> +	struct pmcw *p = &schib.pmcw;
> +
> +	p->intparm = 0xdeadbeef;
> +	p->flags |= PMCW_ENABLE;
> +}
> +
> +static void test_enable(void)
> +{
> +	int ret;
> +
> +	if (!test_device_sid) {
> +		report_skip("No device");
> +		return;
> +	}
> +	set_schib();
> +	dump_schib(&schib);
> +
> +	ret = msch(test_device_sid, &schib);
> +	if (ret)
> +		report("msch cc=%d", 0, ret);

Maybe do a stsch and then check/dump the contents of the schib again?

Background: The architecture allows that msch returns success, but that
the fields modified by the issuer remain unchanged at the subchannel
regardless. That should not happen with QEMU; but I remember versions
of z/VM where we sometimes had to call msch twice to make changes stick.

> +	else
> +		report("Tested", 1);
> +}
> +
>  static struct {
>  	const char *name;
>  	void (*func)(void);
>  } tests[] = {
>  	{ "enumerate (stsch)", test_enumerate },
> +	{ "enable (msch)", test_enable },
>  	{ NULL, NULL }
>  };
>  
