Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 26 Jul 2017 07:00:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Qemu problems in -next with 's390/spinlock: add niai spinlock
 hints'
References: <20170726011451.GA24947@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726011451.GA24947@roeck-us.net>
Message-Id: <20170726050033.GA3218@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 25, 2017 at 06:14:51PM -0700, Guenter Roeck wrote:
> Hi Martin,
> 
> my s390 qemu tests in linux-next stopped working a few days ago.
> Bisect points to commit 's390/spinlock: add niai spinlock hints'.
> 
> Looking at the patch, this isn't really surprising; at least to me it looks
> like the patch is making instructions mandatory which are only available in
> Z14 CPUs. Does this mean that older s390 CPUs (such as the Z900 used in my
> qemu tests) are no longer going to be supported in Linux ?

No, that means that the patch has a bug. The NIAI instruction is only
available if the execution-hint facility is installed. That facility came
with zEC12. Luckily it uses the same facility indicator bit like the
miscellaneous-instruction-extensions facility, which we already use anyway
if the kernel gets compiled for zEC12. In that case we have early code
which verifies if all required facilities to run the kernel are installed,
and if not it will print a message to the console and stop the machine.

So the easiest fix would be to generate the NIAI instruction only if the
kernel gets compiled for zEC12 or newer.
