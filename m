From: Thomas Huth <thuth@redhat.com>
Date: Thu, 03 Jan 2019 13:39:23 +0000
Subject: Re: [kvm-unit-tests PATCH v4 10/13] s390x: Add linemode buffer to fix newline on every print
Message-Id: <491081ce-2a50-595b-ac8f-33b7264969d4@redhat.com>
In-Reply-To: <20190103100806.9039-11-frankja@linux.ibm.com>
References: <20190103100806.9039-11-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2019-01-03 11:08, Janosch Frank wrote:
> Linemode seems to add a newline for each sent message which makes
> reading rather hard. Hence we add a small buffer that and only print
> if it's full or a newline is encountered.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/sclp-console.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
> index 6b30fab..5d2c9d8 100644
> --- a/lib/s390x/sclp-console.c
> +++ b/lib/s390x/sclp-console.c
> @@ -87,6 +87,9 @@ static uint8_t _ascebc[256] = {
>       0x90, 0x3F, 0x3F, 0x3F, 0x3F, 0xEA, 0x3F, 0xFF
>  };
>  
> +static char lm_buff[120];
> +static unsigned char lm_buff_off;
> +
>  static void sclp_print_ascii(const char *str)
>  {
>  	int len = strlen(str);
> @@ -112,17 +115,40 @@ static void sclp_print_lm(const char *str)
>  	struct mdb *mdb;
>  	struct mto *mto;
>  	struct go *go;
> +	char *nl;
> +
> +	/*
> +	 * In contrast to the ascii console, linemode produces a new
> +	 * line with every write of data. The report() function uses
> +	 * several printf() calls to generate a line of data which
> +	 * would all end up on different lines.
> +	 *
> +	 * Hence we buffer here until we encounter a \n or the buffer
> +	 * is full. That means that linemode output can look a bit
> +	 * different from ascii and that it takes a bit longer for
> +	 * lines to appear.
> +	 */
> +	len = strlen(str);
> +	len = len < (sizeof(lm_buff) - lm_buff_off) ? len : (sizeof(lm_buff) - lm_buff_off);
> +	nl = strchr(str, '\n');
> +	if ((lm_buff_off < sizeof(lm_buff) - 1)) {
> +		memcpy(&lm_buff[lm_buff_off], str, len);
> +		lm_buff_off += len;
> +	}
> +	/* Buffer not full and no newline */
> +	if (lm_buff_off != sizeof(lm_buff) - 1 && !nl)
> +		return;
>  
>  	sclp_mark_busy();
>  	sccb = (struct write_sccb *) _sccb;
>  	end = (unsigned char *) sccb + 4096 - 1;
>  	memset(sccb, 0, sizeof(*sccb));
>  	ptr = (unsigned char *) &sccb->msg.mdb.mto;
> -	len = strlen(str);
> +	len = strlen(lm_buff);
>  	offset = 0;
>  	do {
>  		for (count = sizeof(*mto); offset < len; count++) {
> -			ch = str[offset++];
> +			ch = lm_buff[offset++];
>  			if ((ch == 0x0a) || (ptr + count > end))
>  				break;
>  			ptr[count] = _ascebc[ch];
> @@ -148,6 +174,8 @@ static void sclp_print_lm(const char *str)
>  	go->length = sizeof(*go);
>  	go->type = 1;
>  	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
> +	memset(lm_buff, 0 , sizeof(lm_buff));
> +	lm_buff_off = 0;
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
