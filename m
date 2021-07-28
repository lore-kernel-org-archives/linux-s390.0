Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF30C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5865460EC0
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 13:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhG1NnO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:43:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235314AbhG1NnO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 09:43:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SDXoqn128509;
        Wed, 28 Jul 2021 09:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=H2yNMS1D+GRLF/AUuNQuhT8RlaBua7StLFaTOY1jVsw=;
 b=p+vPhRbGAyw6CowI36EGGNWrOAnEPUzVFwbA8fLRYgvDDYf1V2LZbaG14MhsWzN36Qky
 wF/kvQ90O/AxLCpsRdjsPfQTnXg1XemupLtnGe16AZq78KpNqNuxtmFdGnhEqaRJCfVl
 W9hGNpTmiyQuGz3nn8KGAlOTFt6+eeoGxbER8ughJnb51e/a1XuQU58zNaj4M8dkDo76
 xanmMkdDbAeEMi8sJmZAVyXotZX08lQeXeQb6lPi+FwtD8ZqFb/31xtJU5NH9iePui63
 GeDrCLZkX2Yiodhn/R55MuM/oZpTSfoCB/EZucJlBQTksdnIFFhX57IOdjoPHm4w2sus Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a377bb2cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 09:43:09 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SDXqoU128660;
        Wed, 28 Jul 2021 09:43:08 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a377bb2c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 09:43:08 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SDSTfc008025;
        Wed, 28 Jul 2021 13:43:07 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 3a235pc4ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 13:43:07 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SDh6F833095976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 13:43:06 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 135BA6A054;
        Wed, 28 Jul 2021 13:43:06 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A4696A058;
        Wed, 28 Jul 2021 13:43:04 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.77.143.250])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 13:43:04 +0000 (GMT)
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Halil Pasic <pasic@linux.ibm.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, David Hildenbrand <david@redhat.com>,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-3-akrowiak@linux.ibm.com>
 <20210721164550.5402fe1c.pasic@linux.ibm.com>
 <c3b80f79-6795-61ce-2dd1-f4cc7110e417@linux.ibm.com>
 <20210723162625.59cead27.pasic@linux.ibm.com>
 <5380652f-e68f-bbd0-10c0-c7d541065843@linux.ibm.com>
 <20210726223628.4d7759bf.pasic@linux.ibm.com>
 <20210726220317.GA1721383@nvidia.com>
 <20210727004329.3bcc7d4f.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <a5eeac87-069d-171b-5558-3e99e7bda539@linux.ibm.com>
Date:   Wed, 28 Jul 2021 09:43:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727004329.3bcc7d4f.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J4CNyl775TrIyC91pzqarvdtJXqcGreK
X-Proofpoint-ORIG-GUID: MfBEXE31ktBTrbZRs-sEW6NsopN7z9lB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280076
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/26/21 6:43 PM, Halil Pasic wrote:
> On Mon, 26 Jul 2021 19:03:17 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>>> You may end up with open and close running interleaved. What I'
>>> trying to say is, to my best knowledge, normally there is no
>>> you have to close it before you open it again rule for files.
>> This is an existing bug in this driver, I've fixed in the reflck series.
>>
>> open_device/close_device will not run concurrently, or out of order,
>> afer it is fixed.
> Well if that is the case then provided your fix precedes this patch:
>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>
> I'm not entirely happy with this. I did not thoroughly investigate the
> implications of reversing the locking order of the vfio-ap lock (driver
> global) and the kvm lock (guest specific). I will trust Tony and hope
> our KVM maintainers will scream if this is bad from interference and
> delay perspective.

This solution was suggested by Jason G and it does in fact resolve
the lockdep splat encountered when starting an SE guest with
access to crypto resources. There is a chance that the KVM lock
can get held while waiting for the lock on the matrix_dev->mutex,
but this does not seem like a grave concern to me. That would
only happen during VFIO_GROUP_NOTIFY_SET_KVM notification - either
when the guest is being started or terminated, or when the mdev
fd is opened or closed. According to Jason, once he integrates his reflck
series, the open/close will happen only once.

I've copied the KVM maintainers on this response, so hopefully one of
them will provide some input.

>
> Regards,
> Halil

