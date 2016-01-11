Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160111130334-mutt-send-email-mst@redhat.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com> <20160111130334-mutt-send-email-mst@redhat.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 11 Jan 2016 22:06:14 +1100
Message-ID: <CAGRGNgXnxjmvjD8_vT17ZWwK0uCsGNmXq_KdVj9KoT6NRZQvPA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] checkpatch: handling of memory barriers
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160111110614.-paOL_Kr-kVjv7YmC7xsQQaPxqQF3eI-jYRoIyfTVUE@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

Hi Michael,

On Mon, Jan 11, 2016 at 10:04 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jan 11, 2016 at 12:59:25PM +0200, Michael S. Tsirkin wrote:
>> As part of memory barrier cleanup, this patchset
>> extends checkpatch to make it easier to stop
>> incorrect memory barrier usage.
>>
>> This replaces the checkpatch patches in my series
>>       arch: barrier cleanup + barriers for virt
>> and will be included in the pull request including
>> the series.
>>
>> changes from v3:
>>       rename smp_barrier_stems to barrier_stems
>>       as suggested by Julian Calaby.
>
> In fact it was Joe Perches that suggested it.
> Sorry about the confusion.

I was about to point that out.

FWIW this entire series is:

Acked-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
