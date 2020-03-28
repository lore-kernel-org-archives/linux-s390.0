Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgC1KeP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Mar 2020 06:34:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02SAWMQK056763
        for <linux-s390@vger.kernel.org>; Sat, 28 Mar 2020 06:34:14 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3022jsadf8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 28 Mar 2020 06:34:14 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Sat, 28 Mar 2020 10:34:04 -0000
Subject: Re: [PATCH net] s390/qeth: support net namespaces for L3 devices
References: <20200327110042.50797-1-jwi@linux.ibm.com>
 <20200327.153902.1896503128370913021.davem@davemloft.net>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Sat, 28 Mar 2020 11:34:07 +0100
MIME-Version: 1.0
In-Reply-To: <20200327.153902.1896503128370913021.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f0db28f1-d1a2-7173-1ac7-123f514768b1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

On 27.03.20 23:39, David Miller wrote:
> From: Julian Wiedmann <jwi@linux.ibm.com>
> Date: Fri, 27 Mar 2020 12:00:42 +0100
> 
>> Enable the L3 driver's IPv4 address notifier to watch for events on qeth
>> devices that have been moved into a net namespace. We need to program
>> those IPs into the HW just as usual, otherwise inbound traffic won't
>> flow.
>>
>> Fixes: 6133fb1aa137 ("[NETNS]: Disable inetaddr notifiers in namespaces other than initial.")
>> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> 
> This looks more like a feature, openning the L3 driver into multiple
> namespaces, rather than a critical fix.
> 

Definitely not 'critical', agreed. It's rather silly though that things
currently work just fine for IPv6, but not for IPv4.

Mind queueing this up for net-next then instead? Thanks.
