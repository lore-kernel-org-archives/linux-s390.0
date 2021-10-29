Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF4EC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 14:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAF761175
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 14:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ2OFp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:05:45 -0400
Received: from lxmxblk1.bfinv.de ([80.245.147.36]:52810 "EHLO
        lxmxblk1.bfinv.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhJ2OFo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Oct 2021 10:05:44 -0400
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Oct 2021 10:05:44 EDT
X-Virus-Scanned: Debian amavisd-new at itzbund.de
Subject: Re: REGRESSION: relocating a Debian/bullseye guest is losing network
 connection
To:     Julian Wiedmann <jwi@linux.ibm.com>,
        Waldemar Brodkorb <mail@waldemar-brodkorb.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>
References: <YXrdxGTkjLhj/2KA@waldemar-brodkorb.de>
 <933ba5bc-a3eb-a67b-26a0-ab19a0ec787c@linux.ibm.com>
From:   Martin Grimm <extern.martin.grimm@itzbund.de>
Organization: ITZBund
Message-ID: <0869a8d7-3b15-bad0-f42e-915b28730c7b@itzbund.de>
Date:   Fri, 29 Oct 2021 15:52:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <933ba5bc-a3eb-a67b-26a0-ab19a0ec787c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

I'm a collegue of Waldemar and I'd like to respond on his behalf.

Am 29.10.21 um 13:05 schrieb Julian Wiedmann:
> On 28.10.21 19:28, Waldemar Brodkorb wrote:
>> Hi,
>>
>> we use z/VM's Live Guest Relocation for our Debian/GNU Linux
>> servers. Since following commit this is broken:
>>
>> d4560150cb47daba50b0d080550ca4bbe80cf3c3 is the first bad commit
>> commit d4560150cb47daba50b0d080550ca4bbe80cf3c3
>> Author: Julian Wiedmann <jwi@linux.ibm.com>
>> Date:   Thu Feb 28 18:59:39 2019 +0100
>>
>>       s390/qeth: call dev_close() during recovery
>>
>>
>> With Debian/buster and Linux 4.18.x this works fine.
>> With Debian/bullseye and Linux 5.10.x this does not work anymore.
>> The reason for that is that all configured routes are lost after
>> relocating the guest.
>> This looks to me like a major regression.
>>
>> The network is configured via /etc/network/interfaces and executing
>> systemctl restart networking fixes the issue. This can be done via a
>> udev rule, but this looks like a rather incomplete workaround to us.
>>
> 
> Can you show an example of how your /etc/network/interfaces configures
> the routes? A quick search [1] points to using 'post-up' statements,
> is that what you're using or have you tried that already?
> 
> 
> [1] https://unix.stackexchange.com/questions/321687/what-is-the-best-way-to-add-a-permanent-route
> 

Yes, we use "up ip route add ..." commands to set static routes.


>> All manually added routing information will be lost anyway.
>>
>> And I might not imagine what happens to any firewall connection
>> tables or ipvs connection tracking information in case of a Live
>> Guest Relocation.
>>
>> So is there any kernel level solution for this you can think of?
>>
> 
> As discussed off-list, a plain "ip link set dev eth0 down" gives you
> the same result. Hence I would recommend to improve your configuration,
> so that the needed routes are restored when the interface comes up
> again.
> 

I'd like to disagree. From my point of view the state after a "real"
device outage is irrelevant regarding "Live Guest Relocation".

LGR is meant to provide seamless migration of zLinux guests from
one z/VM to the other during production workloads.
So the linux guest has to be in exactly the same state after migration
to the new z/VM as it was before. That also includes IMHO dynamic
routes added e.g. by a service like keepalived or even by hand.

Before Kernel v5 this was the observed behavior.

Starting with Kernel v5 LGR now triggers a network outage that makes
it unusable for many kinds of production systems.
Before version 5 there where device failure and recovery messages
in the kernel log but the network configuration stayed intact.

Just to be sure I compared this with the behavior of VMWare Live Migration
and there all dynamic routes stay in place as it was with LGR
before Kernel v5. Not a single error message in kernel log there.

So if the new behavior is correct for a real device outage, maybe LGR
should be handled differently?

>> Thanks for any advice and comments,
>>
>> best regards
>>   Waldemar
>>
> 

Greetings
Martin
