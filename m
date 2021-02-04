Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [RFC v2 0/1] s390/pci: expose UID checking state in sysfs
Date: Thu,  4 Feb 2021 10:43:52 +0100
Message-Id: <20210204094353.63819-1-schnelle@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>

Hi Bjorn,

this is a follow-up to my previous RFC of exposing our s390 specific UID
Checking attribute at /sys/bus/pci/zpci/unique_uids. As suggested by Greg
(thanks!) this version changes things to use named attributes directly without
resorting to any raw kobject handling, as a result the code moves to
drivers/pci/pci-sysfs.c with a CONFIG_S390 ifdef. Also I've changed the wording
to be more restrictive about what this attribute means. Instead of directly
calling out its current use to determine if UIDs are used as PCI domains it now
only explicitly claims that /sys/bus/pci/devices/<dev>/uid is guaranteed to be
a unique user-defined (in the zVM/KVM/LPAR configuration not Linux user-space)
identifier for the PCI function.

We've had some more internal discussion on this and are also considering to
instead put this attribute at /sys/firmware/zpci/unique_uids but as far as
I can see this strictly requires the use of raw kobject handling and loses us
the direct relation with PCI so I wanted to give this just one more shot and
get your opinion on it.

Thanks,
Niklas


Niklas Schnelle (1):
  PCI: Add s390 specific UID uniqueness attribute

 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.17.1
