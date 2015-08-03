Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Aug 2015 13:59:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Build errors in -next due to ' s390/kernel: lazy restore fpu
 registers'
Message-ID: <20150803135958.0c34d9a9@mschwide>
In-Reply-To: <20150731183510.GA9117@roeck-us.net>
References: <20150731183510.GA9117@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 31 Jul 2015 11:35:10 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
> 
> s390:defconfig and s390:allmodconfig fail to build in -next as follows.
> 
> arch/s390/kernel/entry.S:806: Error:
> 	operand out of range (0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
> arch/s390/kernel/entry.S:1254: Error:
> 	operand out of range (0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
> 
> bisect points to commit 9977e886cbb (" s390/kernel: lazy restore fpu
> registers").
> 
> The build has been broken since at least July 20. I thought this was reported
> before, but maybe not; there may have been other failures masking this one.
> 
> Guenter

Should be solved not with an additional patch on the features branch:

git commit d0164ee20d98847d3c777a0ae90e678e7ac1e416
s390/kernel: remove save_fpu_regs() parameter and use __LC_CURRENT instead

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
