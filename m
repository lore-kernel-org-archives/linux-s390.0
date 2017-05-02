From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 02 May 2017 08:32:17 +0000
Subject: Re: linux-4.11/arch/s390/kernel/time.c:417: bad function call ?
Message-Id: <20170502103217.38cede5c@mschwideX1>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2 May 2017 07:59:45 +0000
David Binderman <dcb314@hotmail.com> wrote:

> linux-4.11/arch/s390/kernel/time.c:417]: (error) Shifting 32-bit value by 48 bits is undefined behaviour
> 
> 
> Source code is
> 
>     if ((abs(tod_steering_delta) >> 48) != 0)
> 
> But the type of tod_steering_delta is long long. Suggest replace abs with llabs.

I wonder how you managed to get this error message. The abs definition
in include/linux/kernel.h takes care of the type, it can be used with
basically anything. And llabs does not exist for a kernel compile.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
