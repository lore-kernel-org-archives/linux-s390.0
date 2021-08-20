Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5287C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 14:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8658261101
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 14:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbhHTOZF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 10:25:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240721AbhHTOZF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Aug 2021 10:25:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KEF5Q8085303;
        Fri, 20 Aug 2021 10:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BcoMMflsLYE3BWsm/Yp3/r4I8XFQP6V5LFbLZTJmZxQ=;
 b=rUMGvnq9VhzQuTY8xiNG0HrFyAGdbIKmGf94elUlXZAXNzcOzHzx2y/13NN/ERjMBzXV
 DOplkdNNCeARX5+1+5tkXHU+UzrDgrwnE2x9L04ucx17XaaLWKktzJOZ9COl+m3VIYYL
 31VZ9PZLV3p737AE288h69jxxS7TLz+NwHG3i92/WybS9LTY3LIqUFFC3lmwRbIB3X2F
 oysCsHIsLCXwrPKM0NFjIWqVifEm4A8xeTy2iJswTGQO3jqyVlNozDwei9MCiMg2MXKi
 vHVzl+SXPHEE1ZU3u8gcB2/BDBQgCTcCbpStm2OlY9vJCSEDwYLkPivy3WZWyZkQ07Y8 sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aj04tukas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 10:24:25 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17KEFBid085663;
        Fri, 20 Aug 2021 10:24:25 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aj04tukak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 10:24:25 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17KECUfH006452;
        Fri, 20 Aug 2021 14:24:24 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3ae5ffm785-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 14:24:24 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17KEONPd25952662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 14:24:23 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 083A4136060;
        Fri, 20 Aug 2021 14:24:23 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F455136051;
        Fri, 20 Aug 2021 14:24:21 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 20 Aug 2021 14:24:20 +0000 (GMT)
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Cornelia Huck <cohuck@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, pasic@linux.vnet.ibm.com,
        jjherne@linux.ibm.com, jgg@nvidia.com, kwankhede@nvidia.com,
        david@redhat.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
 <20210802155355.22b98789.pasic@linux.ibm.com>
 <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
 <6d64bd83-1519-6065-a4cd-9356c6be5d1a@de.ibm.com>
 <20210818103908.31eb5848.alex.williamson@redhat.com>
 <8735r5sb8y.fsf@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <3b7451cc-6409-5611-b85d-b37060b24d6d@linux.ibm.com>
Date:   Fri, 20 Aug 2021 10:24:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <8735r5sb8y.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zmrtjif4Nru3aFKnDIzoimM1_u4GWes5
X-Proofpoint-GUID: TK3z_0hDKyJiBVnOs7vYrLgCKjrrasnX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-20_06:2021-08-20,2021-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 8/19/21 11:30 AM, Cornelia Huck wrote:
> On Wed, Aug 18 2021, Alex Williamson <alex.williamson@redhat.com> wrote:
>
>> On Wed, 18 Aug 2021 17:59:51 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 02.08.21 18:32, Tony Krowiak wrote:
>>>>
>>>> On 8/2/21 9:53 AM, Halil Pasic wrote:
>>>>> On Mon, 2 Aug 2021 09:10:26 -0400
>>>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>>>   
>>>>>> PING!
>>>>>>
>>>>>> This patch will pre-req version 17 of a patch series I have waiting in
>>>>>> the wings,
>>>>>> so I'd like to get this one merged ASAP. In particular, if a KVM
>>>>>> maintainer can
>>>>>> take a look at the comments concerning the taking of the kvm->lock
>>>>>> before the
>>>>>> matrix_mdev->lock it would be greatly appreciated. Those comments begin with
>>>>>> Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.
>>>>> As far as I'm concerned, we can move forward with this. Was this
>>>>> supposed to go in via Alex's tree?
>>>> I am not certain, Christian queued the previous patches related to
>>>> this on:
>>>>
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
>>>>
>>>> Jason G., since this will need to be integrated with your other patches,
>>>> where should this be queued?
>>>
>>> This previous patch (s390/vfio-ap: clean up mdev resources when remove callback invoked) is
>>> already in master.
>>> Can you respin the series with all Acks and RBs?
>>>
>>> Alex, can you then take these 2 patches via your tree? Thanks
>>>
>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> for this series.
>>
>> I see some review feedback that seems to suggest a new version would be
>> posted:
>>
>> https://lore.kernel.org/linux-s390/0f03ab0b-2dfd-e1c1-fe43-be2a59030a71@linux.ibm.com/
> Yeah, I thought so as well. But it also looks like something that could
> be a fixup on top.

I will post the new patch today. I was waiting for the remainder of
the feedback and frankly forgot to post the patch incorporating
the changes precipitated by the previous comments.

>
>> I also see in this thread:
>>
>> https://lore.kernel.org/linux-s390/20210721164550.5402fe1c.pasic@linux.ibm.com/
>>
>> that Halil's concern's around open/close races are addressed by Jason's
>> device_open/close series that's already in my next branch and he
>> provided an Ack, but there's still the above question regarding the
>> kvm->lock that was looking for a review from... I'm not sure, maybe
>> Connie or Paolo.  Christian, is this specifically what you're ack'ing?
> I'm also unsure about the kvm->lock thing. Is taking the lock buried
> somewhere deep in the code that will ultimately trigger the release?
> I would at least like a pointer.

I'm not quite sure what you're asking here, but if you follow the
thread starting with the link above it may reveal the answer to
what you are asking here.


>
>> It can ultimately go in through my tree, but not being familiar with
>> this code I'd hope for more closure.  Thanks,
>>
>> Alex

