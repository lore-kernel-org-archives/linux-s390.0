Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728444AbhAKJyR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Jan 2021 04:54:17 -0500
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [RFC 0/1] PCI: s390 global attribute "UID Checking"
Date: Mon, 11 Jan 2021 10:38:56 +0100
Message-Id: <20210111093857.24070-1-schnelle@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>

Hi Bjorn, Hi Kernel Hackers,

With the below patch I'm proposing to expose a global (i.e. not device
bound) runtime attribute of the s390 PCI implementation (zPCI) called
"UID Checking".  You can find some background information on what this
attribute means and why it is important at the end of this mail. The
reason I'm writing to you about it however is that this is the first
global PCI attribute we would like to expose to user space and I'm
searching for a good place to put it.
The proposed patch uses "/sys/bus/pci/zpci/uid_checking" which from
our perspective would be a great choice but I realize that there
currently are no platform specific attributes directly under
"/sys/bus/pci" so this clearly requires some discussion. What's your
thought on this and do you know of any other platform specific global
PCI attributes as I couldn't find any?

Best regards,
Niklas Schnelle

Background:
On s390 OSs always run under at least a machine level hypervisor
(LPAR).  Simpliefied by usually running from SAN this makes VM
migration possible at every level. For PCI this has created the need
to allow PCI IDs to be stable across machines and to be partly user
defined such that the setup of an existing VM on one machine can be
recreated on another machine.
In particular the Domain part of the PCI ID can be user defined by
setting a per device value called UID. Since this was a late addition
and isn't used by all OSs and since UIDs need to be unique if used as
Domains, there is an additional global platform supplied runtime value
called "UID Checking".  This value indicates if UIDs are guaranteed to
be unique and set which triggers Linux to use the UIDs as PCI Domains
otherwise PCI Domains are simply incremented as necessary.
This "UID Checking" setting is thus very important e.g. when deciding
how network interface names are generated as it indicates if the
domain part of the PCI ID will remain stable across reboots and
migrations.  Once exposed we will propose a patch to udev/systemd to
use the "UID Checking" attribute to prefer network interface names
which can be guaranteed to be stable and re-creatable for migration.

Niklas Schnelle (1):
  s390/pci: expose UID checking state in sysfs

 Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++++
 arch/s390/include/asm/pci.h             |  3 +++
 arch/s390/pci/pci.c                     |  4 +++
 arch/s390/pci/pci_sysfs.c               | 34 +++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

-- 
2.17.1
