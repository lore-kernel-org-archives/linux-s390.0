Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbgEKU2Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 May 2020 16:28:16 -0400
Subject: Re: [PATCH -next] s390: Remove two unused inline functions
References: <20200508140724.11324-1-yuehaibing@huawei.com>
 <20200511060750.GA93884@tuxmaker.boeblingen.de.ibm.com>
 <20200511161756.7586afe6@gandalf.local.home>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <cf344230-27b1-7302-36bb-55c25c6b5de4@de.ibm.com>
Date: Mon, 11 May 2020 22:27:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200511161756.7586afe6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>
Cc: YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 11.05.20 22:17, Steven Rostedt wrote:
> On Mon, 11 May 2020 08:07:51 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
> 
>> Thanks for noticing, looks like i missed them.
>>
>> Acked-by: Sven Schnelle <svens@linux.ibm.com>
> 
> As this is s390 specific, will it be going through the s390 repo?

Yes. 
I will pick this up. Vasily will then take care of it.
