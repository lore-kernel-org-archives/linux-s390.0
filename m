Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4C7279A4.5040606@in.ibm.com>
Date: Mon, 23 Aug 2010 19:07:40 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [s390] Build failure with latest 2.6.36-rc1 git (sys_execve)
References: <4C6CBA56.9020909@in.ibm.com> <20100819094444.28e7b2e4@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20100819094444.28e7b2e4@mschwide.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, dhowells@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Martin Schwidefsky wrote:
> On Thu, 19 Aug 2010 10:30:06 +0530
> Sachin Sant <sachinp@in.ibm.com> wrote:
>
>   
>> Latest 2.6.36-rc1 git fails to build on a s390 with
>>
>> arch/s390/kernel/process.c:272: error: conflicting types for 'sys_execve'
>> arch/s390/kernel/entry.h:45: error: previous declaration of 'sys_execve' was here
>> make[1]: *** [arch/s390/kernel/process.o] Error 1
>>
>> This error was introduced via commit :
>>
>> commit d7627467b7a8dd6944885290a03a07ceb28c10eb
>> Make do_execve() take a const filename pointer
>>
>> I guess the corresponding definition of sys_execve()
>> in arch/s390/kernel/entry.h also needs an update.
>>     
>
> Fix is uploaded to git390. Tomorrows -next tree should work again.
>   
The patch is still missing from Linus's tree.
2.6.36-rc2-git1 (9ee4747..) fails with the same error.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
