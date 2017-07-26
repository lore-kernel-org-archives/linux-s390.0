Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 25 Jul 2017 18:14:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Qemu problems in -next with 's390/spinlock: add niai spinlock hints'
Message-ID: <20170726011451.GA24947@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Martin,

my s390 qemu tests in linux-next stopped working a few days ago.
Bisect points to commit 's390/spinlock: add niai spinlock hints'.

Looking at the patch, this isn't really surprising; at least to me it looks
like the patch is making instructions mandatory which are only available in
Z14 CPUs. Does this mean that older s390 CPUs (such as the Z900 used in my
qemu tests) are no longer going to be supported in Linux ?

Thanks,
Guenter
