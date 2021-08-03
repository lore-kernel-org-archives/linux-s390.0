Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D9EC4338F
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 13:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A316160F45
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 13:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhHCNe1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:34:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235954AbhHCNeT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Aug 2021 09:34:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173DY390012767;
        Tue, 3 Aug 2021 09:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+fVqFRShJsHXkqXZoDfljmB96G/QkN7VqFsptjZbSDE=;
 b=VKx93cFxlF4vr3lDlwDbf/6/tEhY5XW8n4DBGKTnX9OFJxp/ovOaGZVC0tf3HOp489dV
 Wg/19EpjPazYupbY8lQ9ecdu4mHVOFgVsUKKvkUHrO4Oh9WEE8TmUy4Q7VFVd7fWBOP8
 Qq5x873xXdqweXMV9+4QAb798smMRJ3NTTSwSOwRUkAigDeNeWptyca3rjfWgKete5Pr
 Lhbq+rmM+T7MfC2iMo5eekf4q8JBzMtzWlSyfYFvuOz+yFMpkqIHl7qd2i1Y5awcejGA
 woeQk0rBE8kauFJqqgm9mkgLY3ZM1o8taczrVdjlAR3tgqHg7q/Bdve8ycm87CwjD7Pa uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76r585dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 09:34:06 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 173DY6dS013162;
        Tue, 3 Aug 2021 09:34:06 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76r585ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 09:34:06 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173DNbgm016921;
        Tue, 3 Aug 2021 13:34:05 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3a4x5dgufn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 13:34:05 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173DY3Xw30605812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 13:34:03 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B59F128066;
        Tue,  3 Aug 2021 13:34:03 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0173528064;
        Tue,  3 Aug 2021 13:34:02 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.77.143.250])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 13:34:02 +0000 (GMT)
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
 <20210802155355.22b98789.pasic@linux.ibm.com>
 <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
 <20210803130850.GY1721383@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <b7272d7a-851f-aefd-cdda-be061d4e309a@linux.ibm.com>
Date:   Tue, 3 Aug 2021 09:34:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210803130850.GY1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r_5aO6olQWMv2JOtc0WLbfcaKqpXPqvN
X-Proofpoint-ORIG-GUID: TX9jkR3bp1tUHh4rIZ_FpD7vCfL5xaxy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_03:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030090
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 8/3/21 9:08 AM, Jason Gunthorpe wrote:
> On Mon, Aug 02, 2021 at 12:32:12PM -0400, Tony Krowiak wrote:
>> On 8/2/21 9:53 AM, Halil Pasic wrote:
>>> On Mon, 2 Aug 2021 09:10:26 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>
>>>> PING!
>>>>
>>>> This patch will pre-req version 17 of a patch series I have waiting in
>>>> the wings,
>>>> so I'd like to get this one merged ASAP. In particular, if a KVM
>>>> maintainer can
>>>> take a look at the comments concerning the taking of the kvm->lock
>>>> before the
>>>> matrix_mdev->lock it would be greatly appreciated. Those comments begin with
>>>> Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.
>>> As far as I'm concerned, we can move forward with this. Was this
>>> supposed to go in via Alex's tree?
>> I am not certain, Christian queued the previous patches related to
>> this on:
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
>>
>> Jason G., since this will need to be integrated with your other patches,
>> where should this be queued?
> I prefer changes to the vfio stuff go to Alex as we are changing it a
> lot as well this cycle.

Thanks Jason.

>
> Jason

