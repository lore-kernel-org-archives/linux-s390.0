Return-Path: <linux-kernel-owner+w=401wt.eu-S1753130AbYJQIHY@vger.kernel.org>
Subject: Re: [GIT PULL] kernel message catalog patches
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <1224168620.9617.14.camel@localhost>
References: <1224168620.9617.14.camel@localhost>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 09:59:14 +0200
Message-Id: <1224230354.4631.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

On Thu, 2008-10-16 at 16:50 +0200, Martin Schwidefsky wrote:
> please pull from 'kmsg' branch of
> 
>         git://git390.osdl.marist.edu/pub/scm/linux-2.6.git kmsg
> 
> to get the kernel message catalog code. This is been reworked half
> a dozen times and this is the outcome. The bulk of this patch set
> are the printk changes and documentation files for s390. The three
> patches are:
>   "[S390] kmsg: tagged kernel messages.",
>   "[S390] kmsg: tagged device messages." and
>   "[S390] kmsg: Kernel message catalog script."

I've fixed the merge conflicts with todays git and recreated the kmsg
branch on git390.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
