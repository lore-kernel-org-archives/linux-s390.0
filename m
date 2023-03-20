Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFCFC6FD1D
	for <linux-s390@archiver.kernel.org>; Mon, 20 Mar 2023 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjCTQAb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjCTP7w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Mar 2023 11:59:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519AD3D910;
        Mon, 20 Mar 2023 08:50:08 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KDoR3B029149;
        Mon, 20 Mar 2023 14:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JqwEq22q9ncqQOVEz7KN8AdM+7Ga4CcGnI0+KU4Ih5g=;
 b=DNywmC9r1P8uMY6oQ2un0xAi0OGgDewtUlj1ExZ1PyAs3BoFuPzr/A0ULWoc+8eXHJKJ
 iVfiesckik84LreWUnnTl7404jjD5PR+HGL/iOzw/XSuMLzjKGVUY6suw1xEVuWqbg18
 CaglMW1cZOTZs/eD3L0icgqM9rVIiNXXHXdk7U4KHAjtAj583LomK6N584UAc08MKllT
 ZNlqvhp6Ty9QsSpTXZLicjb1DHdEZoH//KReaxwK+PtG++y93UkzRXXRael5FO8mTChB
 7Pnaq/1j4tAtQMzF0L/Iv1OGZW4g5ozHYDhBRvzDwXi25R/LR96oqx00WsSZxq0ybPEd xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3perqfsmxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 14:47:56 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32KDqqcX008157;
        Mon, 20 Mar 2023 14:47:55 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3perqfsmx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 14:47:55 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KCe6m8028306;
        Mon, 20 Mar 2023 14:47:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pd4x78m2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 14:47:54 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KElr5n57344392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 14:47:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4750B5805C;
        Mon, 20 Mar 2023 14:47:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0271458054;
        Mon, 20 Mar 2023 14:47:52 +0000 (GMT)
Received: from [9.65.246.37] (unknown [9.65.246.37])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Mar 2023 14:47:51 +0000 (GMT)
Message-ID: <29430ef5-101d-c639-0f64-b9b709d34afd@linux.ibm.com>
Date:   Mon, 20 Mar 2023 10:47:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] s390/vfio-ap-drv: Remove redundant driver match
 function
Content-Language: en-US
To:     Lizhe <sensor1010@163.com>, pasic@linux.ibm.com,
        jjherne@linux.ibm.com, freude@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230319041941.259830-1-sensor1010@163.com>
From:   Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20230319041941.259830-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LXsdhGqwjc-oO3sUCnQd1LwMBlyobEX5
X-Proofpoint-ORIG-GUID: 5BKVyTrzBrO8xaRUScMQkRam9Lv_6LoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200123
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

On 3/19/23 12:19 AM, Lizhe wrote:
> If there is no driver match function, the driver core assumes that each
> candidate pair (driver, device) matches, see driver_match_device().
>
> Drop the matrix bus's match function that always returned 1 and so
> implements the same behaviour as when there is no match function
>
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 997b524bdd2b..9341c000da41 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -59,14 +59,8 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>   	kfree(matrix_dev);
>   }
>   
> -static int matrix_bus_match(struct device *dev, struct device_driver *drv)
> -{
> -	return 1;
> -}
> -
>   static struct bus_type matrix_bus = {
>   	.name = "matrix",
> -	.match = &matrix_bus_match,
>   };
>   
>   static struct device_driver matrix_driver = {
