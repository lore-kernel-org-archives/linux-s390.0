Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: s390 qemu boot failure in -next
References: <20180622194736.GA5794@roeck-us.net>
 <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
 <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
 <20180626053246.6kyvrj7jbuhgdkgv@sivokote.iziade.m$>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f6c25172-573e-a7d2-8264-f44f0a5a0a27@redhat.com>
Date: Tue, 26 Jun 2018 07:40:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180626053246.6kyvrj7jbuhgdkgv@sivokote.iziade.m$>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Georgi Guninski <guninski@guninski.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 26.06.2018 07:32, Georgi Guninski wrote:
> On Mon, Jun 25, 2018 at 09:27:59AM +0200, Christian Borntraeger wrote:
>> -            /* Overwrite parameters in the kernel image, which are "rom" */
>> -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> 
>> +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> 
> Why not replace strcpy() with strncpy() or snprintf()?
> strcpy() may overflow.

This will be fixed by
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04227.html by
adding a check for a valid size.

 Thomas
