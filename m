Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2266C48BE6
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8832C61159
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 14:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhFPO07 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:26:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232408AbhFPO07 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Jun 2021 10:26:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GE4M7D191708;
        Wed, 16 Jun 2021 10:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cBGvL7LrjTGK1si4gGsUEKacGpD6gYr3p41k0yAXkCo=;
 b=E7F/OEAJqovfbhu1hnvvAUKOqMEQDdG1IdWFXXAkZ9J/1HB0zsVkNRtlxGFORoGozmUH
 quEXJdGNQ0yZuQAkyrIQO5Qe84loTP4I1jv0oiPnAgtqCYkG4aCAdKSWvne6yPu/r43K
 CPppbLuSEbSzor5PhXKA/lCP3BJa17JmctTCyFGTacu6x3NTJgHsPfwcDAopva2m7qSE
 rBrdQfMFN+HyvJRyRzFBfSzHdG53FK0ZkSf3JGD05e18AMC3sUulXrw9McL1PDXWcLCn
 ZE3xTys05gL19jW3XCwnPzCeMiGdI6FX3GE5d9GoQ8U/0iUe7l+HLudQ2Fw8CezlOVN4 cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 397jnr91nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:24:50 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15GE55Xd195572;
        Wed, 16 Jun 2021 10:24:49 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 397jnr91mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:24:49 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15GEC9aV024852;
        Wed, 16 Jun 2021 14:24:49 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 394mj9rxr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 14:24:49 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15GEOmJV39453084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 14:24:48 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67509AE05C;
        Wed, 16 Jun 2021 14:24:48 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0A26AE07C;
        Wed, 16 Jun 2021 14:24:47 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.128.252])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jun 2021 14:24:47 +0000 (GMT)
Subject: Re: [PATCH v4 0/2] s390/vfio-ap: fix memory leak in mdev remove
 callback
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <b5ff6818-fb8c-3d50-2d2e-d3992be1644b@de.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <cb9883fb-8a4f-db8e-1349-cb078c7ba5e8@linux.ibm.com>
Date:   Wed, 16 Jun 2021 10:24:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b5ff6818-fb8c-3d50-2d2e-d3992be1644b@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XRaXoYzI0w5WvMShGvIccnT_xpVyN9qW
X-Proofpoint-ORIG-GUID: l5MEz4YwLzQiwO9VXOD2VnvyymfJOIUX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160082
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/14/21 3:51 AM, Christian Borntraeger wrote:
>
> On 21.05.21 21:36, Tony Krowiak wrote:
>> Fixes a memory leak in the mdev remove callback when invoked while the
>> mdev is in use by a KVM guest. Instead of returning -EBUSY from the
>> callback, a full cleanup of the resources allocated to the mdev is
>> performed because regardless of the value returned from the function, 
>> the
>> mdev is removed from sysfs.
>>
>> The cleanup of resources allocated to the mdev may coincide with the
>> interception of the PQAP(AQIC) instruction in which case data needed to
>> handle the interception may get removed. A patch is included in this 
>> series
>> to synchronize access to resources needed by the interception handler to
>> protect against invalid memory accesses.
>>
>> The first pass (PATCH v3) at trying to synchronize access to the pqap
>> function pointer employed RCU. The problem is, the RCU read-side 
>> critical
>> section would have to include the execution of the pqap function which
>> sleeps; RCU disallows sleeping inside an RCU region. When I subsequently
>> tried to encompass the pqap function within the
>> rcu_read_lock/rcu_read_unlock, I ended up seeing lockdep warnings in the
>> syslog.
>>
>> It was suggested that we use an rw_semaphore to synchronize access to
>> the pqap hook, but I also ran into similar lockdep complaints something
>> like the following:
>>
>>    Possible unsafe locking scenario:
>>
>>          CPU0                            CPU1
>>          ----                            ----
>>     down_read(&rwsem)
>>     in handle_pqap (priv.c);
>> lock(&matrix_dev->lock);
>>                                    in vfio_ap_mdev_set_kvm 
>> (vfio_ap_ops.c)
>>                                    down_write(&rwsem;
>>                                    in vfio_ap_mdev_set_kvm 
>> (vfio_ap_ops.c)
>> lock(&matrix_dev->lock);
>>     in handle_pqap(vfio_ap_ops.c)
>>
>> Access to the mdev must be done under the matrix_dev->lock to ensure 
>> that
>> it doesn't get freed via the remove callback while in use. This appears
>> to be mutually exclusive with setting/unsetting the pqap_hook pointer
>> due to lockdep issues.
>>
>> The solution:
>> ------------
>> The lifetime of the handle_pqap function (vfio_ap_ops) is syncrhonous
>> with the lifetime of the vfio_ap module, so there really is not reason
>> to tie the setting/clearing of its function pointer with the lifetime
>> of a guest or even an mdev. If the function pointer is set when the
>> vfio_ap module is loaded and cleared when the vfio_ap module is 
>> unloaded,
>> then access to it can be protected independently from mdev creation or
>> removal as well as the starting or shutdown of a guest. As long as
>> access to the mdev is always controlled by the matrix_dev->lock, the
>> mdev can not be freed without other functions being aware.
>>
>> Change log:
>> v3 -> v4:
>> --------
>> * Created a registry for crypto hooks in priv.c with functions for
>>    registering/unregistering function pointers in kvm_host.h (for s390).
>>
>> * Register the function pointer for handling the PQAP instruction when
>>    the vfio_ap module is loaded and unregister it when the module is
>>    unloaded.
>
> Was there a v5? I cannot find it.

I'm sorry, it morphed into a different set of patches due to the 
addition of a
patch precipitated by review comments of an unrelated issue. I pushed a
v5 today that contains only the relevant patches. I believe that set can be
integrated.

