Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F60C432BE
	for <linux-s390@archiver.kernel.org>; Fri, 30 Jul 2021 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891EF60F4A
	for <linux-s390@archiver.kernel.org>; Fri, 30 Jul 2021 13:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbhG3NdV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:33:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238979AbhG3NdV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Jul 2021 09:33:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UD4JRt083591;
        Fri, 30 Jul 2021 09:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UJPQ9VbDNI1euybHi4NIJ6hXWWUgW7x0UOukPqMkAzI=;
 b=VK3ng8HuyO/qImuua2YfEQW7OF8V1rwMmQoBYX6XT/8lYmKFwchUeM4HxNMe7L0HhGB0
 WciZooGopAnutB67g0SMdJxOkqffLMqb06uyTctr70uaPwxDfnxvAsoY5RsD/cbUm07f
 ucXdpdKiSa0s2nCxQxBaVmurNqJdV2UPBK1zdKxWRujxgnQuFThzGh3UXaw+v26cHOGT
 QzhnGcyulikgVZXNJ5RcPpsR98hEwIaFiq7Je69bbdu7qsdVPi/gDrhozUdktF3Tf1KQ
 unLJ7IhCk3mDdiEwVzZ6GIhcooZ+HCRmT3BbelPiiHQ9G+n2Vhhxm5ZDfszVW9yR1FWw qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a4g23mp4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 09:33:15 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16UD5U6e095868;
        Fri, 30 Jul 2021 09:33:14 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a4g23mp42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 09:33:14 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16UDT2ki003953;
        Fri, 30 Jul 2021 13:33:13 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3a235tw37w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 13:33:13 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16UDXBqC10027386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 13:33:12 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBFC06A051;
        Fri, 30 Jul 2021 13:33:11 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 532C06A064;
        Fri, 30 Jul 2021 13:33:10 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.77.143.250])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 30 Jul 2021 13:33:10 +0000 (GMT)
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-3-akrowiak@linux.ibm.com>
 <20210721164550.5402fe1c.pasic@linux.ibm.com>
 <c3b80f79-6795-61ce-2dd1-f4cc7110e417@linux.ibm.com>
 <20210723162625.59cead27.pasic@linux.ibm.com>
 <5380652f-e68f-bbd0-10c0-c7d541065843@linux.ibm.com>
 <20210726223628.4d7759bf.pasic@linux.ibm.com>
 <20210726220317.GA1721383@nvidia.com>
 <20210727004329.3bcc7d4f.pasic@linux.ibm.com>
 <a5eeac87-069d-171b-5558-3e99e7bda539@linux.ibm.com>
 <20210728214257.5e5c28c4.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <8e0b4b16-ce45-449e-4849-29919da3a70f@linux.ibm.com>
Date:   Fri, 30 Jul 2021 09:33:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728214257.5e5c28c4.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5qCbVJV3xaAXmeXxXzIkkudf94U1v6hF
X-Proofpoint-ORIG-GUID: SJpn8fi77RYkL1W3rrjNxRcCagEKb78y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_05:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/28/21 3:42 PM, Halil Pasic wrote:
> On Wed, 28 Jul 2021 09:43:03 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> This solution was suggested by Jason G and it does in fact resolve
>> the lockdep splat encountered when starting an SE guest with
>> access to crypto resources. There is a chance that the KVM lock
>> can get held while waiting for the lock on the matrix_dev->mutex,
>> but this does not seem like a grave concern to me.
> Yes I agree. I was thinking along the lines: matrix modifications
> via the sysfs take the matrix_dev->lock so the level of contention
> may depend on what userspace is doing...

The probe/remove functions also take the matrix_dev->lock
as does the handle_pqap() function. In any case, while all of
those are possible, in our implementation of AP queue
pass-through, the two functions that take the KVM lock
are invoked when the guest is starting or shutting down,
or when the mdev is hot plugged/unplugged. For the cases of
guest startup/shutdown, it would seem that holding the
kvm->lock while waiting for the matrix_dev->lock shouldn't
be a big problem since the guest will either not be fully up
yet or on its way down. I suppose the hot plug/unplug case
could potentially cause the guest vcpus to pause while processing,
but how often do you anticipate a hot plug to take place?

>
> Regards,
> Halil

