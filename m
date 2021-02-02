Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhBBW7l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 17:59:41 -0500
Subject: Re: [PATCH v5 1/2] drivers/misc: sysgenid: add system generation id
 driver
References: <1612200294-17561-1-git-send-email-acatan@amazon.com>
 <1612200294-17561-2-git-send-email-acatan@amazon.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5290f6f5-396f-aa47-3b74-8d50c2434a04@infradead.org>
Date: Tue, 2 Feb 2021 14:58:02 -0800
MIME-Version: 1.0
In-Reply-To: <1612200294-17561-2-git-send-email-acatan@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Adrian Catangiu <acatan@amazon.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: gregkh@linuxfoundation.org, graf@amazon.com, arnd@arndb.de, ebiederm@xmission.com, rppt@kernel.org, 0x7f454c46@gmail.com, borntraeger@de.ibm.com, Jason@zx2c4.com, jannh@google.com, w@1wt.eu, colmmacc@amazon.com, luto@kernel.org, tytso@mit.edu, ebiggers@kernel.org, dwmw@amazon.co.uk, bonzini@gnu.org, sblbir@amazon.com, raduweis@amazon.com, corbet@lwn.net, mst@redhat.com, mhocko@kernel.org, rafael@kernel.org, pavel@ucw.cz, mpe@ellerman.id.au, areber@redhat.com, ovzxemul@gmail.com, avagin@gmail.com, ptikhomirov@virtuozzo.com, gil@azul.com, asmehra@redhat.com, dgunigun@redhat.com, vijaysun@ca.ibm.com, oridgar@gmail.com, ghammer@redhat.com

Hi--

On 2/1/21 9:24 AM, Adrian Catangiu wrote:
> - Background and problem
> 
> The System Generation ID feature is required in virtualized or
> containerized environments by applications that work with local copies
> or caches of world-unique data such as random values, uuids,
> monotonically increasing counters, etc.

  ... if those applications want to comply with <some MS spec>.

> Such applications can be negatively affected by VM or container
> snapshotting when the VM or container is either cloned or returned to
> an earlier point in time.


> Signed-off-by: Adrian Catangiu <acatan@amazon.com>
> ---
>  Documentation/misc-devices/sysgenid.rst            | 236 ++++++++++++++++
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
>  MAINTAINERS                                        |   8 +
>  drivers/misc/Kconfig                               |  16 ++
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/sysgenid.c                            | 307 +++++++++++++++++++++
>  include/uapi/linux/sysgenid.h                      |  17 ++
>  7 files changed, 586 insertions(+)
>  create mode 100644 Documentation/misc-devices/sysgenid.rst
>  create mode 100644 drivers/misc/sysgenid.c
>  create mode 100644 include/uapi/linux/sysgenid.h
> 
> diff --git a/Documentation/misc-devices/sysgenid.rst b/Documentation/misc-devices/sysgenid.rst
> new file mode 100644
> index 0000000..4337ca0
> --- /dev/null
> +++ b/Documentation/misc-devices/sysgenid.rst
> @@ -0,0 +1,236 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========
> +SYSGENID
> +========
> +
> +The System Generation ID feature is required in virtualized or
> +containerized environments by applications that work with local copies
> +or caches of world-unique data such as random values, UUIDs,
> +monotonically increasing counters, etc.
> +Such applications can be negatively affected by VM or container
> +snapshotting when the VM or container is either cloned or returned to
> +an earlier point in time.
> +
> +The System Generation ID is a simple concept meant to alleviate the
> +issue by providing a monotonically increasing counter that changes
> +each time the VM or container is restored from a snapshot.
> +The driver for it lives at ``drivers/misc/sysgenid.c``.
> +
> +The ``sysgenid`` driver exposes a monotonic incremental System
> +Generation u32 counter via a char-dev FS interface accessible through

s/FS/filesystem/

> +``/dev/sysgenid`` that provides sync and async SysGen counter update
> +notifications. It also provides SysGen counter retrieval and
> +confirmation mechanisms.
> +
> +The counter starts from zero when the driver is initialized and
> +monotonically increments every time the system generation changes.
> +
> +The ``sysgenid`` driver exports the ``void sysgenid_bump_generation()``
> +symbol which can be used by backend drivers to drive system generation
> +changes based on hardware events.
> +System generation changes can also be driven by userspace software
> +through a dedicated driver ioctl.
> +
> +Userspace applications or libraries can (a)synchronously consume the
> +system generation counter through the provided FS interface, to make

s/FS/filesystem/

> +any necessary internal adjustments following a system generation update.
> +
> +Driver FS interface:
> +
> +``open()``:
> +  When the device is opened, a copy of the current Sys-Gen-Id (counter)
> +  is associated with the open file descriptor. The driver now tracks
> +  this file as an independent *watcher*. The driver tracks how many
> +  watchers are aware of the latest Sys-Gen-Id counter and how many of
> +  them are *outdated*; outdated being those that have lived through
> +  a Sys-Gen-Id change but not yet confirmed the new generation counter.
> +
> +``read()``:
> +  Read is meant to provide the *new* system generation counter when a
> +  generation change takes place. The read operation blocks until the
> +  associated counter is no longer up to date, at which point the new
> +  counter is provided/returned.
> +  Nonblocking ``read()`` uses ``EAGAIN`` to signal that there is no
> +  *new* counter value available. The generation counter is considered
> +  *new* for each open file descriptor that hasn't confirmed the new
> +  value following a generation change. Therefore, once a generation
> +  change takes place, all ``read()`` calls will immediately return the
> +  new generation counter and will continue to do so until the
> +  new value is confirmed back to the driver through ``write()``.
> +  Partial reads are not allowed - read buffer needs to be at least
> +  32 bits in size.
> +
> +``write()``:
> +  Write is used to confirm the up-to-date Sys Gen counter back to the
> +  driver.
> +  Following a VM generation change, all existing watchers are marked
> +  as *outdated*. Each file descriptor will maintain the *outdated*
> +  status until a ``write()`` confirms the up-to-date counter back to
> +  the driver.
> +  Partial writes are not allowed - write buffer should be exactly
> +  32 bits in size.
> +
> +``poll()``:
> +  Poll is implemented to allow polling for generation counter updates.
> +  Such updates result in ``EPOLLIN`` polling status until the new
> +  up-to-date counter is confirmed back to the driver through a
> +  ``write()``.
> +
> +``ioctl()``:
> +  The driver also adds support for waiting on open file descriptors
> +  that haven't acknowledged a generation counter update, as well as a
> +  mechanism for userspace to *force* a generation update:
> +
> +  - SYSGENID_WAIT_WATCHERS: blocks until there are no more *outdated*
> +    watchers, or if a ``timeout`` argument is provided, until the
> +    timeout expires.
> +    If the current caller is *outdated* or a generation change happens
> +    while waiting (thus making current caller *outdated*), the ioctl
> +    returns ``-EINTR`` to signal the user to handle event and retry.
> +  - SYSGENID_FORCE_GEN_UPDATE: forces a generation counter increment.
> +    It takes a ``minimum-generation`` argument which represents the
> +    minimum value the generation counter will be incremented to. For

                                            will be set to. For
It's not so much an increment as it is a "set to this value or higher".

> +    example if current generation is ``5`` and ``SYSGENID_FORCE_GEN_UPDATE(8)``
> +    is called, the generation counter will increment to ``8``.
> +    This IOCTL can only be used by processes with CAP_CHECKPOINT_RESTORE
> +    or CAP_SYS_ADMIN capabilities.
> +
> +``mmap()``:
> +  The driver supports ``PROT_READ, MAP_SHARED`` mmaps of a single page
> +  in size. The first 4 bytes of the mapped page will contain an
> +  up-to-date u32 copy of the system generation counter.
> +  The mapped memory can be used as a low-latency generation counter
> +  probe mechanism in critical sections - see examples.
> +
> +``close()``:
> +  Removes the file descriptor as a system generation counter *watcher*.
> +
> +Example application workflows
> +-----------------------------
> +
[snip]


-- 
~Randy
