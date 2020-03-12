Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgCLK0L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 06:26:11 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CAPxew187686
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 06:26:11 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yq9b64g4u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 06:18:34 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Thu, 12 Mar 2020 10:17:24 -0000
Subject: Re: [PATCH] s390/zcrypt: Use scnprintf() for avoiding potential
 buffer overflow
References: <20200311090915.21059-1-tiwai@suse.de>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Thu, 12 Mar 2020 11:17:14 +0100
MIME-Version: 1.0
In-Reply-To: <20200311090915.21059-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <b098aca8-6a90-6b0d-408f-2f86a6e73032@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On 11.03.20 10:09, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/s390/crypto/zcrypt_cex4.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
> index 9a9d02e19774..dea96d5b65fb 100644
> --- a/drivers/s390/crypto/zcrypt_cex4.c
> +++ b/drivers/s390/crypto/zcrypt_cex4.c
> @@ -128,16 +128,16 @@ static ssize_t cca_mkvps_show(struct device *dev,
>  		n = snprintf(buf, PAGE_SIZE, "AES NEW: - -\n");
>  
>  	if (ci.cur_mk_state >= '1' && ci.cur_mk_state <= '2')
> -		n += snprintf(buf + n, PAGE_SIZE - n, "AES CUR: %s 0x%016llx\n",
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "AES CUR: %s 0x%016llx\n",
>  			      cao_state[ci.cur_mk_state - '1'], ci.cur_mkvp);
>  	else
> -		n += snprintf(buf + n, PAGE_SIZE - n, "AES CUR: - -\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "AES CUR: - -\n");
>  
>  	if (ci.old_mk_state >= '1' && ci.old_mk_state <= '2')
> -		n += snprintf(buf + n, PAGE_SIZE - n, "AES OLD: %s 0x%016llx\n",
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "AES OLD: %s 0x%016llx\n",
>  			      cao_state[ci.old_mk_state - '1'], ci.old_mkvp);
>  	else
> -		n += snprintf(buf + n, PAGE_SIZE - n, "AES OLD: - -\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "AES OLD: - -\n");
>  
>  	return n;
>  }
> @@ -251,11 +251,11 @@ static ssize_t ep11_card_op_modes_show(struct device *dev,
>  		if (ci.op_mode & (1 << ep11_op_modes[i].mode_bit)) {
>  			if (n > 0)
>  				buf[n++] = ' ';
> -			n += snprintf(buf + n, PAGE_SIZE - n,
> +			n += scnprintf(buf + n, PAGE_SIZE - n,
>  				      "%s", ep11_op_modes[i].mode_txt);
>  		}
>  	}
> -	n += snprintf(buf + n, PAGE_SIZE - n, "\n");
> +	n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
>  
>  	return n;
>  }
> @@ -305,21 +305,21 @@ static ssize_t ep11_mkvps_show(struct device *dev,
>  			     cwk_state[di.cur_wk_state - '0']);
>  		bin2hex(buf + n, di.cur_wkvp, sizeof(di.cur_wkvp));
>  		n += 2 * sizeof(di.cur_wkvp);
> -		n += snprintf(buf + n, PAGE_SIZE - n, "\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
>  	} else
>  		n = snprintf(buf, PAGE_SIZE, "WK CUR: - -\n");
>  
>  	if (di.new_wk_state == '0') {
> -		n += snprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s -\n",
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s -\n",
>  			      nwk_state[di.new_wk_state - '0']);
>  	} else if (di.new_wk_state >= '1' && di.new_wk_state <= '2') {
> -		n += snprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s 0x",
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s 0x",
>  			      nwk_state[di.new_wk_state - '0']);
>  		bin2hex(buf + n, di.new_wkvp, sizeof(di.new_wkvp));
>  		n += 2 * sizeof(di.new_wkvp);
> -		n += snprintf(buf + n, PAGE_SIZE - n, "\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
>  	} else
> -		n += snprintf(buf + n, PAGE_SIZE - n, "WK NEW: - -\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "WK NEW: - -\n");
>  
>  	return n;
>  }
> @@ -346,11 +346,11 @@ static ssize_t ep11_queue_op_modes_show(struct device *dev,
>  		if (di.op_mode & (1 << ep11_op_modes[i].mode_bit)) {
>  			if (n > 0)
>  				buf[n++] = ' ';
> -			n += snprintf(buf + n, PAGE_SIZE - n,
> +			n += scnprintf(buf + n, PAGE_SIZE - n,
>  				      "%s", ep11_op_modes[i].mode_txt);
>  		}
>  	}
> -	n += snprintf(buf + n, PAGE_SIZE - n, "\n");
> +	n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
>  
>  	return n;
>  }

Thanks for this patch.

I will use this as a trigger point to rework all the snprintfs within the ap bus and zcrypt code
and replace them with scnprintf wherever the return code is used. Did not know that
there are issues with snprintf ... This article gives some background: https://lwn.net/Articles/69419/

The updates will go into the s390 subsystem and will be forwarded to the upstream kernel with the
next kernel merge window.

Harald Freudenberger
