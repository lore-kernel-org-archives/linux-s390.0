Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] bitops: add ifdef CONFIG_GENERIC_FIND_BIT_LE guard
Date: Thu, 21 Apr 2011 11:03:55 +0200
References: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com> <201104201631.40017.arnd@arndb.de> <BANLkTimBF312svk0mRkt5_Y=t+B12cLW+Q@mail.gmail.com>
In-Reply-To: <BANLkTimBF312svk0mRkt5_Y=t+B12cLW+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201104211103.55929.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Thursday 21 April 2011, Akinobu Mita wrote:
> Should we also kill CONFIG_GENERIC_FIND_BIT_LE option comletely,
> then add the #ifdef for each find_*() in lib/find_next_bit.c and always build
> it unconditionally ?

I think that would be more consistent. It's not a big difference anyway, so
do it only if you feel motivated. There are a lot of other things that could
be changed this way, I'd only change it while reworking other aspects in order
to avoid accidentally breaking things.

	Arnd
