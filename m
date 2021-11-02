Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2123C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  2 Nov 2021 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A8661050
	for <linux-s390@archiver.kernel.org>; Tue,  2 Nov 2021 09:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhKBJFu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 2 Nov 2021 05:05:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230281AbhKBJFu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Nov 2021 05:05:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A27uQLa028146;
        Tue, 2 Nov 2021 09:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Jw2cXUZ9zv3SlIsqotu5O/HD+9AGrqggC7CAUEDAka8=;
 b=MDmlzXbX9d+NCNXY8wYN4P9xQZxf1hcMHWOmJf42PuVabWPAIwYvXK5kka7UMU5JAxSk
 wVtRAzwiDyGa2prcAMR835L5EJCiKKoNW7pjRKqLE6OLyfdGise61gt9gyg+JmnGOJ9y
 ZTyvFjK+n0il6ICyzzRyK5u5vY1SQchzNPFy/S3fZ1UQ0Ud3XQ0W/uzpWFvZn/Tp3V0m
 9It1rIXZHdI6RsVpNzE/O3K84CmleXJf88qT3PJhmjuy5VytW/vv2cHrVagcfSadhRp4
 bMTQ5fnpEiUIScFmIqiF0NcFilfGH977r4hQd2sFtvoXlczwWfZ2iQSvC9P0HuMn0vHX Vw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c2qy7m1u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 09:03:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A28wirF013073;
        Tue, 2 Nov 2021 09:03:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3c0wpb041k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 09:03:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A2938vP12714360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Nov 2021 09:03:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD8A8AE05A;
        Tue,  2 Nov 2021 09:03:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D71BAE056;
        Tue,  2 Nov 2021 09:03:07 +0000 (GMT)
Received: from [9.171.61.66] (unknown [9.171.61.66])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Nov 2021 09:03:07 +0000 (GMT)
Message-ID: <e39c57e1-2a2e-5ab3-c967-c5881558e04c@linux.ibm.com>
Date:   Tue, 2 Nov 2021 10:03:06 +0100
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
From:   Julian Wiedmann <jwi@linux.ibm.com>
In-Reply-To: <0869a8d7-3b15-bad0-f42e-915b28730c7b@itzbund.de>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EPy7AXtx9HAxweFuIApO1zuDjh2bEjHz
X-Proofpoint-ORIG-GUID: EPy7AXtx9HAxweFuIApO1zuDjh2bEjHz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_06,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020054
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29.10.21 15:52, Martin Grimm wrote:
> Hi,
> 
> I'm a collegue of Waldemar and I'd like to respond on his behalf.
> 
> Am 29.10.21 um 13:05 schrieb Julian Wiedmann:
>> On 28.10.21 19:28, Waldemar Brodkorb wrote:
>>> Hi,
>>>
>>> we use z/VM's Live Guest Relocation for our Debian/GNU Linux
>>> servers. Since following commit this is broken:
>>>
>>> d4560150cb47daba50b0d080550ca4bbe80cf3c3 is the first bad commit
>>> commit d4560150cb47daba50b0d080550ca4bbe80cf3c3
>>> Author: Julian Wiedmann <jwi@linux.ibm.com>
>>> Date:   Thu Feb 28 18:59:39 2019 +0100
>>>
>>>       s390/qeth: call dev_close() during recovery
>>>
>>>
>>> With Debian/buster and Linux 4.18.x this works fine.
>>> With Debian/bullseye and Linux 5.10.x this does not work anymore.
>>> The reason for that is that all configured routes are lost after
>>> relocating the guest.
>>> This looks to me like a major regression.
>>>
>>> The network is configured via /etc/network/interfaces and executing
>>> systemctl restart networking fixes the issue. This can be done via a
>>> udev rule, but this looks like a rather incomplete workaround to us.
>>>
>>
>> Can you show an example of how your /etc/network/interfaces configures
>> the routes? A quick search [1] points to using 'post-up' statements,
>> is that what you're using or have you tried that already?
>>
>>
>> [1] https://unix.stackexchange.com/questions/321687/what-is-the-best-way-to-add-a-permanent-route
>>
> 
> Yes, we use "up ip route add ..." commands to set static routes.
> 

Ok, I trust you are debugging why that doesn't work then ...?

> 
>>> All manually added routing information will be lost anyway.
>>>
>>> And I might not imagine what happens to any firewall connection
>>> tables or ipvs connection tracking information in case of a Live
>>> Guest Relocation.
>>>
>>> So is there any kernel level solution for this you can think of?
>>>
>>
>> As discussed off-list, a plain "ip link set dev eth0 down" gives you
>> the same result. Hence I would recommend to improve your configuration,
>> so that the needed routes are restored when the interface comes up
>> again.
>>
> 
> I'd like to disagree. From my point of view the state after a "real"
> device outage is irrelevant regarding "Live Guest Relocation".
> 
> LGR is meant to provide seamless migration of zLinux guests from
> one z/VM to the other during production workloads.
> So the linux guest has to be in exactly the same state after migration
> to the new z/VM as it was before. That also includes IMHO dynamic
> routes added e.g. by a service like keepalived or even by hand.
> 

Sorry, unfortunately that doesn't match up with reality. LGR still requires
a full re-establish of the HW context (ie. you're losing whatever packets
are in the RX and TX queues at that moment), and then needs activity by the
Linux network core to establish itself in the new network environment.

Bypassing the corresponding NETDEV_UP event etc (as the old code did) means
that we eg. don't get fresh GARPs, and traffic is then forwarded to stale
switch ports.

So no, we can't go back to the mode of doing things behind the network
stack's back. It sort-of worked for a while, but we reached its limits.

> Before Kernel v5 this was the observed behavior.
> 
> Starting with Kernel v5 LGR now triggers a network outage that makes
> it unusable for many kinds of production systems.
> Before version 5 there where device failure and recovery messages
> in the kernel log but the network configuration stayed intact.
> 
> Just to be sure I compared this with the behavior of VMWare Live Migration
> and there all dynamic routes stay in place as it was with LGR
> before Kernel v5. Not a single error message in kernel log there.
> 
> So if the new behavior is correct for a real device outage, maybe LGR
> should be handled differently?
> 
>>> Thanks for any advice and comments,
>>>
>>> best regards
>>>   Waldemar
>>>
>>
> 
> Greetings
> Martin

