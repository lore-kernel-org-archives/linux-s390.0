Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1330099282-4588-1-git-send-email-danny.kukawka@bisect.de>
References: <1330099282-4588-1-git-send-email-danny.kukawka@bisect.de>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Fri, 24 Feb 2012 18:59:04 +0100
Message-ID: <CAHXqBFK=u+MchBn=D31h6nhp-R9GTNbaC18QJA937zjXc60UQw@mail.gmail.com>
Subject: Re: [PATCH 00/12] Part 2: check given MAC address, if invalid return -EADDRNOTAVAIL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andy Gospodarek <andy@greyhouse.net>, Guo-Fu Tseng <cooldavid@cooldavid.org>, Petko Manolov <petkan@users.sourceforge.net>, "VMware, Inc." <pv-drivers@vmware.com>, "John W. Linville" <linville@tuxdriver.com>, linux390@de.ibm.com, Mauro Carvalho Chehab <mchehab@infradead.org>, Danny Kukawka <dkukawka@suse.de>, Stephen Hemminger <shemminger@vyatta.com>, Joe Perches <joe@perches.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jiri Pirko <jpirko@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, linux-hams@vger.kernel.org, linux-mips@linux-mips.org
List-ID: <linux-s390.vger.kernel.org>

2012/2/24 Danny Kukawka <danny.kukawka@bisect.de>:
> Second Part of series patches to unifiy the return value of
> .ndo_set_mac_address if the given address isn't valid.
>
> These changes check if a given (MAC) address is valid in
> .ndo_set_mac_address, if invalid return -EADDRNOTAVAIL
> as eth_mac_addr() already does if is_valid_ether_addr() fails.

Why not just fix dev_set_mac_address() and make do_setlink() use that?
Checks are specific to address family, not device model I assume.

Best Regards,
Michał Mirosław
