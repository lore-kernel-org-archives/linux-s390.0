Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHXqBFK=u+MchBn=D31h6nhp-R9GTNbaC18QJA937zjXc60UQw@mail.gmail.com>
References: <1330099282-4588-1-git-send-email-danny.kukawka@bisect.de>
	<CAHXqBFK=u+MchBn=D31h6nhp-R9GTNbaC18QJA937zjXc60UQw@mail.gmail.com>
Date: Sat, 25 Feb 2012 11:13:21 +0100
Message-ID: <CAMuHMdVZ8eVdRLtsq23XCLtA4wU7cTc-mLebAQ4QzO=gkuNMWQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] Part 2: check given MAC address, if invalid return -EADDRNOTAVAIL
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
Cc: Danny Kukawka <danny.kukawka@bisect.de>, "David S. Miller" <davem@davemloft.net>, Andy Gospodarek <andy@greyhouse.net>, Guo-Fu Tseng <cooldavid@cooldavid.org>, Petko Manolov <petkan@users.sourceforge.net>, "VMware, Inc." <pv-drivers@vmware.com>, "John W. Linville" <linville@tuxdriver.com>, linux390@de.ibm.com, Mauro Carvalho Chehab <mchehab@infradead.org>, Danny Kukawka <dkukawka@suse.de>, Stephen Hemminger <shemminger@vyatta.com>, Joe Perches <joe@perches.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jiri Pirko <jpirko@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, linux-hams@vger.kernel.org, linux-mips@linux-mips.org
List-ID: <linux-s390.vger.kernel.org>

2012/2/24 Michał Mirosław <mirqus@gmail.com>:
> 2012/2/24 Danny Kukawka <danny.kukawka@bisect.de>:
>> Second Part of series patches to unifiy the return value of
>> .ndo_set_mac_address if the given address isn't valid.
>>
>> These changes check if a given (MAC) address is valid in
>> .ndo_set_mac_address, if invalid return -EADDRNOTAVAIL
>> as eth_mac_addr() already does if is_valid_ether_addr() fails.
>
> Why not just fix dev_set_mac_address() and make do_setlink() use that?

BTW, it's also called from dev_set_mac_address().

> Checks are specific to address family, not device model I assume.

Indeed, why can't this be done in one single place, instead of sprinkling these
checks over all drivers, missing all out-of-tree (note: I don't care) and all
soon-to-be-submitted drivers?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
