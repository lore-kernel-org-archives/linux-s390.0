Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbfKUMgJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Nov 2019 07:36:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALCWBUw109697
        for <linux-s390@vger.kernel.org>; Thu, 21 Nov 2019 07:36:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf73779n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 21 Nov 2019 07:36:07 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <hoeppner@linux.ibm.com>;
        Thu, 21 Nov 2019 12:36:05 -0000
Subject: Re: [PATCH] dasd_fba: Display '00000000' for zero page when dumping
 sense
References: <20191118111226.56666-1-hare@suse.de>
From: =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Date: Thu, 21 Nov 2019 13:36:00 +0100
MIME-Version: 1.0
In-Reply-To: <20191118111226.56666-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d329f133-6ed7-0389-2c7f-64c6bdc364c5@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Stefan Haberland <sth@linux.ibm.com>, linux-s390@vger.kernel.org, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>, Sebastian Parschauer <sparschauer@suse.de>

On 11/18/19 12:12 PM, Hannes Reinecke wrote:
> When a discard I/O fails, dasd_fba_dump_sense() will crash as it
> tries to print out the CCW, and failing to take into account that
> for discard I/O we have only one data pointer, not one per sg.
> As the data pointer will always point to the zero page this patch
> replaces the data pointer output with '00000000' to avoid the crash.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> [sparschauer: replaced "ccw" with "act", "snprintf" with "sprintf"]
> [sparschauer v2: added missing curly braces to for loops]
> Signed-off-by: Sebastian Parschauer <sparschauer@suse.de>
> ---
>  drivers/s390/block/dasd_fba.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 

Hi Hannes,

thanks for the patch. However,

> diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
> index cbb770824226..4b867bd6b164 100644
> --- a/drivers/s390/block/dasd_fba.c
> +++ b/drivers/s390/block/dasd_fba.c
> @@ -717,10 +717,15 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
>  			       " CCW %p: %08X %08X DAT:",
>  			       act, ((int *) act)[0], ((int *) act)[1]);
>  		for (count = 0; count < 32 && count < act->count;
> -		     count += sizeof(int))
> +		     count += sizeof(int)) {
> +			if (act->flags & CCW_FLAG_SLI) {

I'm not quite happy with the usage of CCW_FLAG_SLI here.
We're currently looking into this issue in more detail to fully
understand the problem.

I'll let you know the outcome and possible improvements for the
patch as soon as possible.

regards,
Jan
