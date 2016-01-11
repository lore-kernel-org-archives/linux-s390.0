Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: s390 cross-compiling code coverage
References: <569404BB.1010008@hurleysoftware.com>
 <20160111204112.GA4260@roeck-us.net>
From: Peter Hurley <peter@hurleysoftware.com>
Message-ID: <56941554.9050100@hurleysoftware.com>
Date: Mon, 11 Jan 2016 12:49:24 -0800
MIME-Version: 1.0
In-Reply-To: <20160111204112.GA4260@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 01/11/2016 12:41 PM, Guenter Roeck wrote:
> On Mon, Jan 11, 2016 at 11:38:35AM -0800, Peter Hurley wrote:
>> Occasionally, it's necessary to touch s390 code because of changes
>> within a subsystem, such as tty/serial.
>>
>> Since changing the configs to the zEC12 march, the gcc 4.6.3 s390
>> cross-compiler hosted at kernel.org/pub/tools/crosstool no longer
>> builds any of the configs.
>>
>> Would someone please add a config expected to build with that
>> cross-compiler? And/or point to a more recent cross-compiler?
>> And either confirm that one of these configs is suitable for
>> build coverage?
>>
> Hi Peter,
> 
> Seems to still work for me (up to and including linux-next), at least
> for building defconfig, allmodconfig, and allnoconfig. Also, the defconfig
> kernel boots for me with qemu after replacing CONFIG_MARCH_Z196 with
> CONFIG_MARCH_Z900.
> 
> Have you tried gcc 4.9.0 from
> www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/ ?

Hahaha, no. Because I never thought to look behind the html at

kernel.org/pub/tools/crosstool

which has _stale_ links to gcc 4.6.3

Thanks,
Peter Hurley
