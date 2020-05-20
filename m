Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbgETHOc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 May 2020 03:14:32 -0400
Subject: Re: [PATCH] s390/sclp_vt220: Fix console name to match device
References: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
 <65218cdb-d03f-29a8-1e78-42ff2d4f958d@de.ibm.com>
 <20200520070743.GO4974@valentin-vidic.from.hr>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <cba24059-b3a5-1587-c1f3-8d7dfd0807f5@de.ibm.com>
Date: Wed, 20 May 2020 09:14:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200520070743.GO4974@valentin-vidic.from.hr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: =?UTF-8?Q?Valentin_Vidi=c4=87?= <vvidic@valentin-vidic.from.hr>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org



On 20.05.20 09:07, Valentin Vidić wrote:
> On Wed, May 20, 2020 at 07:25:06AM +0200, Christian Borntraeger wrote:
>> This is not as simple. ttyS1 is the the console name and ttysclp0 is the tty name.
>> This has mostly historic reasons and it obviously causes problems.
>> But there is  documentation out that that actually describes the use of 
>> console=ttyS1 console=ttyS0.
>> to have console output on both sclp consoles and there are probably scripts
>> using ttyS1.
>>
>> I am wondering. The tty for ttyS0 is named sclp_line0. Does this work in LPAR?
> 
> I ran into this problem with qemu-system-s390x, so not sure about LPAR.
> Would changing the tty name also cause problems?

My point was more that a similar issue should happen when installing in LPAR. LPAR
uses the line mode style console which is ttyS0 for the console but sclp_line0 for the
tty. How does the debian installer handle this?

Regarding your patch I fear that this patch would break existing setups so we cannot
use it as is.
