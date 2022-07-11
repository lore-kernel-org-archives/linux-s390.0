Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F642C43334
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 17:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiGKRbK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKRbK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 13:31:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DC422F8
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 10:31:09 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BHJb4h009848
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 17:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=g8F6M21BMPqKEoMdZPLV08z18xfwdKoodFnXbJQfEwg=;
 b=UtUGNjANSyiTkStGgkiHsPkT3MWvmGEWXEC4TXziM4tM0m+lpp4YOZHnMTJQW2rhGIs0
 zyUjhRG2cUEUjbHMQW1XJQki8h+t6dUkeGS0iI6W0FPUz6U3HVMDqta+xHfQhHY4fPOf
 Y7nosuenUKFppj1C6UY4luZ4zGbsZ/ar7dlf4/3OvIiouHk1qt2gFb1COwXmKrwRB5Q3
 sTaNT60Xpby1gzMyN5iay4lTk1ViiQqvM1lIFVtikgD1lWBaWOFy60qYPkwaewl2cqhJ
 t/C6PfuB95LIWoSzbcZ7gmnbphY5H69qEoSgKS1i3bZQ3/INr6Ix1WnnfPSVRVqEdX9+ 9Q== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8r5rg74m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 17:31:08 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26BHK6wt027231
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 17:31:07 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3h71a9mv8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 17:31:07 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26BHV6dX56885650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 17:31:07 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCD022805E;
        Mon, 11 Jul 2022 17:31:06 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C7CB2805C;
        Mon, 11 Jul 2022 17:31:06 +0000 (GMT)
Received: from [9.65.200.23] (unknown [9.65.200.23])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jul 2022 17:31:06 +0000 (GMT)
Message-ID: <19bf0e50-82fb-6572-d679-1cdd01e333a6@linux.ibm.com>
Date:   Mon, 11 Jul 2022 13:31:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] s390/ap: fixes bug in the AP bus's
 __verify_queue_reservations function
Content-Language: en-US
To:     freude@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, jjherne@linux.ibm.com,
        borntraeger@de.ibm.com
References: <20220706222619.602094-1-akrowiak@linux.ibm.com>
 <e0cfef0c765e577d86be53c9606cbca3@linux.ibm.com>
From:   Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <e0cfef0c765e577d86be53c9606cbca3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bfQlJjeDNgpmXAfKn6HafDQljfxSxnVz
X-Proofpoint-GUID: bfQlJjeDNgpmXAfKn6HafDQljfxSxnVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_21,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110074
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 7/7/22 2:47 AM, Harald Freudenberger wrote:
> On 2022-07-07 00:26, Tony Krowiak wrote:
>> The AP bus's __verify_queue_reservations function increments the ref 
>> count
>> for the device driver passed in as a parameter, but fails to 
>> decrement it
>> before returning control to the caller. This will prevents any 
>> subsequent
>> removal of the module.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reported-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/ap_bus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 5c13d2079d96..0a9045b49c50 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -1435,7 +1435,7 @@ static int __verify_queue_reservations(struct
>> device_driver *drv, void *data)
>>      if (ap_drv->in_use) {
>>          rc = ap_drv->in_use(ap_perms.apm, newaqm);
>>          if (rc)
>> -            return -EBUSY;
>> +            rc = -EBUSY;
>>      }
>>
>>      /* release the driver's module */
> Tony, good catch. Thanks. Please add my Reviewed-by: Harald 
> Freudenberger <freude@linux.ibm.com>
> and then commit into devel and cc stable.


It is done.

