Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 22 Jun 2018 12:47:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: s390 qemu boot failure in -next
Message-ID: <20180622194736.GA5794@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

starting with commit 's390/boot: make head.S and als.c be part of the
decompressor only' in -next, s390 immages no longer boot in qemu.
As far as I can see, the reason is that the command line is no longer
passed from qemu to the kernel, which results in a panic because the
root file system can not be mounted.

Was this change made on purpose ? If so, is there a way to get qemu
back to working ?

Thanks,
Guenter

---
bisect log:

# bad: [2e6381681ec48ed6dd455473a657d8a393518aa6] Add linux-next specific files for 20180622
# good: [ce397d215ccd07b8ae3f71db689aedb85d56ab40] Linux 4.18-rc1
git bisect start 'HEAD' 'v4.18-rc1'
# bad: [07b762f7baf30aaa93d35f36ff367d4b36632059] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect bad 07b762f7baf30aaa93d35f36ff367d4b36632059
# good: [6d92c59898b58a2ee80e7aa15cc72c035d33ba20] Merge remote-tracking branch 'realtek/for-next'
git bisect good 6d92c59898b58a2ee80e7aa15cc72c035d33ba20
# bad: [0e743bf802047ea83ce2345bbe9df52e96bf6d1a] Merge remote-tracking branch 'ext4/dev'
git bisect bad 0e743bf802047ea83ce2345bbe9df52e96bf6d1a
# good: [8039f3664e6b07b6797579e29bcc1c51c022e07b] Merge remote-tracking branch 'microblaze/next'
git bisect good 8039f3664e6b07b6797579e29bcc1c51c022e07b
# bad: [c6c285ec2bb43d90176dda4a0cd63c48df7dee98] Merge remote-tracking branch 's390/features'
git bisect bad c6c285ec2bb43d90176dda4a0cd63c48df7dee98
# good: [0e56f3749f0b28166a29691a5422d62a516877ae] MIPS: loongson64: use generic dma noncoherent ops
git bisect good 0e56f3749f0b28166a29691a5422d62a516877ae
# bad: [32bf311a88e9fa70eb3604a697c2390f02ef2de2] init/Kconfig: add an option for uncompressed kernel
git bisect bad 32bf311a88e9fa70eb3604a697c2390f02ef2de2
# bad: [34139a786a40f9f97f84e7f422a9c29d59e2606d] s390/decompressor: rename entry point to startup_decompressor
git bisect bad 34139a786a40f9f97f84e7f422a9c29d59e2606d
# good: [d035a77cb9256f52dc6c4940cbdb2051adb5420c] s390/decompressor: correct build flags
git bisect good d035a77cb9256f52dc6c4940cbdb2051adb5420c
# good: [652e75c51463aead06389dd6f5756f9b91f7fd75] s390/setup: do not reserve the decompressor code
git bisect good 652e75c51463aead06389dd6f5756f9b91f7fd75
# bad: [1b78ef09741223c630a37311ae12d6f6bd212e1a] s390/boot: make head.S and als.c be part of the decompressor only
git bisect bad 1b78ef09741223c630a37311ae12d6f6bd212e1a
# good: [aa71c78a63a3ac82e47714f48b3ea14e2ef94dfc] s390/decompressor: trim the kernel image up to 1M
git bisect good aa71c78a63a3ac82e47714f48b3ea14e2ef94dfc
# first bad commit: [1b78ef09741223c630a37311ae12d6f6bd212e1a] s390/boot: make head.S and als.c be part of the decompressor only
