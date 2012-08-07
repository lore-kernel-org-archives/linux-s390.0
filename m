From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC] s390: virtual channel subsystem and new virtio transport.
Date: Tue, 7 Aug 2012 16:52:04 +0200
Message-ID: <20120807165204.7a176ca7@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

I've been working on a new virtio transport for s390 replacing the
existing s390-virtio transport. Patches to Linux, qemu and the virtio
spec will follow.


Why?

s390-virtio is quite limited in the number of supported devices (all
related structures need to fit into a single specially mapped page),
and does not support hotunplug. It is also completely dissimilar to
other devices on s390.


What's the alternative?

The classic method of discovering and addressing devices on s390 is via
channel I/O. Devices are accessed through subchannels and driven via
control units. A set of instructions operates on subchannels and allows
the operating system to send channel programs to the control
unit/device. Hot(un)plug of devices is reported via channel reports.

This method of accessing devices is well architectured and supported by
every s390 operating system (for Linux, the common I/O layer under
drivers/s390/cio handles the non device-specific work).

More information about channel I/O can be found in the z/Architecture
Principles of Operation (SA22-7832), chapter 13 ff. Also of interest
might be Common I/O-Device Commands and Self-Description (SA22-7204).

My patches implement support for virtual subchannels in kvm/s390
(Linux) and qemu (!kvm).


How does this tie in with virtio?

virtio devices in the host show up with a special (architectured)
control unit type (0x3832). The type (block,...) of the virtio device
is reflected in the control unit model. All virtual subchannels/devices
are in a special virtual channel subsystem (architectured id 0xfe).

For setting up virtqueues etc., a set of channel commands has been
defined for the virtio control unit type. Setting up thus works
completely through channel programs.

Guest -> host notification is implemented through normal I/O
interrupts; host -> guest notification is done via a new subcode to the
kvm diagnose (hypercall).

Host support for virtio-ccw is implemented in qemu.


How does this look in action?

The Linux guest looks like a normal s390 Linux guest with some channel
devices:

[root@localhost ~]# lscss
Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs
----------------------------------------------------------------------
0.0.0000 0.0.0000  0000/00 3832/01 yes  80  80  ff   00000000 00000000 
0.0.0815 0.0.0001  0000/00 3832/02 yes  80  80  ff   00000000 00000000 
0.0.9999 0.0.0002  0000/00 3832/03 yes  80  80  ff   00000000 00000000 
0.1.abcd 0.1.0000  0000/00 3832/05 yes  80  80  ff   00000000 00000000 

[root@localhost ~]# lschp
CHPID  Vary  Cfg.  Type  Cmg  Shared  PCHID
============================================
0.00   1     -     32    -    0       -    


How can you try this out?

The patches should apply on top of kvm-next (Linux) resp. qemu head.

qemu device drivers are called virtio-xxx-ccw, the default machine type
is s390-ccw(-virtio).

You can specify an optional device id with the 'devno' property:

-device virtio-balloon-ccw,devno=fe.1.abcd

Note that the virtual channel subsystem id 0xfe needs to be specified;
in the guest, the devices will show in the default channel subsystem
(0x00).


Feedback welcome!

Cornelia
