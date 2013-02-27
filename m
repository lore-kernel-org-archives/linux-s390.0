From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECK
Date: Wed, 27 Feb 2013 15:19:28 -0800
Message-ID: <512E9480.7020306@codeaurora.org>
References: <1361934016-22630-1-git-send-email-sboyd@codeaurora.org> <201302272032.21014.arnd@arndb.de> <512E6FA9.4060504@codeaurora.org> <512E8664.3070903@zytor.com> <512E8E48.8020007@codeaurora.org> <512E8ECF.1080307@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <512E8ECF.1080307@zytor.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Chris Metcalf <cmetcalf@tilera.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/27/13 14:55, H. Peter Anvin wrote:
> On 02/27/2013 02:52 PM, Stephen Boyd wrote:
>> On 02/27/13 14:19, H. Peter Anvin wrote:
>>> On 02/27/2013 12:42 PM, Stephen Boyd wrote:
>>>>> It's fine to do your patch as a first step though, which would not
>>>>> change the behavior.
>>>> A lot of arches seem to not want to enable it because false positives
>>>> are everywhere. It really depends on how good the compiler is at doing
>>>> constant propagation and dead code removal.
>>>>
>>> Although some of the cases I have seen being flagged as "false
>>> positives" have been real bugs.
>> There were so many false-positives on x86_64 that Andrew eventually
>> dropped my patch to add support for this option to the copy_from_user()
>> function there.
>>
> I would probably have taken it, especially if it came with more x86-64
> to i386 unification.
>
> It's an option, though.

You acked the patch[1]. Will you pick it up?

[1] https://patchwork.kernel.org/patch/833192/

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
