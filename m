Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390765AbfITIYO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Sep 2019 04:24:14 -0400
Subject: Re: [kvm-unit-tests PATCH v3 3/6] s390x: Add linemode buffer to fix
 newline on every print
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-4-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <43bb9ff6-4233-3f6f-8cdb-3a00d1662d4d@redhat.com>
Date: Fri, 20 Sep 2019 10:24:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190920080356.1948-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 20.09.19 10:03, Janosch Frank wrote:
> Linemode seems to add a newline for each sent message which makes
> reading rather hard. Hence we add a small buffer and only print if
> it's full or a newline is encountered. Except for when the string is
> longer than the buffer, then we flush the buffer and print directly.

I think that last sentence is not correct anymore.

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  lib/s390x/sclp-console.c | 45 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
> index 19416b5..e1b9000 100644
> --- a/lib/s390x/sclp-console.c
> +++ b/lib/s390x/sclp-console.c
> @@ -13,6 +13,7 @@
>  #include <asm/page.h>
>  #include <asm/arch_def.h>
>  #include <asm/io.h>
> +#include <asm/spinlock.h>
>  #include "sclp.h"
>  
>  /*
> @@ -87,6 +88,10 @@ static uint8_t _ascebc[256] = {
>       0x90, 0x3F, 0x3F, 0x3F, 0x3F, 0xEA, 0x3F, 0xFF
>  };
>  
> +static char lm_buff[120];
> +static unsigned char lm_buff_off;
> +static struct spinlock lm_buff_lock;
> +
>  static void sclp_print_ascii(const char *str)
>  {
>  	int len = strlen(str);
> @@ -103,10 +108,10 @@ static void sclp_print_ascii(const char *str)
>  	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>  }
>  
> -static void sclp_print_lm(const char *str)
> +static void lm_print(const char *buff, int len)
>  {
>  	unsigned char *ptr, *end, ch;
> -	unsigned int count, offset, len;
> +	unsigned int count, offset;
>  	struct WriteEventData *sccb;
>  	struct mdb *mdb;
>  	struct mto *mto;
> @@ -117,11 +122,10 @@ static void sclp_print_lm(const char *str)
>  	end = (unsigned char *) sccb + 4096 - 1;
>  	memset(sccb, 0, sizeof(*sccb));
>  	ptr = (unsigned char *) &sccb->msg.mdb.mto;
> -	len = strlen(str);
>  	offset = 0;
>  	do {
>  		for (count = sizeof(*mto); offset < len; count++) {
> -			ch = str[offset++];
> +			ch = buff[offset++];
>  			if (ch == 0x0a || ptr + count > end)
>  				break;
>  			ptr[count] = _ascebc[ch];
> @@ -148,6 +152,39 @@ static void sclp_print_lm(const char *str)
>  	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>  }
>  
> +
> +/*
> + * In contrast to the ascii console, linemode produces a new
> + * line with every write of data. The report() function uses
> + * several printf() calls to generate a line of data which
> + * would all end up on different lines.
> + *
> + * Hence we buffer here until we encounter a \n or the buffer
> + * is full. That means that linemode output can look a bit
> + * different from ascii and that it takes a bit longer for
> + * lines to appear.
> + */
> +static void sclp_print_lm(const char *str)
> +{
> +	int len = strlen(str), i = 0;
> +
> +	spin_lock(&lm_buff_lock);
> +
> +	while (len) {

for (i = 0; i < len; i++)

Then make len const and drop "len--" and "i++" from the body.

> +		lm_buff[lm_buff_off] = str[i];
> +		lm_buff_off++;

lm_buff[lm_buff_off++] = str[i];

if you feel like saving one LOC :)

> +		len--;
> +		/* Buffer full or newline? */
> +		if (str[i] == '\n' || lm_buff_off == (sizeof(lm_buff) - 1)) {

I still prefer ARRAY_SIZE(), but this is also fine.

> +			lm_print(lm_buff, lm_buff_off);
> +			memset(lm_buff, 0 , sizeof(lm_buff));

Is the memset really necessary? (I would have assumed it would only
print until the last "\n" ?)

> +			lm_buff_off = 0;
> +		}
> +		i++;
> +	}

Guess we don't care about performance, so the simple byte-based approach
should be just fine.

> +	spin_unlock(&lm_buff_lock);
> +}
> +
>  /*
>   * SCLP needs to be initialized by setting a send and receive mask,
>   * indicating which messages the control program (we) want(s) to
> 


I wonder if we have to implement some kind of fflush(), so we will flush
the buffer on any abort ... but I assume we will always end printing
with a "\n", so we don't really care.

-- 

Thanks,

David / dhildenb
