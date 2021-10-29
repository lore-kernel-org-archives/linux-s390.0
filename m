Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A51FC433F5
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 11:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D6F6112F
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 11:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhJ2LIN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Oct 2021 07:08:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231740AbhJ2LIM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Oct 2021 07:08:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19T8mRLS002075;
        Fri, 29 Oct 2021 11:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oYBWQwG/rpXwBWgVEQfjStW37AVEiBJi97uq/G7cS7s=;
 b=UuUeU/ul2PCgZDL8hum4TbIjrzcklbGbeVvfIs4k0SyptQqXTr/nxX0iAnO2fMn0hDc9
 Q07aAo9OwHguysKIUS6c8Wr9K4kk9pn56k3arCqwM6bit1CTTeBuK8spSyVz/kcQqred
 gwNes+XWMM5jbZDzBEawLy5Ek06cmyTUyYItVOIxvbQT7z3CNiVMjYDQ8UMO1av2McCM
 jdMC4ru2hXrtnwdElba2bgbXreKKmC/6UCvaonsqZmIzHJ8vDtTKL6yE83skRS4Xl7Sz
 emISXd9BIuyiq0RFM0+L00g8VgGv9SfT8o5qP0B9KvaBzvSPoTohp4Mu5IEwArVDZLs4 zQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c0ds62jtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 11:05:43 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19TB2VJq025029;
        Fri, 29 Oct 2021 11:05:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3bx4eqgf68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 11:05:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19TB5btd54329662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 11:05:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0C1EAE068;
        Fri, 29 Oct 2021 11:05:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 844D2AE073;
        Fri, 29 Oct 2021 11:05:37 +0000 (GMT)
Received: from [9.171.84.87] (unknown [9.171.84.87])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Oct 2021 11:05:37 +0000 (GMT)
Message-ID: <933ba5bc-a3eb-a67b-26a0-ab19a0ec787c@linux.ibm.com>
Date:   Fri, 29 Oct 2021 13:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: REGRESSION: relocating a Debian/bullseye guest is losing network
 connection
Content-Language: en-US
To:     Waldemar Brodkorb <mail@waldemar-brodkorb.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>
References: <YXrdxGTkjLhj/2KA@waldemar-brodkorb.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
In-Reply-To: <YXrdxGTkjLhj/2KA@waldemar-brodkorb.de>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -MSWXs0fnqt3xAuTWZTH98_CCaeZ7c0O
X-Proofpoint-ORIG-GUID: -MSWXs0fnqt3xAuTWZTH98_CCaeZ7c0O
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_02,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290063
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28.10.21 19:28, Waldemar Brodkorb wrote:
> Hi,
> 
> we use z/VM's Live Guest Relocation for our Debian/GNU Linux
> servers. Since following commit this is broken:
> 
> d4560150cb47daba50b0d080550ca4bbe80cf3c3 is the first bad commit
> commit d4560150cb47daba50b0d080550ca4bbe80cf3c3
> Author: Julian Wiedmann <jwi@linux.ibm.com>
> Date:   Thu Feb 28 18:59:39 2019 +0100
> 
>      s390/qeth: call dev_close() during recovery
> 
> 
> With Debian/buster and Linux 4.18.x this works fine.
> With Debian/bullseye and Linux 5.10.x this does not work anymore.
> The reason for that is that all configured routes are lost after
> relocating the guest.
> This looks to me like a major regression.
> 
> The network is configured via /etc/network/interfaces and executing
> systemctl restart networking fixes the issue. This can be done via a 
> udev rule, but this looks like a rather incomplete workaround to us.
> 

Can you show an example of how your /etc/network/interfaces configures
the routes? A quick search [1] points to using 'post-up' statements,
is that what you're using or have you tried that already?


[1] https://unix.stackexchange.com/questions/321687/what-is-the-best-way-to-add-a-permanent-route

> All manually added routing information will be lost anyway.
> 
> And I might not imagine what happens to any firewall connection
> tables or ipvs connection tracking information in case of a Live
> Guest Relocation.
> 
> So is there any kernel level solution for this you can think of?
> 

As discussed off-list, a plain "ip link set dev eth0 down" gives you
the same result. Hence I would recommend to improve your configuration,
so that the needed routes are restored when the interface comes up
again.

> Thanks for any advice and comments,
> 
> best regards
>  Waldemar
> 

