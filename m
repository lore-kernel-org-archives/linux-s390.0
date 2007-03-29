Return-Path: <linux-kernel-owner+w=401wt.eu-S1752820AbXC2JKS@vger.kernel.org>
Date: Thu, 29 Mar 2007 11:12:06 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [Patch -mm 0/3] uevent_suppress handling.
Message-ID: <20070329111206.239991b8@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg K-H <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>, Eric Rannaud <eric.rannaud@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

following up on the firmware loading problems in 2.6.21-rc4-mm1, I've
been looking into uevent_suppress and using it in the firmware class.
As an added bonus, I also managed to suppress some unwanted uevents on
s390.

Works for me on i386 (the firmware stuff) and on s390 (the subchannel
stuff).

Patches are against 2.6.21-rc5-mm1.

[1/3] Driver core: suppress uevents via filter.
[2/3] Driver core: switch firmware_class to uevent_suppress.
[3/3] s390: cio: Delay uevents for subchannels.
