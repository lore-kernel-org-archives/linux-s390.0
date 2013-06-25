Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20130625141508.6c391fd8@mschwide>
References: <20130403172534.528d04c5@mschwide> <CACxGe6sYM8QPB-ZZkgB0+f81CZHULPi5zPAsWb5dzHiRgU+w6Q@mail.gmail.com>
 <20130625141508.6c391fd8@mschwide>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 25 Jun 2013 13:42:23 +0100
Message-ID: <CACxGe6s3RqOkf=M4zwpJGEEVa9XjJvP2q5xeLKewGo6np5C-3g@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 3.9-rc6
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 25, 2013 at 1:15 PM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Tue, 25 Jun 2013 13:09:51 +0100
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> On Wed, Apr 3, 2013 at 4:25 PM, Martin Schwidefsky
>> <schwidefsky@de.ibm.com> wrote:
>> > Hi Linus,
>> >
>> > please pull from the 'for-linus' branch of
>> >
>> >         git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus
>> >
>> > to receive the following updates: Just a bunch of bugfixes.
>> >
>> > Heiko Carstens (4):
>> >       drivers/Kconfig: add several missing GENERIC_HARDIRQS dependencies
>>
>> Is anyone currently working on fixing this? s390 is the only
>> architecture left that does not enable GENERIC_HARDIRQS. It's painful
>> to keep adding dependencies on GENERIC_HARDIRQS to driver configs.
>
> I am working on it. The hardest part is MSI irqs for PCI. Chances are
> that I get it done for the merge window of 3.12.

How are you handling the MSIs? I've just been looking at some code for
irq_domain to handle MSI mapping. What's the part that is getting you
hung up?

I'd be happy to take a look if you want a hand.

g.
