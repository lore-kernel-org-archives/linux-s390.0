Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A699FC4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 16:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C13610CB
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 16:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhHRQvd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 12:51:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24968 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhHRQvd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 12:51:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IGZ31o031933;
        Wed, 18 Aug 2021 12:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Z8NDW7xveE9evwODAexv0KQTZMbXBRZR007ufKGl3jQ=;
 b=j6CNmjToo9yF9jbMXP2odyNFeIXpff7GMaNsfegr4BE/DTNGhxc/wNkK805I0mvVUdbN
 TMHgU6Ohtaj8Dac5JP305blDr6jbDl/ZcPYfRCwv9k+XMEjrm+ka5/iAuLDen0y+9dPn
 nwBOhwoZll3GTnZUmk2XkjwOzr8pGHLZN99uNR3cg6UurP/viCe7uHXuUggESi2py5Qc
 JYKpQn3JkOItyK5eH85yWgW/G0kOkeuTse03XnL0HwkipW40Wg7cCIza2BW+fRb1VgXM
 QnNVI3oR5vrjpf7hrlLAg/mWIQewO/FJF9pHMP2FoRB+PSTTecqaSwIT3lJ29Selbv4m Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agcwx44yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 12:50:56 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17IGZRn4033775;
        Wed, 18 Aug 2021 12:50:55 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agcwx44ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 12:50:55 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17IGmIhg007574;
        Wed, 18 Aug 2021 16:50:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3ae5f8dxcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 16:50:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17IGlMSV61407666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 16:47:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E44A411C069;
        Wed, 18 Aug 2021 16:50:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FBF611C075;
        Wed, 18 Aug 2021 16:50:49 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.60.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Aug 2021 16:50:49 +0000 (GMT)
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        kwankhede@nvidia.com, david@redhat.com, pbonzini@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
 <20210802155355.22b98789.pasic@linux.ibm.com>
 <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
 <6d64bd83-1519-6065-a4cd-9356c6be5d1a@de.ibm.com>
 <20210818103908.31eb5848.alex.williamson@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <4dac22cf-1956-41eb-88da-f16af58530a3@de.ibm.com>
Date:   Wed, 18 Aug 2021 18:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210818103908.31eb5848.alex.williamson@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6SgdOAZ8kzii6u7H1c3Y0Dnx0gg9QkvB
X-Proofpoint-ORIG-GUID: 4pKYXWG3W6NyQdj1SqE_1AUem7e6E-SE
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_05:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108180104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 18.08.21 18:39, Alex Williamson wrote:
> On Wed, 18 Aug 2021 17:59:51 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 02.08.21 18:32, Tony Krowiak wrote:
>>>
>>>
>>> On 8/2/21 9:53 AM, Halil Pasic wrote:
>>>> On Mon, 2 Aug 2021 09:10:26 -0400
>>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>>   
>>>>> PING!
>>>>>
>>>>> This patch will pre-req version 17 of a patch series I have waiting in
>>>>> the wings,
>>>>> so I'd like to get this one merged ASAP. In particular, if a KVM
>>>>> maintainer can
>>>>> take a look at the comments concerning the taking of the kvm->lock
>>>>> before the
>>>>> matrix_mdev->lock it would be greatly appreciated. Those comments begin with
>>>>> Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.
>>>> As far as I'm concerned, we can move forward with this. Was this
>>>> supposed to go in via Alex's tree?
>>>
>>> I am not certain, Christian queued the previous patches related to
>>> this on:
>>>
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
>>>
>>> Jason G., since this will need to be integrated with your other patches,
>>> where should this be queued?
>>
>>
>> This previous patch (s390/vfio-ap: clean up mdev resources when remove callback invoked) is
>> already in master.
>> Can you respin the series with all Acks and RBs?
>>
>> Alex, can you then take these 2 patches via your tree? Thanks
>>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> for this series.
> 
> 
> I see some review feedback that seems to suggest a new version would be
> posted:
> 
> https://lore.kernel.org/linux-s390/0f03ab0b-2dfd-e1c1-fe43-be2a59030a71@linux.ibm.com/
> 
> I also see in this thread:
> 
> https://lore.kernel.org/linux-s390/20210721164550.5402fe1c.pasic@linux.ibm.com/
> 
> that Halil's concern's around open/close races are addressed by Jason's
> device_open/close series that's already in my next branch and he
> provided an Ack, but there's still the above question regarding the
> kvm->lock that was looking for a review from... I'm not sure, maybe
> Connie or Paolo.  Christian, is this specifically what you're ack'ing?

My understanding was that Halil was ok in the end?
I will do a review myself then if that helps.
> 
> It can ultimately go in through my tree, but not being familiar with
> this code I'd hope for more closure.  Thanks,
> 
> Alex
> 
