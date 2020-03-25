Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgCYJVC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 05:21:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P93gPW001269
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:21:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywet4nstc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:21:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 25 Mar 2020 09:20:55 -0000
Subject: Re: [PATCH net-next 01/11] s390/qeth: simplify RX buffer tracking
References: <20200324182448.95362-1-jwi@linux.ibm.com>
 <20200324182448.95362-2-jwi@linux.ibm.com>
 <20200324.164326.639594724461733845.davem@davemloft.net>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 25 Mar 2020 10:20:54 +0100
MIME-Version: 1.0
In-Reply-To: <20200324.164326.639594724461733845.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <30d06ab8-ee58-0c58-aab2-f68254d9a232@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

On 25.03.20 00:43, David Miller wrote:
> From: Julian Wiedmann <jwi@linux.ibm.com>
> Date: Tue, 24 Mar 2020 19:24:38 +0100
> 
>> +#define QDIO_ELEMENT_NO(buf, element)	(element - &buf->element[0])
> 
> Maybe this works, but I would strongly suggest against using a CPP
> macro argument that is the same name for the singleton element on
> the left branch of the expression as the struct member name on
> the right side of the element.

Right you are, this would look a lot less fragile with some underscores.

> 
> Furthermore, as far as I can tell this is only used in one location
> in the code, and for such a simple expression that is excessive.
> 

This I flat out disagree with, but it's hardly worth arguing about.
So let me fold that macro back in, and send you a v2.
