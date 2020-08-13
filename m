Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726048AbgHMJAk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 05:00:40 -0400
Subject: Re: [PATCH v2] PCI: Introduce flag for detached virtual functions
References: <1597260071-2219-1-git-send-email-mjrosato@linux.ibm.com>
 <1597260071-2219-2-git-send-email-mjrosato@linux.ibm.com>
 <CAOSf1CFjaVoeTyk=cLmWhBB6YQrHQkcD8Aj=ZYrB4kYc-rqLiw@mail.gmail.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <2a862199-16c8-2141-d27f-79761c1b1b25@linux.ibm.com>
Date: Thu, 13 Aug 2020 11:00:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAOSf1CFjaVoeTyk=cLmWhBB6YQrHQkcD8Aj=ZYrB4kYc-rqLiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Oliver O'Halloran <oohall@gmail.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, pmorel@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, linux-s390@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>



On 8/13/20 3:55 AM, Oliver O'Halloran wrote:
> On Thu, Aug 13, 2020 at 5:21 AM Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>
>> s390x has the notion of providing VFs to the kernel in a manner
>> where the associated PF is inaccessible other than via firmware.
>> These are not treated as typical VFs and access to them is emulated
>> by underlying firmware which can still access the PF.  After
>> abafbc55 however these detached VFs were no longer able to work
>> with vfio-pci as the firmware does not provide emulation of the
>> PCI_COMMAND_MEMORY bit.  In this case, let's explicitly recognize
>> these detached VFs so that vfio-pci can allow memory access to
>> them again.
> 
> Hmm, cool. I think we have a similar feature on pseries so that's
> probably broken too.
> 
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>  arch/s390/pci/pci.c                |  8 ++++++++
>>  drivers/vfio/pci/vfio_pci_config.c | 11 +++++++----
>>  include/linux/pci.h                |  1 +
>>  3 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 3902c9f..04ac76d 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -581,6 +581,14 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
>>  {
>>         struct zpci_dev *zdev = to_zpci(pdev);
>>
>> +       /*
>> +        * If we have a VF on a non-multifunction bus, it must be a VF that is
>> +        * detached from its parent PF.  We rely on firmware emulation to
>> +        * provide underlying PF details.
>> +        */
>> +       if (zdev->vfn && !zdev->zbus->multifunction)
>> +               pdev->detached_vf = 1;
> 
> The enable hook seems like it's a bit too late for this sort of
> screwing around with the pci_dev. Anything in the setup path that
> looks at ->detached_vf would see it cleared while anything that looks
> after the device is enabled will see it set. Can this go into
> pcibios_add_device() or a fixup instead?
> 

This particular check could go into pcibios_add_device() yes.
We're also currently working on a slight rework of how
we establish the VF to parent PF linking including the sysfs
part of that. The latter sadly can only go after the sysfs
for the virtfn has been created and that only happens
after all fixups. We would like to do both together because
the latter sets pdev->is_virtfn which I think is closely related.

I was thinking of starting another discussion
about adding a hook that is executed just after the sysfs entries
for the PCI device are created but haven't yet.
That said pcibios_enable_device() is called before drivers
like vfio-pci are enabled and so as long as all uses of pdev->detached_vf
are in drivers it should be early enough. AFAIK almost everything
dealing with VFs before that is already skipped with pdev->no_vf_scan
though.
