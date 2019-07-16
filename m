Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:36299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPUOL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jul 2019 16:14:11 -0400
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
 <20190716130631.tohj4ub54md25dys@brauner.io>
 <20190716185310.GA12537@t470p.stackframe.org>
 <20190716185554.gwpppirvmxgvnkgb@brauner.io>
From: Helge Deller <deller@gmx.de>
Message-ID: <6d47935e-218c-3eb9-7617-14ce199f5958@gmx.de>
Date: Tue, 16 Jul 2019 22:13:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190716185554.gwpppirvmxgvnkgb@brauner.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>, Sven Schnelle <svens@stackframe.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, mpe@ellerman.id.au

On 16.07.19 20:55, Christian Brauner wrote:
> On Tue, Jul 16, 2019 at 08:53:10PM +0200, Sven Schnelle wrote:
>> Hi,
>>
>> [Adding Helge to CC list]
>>
>> On Tue, Jul 16, 2019 at 03:06:33PM +0200, Christian Brauner wrote:
>>> On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
>>>> I think Vasily already has a clone3 patch for s390x with 435.
>>>
>>> A quick follow-up on this. Helge and Michael have asked whether there
>>> are any tests for clone3. Yes, there will be and I try to have them
>>> ready by the end of the this or next week for review. In the meantime =
I
>>> hope the following minimalistic test program that just verifies very
>>> very basic functionality (It's not pretty.) will help you test:
>>> [..]
>>
>> On PA-RISC this seems to work fine with Helge's patch to wire up the
>> clone3 syscall.
>
> [...]
> In any case, I saw Helge's patch and I think I might've missed to add an
> Acked-by but feel free to add it.

Thanks!
I've added the patch to the parisc-linux for-next tree.

Helge
