Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbfGSHrz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jul 2019 03:47:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6J7lDlO051743
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 03:47:53 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tu5y6gqy0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 03:47:53 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 19 Jul 2019 08:47:51 +0100
Subject: Re: [PATCH AUTOSEL 5.2 149/171] s390/dasd: Make layout analysis ESE
 compatible
References: <20190719035643.14300-1-sashal@kernel.org>
 <20190719035643.14300-149-sashal@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 19 Jul 2019 09:47:46 +0200
MIME-Version: 1.0
In-Reply-To: <20190719035643.14300-149-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a8ad62c7-383a-a890-ca20-4348d8ab9dec@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>, Stefan Haberland <sth@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>

The comment is true for all stable versions.

This patch is part of a larger series that enables ESE volumes.
I think it should not go alone as other patches like 
5e2b17e712cf s390/dasd: Add dynamic formatting support for ESE volumes
are needed to actually work with ESE volumes.
So I suggest to drop this patch.
Jan, Stefan, do you agree?



On 19.07.19 05:56, Sasha Levin wrote:
> From: Jan Höppner <hoeppner@linux.ibm.com>
> 
> [ Upstream commit ce6915f5343f5f2a2a937b683d8ffbf12dab3ad4 ]
> 
> The disk layout and volume information of a DASD reside in the first two
> tracks of cylinder 0. When a DASD is set online, currently the first
> three tracks are read and analysed to confirm an expected layout.
> 
> For CDL (Compatible Disk Layout) only count area data of the first track
> is evaluated and checked against expected key and data lengths. For LDL
> (Linux Disk Layout) the first and third track is evaluated. However,
> an LDL formatted volume is expected to be in the same format across all
> tracks. Checking the third track therefore doesn't have any more value
> than checking any other track at random.
> 
> Now, an Extent Space Efficient (ESE) DASD is initialised by only
> formatting the first two tracks, as those tracks always contain all
> information necessarry.
> 
> Checking the third track on an ESE volume will therefore most likely
> fail with a record not found error, as the third track will be empty.
> This in turn leads to the device being recognised with a volume size of
> 0. Attempts to write volume information on the first two tracks then
> fail with "no space left on device" errors.
> 
> Initialising the first three tracks for an ESE volume is not a viable
> solution, because the third track is already a regular track and could
> contain user data. With that there is potential for data corruption.
> 
> Instead, always only analyse the first two tracks, as it is sufficiant
> for both CDL and LDL, and allow ESE volumes to be recognised as well.
> 
> Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/s390/block/dasd_eckd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
> index c09039eea707..c7aec1b44b7c 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -157,7 +157,7 @@ static const int sizes_trk0[] = { 28, 148, 84 };
>  #define LABEL_SIZE 140
>  
>  /* head and record addresses of count_area read in analysis ccw */
> -static const int count_area_head[] = { 0, 0, 0, 0, 2 };
> +static const int count_area_head[] = { 0, 0, 0, 0, 1 };
>  static const int count_area_rec[] = { 1, 2, 3, 4, 1 };
>  
>  static inline unsigned int
> @@ -1823,8 +1823,8 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
>  	if (IS_ERR(cqr))
>  		return cqr;
>  	ccw = cqr->cpaddr;
> -	/* Define extent for the first 3 tracks. */
> -	define_extent(ccw++, cqr->data, 0, 2,
> +	/* Define extent for the first 2 tracks. */
> +	define_extent(ccw++, cqr->data, 0, 1,
>  		      DASD_ECKD_CCW_READ_COUNT, device, 0);
>  	LO_data = cqr->data + sizeof(struct DE_eckd_data);
>  	/* Locate record for the first 4 records on track 0. */
> @@ -1843,9 +1843,9 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
>  		count_data++;
>  	}
>  
> -	/* Locate record for the first record on track 2. */
> +	/* Locate record for the first record on track 1. */
>  	ccw[-1].flags |= CCW_FLAG_CC;
> -	locate_record(ccw++, LO_data++, 2, 0, 1,
> +	locate_record(ccw++, LO_data++, 1, 0, 1,
>  		      DASD_ECKD_CCW_READ_COUNT, device, 0);
>  	/* Read count ccw. */
>  	ccw[-1].flags |= CCW_FLAG_CC;
> @@ -1967,7 +1967,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
>  		}
>  	}
>  	if (i == 3)
> -		count_area = &private->count_area[4];
> +		count_area = &private->count_area[3];
>  
>  	if (private->uses_cdl == 0) {
>  		for (i = 0; i < 5; i++) {
> 
