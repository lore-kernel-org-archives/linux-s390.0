Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
Date: Fri, 10 May 2019 19:35:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190510122401.21a598f6@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190510173529.XATeuZJ4qvPsIGIrHM2kfdN6CdMiyb6gddK2hUaBa-I@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



Le 10/05/2019 à 18:24, Steven Rostedt a écrit :
> On Fri, 10 May 2019 10:42:13 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
>>   static const char *check_pointer_msg(const void *ptr)
>>   {
>> -	char byte;
>> -
>>   	if (!ptr)
>>   		return "(null)";
>>   
>> -	if (probe_kernel_address(ptr, byte))
>> +	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>>   		return "(efault)";
>>   
> 
> 
> 	< PAGE_SIZE ?
> 
> do you mean: < TASK_SIZE ?

I guess not.

Usually, < PAGE_SIZE means NULL pointer dereference (via the member of a 
struct)

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
