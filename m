Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F11EC433F5
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 10:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718F9610A8
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 10:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhKEKvO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Nov 2021 06:51:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231341AbhKEKvN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Nov 2021 06:51:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A58Ci13017548;
        Fri, 5 Nov 2021 10:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YswT44oYLJ1/YWPku653gcH5Xu3poC4JGNqXkOaeKlQ=;
 b=n8jauLuUDiVdlUeGN1zQ7G15jLnarnMU4JP5sKRsSIccm5XojEpSvQgtyidXv6Z7kAN8
 dCOTA2KBVrVVjyvYObHtBZwWlOxq9NhZsdeMEIPlRFPmrwRTCkFxVp1XFUhYVN+nSm57
 1l/pLFCWiorQe74SlRv0pDwXz3AWV3m//HULOY8yfG8tyaWZ8GuqhDShNmTtrsYpLfPK
 r1djwo9ol/OKOYjUFP2gtDtd5fAVHUMeN7xCngO3pznRDAm9iiwFd15h+NpiFK1xceul
 pr7o3sEPlq0jRDnGoP54/yQCUHb2O2DOttAf08DePV8VMadKmxL9283p0cQzOtqLTcID 8g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c4xuhw0pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 10:48:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A5AmE9j012139;
        Fri, 5 Nov 2021 10:48:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3c4t4tba6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 10:48:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A5AmOw259506958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Nov 2021 10:48:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4925E4C05C;
        Fri,  5 Nov 2021 10:48:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D26E24C04E;
        Fri,  5 Nov 2021 10:48:23 +0000 (GMT)
Received: from [9.171.36.217] (unknown [9.171.36.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Nov 2021 10:48:23 +0000 (GMT)
Message-ID: <9784062e-df82-c6f0-28a2-6bdb2ea9d874@linux.ibm.com>
Date:   Fri, 5 Nov 2021 11:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: REGRESSION: relocating a Debian/bullseye guest is losing network
 connection
Content-Language: en-US
To:     Martin Grimm <extern.martin.grimm@itzbund.de>,
        Waldemar Brodkorb <mail@waldemar-brodkorb.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>
References: <YXrdxGTkjLhj/2KA@waldemar-brodkorb.de>
 <933ba5bc-a3eb-a67b-26a0-ab19a0ec787c@linux.ibm.com>
 <0869a8d7-3b15-bad0-f42e-915b28730c7b@itzbund.de>
 <e39c57e1-2a2e-5ab3-c967-c5881558e04c@linux.ibm.com>
 <d53cc12a-a824-d2e7-2b41-5787c0600013@itzbund.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
In-Reply-To: <d53cc12a-a824-d2e7-2b41-5787c0600013@itzbund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5E5n2Ypt_lFNOt3Mp5wWRMS7NevvE3fy
X-Proofpoint-ORIG-GUID: 5E5n2Ypt_lFNOt3Mp5wWRMS7NevvE3fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050062
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04.11.21 12:53, Martin Grimm wrote:
> Am 02.11.21 um 10:03 schrieb Julian Wiedmann:
>> On 29.10.21 15:52, Martin Grimm wrote:
>>> Hi,
>>>
>>> I'm a collegue of Waldemar and I'd like to respond on his behalf.
>>>

[...]

>>>>> All manually added routing information will be lost anyway.
>>>>>
>>>>> And I might not imagine what happens to any firewall connection
>>>>> tables or ipvs connection tracking information in case of a Live
>>>>> Guest Relocation.
>>>>>
>>>>> So is there any kernel level solution for this you can think of?
>>>>>
>>>>
>>>> As discussed off-list, a plain "ip link set dev eth0 down" gives you
>>>> the same result. Hence I would recommend to improve your configuration,
>>>> so that the needed routes are restored when the interface comes up
>>>> again.
>>>>
> Your proposed test with "ip link set dev eth0 down && ip link set dev eth0 up"
> also kills all static routing information on a regular setup RHEL 7.9 system.
> So maybe it shouldn't be taken for granted that server systems with static
> network configuration recover from such outages automatically.
> 

It's taken for granted in a sense that even old code was calling dev_close()
when setting the device offline (ie. 0 > /sys/devices/qeth/x.x.xxxx/offline)
for certain config changes.

So the implicit need to preserve such user-side config was there, even when
you didn't encounter it previously.

>>>
>>> I'd like to disagree. From my point of view the state after a "real"
>>> device outage is irrelevant regarding "Live Guest Relocation".
>>>
>>> LGR is meant to provide seamless migration of zLinux guests from
>>> one z/VM to the other during production workloads.
>>> So the linux guest has to be in exactly the same state after migration
>>> to the new z/VM as it was before. That also includes IMHO dynamic
>>> routes added e.g. by a service like keepalived or even by hand.
>>>
>>
>> Sorry, unfortunately that doesn't match up with reality. LGR still requires
>> a full re-establish of the HW context (ie. you're losing whatever packets
>> are in the RX and TX queues at that moment), and then needs activity by the
>> Linux network core to establish itself in the new network environment.
>>
>> Bypassing the corresponding NETDEV_UP event etc (as the old code did) means
>> that we eg. don't get fresh GARPs, and traffic is then forwarded to stale
>> switch ports.
>>
>> So no, we can't go back to the mode of doing things behind the network
>> stack's back. It sort-of worked for a while, but we reached its limits.
>>
> 
> Sorry to hear that :-(
> For us as customers (our POV) that means LGR that worked for years without
> any noticable problem for hundreds of linux guests with thousands of successful
> relocations isn't usable anymore or only with great care.

I wouldn't want to fully demotivate you. If there are ways to bypass such a "fake"
admin-down via dev_close() but still
1. close & open the device in a sane manner so that all the relevant driver-level
   callbacks are fenced off, and
2. have the network code do all the necessary work on stop & open to harmonize us
   with a potentially new network environment, stacked devices etc
   (based on eg. linkwatch's NETDEV_CHANGE, netdev_state_change(),
   netdev_notify_peers(), ...)

then I'd consider that a very viable solution. What we _can't_ do is re-implement
that logic in the driver itself, and then just pray that we stay current with all
subsequent changes in the stack's behaviour.

> But perhaps this mailing list is not the right audience for customer problems
> and we should address this via a PMR to focus on the interaction between z/VM
> and Linux.
> 
>>> Before Kernel v5 this was the observed behavior.
>>>
>>> Starting with Kernel v5 LGR now triggers a network outage that makes
>>> it unusable for many kinds of production systems.
>>> Before version 5 there where device failure and recovery messages
>>> in the kernel log but the network configuration stayed intact.
>>>
>>> Just to be sure I compared this with the behavior of VMWare Live Migration
>>> and there all dynamic routes stay in place as it was with LGR
>>> before Kernel v5. Not a single error message in kernel log there.
>>>
>>> So if the new behavior is correct for a real device outage, maybe LGR
>>> should be handled differently?
>>>
>>>>> Thanks for any advice and comments,
>>>>>
>>>>> best regards
>>>>>    Waldemar
>>>>>
>>>>
>>>
>>> Greetings
>>> Martin
>>
> 

