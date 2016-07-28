Return-Path: <owner-linux-mm@kvack.org>
MIME-Version: 1.0
In-Reply-To: <20160728134142.GA12516@thunk.org>
References: <20160727071400.GA3912@osiris> <20160728034601.GC20032@thunk.org>
 <20160728055548.GA3942@osiris> <20160728072408.GB3942@osiris> <20160728134142.GA12516@thunk.org>
From: Tony Luck <tony.luck@gmail.com>
Date: Thu, 28 Jul 2016 16:56:24 -0700
Message-ID: <CA+8MBbKDpuuN4FCPnCGXei2v+z2PvLS_vGscP6H32NcGM1xhhw@mail.gmail.com>
Subject: Re: [BUG -next] "random: make /dev/urandom scalable for silly
 userspace programs" causes crash
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Theodore Ts'o <tytso@mit.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 28, 2016 at 6:41 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Thu, Jul 28, 2016 at 09:24:08AM +0200, Heiko Carstens wrote:
>>
>> Oh, I just realized that Linus pulled your changes. Actually I was hoping
>> we could get this fixed before the broken code would be merged.
>> Could you please make sure the bug fix gets included as soon as possible?
>
> Yes, I'll send the pull request to ASAP.

Also broke ia64.  Same fix works for me.

Tested-by: Tony Luck <tony.luck@intel.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
