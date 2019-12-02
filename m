Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25111 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727435AbfLBPDw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 10:03:52 -0500
Date: Mon, 2 Dec 2019 16:03:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 9/9] s390x: css: ping pong
Message-ID: <20191202160341.5e96fb81.cohuck@redhat.com>
In-Reply-To: <1574945167-29677-10-git-send-email-pmorel@linux.ibm.com>
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
        <1574945167-29677-10-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 28 Nov 2019 13:46:07 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> To test a write command with the SSCH instruction we need a QEMU device,
> with control unit type 0xC0CA. The PONG device is such a device.

"We want to test some read/write ccws via the SSCH instruction with a
QEMU device with control unit type 0xC0CA." ?

> 
> This type of device respond to PONG_WRITE requests by incrementing an

s/respond/responds/

> integer, stored as a string at offset 0 of the CCW data.
> 
> This is only a success test, no error expected.

Nobody expects the Spanish Inquisition^W^W^W an error :)

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/css.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/css.c b/s390x/css.c
> index 534864f..0761e70 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -23,6 +23,10 @@
>  #define SID_ONE		0x00010000
>  #define PSW_PRG_MASK (PSW_MASK_IO | PSW_MASK_EA | PSW_MASK_BA)
>  
> +/* Local Channel Commands */

/* Channel commands for the PONG device */

?

> +#define PONG_WRITE	0x21 /* Write */
> +#define PONG_READ	0x22 /* Read buffer */
> +
>  struct lowcore *lowcore = (void *)0x0;
>  
>  static struct schib schib;
> @@ -31,7 +35,8 @@ static struct ccw ccw[NB_CCW];
>  #define NB_ORB  100
>  static struct orb orb[NB_ORB];
>  static struct irb irb;
> -static char buffer[0x1000] __attribute__ ((aligned(8)));
> +#define BUF_SZ	0x1000
> +static char buffer[BUF_SZ] __attribute__ ((aligned(8)));

Merge this with the introduction of this variable?

>  static struct senseid senseid;
>  
>  static const char *Channel_type[3] = {
> @@ -224,6 +229,44 @@ static void test_sense(void)
>  		report("cu_type: expect c0ca, got %04x", 0, senseid.cu_type);
>  }
>  
> +static void test_ping(void)
> +{
> +	int success, result;
> +	int cnt = 0, max = 4;
> +
> +	if (senseid.cu_type != PONG_CU) {
> +		report_skip("No PONG, no ping-pong");

:D

> +		return;
> +	}
> +
> +	enable_io_irq();

Hasn't that been enabled already for doing SenseID?

> +
> +	while (cnt++ < max) {
> +report_info("cnt..: %08x", cnt);

Wrong indentation?

> +		snprintf(buffer, BUF_SZ, "%08x\n", cnt);
> +		success = start_subchannel(PONG_WRITE, buffer, 8);
> +		if (!success) {
> +			report("start_subchannel failed", 0);
> +			return;
> +		}
> +		delay(100);
> +		success = start_subchannel(PONG_READ, buffer, 8);
> +		if (!success) {
> +			report("start_subchannel failed", 0);
> +			return;
> +		}
> +		result = atol(buffer);
> +		if (result != (cnt + 1)) {
> +			report("Bad answer from pong: %08x - %08x", 0, cnt, result);
> +			return;
> +		} else 
> +			report_info("%08x - %08x", cnt, result);
> +
> +		delay(100);
> +	}
> +	report("ping-pong count 0x%08x", 1, cnt);
> +}
> +
>  static struct {
>  	const char *name;
>  	void (*func)(void);
> @@ -231,6 +274,7 @@ static struct {
>  	{ "enumerate (stsch)", test_enumerate },
>  	{ "enable (msch)", test_enable },
>  	{ "sense (ssch/tsch)", test_sense },
> +	{ "ping-pong (ssch/tsch)", test_ping },
>  	{ NULL, NULL }
>  };
>  
