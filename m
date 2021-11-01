Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DDBC433F5
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 15:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1652660FC4
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 15:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhKAPvj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 Nov 2021 11:51:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230517AbhKAPvi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Nov 2021 11:51:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1F30L7031608
        for <linux-s390@vger.kernel.org>; Mon, 1 Nov 2021 15:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qmb99sHtDFqIsxehquBoOdCMPljXKhOa0bMCyZWYYFI=;
 b=FcWK6M9T4U75dLGqMA0Yn4STK13VtzUq26Zbm76a5DWN/FajFVD1uc2F125HA5RaoS6x
 UkKsNvevZZ7/vAXPQ091UDZ6NUfDG9InnHdeWHZUVGos4eLVTz+P4a9ZZVTdvvu4950E
 Q2VdwF1SzCf9ozZQz3zycw0M1qY90aO10B+pifqJTqi4bdp2HopK03pXV7zCJaHX0LOP
 Mid61RD9PuSOoVPP2/xBDJvl7p2j031a4OJbUMVgEnTCN0ZPJ3tIssKlNqUSb8baQOJk
 rm6ShjXsyuApjOjVrXwpyiod8m/GjR31fsiGRqHxWt7hOpXltfWlrSOWWsMnLFo+aNiF hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c2ggaus7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 01 Nov 2021 15:49:04 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A1F13R2018490
        for <linux-s390@vger.kernel.org>; Mon, 1 Nov 2021 15:49:04 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c2ggaus7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 15:49:04 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A1FZ5Sn011413;
        Mon, 1 Nov 2021 15:49:03 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3c0wpafm0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 15:49:03 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A1Fn21R51970322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Nov 2021 15:49:02 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64E5A11206E;
        Mon,  1 Nov 2021 15:49:02 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27FD2112062;
        Mon,  1 Nov 2021 15:49:01 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.119.222])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Nov 2021 15:48:58 +0000 (GMT)
Subject: Re: [PATCH 2/2] s390/vfio-ap: add status attribute to AP queue
 device's sysfs dir
To:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     borntraeger@linux.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com
References: <20211027164810.19678-1-akrowiak@linux.ibm.com>
 <20211027164810.19678-3-akrowiak@linux.ibm.com>
 <5ce1ab5f-da7b-451d-ebfe-08919a56f5d8@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <b8e60398-baad-ced1-7687-e5bf90ab52c5@linux.ibm.com>
Date:   Mon, 1 Nov 2021 11:48:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5ce1ab5f-da7b-451d-ebfe-08919a56f5d8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0nXFAA17OGwFed1t2zgW02I7XnLWw46i
X-Proofpoint-GUID: -xKjLkqP_kcAR4KZalVM0aUKW8ZZ8UrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_06,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 10/28/21 3:40 AM, Harald Freudenberger wrote:
> On 27.10.21 18:48, Tony Krowiak wrote:
>> This patch adds a sysfs 'status' attribute to a queue device when it is
>> bound to the vfio_ap device driver. The field displays a string indicating
>> the status of the queue device:
>>
>> Status String:  Indicates:
>> -------------   ---------
>> "assigned"      the queue is assigned to an mdev, but is not in use by a
>>                  KVM guest.
>> "in use"        the queue is assigned to an mdev and is in use by a KVM
>>                  guest.
>> "unassigned"    the queue is not assigned to an mdev.
>>
>> The status string will be displayed by the 'lszcrypt' command if the queue
>> device is bound to the vfio_ap device driver.
>>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> [akrowiak@linux.ibm.com: added check for queue in use by guest]
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>Looks good to me, add my "Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>"

You already have a Signed-off-by since you created the original version 
of this
patch. I added my Signed-off-by for adding the "in use" status value. 
Should I still
add a Reviewed-by for you?


