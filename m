Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgBGNNO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 08:13:14 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017D9MA6078593
        for <linux-s390@vger.kernel.org>; Fri, 7 Feb 2020 08:13:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0mppccsg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 07 Feb 2020 08:13:12 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 7 Feb 2020 13:13:10 -0000
Subject: Re: [PATCH 1/1] cio_ignore_proc_seq_next should increase position
 index
References: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 7 Feb 2020 14:13:05 +0100
MIME-Version: 1.0
In-Reply-To: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <51ac7c33-ea7d-d780-c9de-4858af5e5f18@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Averin <vvs@virtuozzo.com>, linux-s390@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>



On 24.01.20 06:48, Vasily Averin wrote:
> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  drivers/s390/cio/blacklist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
> index 2a3f874..9cebff8 100644
> --- a/drivers/s390/cio/blacklist.c
> +++ b/drivers/s390/cio/blacklist.c
> @@ -303,8 +303,10 @@ struct ccwdev_iter {
>  cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
>  {
>  	struct ccwdev_iter *iter;
> +	loff_t p = *offset;
>  
> -	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
> +	(*offset)++;
> +	if (p >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
>  		return NULL;
>  	iter = it;
>  	if (iter->devno == __MAX_SUBCHANNEL) {
> @@ -314,7 +316,6 @@ struct ccwdev_iter {
>  			return NULL;
>  	} else
>  		iter->devno++;
> -	(*offset)++;
>  	return iter;
>  }
>  
> 

I guess this fixes one aspect:
"dd: /proc/cio_ignore: cannot skip to specified offset"
is now gone. So I am tempted to apply this. 

but this code is still fishy:

$ cat /proc/cio_ignore 
0.0.fe00-0.0.fefe
0.0.ff00-0.0.ffff
$ dd if=/proc/cio_ignore status=none
0.0.fe00-0.0.fefe
0.0.ff00-0.0.ffff
$ dd if=/proc/cio_ignore status=none bs=10
0.0.fe00-0.0.fefe
0.0.ff00-0.0.ff01-0.0.ff02-0.0.ff03-0.0.ff04-0.0.ff05-0.0.ff06-0.0.ff07-0.0.ff08-0.0.ffff
$ dd if=/proc/cio_ignore status=none bs=10 skip=1
.0.fefe
0.0.ff00-0.0.ff01-0.0.ff02-0.0.ff03-0.0.ff04-0.0.ff05-0.0.ff06-0.0.ff07-0.0.ff08-0.0.ffff


Peter, any opinions on this?
