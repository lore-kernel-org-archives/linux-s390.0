Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2959BC433EF
	for <linux-s390@archiver.kernel.org>; Thu,  7 Jul 2022 06:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiGGGro (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Jul 2022 02:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiGGGrm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Jul 2022 02:47:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCB42BB27
        for <linux-s390@vger.kernel.org>; Wed,  6 Jul 2022 23:47:41 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2676M19I014611
        for <linux-s390@vger.kernel.org>; Thu, 7 Jul 2022 06:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=BtM5JD6q6G58nF5JJSctaFUujHCxBvZJ6gMzmdN3Fls=;
 b=OPou+0ADvk81badK9JCp7kNjgQF4uoR46Lw5Dk77Blc25W5njDXFhQrCFufiah3e2NMs
 RV1hKPtqXY3myzwuw8CTVJipgPieCVWEPdDcMXtp75MaezQfxSJIX2hZsxgxHhendX06
 v2wus+gDyAghY67+0Jei9Tw98fClDtNckmQBBbXOO5HWwDgqNoxSYqANMIteEknQfyw3
 miphtrzJufBXSRRv5mzeFh2CjgLtgXc5xaG/ZQSVtamzCJUXA85Xy3odjqO+K/mQ0Obn
 BSz5j+CLX/TPEDL2y9SBIpgTJbVNrT3xqU8NM4qtRkg3VgTbYNY1ZpFr/v/JimULmKjb 0Q== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5t5frgx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 07 Jul 2022 06:47:40 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2676KVeB009336
        for <linux-s390@vger.kernel.org>; Thu, 7 Jul 2022 06:47:39 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 3h4v501av2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 07 Jul 2022 06:47:39 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2676lc0w42467618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 06:47:38 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 934F7136051;
        Thu,  7 Jul 2022 06:47:38 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DB6C13604F;
        Thu,  7 Jul 2022 06:47:38 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.10.229.42])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 06:47:38 +0000 (GMT)
MIME-Version: 1.0
Date:   Thu, 07 Jul 2022 08:47:38 +0200
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, jjherne@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH] s390/ap: fixes bug in the AP bus's
 __verify_queue_reservations function
Reply-To: freude@linux.ibm.com
In-Reply-To: <20220706222619.602094-1-akrowiak@linux.ibm.com>
References: <20220706222619.602094-1-akrowiak@linux.ibm.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e0cfef0c765e577d86be53c9606cbca3@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SgFC23Rph9Hx_XHMSepHIj7apESSBjhQ
X-Proofpoint-GUID: SgFC23Rph9Hx_XHMSepHIj7apESSBjhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070024
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2022-07-07 00:26, Tony Krowiak wrote:
> The AP bus's __verify_queue_reservations function increments the ref 
> count
> for the device driver passed in as a parameter, but fails to decrement 
> it
> before returning control to the caller. This will prevents any 
> subsequent
> removal of the module.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reported-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/ap_bus.c 
> b/drivers/s390/crypto/ap_bus.c
> index 5c13d2079d96..0a9045b49c50 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -1435,7 +1435,7 @@ static int __verify_queue_reservations(struct
> device_driver *drv, void *data)
>  	if (ap_drv->in_use) {
>  		rc = ap_drv->in_use(ap_perms.apm, newaqm);
>  		if (rc)
> -			return -EBUSY;
> +			rc = -EBUSY;
>  	}
> 
>  	/* release the driver's module */
Tony, good catch. Thanks. Please add my Reviewed-by: Harald 
Freudenberger <freude@linux.ibm.com>
and then commit into devel and cc stable.
