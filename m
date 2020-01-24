Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729375AbgAXJYl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Jan 2020 04:24:41 -0500
Date: Fri, 24 Jan 2020 10:24:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] cio_ignore_proc_seq_next should increase position
 index
Message-ID: <20200124102432.0458ad45.cohuck@redhat.com>
In-Reply-To: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
References: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Averin <vvs@virtuozzo.com>
Cc: linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri, 24 Jan 2020 08:48:55 +0300
Vasily Averin <vvs@virtuozzo.com> wrote:

$SUBJECT: "s390/cio: ..." ?

> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
> 

Fixes: 678a395b356a ("[PATCH] s390: convert /proc/cio_ignore")

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

I was asking myself if we could avoid the new variable, but anything I
could think of looked worse.

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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
