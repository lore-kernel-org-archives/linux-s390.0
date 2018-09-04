Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 4 Sep 2018 06:42:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 00/25] Change tty_port(standard)_install's return type
Message-ID: <20180904044239.GA24208@ravnborg.org>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Jaejoong.

> Change return type for tty functions. Patch No.01
>   tty: Change return type to void
Adding this patch first will generate a lot of warnings
until all users are updated.
It is usual practice to prepare all users
and then apply the infrastructure changes as the
last patch.
Then people will not see a lot of warnings when
they build something in the middle,
and I guess current stack set may also generate
a few mails from the 0-day build infrastructure.


>   isdn: i4l: isdn_tty: Change return type to void

And a nitpick on the patch description.
This patch do not change any return type, but
it ignore the return value og tty_part_install().
Same goes for all ramaining patches.

	Sam
