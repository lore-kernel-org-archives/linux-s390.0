Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F380C32771
	for <linux-s390@archiver.kernel.org>; Wed, 21 Sep 2022 08:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiIUIXf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Sep 2022 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiIUIXa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Sep 2022 04:23:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE03876A4;
        Wed, 21 Sep 2022 01:23:16 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28L8L8NC015160;
        Wed, 21 Sep 2022 08:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3aVfH+AgvYFT9Ahtj0jCANgIGt0Ia0rtxyCdGvkhSwc=;
 b=iEN/3DUpmrfe0YgCyxwURGlNtlTGqnrqUevUAuamfE6H5yVlghCwBuu6dsxA3TQAUnDc
 R52ddncnPz3nAQYpqsgQNFRetReTED51A305HHRUpDMg3jrtrpK3vTP85Pzt0GQxgO0W
 eyzJ5aXS75qrR8uS9dNTguJKo8ta+4nIBMQzQUoim42LpW2JgiEuVI0j/AalrRjj9pvN
 1gUKS7xX9VhduoWE27oGKnQqtvtDcRvhuCSfVX90ZNH+qYL3l6LjH6nmvb9i/WqMwKCq
 WCz+EkOqdkqpi+fqeqFIcpnoubXK4A+dplB+B5OI4GsL7MM57+sDTD/6wiWwFVnM3m5S Iw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqxgyh4h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 08:23:14 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28L8M0EM019819;
        Wed, 21 Sep 2022 08:23:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3jn5v8knm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 08:23:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28L8N9KJ41484562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 08:23:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 728EEA4054;
        Wed, 21 Sep 2022 08:23:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3DABA405C;
        Wed, 21 Sep 2022 08:23:07 +0000 (GMT)
Received: from [9.65.239.211] (unknown [9.65.239.211])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Sep 2022 08:23:07 +0000 (GMT)
Message-ID: <cbf33cbb-e539-f5e1-16fd-f8e9aba83005@linux.ibm.com>
Date:   Wed, 21 Sep 2022 10:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
 <PH0PR04MB741609C789F6A801747A64759B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH 0/7] s390/dasd: add hardware copy relation
In-Reply-To: <PH0PR04MB741609C789F6A801747A64759B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JfW7H6vir5dxVDmuYCwluHUc2ShS35rD
X-Proofpoint-ORIG-GUID: JfW7H6vir5dxVDmuYCwluHUc2ShS35rD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1011
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=778 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210053
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 21.09.22 um 09:07 schrieb Johannes Thumshirn:
> On 20.09.22 21:26, Stefan Haberland wrote:
>> Hi Jens,
>>
>> please apply the following patchset to for-next.
>> It adds basic support for a harwdare based copy relation to the DASD
>> device driver.
> Hi Stefan,
>
> How's the relation of this patchset to the current efforts of getting a common
> copy offload API (NVMe Simple Copy and SCSI XCOPY) into the block-layer?
>
>
> Thanks,
> 	Johannes

Hi Johannes,

there is no relation to this efforts.
My patchset basically aims to add some support of IBMs 
Peer-to-Peer-Remote-Copy (PPRC) hardware feature to the DASD device driver.
PPRC is a protocol that might be used without any OS interaction on a 
storage server level.
This patchset allows the driver to recognize such devices correctly and 
allows an user to make a copy relation known to the driver.
In this case Linux is only an observer/user of the copy relation which 
is set up by an external entity.


regards,
Stefan
