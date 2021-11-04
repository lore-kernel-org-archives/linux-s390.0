Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD86C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  4 Nov 2021 11:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19A961186
	for <linux-s390@archiver.kernel.org>; Thu,  4 Nov 2021 11:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhKDL4f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:56:35 -0400
Received: from lxmxblk1.bfinv.de ([80.245.147.36]:42994 "EHLO
        lxmxblk1.bfinv.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhKDL4d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Nov 2021 07:56:33 -0400
X-Virus-Scanned: Debian amavisd-new at itzbund.de
Subject: Re: REGRESSION: relocating a Debian/bullseye guest is losing network
 connection
To:     Julian Wiedmann <jwi@linux.ibm.com>,
        Waldemar Brodkorb <mail@waldemar-brodkorb.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>
References: <YXrdxGTkjLhj/2KA@waldemar-brodkorb.de>
 <933ba5bc-a3eb-a67b-26a0-ab19a0ec787c@linux.ibm.com>
 <0869a8d7-3b15-bad0-f42e-915b28730c7b@itzbund.de>
 <e39c57e1-2a2e-5ab3-c967-c5881558e04c@linux.ibm.com>
From:   Martin Grimm <extern.martin.grimm@itzbund.de>
Organization: ITZBund
Message-ID: <d53cc12a-a824-d2e7-2b41-5787c0600013@itzbund.de>
Date:   Thu, 4 Nov 2021 12:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e39c57e1-2a2e-5ab3-c967-c5881558e04c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 02.11.21 um 10:03 schrieb Julian Wiedmann:
> On 29.10.21 15:52, Martin Grimm wrote:
>> Hi,
>>
>> I'm a collegue of Waldemar and I'd like to respond on his behalf.
>>
>> Am 29.10.21 um 13:05 schrieb Julian Wiedmann:
>>> On 28.10.21 19:28, Waldemar Brodkorb wrote:
>>>> Hi,
>>>>
>>>> we use z/VM's Live Guest Relocation for our Debian/GNU Linux
>>>> servers. Since following commit this is broken:
>>>>
>>>> d4560150cb47daba50b0d080550ca4bbe80cf3c3 is the first bad commit
>>>> commit d4560150cb47daba50b0d080550ca4bbe80cf3c3
>>>> Author: Julian Wiedmann <jwi@linux.ibm.com>
>>>> Date:   Thu Feb 28 18:59:39 2019 +0100
>>>>
>>>>        s390/qeth: call dev_close() during recovery
>>>>
>>>>
>>>> With Debian/buster and Linux 4.18.x this works fine.
>>>> With Debian/bullseye and Linux 5.10.x this does not work anymore.
>>>> The reason for that is that all configured routes are lost after
>>>> relocating the guest.
>>>> This looks to me like a major regression.
>>>>
>>>> The network is configured via /etc/network/interfaces and executing
>>>> systemctl restart networking fixes the issue. This can be done via a
>>>> udev rule, but this looks like a rather incomplete workaround to us.
>>>>
>>>
>>> Can you show an example of how your /etc/network/interfaces configures
>>> the routes? A quick search [1] points to using 'post-up' statements,
>>> is that what you're using or have you tried that already?
>>>
>>>
>>> [1] https://unix.stackexchange.com/questions/321687/what-is-the-best-way-to-add-a-permanent-route
>>>
>>
>> Yes, we use "up ip route add ..." commands to set static routes.
>>
> 
> Ok, I trust you are debugging why that doesn't work then ...?
>

It works as exspected. The routes are set up on device initialization
on boot as IMHO is customary on a static server network setup.
There's no standard mechanism to detect a device change and reinitialize
the interface.
  
>>
>>>> All manually added routing information will be lost anyway.
>>>>
>>>> And I might not imagine what happens to any firewall connection
>>>> tables or ipvs connection tracking information in case of a Live
>>>> Guest Relocation.
>>>>
>>>> So is there any kernel level solution for this you can think of?
>>>>
>>>
>>> As discussed off-list, a plain "ip link set dev eth0 down" gives you
>>> the same result. Hence I would recommend to improve your configuration,
>>> so that the needed routes are restored when the interface comes up
>>> again.
>>>
Your proposed test with "ip link set dev eth0 down && ip link set dev eth0 up"
also kills all static routing information on a regular setup RHEL 7.9 system.
So maybe it shouldn't be taken for granted that server systems with static
network configuration recover from such outages automatically.

>>
>> I'd like to disagree. From my point of view the state after a "real"
>> device outage is irrelevant regarding "Live Guest Relocation".
>>
>> LGR is meant to provide seamless migration of zLinux guests from
>> one z/VM to the other during production workloads.
>> So the linux guest has to be in exactly the same state after migration
>> to the new z/VM as it was before. That also includes IMHO dynamic
>> routes added e.g. by a service like keepalived or even by hand.
>>
> 
> Sorry, unfortunately that doesn't match up with reality. LGR still requires
> a full re-establish of the HW context (ie. you're losing whatever packets
> are in the RX and TX queues at that moment), and then needs activity by the
> Linux network core to establish itself in the new network environment.
> 
> Bypassing the corresponding NETDEV_UP event etc (as the old code did) means
> that we eg. don't get fresh GARPs, and traffic is then forwarded to stale
> switch ports.
> 
> So no, we can't go back to the mode of doing things behind the network
> stack's back. It sort-of worked for a while, but we reached its limits.
> 

Sorry to hear that :-(
For us as customers (our POV) that means LGR that worked for years without
any noticable problem for hundreds of linux guests with thousands of successful
relocations isn't usable anymore or only with great care.
But perhaps this mailing list is not the right audience for customer problems
and we should address this via a PMR to focus on the interaction between z/VM
and Linux.

>> Before Kernel v5 this was the observed behavior.
>>
>> Starting with Kernel v5 LGR now triggers a network outage that makes
>> it unusable for many kinds of production systems.
>> Before version 5 there where device failure and recovery messages
>> in the kernel log but the network configuration stayed intact.
>>
>> Just to be sure I compared this with the behavior of VMWare Live Migration
>> and there all dynamic routes stay in place as it was with LGR
>> before Kernel v5. Not a single error message in kernel log there.
>>
>> So if the new behavior is correct for a real device outage, maybe LGR
>> should be handled differently?
>>
>>>> Thanks for any advice and comments,
>>>>
>>>> best regards
>>>>    Waldemar
>>>>
>>>
>>
>> Greetings
>> Martin
> 

