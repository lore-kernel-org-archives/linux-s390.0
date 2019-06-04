Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726844AbfFDIEH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 04:04:07 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54829x4061002
        for <linux-s390@vger.kernel.org>; Tue, 4 Jun 2019 04:04:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2swjgnwtyu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Jun 2019 04:04:05 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 4 Jun 2019 09:04:04 +0100
Subject: Re: [PATCH net 2/4] s390/qeth: don't use obsolete dst entry
References: <20190603150446.23351-1-jwi@linux.ibm.com>
 <20190603150446.23351-3-jwi@linux.ibm.com>
 <20190603.124348.5212561789204100.davem@davemloft.net>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Tue, 4 Jun 2019 10:03:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190603.124348.5212561789204100.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <06972ee2-43ac-045f-8d7e-568752908ecd@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On 03.06.19 21:43, David Miller wrote:
> From: Julian Wiedmann <jwi@linux.ibm.com>
> Date: Mon,  3 Jun 2019 17:04:44 +0200
> 
>> While qeth_l3 uses netif_keep_dst() to hold onto the dst, a skb's dst
>> may still have been obsoleted (via dst_dev_put()) by the time that we
>> end up using it. The dst then points to the loopback interface, which
>> means the neighbour lookup in qeth_l3_get_cast_type() determines a bogus
>> cast type of RTN_BROADCAST.
>> For IQD interfaces this causes us to place such skbs on the wrong
>> HW queue, resulting in TX errors.
>>
>> Fix-up the various call sites to check whether the dst is obsolete, and
>> fall back accordingly.
>>
>> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> 
> Please use "dst_check()".
> 
> Some routes have DST_OBSOLETE_FORCE_CHK set on them from the very beginning
> so that uses of the route are forced through the dst->ops->check() method.
> 
> Simply use dst_check() and then you can just retain the 'rt == NULL' logic
> as-is.
> 
> Thanks.
> 
Alright - I was hesitant to go down that path in the context of a driver,
but looks like rt6_get_cookie() should do the trick. v2 coming up... thanks.
