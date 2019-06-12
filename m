Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436673AbfFLN5r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 09:57:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CDh8PV073043
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 09:57:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3242htww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 09:57:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 12 Jun 2019 14:57:42 +0100
Subject: Re: [PATCH v9 4/4] s390: ap: kvm: Enable PQAP/AQIC facility for the
 guest
References: <1558452877-27822-1-git-send-email-pmorel@linux.ibm.com>
 <1558452877-27822-5-git-send-email-pmorel@linux.ibm.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 12 Jun 2019 15:57:37 +0200
MIME-Version: 1.0
In-Reply-To: <1558452877-27822-5-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <d9b32e45-43de-aff4-61ef-2b40bf84dcf1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, mimu@linux.ibm.com

On 21.05.19 17:34, Pierre Morel wrote:
> AP Queue Interruption Control (AQIC) facility gives
> the guest the possibility to control interruption for
> the Cryptographic Adjunct Processor queues.
>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  arch/s390/tools/gen_facilities.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 61ce5b5..aed14fc 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -114,6 +114,7 @@ static struct facility_def facility_defs[] = {
>  		.bits = (int[]){
>  			12, /* AP Query Configuration Information */
>  			15, /* AP Facilities Test */
> +			65, /* AP Queue Interruption Control */
>  			156, /* etoken facility */
>  			-1  /* END */
>  		}
acked-by: Harald Freudenberger <freude@linux.ibm.com>
