Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728276AbgBKK0U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 05:26:20 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BAIiZ0071463
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 05:26:18 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1tne33bn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 05:26:18 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 11 Feb 2020 10:26:16 -0000
Subject: Re: [PATCH 1/1] cio_ignore_proc_seq_next should increase position
 index
References: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 11 Feb 2020 11:26:12 +0100
MIME-Version: 1.0
In-Reply-To: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <818b8989-4294-b5fb-d2d5-da3f2c0b903c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Averin <vvs@virtuozzo.com>, linux-s390@vger.kernel.org
Cc: Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 24.01.20 06:48, Vasily Averin wrote:
> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

thanks applied. 
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
