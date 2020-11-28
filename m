Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732513AbgK1TB4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Nov 2020 14:01:56 -0500
Date: Sat, 28 Nov 2020 12:16:04 +0200
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v3] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201128101604.GC557259@kernel.org>
References: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com>
 <300d4404-3efe-880e-ef30-692eabbff5f7@de.ibm.com>
 <da1a1fa7-a1de-d0e6-755b-dd587687765e@amazon.de>
 <20201119173800.GD8537@kernel.org>
 <1cdb6fac-0d50-3399-74a6-24c119ebbaa5@amazon.de>
 <106f56ca-49bc-7cad-480f-4b26656e90ce@gmail.com>
 <96625ce2-66c6-34b8-ef81-7c17c05b4c7a@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <96625ce2-66c6-34b8-ef81-7c17c05b4c7a@amazon.com>
List-ID: <linux-s390.vger.kernel.org>
To: "Catangiu, Adrian Costin" <acatan@amazon.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Alexander Graf <graf@amazon.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Jann Horn <jannh@google.com>, Willy Tarreau <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, linux-s390 <linux-s390@vger.kernel.org>, "areber@redhat.com" <areber@redhat.com>, Pavel Emelyanov <ovzxemul@gmail.com>, Andrey Vagin <avagin@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Hi Adrian,

Usually each version of a patch is a separate e-mail thread

On Fri, Nov 27, 2020 at 08:26:02PM +0200, Catangiu, Adrian Costin wrote:
> - Background
>=20
> The VM Generation ID is a feature defined by Microsoft (paper:
> http://go.microsoft.com/fwlink/?LinkId=3D260709) and supported by
> multiple hypervisor vendors.
>=20
> The feature is required in virtualized environments by apps that work
> with local copies/caches of world-unique data such as random values,
> uuids, monotonically increasing counters, etc.
> Such apps can be negatively affected by VM snapshotting when the VM
> is either cloned or returned to an earlier point in time.
>=20
> The VM Generation ID is a simple concept meant to alleviate the issue
> by providing a unique ID that changes each time the VM is restored
> from a snapshot. The hw provided UUID value can be used to
> differentiate between VMs or different generations of the same VM.
>=20
> - Problem
>=20
> The VM Generation ID is exposed through an ACPI device by multiple
> hypervisor vendors but neither the vendors or upstream Linux have no
> default driver for it leaving users to fend for themselves.
>=20
> Furthermore, simply finding out about a VM generation change is only
> the starting point of a process to renew internal states of possibly
> multiple applications across the system. This process could benefit
> from a driver that provides an interface through which orchestration
> can be easily done.
>=20
> - Solution
>=20
> This patch is a driver that exposes a monotonic incremental Virtual
> Machine Generation u32 counter via a char-dev FS interface. The FS
> interface provides sync and async VmGen counter updates notifications.
> It also provides VmGen counter retrieval and confirmation mechanisms.
>=20
> The generation counter and the interface through which it is exposed
> are available even when there is no acpi device present.
>=20
> When the device is present, the hw provided UUID is not exposed to
> userspace, it is internally used by the driver to keep accounting for
> the exposed VmGen counter. The counter starts from zero when the
> driver is initialized and monotonically increments every time the hw
> UUID changes (the VM generation changes).
> On each hw UUID change, the new hypervisor-provided UUID is also fed
> to the kernel RNG.
>=20
> If there is no acpi vmgenid device present, the generation changes are
> not driven by hw vmgenid events but can be driven by software through
> a dedicated driver ioctl.
>=20
> This patch builds on top of Or Idgar <oridgar@gmail.com>'s proposal
> https://lkml.org/lkml/2018/3/1/498
>=20
> - Future improvements
>=20
> Ideally we would want the driver to register itself based on devices'
> _CID and not _HID, but unfortunately I couldn't find a way to do that.
> The problem is that ACPI device matching is done by
> '__acpi_match_device()' which exclusively looks at
> 'acpi_hardware_id *hwid'.
>=20
> There is a path for platform devices to match on _CID when _HID is
> 'PRP0001' - but this is not the case for the Qemu vmgenid device.
>=20
> Guidance and help here would be greatly appreciated.
>=20
> Signed-off-by: Adrian Catangiu <acatan@amazon.com>
>=20
> ---
=20
Please put the history in the descending order next time

v2 -> v3:
...

v1 -> v2:
...

> v1 -> v2:
>=20
> =EF=BF=BD - expose to userspace a monotonically increasing u32 Vm Gen Cou=
nter
> =EF=BF=BD=EF=BF=BD=EF=BF=BD instead of the hw VmGen UUID
> =EF=BF=BD - since the hw/hypervisor-provided 128-bit UUID is not public
> =EF=BF=BD=EF=BF=BD=EF=BF=BD anymore, add it to the kernel RNG as device r=
andomness
> =EF=BF=BD - insert driver page containing Vm Gen Counter in the user vma =
in
> =EF=BF=BD=EF=BF=BD=EF=BF=BD the driver's mmap handler instead of using a =
fault handler
> =EF=BF=BD - turn driver into a misc device driver to auto-create /dev/vmg=
enid
> =EF=BF=BD - change ioctl arg to avoid leaking kernel structs to userspace
> =EF=BF=BD - update documentation
> =EF=BF=BD - various nits
> =EF=BF=BD - rebase on top of linus latest
>=20
> v2 -> v3:
>=20
> =EF=BF=BD - separate the core driver logic and interface, from the ACPI d=
evice.
> =EF=BF=BD=EF=BF=BD=EF=BF=BD The ACPI vmgenid device is now one possible b=
ackend.
> =EF=BF=BD - fix issue when timeout=3D0 in VMGENID_WAIT_WATCHERS
> =EF=BF=BD - add locking to avoid races between fs ops handlers and hw irq
> =EF=BF=BD=EF=BF=BD=EF=BF=BD driven generation updates
> =EF=BF=BD - change VMGENID_WAIT_WATCHERS ioctl so if the current caller is
> =EF=BF=BD=EF=BF=BD=EF=BF=BD outdated or a generation change happens while=
 waiting (thus making
> =EF=BF=BD=EF=BF=BD=EF=BF=BD current caller outdated), the ioctl returns -=
EINTR to signal the
> =EF=BF=BD=EF=BF=BD=EF=BF=BD user to handle event and retry. Fixes blockin=
g on oneself.
> =EF=BF=BD - add VMGENID_FORCE_GEN_UPDATE ioctl conditioned by
> =EF=BF=BD=EF=BF=BD=EF=BF=BD CAP_CHECKPOINT_RESTORE capability, through wh=
ich software can force
> =EF=BF=BD=EF=BF=BD=EF=BF=BD generation bump.
> ---
> =EF=BF=BDDocumentation/virt/vmgenid.rst | 240 +++++++++++++++++++++++
> =EF=BF=BDdrivers/virt/Kconfig=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD |=EF=BF=BD 17 ++
> =EF=BF=BDdrivers/virt/Makefile=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD |=EF=BF=BD=EF=BF=BD 1 +
> =EF=BF=BDdrivers/virt/vmgenid.c=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD | 435 ++++++++++++++++++++++++++++++++++++++=
+++
> =EF=BF=BDinclude/uapi/linux/vmgenid.h=EF=BF=BD=EF=BF=BD |=EF=BF=BD 14 ++
> =EF=BF=BD5 files changed, 707 insertions(+)
> =EF=BF=BDcreate mode 100644 Documentation/virt/vmgenid.rst
> =EF=BF=BDcreate mode 100644 drivers/virt/vmgenid.c
> =EF=BF=BDcreate mode 100644 include/uapi/linux/vmgenid.h
>=20
> diff --git a/Documentation/virt/vmgenid.rst b/Documentation/virt/vmgenid.=
rst
> new file mode 100644
> index 0000000..b6a9f8d
> --- /dev/null
> +++ b/Documentation/virt/vmgenid.rst
> @@ -0,0 +1,240 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +VMGENID
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The "=3D=3D" line should be the same length as the title, I think.

> +
> +The VM Generation ID is a feature defined by Microsoft (paper:
> +http://go.microsoft.com/fwlink/?LinkId=3D260709) and supported by
> +multiple hypervisor vendors.
> +
> +The feature is required in virtualized environments by apps that work

Please spell 'applications' fully

> +with local copies/caches of world-unique data such as random values,
> +uuids, monotonically increasing counters, etc.

UUIDs

> +Such apps can be negatively affected by VM snapshotting when the VM

       ^applications

> +is either cloned or returned to an earlier point in time.
> +
> +The VM Generation ID is a simple concept meant to alleviate the issue
> +by providing a unique ID that changes each time the VM is restored
> +from a snapshot. The hw provided UUID value can be used to

                       ^hardware (and below as well)

> +differentiate between VMs or different generations of the same VM.
> +
> +The VM Generation ID is exposed through an ACPI device by multiple
> +hypervisor vendors. The driver for it lives at
> +``drivers/virt/vmgenid.c``
> +
> +The ``vmgenid`` driver exposes a monotonic incremental Virtual
> +Machine Generation u32 counter via a char-dev FS interface that
> +provides sync and async VmGen counter updates notifications. It also
> +provides VmGen counter retrieval and confirmation mechanisms.

It would be nice to memntion here the name of the chardev :)

> +This counter and the interface through which it is exposed are
> +available even when there is no acpi device present.
> +
> +When the device is present, the hw provided UUID is not exposed to
> +userspace, it is internally used by the driver to keep accounting for
> +the exposed VmGen counter. The counter starts from zero when the
> +driver is initialized and monotonically increments every time the hw
> +UUID changes (the VM generation changes).
> +On each hw UUID change, the new UUID is also fed to the kernel RNG.
> +
> +If there is no acpi vmgenid device present, the generation changes are
> +not driven by hw vmgenid events and thus should be driven by software
> +through a dedicated driver ioctl.
> +
> +Driver interface:
> +
> +``open()``:
> +=EF=BF=BD When the device is opened, a copy of the current Vm-Gen-Id (co=
unter)
> +=EF=BF=BD is associated with the open file descriptor. The driver now tr=
acks
> +=EF=BF=BD this file as an independent *watcher*. The driver tracks how m=
any
> +=EF=BF=BD watchers are aware of the latest Vm-Gen-Id counter and how man=
y of
> +=EF=BF=BD them are *outdated*; outdated being those that have lived thro=
ugh
> +=EF=BF=BD a Vm-Gen-Id change but not yet confirmed the new generation co=
unter.
> +
> +``read()``:
> +=EF=BF=BD Read is meant to provide the *new* VM generation counter when a
> +=EF=BF=BD generation change takes place. The read operation blocks until=
 the
> +=EF=BF=BD associated counter is no longer up to date - until HW vm gen id
> +=EF=BF=BD changes - at which point the new counter is provided/returned.
> +=EF=BF=BD Nonblocking ``read()`` uses ``EAGAIN`` to signal that there is=
 no
> +=EF=BF=BD *new* counter value available. The generation counter is consi=
dered
> +=EF=BF=BD *new* for each open file descriptor that hasn't confirmed the =
new
> +=EF=BF=BD value, following a generation change. Therefore, once a genera=
tion
> +=EF=BF=BD change takes place, all ``read()`` calls will immediately retu=
rn the
> +=EF=BF=BD new generation counter and will continue to do so until the
> +=EF=BF=BD new value is confirmed back to the driver through ``write()``.
> +=EF=BF=BD Partial reads are not allowed - read buffer needs to be at lea=
st
> +=EF=BF=BD ``sizeof(unsigned)`` in size.
> +
> +``write()``:
> +=EF=BF=BD Write is used to confirm the up-to-date Vm Gen counter back to=
 the
> +=EF=BF=BD driver.
> +=EF=BF=BD Following a VM generation change, all existing watchers are ma=
rked
> +=EF=BF=BD as *outdated*. Each file descriptor will maintain the *outdate=
d*
> +=EF=BF=BD status until a ``write()`` confirms the up-to-date counter bac=
k to
> +=EF=BF=BD the driver.
> +=EF=BF=BD Partial writes are not allowed - write buffer should be exactly
> +=EF=BF=BD ``sizeof(unsigned)`` in size.
> +
> +``poll()``:
> +=EF=BF=BD Poll is implemented to allow polling for generation counter up=
dates.
> +=EF=BF=BD Such updates result in ``EPOLLIN`` polling status until the new
> +=EF=BF=BD up-to-date counter is confirmed back to the driver through a
> +=EF=BF=BD ``write()``.
> +
> +``ioctl()``:
> +=EF=BF=BD The driver also adds support for tracking count of open file
> +=EF=BF=BD descriptors that haven't acknowledged a generation counter upd=
ate.
> +=EF=BF=BD This is exposed through two IOCTLs:
> +
> +=EF=BF=BD - VMGENID_GET_OUTDATED_WATCHERS: immediately returns the numbe=
r of
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD *outdated* watchers - number of file descrip=
tors that were open
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD during a VM generation change, and which hav=
e not yet confirmed the
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD new generation counter.
> +=EF=BF=BD - VMGENID_WAIT_WATCHERS: blocks until there are no more *outda=
ted*
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD watchers, or if a ``timeout`` argument is pr=
ovided, until the
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD timeout expires.
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD If the current caller is *outdated* or a gen=
eration change happens
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD while waiting (thus making current caller *o=
utdated*), the ioctl
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD returns ``-EINTR`` to signal the user to han=
dle event and retry.
> +=EF=BF=BD - VMGENID_FORCE_GEN_UPDATE: forces a generation counter bump. =
Can only
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD be used by processes with CAP_CHECKPOINT_RES=
TORE or CAP_SYS_ADMIN
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD capabilities.
> +
> +``mmap()``:
> +=EF=BF=BD The driver supports ``PROT_READ, MAP_SHARED`` mmaps of a singl=
e page
> +=EF=BF=BD in size. The first 4 bytes of the mapped page will contain an
> +=EF=BF=BD up-to-date copy of the VM generation counter.
> +=EF=BF=BD The mapped memory can be used as a low-latency generation coun=
ter
> +=EF=BF=BD probe mechanism in critical sections - see examples.
> +
> +``close()``:
> +=EF=BF=BD Removes the file descriptor as a Vm generation counter watcher.
> +
> +Example application workflows
> +-----------------------------
> +
> +1) Watchdog thread simplified example::
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD void watchdog_thread_handler(int *thread_act=
ive)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned genid;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD int fd =3D open(=
"/dev/vmgenid", O_RDWR | O_CLOEXEC, S_IRUSR |
> S_IWUSR);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD do {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD // read new gen ID - blocks until VM generation changes
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD read(fd, &genid, sizeof(genid));
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD // because of VM generation change, we need to rebuild world
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD reseed_app_env();
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD // confirm we're done handling gen ID update
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD write(fd, &genid, sizeof(genid));
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD } while (atomic_=
read(thread_active));
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD close(fd);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +2) ASYNC simplified example::
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD void handle_io_on_vmgenfd(int vmgenfd)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned genid;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // read new gen =
ID - we need it to confirm we've handled update
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD read(fd, &genid,=
 sizeof(genid));
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // because of VM=
 generation change, we need to rebuild world
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD reseed_app_env();
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // confirm we're=
 done handling the gen ID update
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD write(fd, &genid=
, sizeof(genid));
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD int main() {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD int epfd, vmgenf=
d;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD struct epoll_eve=
nt ev;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD epfd =3D epoll_c=
reate(EPOLL_QUEUE_LEN);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD vmgenfd =3D open=
("/dev/vmgenid",
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD O_RDWR | O_CLOEXEC | O_NONBLOCK,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD S_IRUSR | S_IWUSR);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // register vmge=
nid for polling
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD ev.events =3D EP=
OLLIN;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD ev.data.fd =3D v=
mgenfd;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD epoll_ctl(epfd, =
EPOLL_CTL_ADD, vmgenfd, &ev);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // register othe=
r parts of your app for polling
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // ...
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD while (1) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD // wait for something to do...
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD int nfds =3D epoll_wait(epfd, events,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD MAX_EPOLL_EVENTS_PER_RUN,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD EPOLL_RUN_TIMEOUT);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD if (nfds < 0) die("Error in epoll_wait!");
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD // for each ready fd
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD for(int i =3D 0; i < nfds; i++) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD int fd =3D events[i].data.fd;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD if (fd =3D=3D vmgenfd)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD handle=
_io_on_vmgenfd(vmgenfd);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD else
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD handle=
_some_other_part_of_the_app(fd);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD }
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return 0;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +3) Mapped memory polling simplified example::
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD /*
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD* app/library function that provide=
s cached secrets
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD*/
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD char * safe_cached_secret(app_data_t *app)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD char *secret;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD volatile unsigne=
d *const genid_ptr =3D get_vmgenid_mapping(app);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD again:
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD secret =3D __cac=
hed_secret(app);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD if (unlikely(*ge=
nid_ptr !=3D app->cached_genid)) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD // rebuild world then confirm the genid update (thru write)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD rebuild_caches(app);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD app->cached_genid =3D *genid_ptr;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD ack_vmgenid_update(app);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD goto again;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return secret;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +4) Orchestrator simplified example::
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD /*
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD* orchestrator - manages multiple a=
pps and libraries used by a service
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD* and tries to make sure all sensit=
ive components gracefully handle
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD* VM generation changes.
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD* Following function is called on d=
etection of a VM generation change.
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD*/
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD int handle_vmgen_update(int vmgen_fd, unsign=
ed new_gen_id)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // pause until a=
ll components have handled event
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD pause_service();
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // confirm *this=
* watcher as up-to-date
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD write(vmgen_fd, =
&new_gen_id, sizeof(unsigned));
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // wait for all =
*others* for at most 5 seconds.
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD ioctl(vmgen_fd, =
VMGENID_WAIT_WATCHERS, 5000);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD // all apps on t=
he system have rebuilt worlds
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD resume_service();
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 80c5f9c1..5d5f37b 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -13,6 +13,23 @@ menuconfig VIRT_DRIVERS
> =EF=BF=BD
> =EF=BF=BDif VIRT_DRIVERS
> =EF=BF=BD
> +config VMGENID
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD tristate "Virtual Machine Generation ID driv=
er"
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD depends on ACPI

I think this is not needed. We have /dev/vmgenid regardless of ACPI
device for container usecase and we may have a different HW emulation
for s390 and PowerPC.

> +=EF=BF=BD=EF=BF=BD=EF=BF=BD default N
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD help
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD This is a Virtual Machine Generati=
on ID driver which provides
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD a virtual machine generation count=
er. The driver exposes FS ops
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD on /dev/vmgenid through which it c=
an provide information and
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD notifications on VM generation cha=
nges that happen on snapshots
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD or cloning.
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD This enables applications and libr=
aries that store or cache
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD sensitive information, to know tha=
t they need to regenerate it
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD after process memory has been expo=
sed to potential copying.
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD To compile this driver as a module=
, choose M here: the
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD module will be called vmgenid.
> +
> =EF=BF=BDconfig FSL_HV_MANAGER
> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD tristate "Freescale hypervisor manag=
ement driver"
> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD depends on FSL_SOC
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index f28425c..889be01 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -4,6 +4,7 @@
> =EF=BF=BD#
> =EF=BF=BD
> =EF=BF=BDobj-$(CONFIG_FSL_HV_MANAGER)=EF=BF=BD=EF=BF=BD=EF=BF=BD +=3D fsl=
_hypervisor.o
> +obj-$(CONFIG_VMGENID)=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=
=BF=BD +=3D vmgenid.o
> =EF=BF=BDobj-y=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=
=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD +=3D vboxguest/
> =EF=BF=BD
> =EF=BF=BDobj-$(CONFIG_NITRO_ENCLAVES)=EF=BF=BD=EF=BF=BD=EF=BF=BD +=3D nit=
ro_enclaves/
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> new file mode 100644
> index 0000000..c4d4683
> --- /dev/null
> +++ b/drivers/virt/vmgenid.c
> @@ -0,0 +1,435 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtual Machine Generation ID driver
> + *
> + * Copyright (C) 2018 Red Hat Inc. All rights reserved.
> + *
> + * Copyright (C) 2020 Amazon. All rights reserved.
> + *
> + *=EF=BF=BD=EF=BF=BD=EF=BF=BD Authors:
> + *=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD Adrian Catangiu <acatan@amazon.c=
om>
> + *=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD Or Idgar <oridgar@gmail.com>
> + *=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD Gal Hammer <ghammer@redhat.com>
> + *
> + */
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +#include <linux/random.h>
> +#include <linux/uuid.h>
> +#include <linux/vmgenid.h>
> +
> +#define DEV_NAME "vmgenid"
> +ACPI_MODULE_NAME(DEV_NAME);
> +
> +struct acpi_data {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD uuid_t uuid;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD void=EF=BF=BD=EF=BF=BD *uuid_iomap;
> +};
> +
> +struct driver_data {

I'd suggest vmgenid_data

> +=EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned long=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD map_buf;

We use tab=3D8 for indentation. Please run your patch though
scripts/checkpatch.pl to make sure it conforms the coding style.

> +=EF=BF=BD=EF=BF=BD=EF=BF=BD wait_queue_head_t read_waitq;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD atomic_t=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD generation_counter;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned int=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD watchers;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD atomic_t=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD outdated_watchers;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD wait_queue_head_t outdated_waitq;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spinlock_t=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD lock;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct acpi_data=EF=BF=BD *acpi_data;
> +};
> +struct driver_data driver_data;

static=20

> +
> +struct file_data {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned int acked_gen_counter;
> +};
> +
> +static int equals_gen_counter(unsigned int counter)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return counter =3D=3D atomic_read(&driver_da=
ta.generation_counter);
> +}
> +
> +static void vmgenid_bump_generation(void)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned long flags;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD int counter;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spin_lock_irqsave(&driver_data.lock, flags);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD counter =3D atomic_inc_return(&driver_data.g=
eneration_counter);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD *((int *) driver_data.map_buf) =3D counter;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD atomic_set(&driver_data.outdated_watchers, d=
river_data.watchers);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD wake_up_interruptible(&driver_data.read_wait=
q);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD wake_up_interruptible(&driver_data.outdated_=
waitq);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spin_unlock_irqrestore(&driver_data.lock, fl=
ags);
> +}
> +
> +static void vmgenid_put_outdated_watchers(void)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (atomic_dec_and_test(&driver_data.outdate=
d_watchers))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD wake_up_interrup=
tible(&driver_data.outdated_waitq);
> +}
> +
> +static int vmgenid_open(struct inode *inode, struct file *file)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct file_data *fdata =3D kzalloc(sizeof(s=
truct file_data),
> GFP_KERNEL);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned long flags;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!fdata)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -ENOMEM;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spin_lock_irqsave(&driver_data.lock, flags);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD fdata->acked_gen_counter =3D
> atomic_read(&driver_data.generation_counter);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD ++driver_data.watchers;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spin_unlock_irqrestore(&driver_data.lock, fl=
ags);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD file->private_data =3D fdata;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return 0;
> +}
> +
> +static int vmgenid_close(struct inode *inode, struct file *file)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct file_data *fdata =3D file->private_da=
ta;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned long flags;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spin_lock_irqsave(&driver_data.lock, flags);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!equals_gen_counter(fdata->acked_gen_cou=
nter))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD vmgenid_put_outd=
ated_watchers();
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD --driver_data.watchers;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spin_unlock_irqrestore(&driver_data.lock, fl=
ags);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD kfree(fdata);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return 0;
> +}
> +
> +static ssize_t
> +vmgenid_read(struct file *file, char __user *ubuf, size_t nbytes,

Please keep the function name at the same line as return type and wrap
parameters to the next line.

> loff_t *ppos)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct file_data *fdata =3D file->private_da=
ta;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD ssize_t ret;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD int gen_counter;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (nbytes =3D=3D 0)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return 0;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD /* disallow partial reads */
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (nbytes < sizeof(gen_counter))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EINVAL;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (equals_gen_counter(fdata->acked_gen_coun=
ter)) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD if (file->f_flag=
s & O_NONBLOCK)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD return -EAGAIN;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D wait_eve=
nt_interruptible(
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD driver_data.read_waitq,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD !equals_gen_counter(fdata->acked_gen_counter)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD );
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD if (ret)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD return ret;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD gen_counter =3D atomic_read(&driver_data.gen=
eration_counter);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D copy_to_user(ubuf, &gen_counter, siz=
eof(gen_counter));
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (ret)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EFAULT;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return sizeof(gen_counter);
> +}
> +
> +static ssize_t vmgenid_write(struct file *file, const char __user *ubuf,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD size_t count, loff_t *ppos)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct file_data *fdata =3D file->private_da=
ta;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned int new_acked_gen;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned long flags;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD /* disallow partial writes */
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (count !=3D sizeof(new_acked_gen))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EINVAL;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (copy_from_user(&new_acked_gen, ubuf, cou=
nt))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EFAULT;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spin_lock_irqsave(&driver_data.lock, flags);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD /* wrong gen-counter acknowledged */
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!equals_gen_counter(new_acked_gen)) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD spin_unlock_irqr=
estore(&driver_data.lock, flags);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EINVAL;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!equals_gen_counter(fdata->acked_gen_cou=
nter)) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD fdata->acked_gen=
_counter =3D new_acked_gen;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD vmgenid_put_outd=
ated_watchers();
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spin_unlock_irqrestore(&driver_data.lock, fl=
ags);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return (ssize_t)count;
> +}
> +
> +static __poll_t
> +vmgenid_poll(struct file *file, poll_table *wait)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD __poll_t mask =3D 0;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct file_data *fdata =3D file->private_da=
ta;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!equals_gen_counter(fdata->acked_gen_cou=
nter))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return EPOLLIN |=
 EPOLLRDNORM;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD poll_wait(file, &driver_data.read_waitq, wai=
t);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!equals_gen_counter(fdata->acked_gen_cou=
nter))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD mask =3D EPOLLIN=
 | EPOLLRDNORM;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return mask;
> +}
> +
> +static long vmgenid_ioctl(struct file *file,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned int cmd=
, unsigned long arg)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct file_data *fdata =3D file->private_da=
ta;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD unsigned long timeout_ns;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD ktime_t until;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD int ret =3D 0;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD switch (cmd) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD case VMGENID_GET_OUTDATED_WATCHERS:
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D atomic_r=
ead(&driver_data.outdated_watchers);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD break;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD case VMGENID_WAIT_WATCHERS:
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD timeout_ns =3D a=
rg * NSEC_PER_MSEC;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD until =3D timeou=
t_ns ? ktime_set(0, timeout_ns) : KTIME_MAX;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D wait_eve=
nt_interruptible_hrtimeout(
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD driver_data.outdated_waitq,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD (!atomic_read(&driver_data.outdated_watchers) ||
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD !equal=
s_gen_counter(fdata->acked_gen_counter)),
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD until
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD );
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD if (atomic_read(=
&driver_data.outdated_watchers))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD ret =3D -EINTR;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD else
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD ret =3D 0;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD break;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD case VMGENID_FORCE_GEN_UPDATE:
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD if (!checkpoint_=
restore_ns_capable(current_user_ns()))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD return -EACCES;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD vmgenid_bump_gen=
eration();
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD break;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD default:
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D -EINVAL;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD break;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return ret;
> +}
> +
> +static int vmgenid_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct file_data *fdata =3D file->private_da=
ta;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (vma->vm_pgoff !=3D 0 || vma_pages(vma) >=
 1)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EINVAL;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if ((vma->vm_flags & VM_WRITE) !=3D 0)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EPERM;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD vma->vm_flags |=3D VM_DONTEXPAND | VM_DONTDU=
MP;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD vma->vm_flags &=3D ~VM_MAYWRITE;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD vma->vm_private_data =3D fdata;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return vm_insert_page(vma, vma->vm_start,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=
=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD virt_to_page(driver_data.map_buf));
> +}
> +
> +static const struct file_operations fops =3D {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .owner=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =3D THIS_MODULE,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .mmap=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =3D vmgenid_mmap,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .open=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =3D vmgenid_open,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .release=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD =3D vmgenid_close,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .read=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =3D vmgenid_read,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .write=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =3D vmgenid_write,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .poll=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =3D vmgenid_poll,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .unlocked_ioctl =3D vmgenid_ioctl,
> +};
> +
> +struct miscdevice vmgenid_misc =3D {

static

> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .minor =3D MISC_DYNAMIC_MINOR,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .name =3D "vmgenid",
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .fops =3D &fops,
> +};
> +
> +static int vmgenid_acpi_map(struct acpi_data *priv, acpi_handle handle)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD int i;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD phys_addr_t phys_addr;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct acpi_buffer buffer =3D { ACPI_ALLOCAT=
E_BUFFER, NULL };
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD acpi_status status;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD union acpi_object *pss;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD union acpi_object *element;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD status =3D acpi_evaluate_object(handle, "ADD=
R", NULL, &buffer);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (ACPI_FAILURE(status)) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD ACPI_EXCEPTION((=
AE_INFO, status, "Evaluating ADDR"));
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -ENODEV;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD pss =3D buffer.pointer;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!pss || pss->type !=3D ACPI_TYPE_PACKAGE=
 || pss->package.count !=3D 2)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EINVAL;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD phys_addr =3D 0;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD for (i =3D 0; i < pss->package.count; i++) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD element =3D &(ps=
s->package.elements[i]);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD if (element->typ=
e !=3D ACPI_TYPE_INTEGER)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD return -EINVAL;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD phys_addr |=3D e=
lement->integer.value << i * 32;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD priv->uuid_iomap =3D acpi_os_map_memory(phys=
_addr, sizeof(uuid_t));
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!priv->uuid_iomap) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD pr_err("Could no=
t map memory at 0x%llx, size %u\n",
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD phys_addr,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=
=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD (u32) sizeof(uuid_t));
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -ENOMEM;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD memcpy_fromio(&priv->uuid, priv->uuid_iomap,=
 sizeof(uuid_t));
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return 0;
> +}
> +
> +static int vmgenid_acpi_add(struct acpi_device *device)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD int ret;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!device)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EINVAL;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD driver_data.acpi_data =3D kzalloc(sizeof(str=
uct acpi_data), GFP_KERNEL);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!driver_data.acpi_data) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD pr_err("vmgenid:=
 failed to allocate acpi_data\n");
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -ENOMEM;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD device->driver_data =3D &driver_data;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D vmgenid_acpi_map(driver_data.acpi_da=
ta, device->handle);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (ret < 0) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD pr_err("vmgenid:=
 failed to map acpi device\n");
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD goto err;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return 0;
> +
> +err:
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD kfree(driver_data.acpi_data);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD driver_data.acpi_data =3D NULL;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return ret;
> +}
> +
> +static int vmgenid_acpi_remove(struct acpi_device *device)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct acpi_data *priv;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!device || !acpi_driver_data(device))
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -EINVAL;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD device->driver_data =3D NULL;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD priv =3D driver_data.acpi_data;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD driver_data.acpi_data =3D NULL;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (priv && priv->uuid_iomap)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD acpi_os_unmap_me=
mory(priv->uuid_iomap, sizeof(uuid_t));
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD kfree(priv);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return 0;
> +}
> +
> +static void vmgenid_acpi_notify(struct acpi_device *device, u32 event)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD struct acpi_data *priv;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD uuid_t old_uuid;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!device || !acpi_driver_data(device)) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD pr_err("VMGENID =
notify with NULL private data\n");
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD priv =3D driver_data.acpi_data;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD /* update VM Generation UUID */
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD old_uuid =3D priv->uuid;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD memcpy_fromio(&priv->uuid, priv->uuid_iomap,=
 sizeof(uuid_t));
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (memcmp(&old_uuid, &priv->uuid, sizeof(uu=
id_t))) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD /* HW uuid updat=
ed */
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD vmgenid_bump_gen=
eration();
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD add_device_rando=
mness(&priv->uuid, sizeof(uuid_t));
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +}
> +
> +static const struct acpi_device_id vmgenid_ids[] =3D {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD {"QEMUVGID", 0},
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD {"", 0},
> +};
> +
> +static struct acpi_driver acpi_vmgenid_driver =3D {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .name =3D "vm_generation_id",
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .ids =3D vmgenid_ids,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .owner =3D THIS_MODULE,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD .ops =3D {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD .add =3D vmgenid=
_acpi_add,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD .remove =3D vmge=
nid_acpi_remove,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD .notify =3D vmge=
nid_acpi_notify,
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +};
> +
> +static int __init vmgenid_init(void)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD int ret;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD driver_data.map_buf =3D get_zeroed_page(GFP_=
KERNEL);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!driver_data.map_buf)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD return -ENOMEM;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD atomic_set(&driver_data.generation_counter, =
0);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD atomic_set(&driver_data.outdated_watchers, 0=
);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD init_waitqueue_head(&driver_data.read_waitq);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD init_waitqueue_head(&driver_data.outdated_wa=
itq);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD spin_lock_init(&driver_data.lock);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD driver_data.acpi_data =3D NULL;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D misc_register(&vmgenid_misc);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (ret < 0) {
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD pr_err("misc_reg=
ister() failed for vmgenid\n");
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD goto err;
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D acpi_bus_register_driver(&acpi_vmgen=
id_driver);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD if (ret < 0)
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD pr_warn("No vmge=
nid acpi device found\n");

I think this needs to be reworked to support no-ACPI version. For
instance we can call here something like

	ret =3D vmgenid_hw_register();

and have=20

#ifdef CONFIG_ACPI
static int vmgenid_hw_register(void)
{
	return acpi_bus_register_driver(&acpi_vmgenid_driver);
}
#else
static int vmgenid_hw_register(void)
{
	return 0;
}
#endif

> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return 0;
> +
> +err:
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD free_pages(driver_data.map_buf, 0);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD driver_data.map_buf =3D 0;
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD return ret;
> +}
> +
> +static void __exit vmgenid_exit(void)
> +{
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD acpi_bus_unregister_driver(&acpi_vmgenid_dri=
ver);
> +
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD misc_deregister(&vmgenid_misc);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD free_pages(driver_data.map_buf, 0);
> +=EF=BF=BD=EF=BF=BD=EF=BF=BD driver_data.map_buf =3D 0;
> +}
> +
> +module_init(vmgenid_init);
> +module_exit(vmgenid_exit);
> +
> +MODULE_AUTHOR("Adrian Catangiu");
> +MODULE_DESCRIPTION("Virtual Machine Generation ID");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("0.1");
> diff --git a/include/uapi/linux/vmgenid.h b/include/uapi/linux/vmgenid.h
> new file mode 100644
> index 0000000..9316b00
> --- /dev/null
> +++ b/include/uapi/linux/vmgenid.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_LINUX_VMGENID_H
> +#define _UAPI_LINUX_VMGENID_H
> +
> +#include <linux/ioctl.h>
> +
> +#define VMGENID_IOCTL 0x2d
> +#define VMGENID_GET_OUTDATED_WATCHERS _IO(VMGENID_IOCTL, 1)
> +#define VMGENID_WAIT_WATCHERS=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD _IO(VMGENID_IOCTL, 2)
> +#define VMGENID_FORCE_GEN_UPDATE=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD _IO(VMGENID_IOCTL, 3)
> +
> +#endif /* _UAPI_LINUX_VMGENID_H */
> +
> --=20
> 2.7.4
>=20

--=20
Sincerely yours,
Mike.
