Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160126174441.GA18873@ravnborg.org>
References: <cover.1453759363.git.luto@kernel.org> <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
 <20160126062951.GA17107@ravnborg.org> <20160125.225100.1932707129794761764.davem@davemloft.net>
 <20160126174441.GA18873@ravnborg.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 26 Jan 2016 09:48:29 -0800
Message-ID: <CALCETrVaOC2=CC0bDoc-g2o+wjwaFfj+LAB7umrRMCHYwsk+Bg@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate
 in_compat_syscall implementation
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160126174829.CQ5cyX_SyTlvnT5lV5mfm82KnrFzT_G5tn5lgy-jP24@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 26, 2016 at 9:44 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Mon, Jan 25, 2016 at 10:51:00PM -0800, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Tue, 26 Jan 2016 07:29:51 +0100
>>
>> > Could you please add a comment about where 0x110 comes from.
>> > I at least failed to track this down.
>>
>> Frankly I'm fine with this.  Someone who understands sparc64 can look
>> at the trap table around entry 0x110 and see:
>>
>> tl0_resv10e:  BTRAP(0x10e) BTRAP(0x10f)
>> tl0_linux32:  LINUX_32BIT_SYSCALL_TRAP
>> tl0_oldlinux64:       LINUX_64BIT_SYSCALL_TRAP
>
> If one realise to look in the trap table in the first place - yes.
>
> Adding a short:
>
> /* Check if this is LINUX_32BIT_SYSCALL_TRAP */
> Would make wonders to readability.

I'll add a comment in v2.

--Andy
-- 
Andy Lutomirski
AMA Capital Management, LLC
