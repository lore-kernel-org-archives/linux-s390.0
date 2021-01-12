Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Jan 2021 07:48:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/2] System Generation ID driver and VMGENID backend
Message-ID: <20210112074658-mutt-send-email-mst@kernel.org>
References: <1610453760-13812-1-git-send-email-acatan@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1610453760-13812-1-git-send-email-acatan@amazon.com>
List-ID: <linux-s390.vger.kernel.org>
To: Adrian Catangiu <acatan@amazon.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, gregkh@linuxfoundation.org, graf@amazon.com, arnd@arndb.de, ebiederm@xmission.com, rppt@kernel.org, 0x7f454c46@gmail.com, borntraeger@de.ibm.com, Jason@zx2c4.com, jannh@google.com, w@1wt.eu, colmmacc@amazon.com, luto@kernel.org, tytso@mit.edu, ebiggers@kernel.org, dwmw@amazon.co.uk, bonzini@gnu.org, sblbir@amazon.com, raduweis@amazon.com, corbet@lwn.net, mhocko@kernel.org, rafael@kernel.org, pavel@ucw.cz, mpe@ellerman.id.au, areber@redhat.com, ovzxemul@gmail.com, avagin@gmail.com, ptikhomirov@virtuozzo.com, gil@azul.com, asmehra@redhat.com, dgunigun@redhat.com, vijaysun@ca.ibm.com, oridgar@gmail.com, ghammer@redhat.com

On Tue, Jan 12, 2021 at 02:15:58PM +0200, Adrian Catangiu wrote:
> This feature is aimed at virtualized or containerized environments
> where VM or container snapshotting duplicates memory state, which is a
> challenge for applications that want to generate unique data such as
> request IDs, UUIDs, and cryptographic nonces.
> 
> The patch set introduces a mechanism that provides a userspace
> interface for applications and libraries to be made aware of uniqueness
> breaking events such as VM or container snapshotting, and allow them to
> react and adapt to such events.
> 
> Solving the uniqueness problem strongly enough for cryptographic
> purposes requires a mechanism which can deterministically reseed
> userspace PRNGs with new entropy at restore time. This mechanism must
> also support the high-throughput and low-latency use-cases that led
> programmers to pick a userspace PRNG in the first place; be usable by
> both application code and libraries; allow transparent retrofitting
> behind existing popular PRNG interfaces without changing application
> code; it must be efficient, especially on snapshot restore; and be
> simple enough for wide adoption.
> 
> The first patch in the set implements a device driver which exposes a
> read-only device /dev/sysgenid to userspace, which contains a
> monotonically increasing u32 generation counter. Libraries and
> applications are expected to open() the device, and then call read()
> which blocks until the SysGenId changes. Following an update, read()
> calls no longer block until the application acknowledges the new
> SysGenId by write()ing it back to the device. Non-blocking read() calls
> return EAGAIN when there is no new SysGenId available. Alternatively,
> libraries can mmap() the device to get a single shared page which
> contains the latest SysGenId at offset 0.

Looking at some specifications, the gen ID might actually be located
at an arbitrary address. How about instead of hard-coding the offset,
we expose it e.g. in sysfs?


> SysGenId also supports a notification mechanism exposed as two IOCTLs
> on the device. SYSGENID_GET_OUTDATED_WATCHERS immediately returns the
> number of file descriptors to the device that were open during the last
> SysGenId change but have not yet acknowledged the new id.
> SYSGENID_WAIT_WATCHERS blocks until there are no open file handles on
> the device which haven’t acknowledged the new id. These two interfaces
> are intended for serverless and container control planes, which want to
> confirm that all application code has detected and reacted to the new
> SysGenId before sending an invoke to the newly-restored sandbox.
> 
> The second patch in the set adds a VmGenId driver which makes use of
> the ACPI vmgenid device to drive SysGenId and to reseed kernel entropy
> on VM snapshots.
> 
> ---
> 
> v3 -> v4:
> 
>   - split functionality in two separate kernel modules: 
>     1. drivers/misc/sysgenid.c which provides the generic userspace
>        interface and mechanisms
>     2. drivers/virt/vmgenid.c as VMGENID acpi device driver that seeds
>        kernel entropy and acts as a driving backend for the generic
>        sysgenid
>   - renamed /dev/vmgenid -> /dev/sysgenid
>   - renamed uapi header file vmgenid.h -> sysgenid.h
>   - renamed ioctls VMGENID_* -> SYSGENID_*
>   - added ‘min_gen’ parameter to SYSGENID_FORCE_GEN_UPDATE ioctl
>   - fixed races in documentation examples
>   - various style nits
>   - rebased on top of linus latest
> 
> v2 -> v3:
> 
>   - separate the core driver logic and interface, from the ACPI device.
>     The ACPI vmgenid device is now one possible backend.
>   - fix issue when timeout=0 in VMGENID_WAIT_WATCHERS
>   - add locking to avoid races between fs ops handlers and hw irq
>     driven generation updates
>   - change VMGENID_WAIT_WATCHERS ioctl so if the current caller is
>     outdated or a generation change happens while waiting (thus making
>     current caller outdated), the ioctl returns -EINTR to signal the
>     user to handle event and retry. Fixes blocking on oneself.
>   - add VMGENID_FORCE_GEN_UPDATE ioctl conditioned by
>     CAP_CHECKPOINT_RESTORE capability, through which software can force
>     generation bump.
> 
> v1 -> v2:
> 
>   - expose to userspace a monotonically increasing u32 Vm Gen Counter
>     instead of the hw VmGen UUID
>   - since the hw/hypervisor-provided 128-bit UUID is not public
>     anymore, add it to the kernel RNG as device randomness
>   - insert driver page containing Vm Gen Counter in the user vma in
>     the driver's mmap handler instead of using a fault handler
>   - turn driver into a misc device driver to auto-create /dev/vmgenid
>   - change ioctl arg to avoid leaking kernel structs to userspace
>   - update documentation
>   - various nits
>   - rebase on top of linus latest
> 
> Adrian Catangiu (2):
>   drivers/misc: sysgenid: add system generation id driver
>   drivers/virt: vmgenid: add vm generation id driver
> 
>  Documentation/misc-devices/sysgenid.rst | 240 +++++++++++++++++++++++++
>  Documentation/virt/vmgenid.rst          |  34 ++++
>  drivers/misc/Kconfig                    |  16 ++
>  drivers/misc/Makefile                   |   1 +
>  drivers/misc/sysgenid.c                 | 298 ++++++++++++++++++++++++++++++++
>  drivers/virt/Kconfig                    |  14 ++
>  drivers/virt/Makefile                   |   1 +
>  drivers/virt/vmgenid.c                  | 153 ++++++++++++++++
>  include/uapi/linux/sysgenid.h           |  18 ++
>  9 files changed, 775 insertions(+)
>  create mode 100644 Documentation/misc-devices/sysgenid.rst
>  create mode 100644 Documentation/virt/vmgenid.rst
>  create mode 100644 drivers/misc/sysgenid.c
>  create mode 100644 drivers/virt/vmgenid.c
>  create mode 100644 include/uapi/linux/sysgenid.h
> 
> -- 
> 2.7.4
> 
> 
> 
> 
> Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in Romania. Registration number J22/2621/2005.
