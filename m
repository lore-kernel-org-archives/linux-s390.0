Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] s390/setup: fix early warning messages
References: <20190218154640.GA27699@roeck-us.net>
 <20190218180146.79930fe6@mschwideX1>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0b8201f1-bdb0-d274-4354-ceb0d05530d2@roeck-us.net>
Date: Mon, 18 Feb 2019 10:09:01 -0800
MIME-Version: 1.0
In-Reply-To: <20190218180146.79930fe6@mschwideX1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Martin,

On 2/18/19 9:01 AM, Martin Schwidefsky wrote:
> On Mon, 18 Feb 2019 07:46:40 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Hi,
>>
>> On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:
>>> The setup_lowcore() function creates a new prefix page for the boot CPU.
>>> The PSW mask for the system_call, external interrupt, i/o interrupt and
>>> the program check handler have the DAT bit set in this new prefix page.
>>>
>>> At the time setup_lowcore is called the system still runs without virtual
>>> address translation, the paging_init() function creates the kernel page
>>> table and loads the CR13 with the kernel ASCE.
>>>
>>> Any code between setup_lowcore() and the end of paging_init() that has
>>> a BUG or WARN statement will create a program check that can not be
>>> handled correctly as there is no kernel page table yet.
>>>
>>> To allow early WARN statements initially setup the lowcore with DAT off
>>> and set the DAT bit only after paging_init() has completed.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>
>> This patch causes s390 qemu emulations to crash with a kernel stack overflow.
>> Reverting the patch fixes the problem. Crash log and bisect results below.
> 
> Urgs, yes. That is EDAT-1 again that makes it work with 1MB pages but breaks
> with 4K mapping where the prefix page is mapped to absolute zero.
> 

Is there some non-default configuration besides defconfig that I could run to
catch both working and non-working images ? I don't immediately see an option
to select the page size.

Thanks,
Guenter

> Just using S390_lowcore instead of lowcore_ptr[0] does not work either
> because low-address protection is already active. I'll think of something.
> 
> Thanks for bug report!
> 
