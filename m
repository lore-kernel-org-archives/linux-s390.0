Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3202 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727571AbgLGQ5u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 11:57:50 -0500
Subject: Re: [PATCH net-next 0/6] s390/qeth: updates 2020-12-07
References: <20201207131233.90383-1-jwi@linux.ibm.com>
 <20201207.065713.357907127824978080.davem@davemloft.net>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <655a8aca-182b-1813-8293-b7e6be02ac09@linux.ibm.com>
Date: Mon, 7 Dec 2020 17:56:58 +0100
MIME-Version: 1.0
In-Reply-To: <20201207.065713.357907127824978080.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com

On 07.12.20 16:57, David Miller wrote:
> From: Julian Wiedmann <jwi@linux.ibm.com>
> Date: Mon,  7 Dec 2020 14:12:27 +0100
> 
>> Hi Jakub,
>>
>> please apply the following patch series for qeth to netdev's net-next tree.
>>
>> Some sysfs cleanups (with the prep work in ccwgroup acked by Heiko), and
>> a few improvements to the code that deals with async TX completion
>> notifications for IQD devices.
>>
>> This also brings the missing patch from the previous net-next submission.
> 
> Series applied, thanks Julian!
> 

Oh hey Dave, you're back on board? Excellent, glad to see you are feeling better!
