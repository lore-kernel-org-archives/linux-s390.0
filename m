From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements explicit
Date: Wed, 2 Sep 2015 18:47:29 -0700
Message-ID: <CAB=NE6VAj8bV1RXRjh=wH=J+MQPDfS2K3RgRSCcjLGHqs1m6uw@mail.gmail.com>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
 <3544271.GfynADMPqZ@wuerfel> <20150903014415.GQ8051@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20150903014415.GQ8051@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, Borislav Petkov <bp@suse.de>, Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 2, 2015 at 6:44 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>> I don't think we really need to spell it out here. s390 PCI is different
>> from everybody else's in a lot of ways, so a simple 'depends on PCI &&
>> !S390' for CONFIG_PCI_IOMAP seems simpler and more intuitive.
>
> Sure that would work as well.

But on second thought it still would leave us reactive to S390, this
solution would get folks extending this asm-generic stuff to also have
something in place for S390, even if its just returning NULL.

 Luis
