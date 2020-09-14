Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64210 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgINHgQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 03:36:16 -0400
Subject: Re: [PATCH] s390/zcrypt: remove set_fs() invocation in zcrypt device
 driver
References: <20200910102838.28887-1-freude@linux.ibm.com>
 <20200911062134.GB21597@lst.de>
From: Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
Date: Mon, 14 Sep 2020 09:36:07 +0200
MIME-Version: 1.0
In-Reply-To: <20200911062134.GB21597@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 11.09.20 08:21, Christoph Hellwig wrote:
> On Thu, Sep 10, 2020 at 12:28:38PM +0200, Harald Freudenberger wrote:
>> +static inline unsigned long z_copy_from_user(bool userspace,
>> +					     void *to, const void __user *from, unsigned long n)
> Can you avoid the pointless long lines in the function declaration?
Yes, will do.
>
>> +{
>> +	if (likely(userspace))
>> +		return copy_from_user(to, from, n);
>> +	memcpy(to, (void __force *) from, n);
>> +	return 0;
>> +}
>> +
>> +static inline unsigned long z_copy_to_user(bool userspace,
>> +					   void __user *to, const void *from, unsigned long n)
>> +{
>> +	if (likely(userspace))
>> +		return copy_to_user(to, from, n);
>> +	memcpy((void __force *) to, from, n);
>> +	return 0;
> Otherwise this doesn't look great, but also not horrible and gets rid
> of the set_fs while reducing the lines of code, so:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Christoph, maybe you have a greater idea on how to solve this. So don't hesitate and tell me.
Otherwise how to we provide this fix then ? My recommendation would be to go the 'usual' way:
Commit this s390 internal and then let this go out with the next kernel merge window when
next time Linus is pulling patches from the s390 subsystem for the 5.10 kernel development cycle.
