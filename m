Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Hurley <peter@hurleysoftware.com>
Subject: s390 cross-compiling code coverage
Message-ID: <569404BB.1010008@hurleysoftware.com>
Date: Mon, 11 Jan 2016 11:38:35 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Linux kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Occasionally, it's necessary to touch s390 code because of changes
within a subsystem, such as tty/serial.

Since changing the configs to the zEC12 march, the gcc 4.6.3 s390
cross-compiler hosted at kernel.org/pub/tools/crosstool no longer
builds any of the configs.

Would someone please add a config expected to build with that
cross-compiler? And/or point to a more recent cross-compiler?
And either confirm that one of these configs is suitable for
build coverage?

Regards,
Peter Hurley

PS - I did make sure that recent changes I've submitted for s390 drivers
     build, by hand-configuring from default_defconfig, but I'd like
     to rely on automation for build testing.
