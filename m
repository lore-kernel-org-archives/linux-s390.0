From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Early printk breakage due to 3e5903eb9cff ("vsprintf: Prevent crash
 when dereferencing invalid pointers")
Date: Thu, 9 May 2019 12:46:58 +0200
Message-ID: <20190509104658.GB5758@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hello Petr,

I just realized that early printks, or more specific vsnprintf invocations,
are broken on s390 due to

3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers").

E.g. the early boot output now looks like this where the first
(efault) should be the linux_banner:

[    0.099985] (efault)
[    0.099985] setup: Linux is running as a z/VM guest operating system in 64-bit mode
[    0.100066] setup: The maximum memory size is 8192MB
[    0.100070] cma: Reserved 4 MiB at (efault)
[    0.100100] numa: NUMA mode: (efault)

The reason for this, is that your code assumes that
probe_kernel_address() works very early. This however is not true on
at least s390. Uaccess on KERNEL_DS works only after page tables have
been setup on s390, which happens with setup_arch()->paging_init().

Any probe_kernel_address() invocation before that will return -EFAULT.

So how should we fix this? We could e.g. again add an arch specific
version of probe_kernel_read() for s390, which would be more or less a
copy of the generic variant, just that it would do something different
if page tables aren't setup yet.

Or... any other idea?

Cc'ing linux-arch, just in case other architectures are also affected.
