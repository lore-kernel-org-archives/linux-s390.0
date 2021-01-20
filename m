Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390678AbhATOkC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 09:40:02 -0500
Subject: Re: [PATCH 2/2] s390: mm: Fix secure storage access exception
 handling
References: <20210119100402.84734-1-frankja@linux.ibm.com>
 <20210119100402.84734-3-frankja@linux.ibm.com>
 <3e1978c6-4462-1de6-e1aa-e664ffa633c1@de.ibm.com>
 <20210120134208.GC8202@osiris>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <221ce6ab-4630-473d-a49f-150ac8c573d6@de.ibm.com>
Date: Wed, 20 Jan 2021 15:39:14 +0100
MIME-Version: 1.0
In-Reply-To: <20210120134208.GC8202@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com



On 20.01.21 14:42, Heiko Carstens wrote:
> On Tue, Jan 19, 2021 at 11:25:01AM +0100, Christian Borntraeger wrote:
>>> +		if (user_mode(regs)) {
>>> +			send_sig(SIGSEGV, current, 0);
>>> +			return;
>>> +		} else
>>> +			panic("Unexpected PGM 0x3d with TEID bit 61=0");
>>
>> use BUG instead of panic? That would kill this process, but it allows
>> people to maybe save unaffected data.
> 
> It would kill the process, and most likely lead to deadlock'ed
> system. But with all the "good" debug information being lost, which
> wouldn't be the case with panic().
> I really don't think this is a good idea.
> 

My understanding is that Linus hates panic for anything that might be able
to continue to run. With BUG the admin can decide via panic_on_oops if
debugging data or runtime data is more important. But mm is more on your
side, so if you insist on panic we can keep it.
