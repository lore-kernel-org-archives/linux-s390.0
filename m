Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: s390 qemu boot failure in -next
References: <20180622194736.GA5794@roeck-us.net>
 <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
 <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
 <20180625100548.64222dad.cohuck@redhat.com>
 <d56829a3-fecf-b812-d002-8ee22ae08da2@de.ibm.com>
 <20180626102954.73965b42.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Jun 2018 10:54:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180626102954.73965b42.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <8617698e-0d1a-15d8-7e6d-e63408857b1c@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 06/26/2018 10:29 AM, Cornelia Huck wrote:
[...]
>>>>  
>>>>          if (ipl->initrd) {
>>>>              ram_addr_t initrd_offset;
>>>>
>>>> would put the command line in no matter what the start address is.  
>>>
>>> I'm for putting that one in (and backporting it to qemu-stable). It's a
>>> bit worrying, though, that our ipl code is so fragile...  
>>
>> We actually have to combine this with Thomas fix (to check for rom_ptr returning
>> something sane). It seems that ipl->commandline is always there, so we have to
>> check for strlen!=0 it seems..
>>
>> I mean if somebody ask for "-append something" we can certainly always write something
>> if there is rom/ram.
> 
> Given that the uncompressed image is not supposed to be bootable
> anymore, does it make sense to add this anyway?

I think we can drop this patch for now.

> 
> I'll go ahead and queue Thomas' fix, though.

yes, please
