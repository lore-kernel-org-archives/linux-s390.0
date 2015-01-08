Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54AE3D49.9060801@arm.com>
Date: Thu, 08 Jan 2015 13:48:17 +0530
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFT] s390: move cacheinfo sysfs to generic cacheinfo infrastructure
References: <1420702912-9749-1-git-send-email-sudeep.holla@arm.com> <20150108081446.GC3997@osiris>
In-Reply-To: <20150108081446.GC3997@osiris>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On Thursday 08 January 2015 01:44 PM, Heiko Carstens wrote:
> On Thu, Jan 08, 2015 at 07:41:52AM +0000, Sudeep Holla wrote:
>> This patch removes the redundant sysfs cacheinfo code by reusing
>> the newly introduced generic cacheinfo infrastructure through the
>> commit 246246cbde5e ("drivers: base: support cpu cache information
>> interface to userspace via sysfs")
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: linux390@de.ibm.com
>> Cc: linux-s390@vger.kernel.org
>> ---
>>   arch/s390/kernel/cache.c | 388 +++++++++++------------------------------------
>>   1 file changed, 92 insertions(+), 296 deletions(-)
>>
>> Hi Heiko,
>>
>> If you can give this a quick testing though nothing has changes since
>> you last tested it, that would be good.
>>
>> If nothing is broken, please feel free to take this through your tree.
>>
>> Regards,
>> Sudeep
>
> Still works. I forwarded your patch with my sign-off to Martin, so he can
> apply it for the next merge window.
>
> Thanks a lot for your work!

Thanks to you indeed for following up, testing and support during 
development.

Regards,
Sudeep
