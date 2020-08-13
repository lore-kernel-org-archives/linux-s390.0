Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgHMKkf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 06:40:35 -0400
Subject: Re: [PATCH v2] PCI: Introduce flag for detached virtual functions
References: <1597260071-2219-1-git-send-email-mjrosato@linux.ibm.com>
 <1597260071-2219-2-git-send-email-mjrosato@linux.ibm.com>
 <CAOSf1CFjaVoeTyk=cLmWhBB6YQrHQkcD8Aj=ZYrB4kYc-rqLiw@mail.gmail.com>
 <2a862199-16c8-2141-d27f-79761c1b1b25@linux.ibm.com>
 <CAOSf1CE6UyL9P31S=rAG=VZKs-JL4Kbq3VMZNhyojHbkPHSw0Q@mail.gmail.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <dc79c8a9-1bbc-380f-741f-bca270a34483@linux.ibm.com>
Date: Thu, 13 Aug 2020 12:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAOSf1CE6UyL9P31S=rAG=VZKs-JL4Kbq3VMZNhyojHbkPHSw0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, pmorel@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, linux-s390@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>



On 8/13/20 11:59 AM, Oliver O'Halloran wrote:
> On Thu, Aug 13, 2020 at 7:00 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>>
>>
>> On 8/13/20 3:55 AM, Oliver O'Halloran wrote:
>>> On Thu, Aug 13, 2020 at 5:21 AM Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>>> *snip*
>>>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>>>> index 3902c9f..04ac76d 100644
>>>> --- a/arch/s390/pci/pci.c
>>>> +++ b/arch/s390/pci/pci.c
>>>> @@ -581,6 +581,14 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
>>>>  {
>>>>         struct zpci_dev *zdev = to_zpci(pdev);
>>>>
>>>> +       /*
>>>> +        * If we have a VF on a non-multifunction bus, it must be a VF that is
>>>> +        * detached from its parent PF.  We rely on firmware emulation to
>>>> +        * provide underlying PF details.
>>>> +        */
>>>> +       if (zdev->vfn && !zdev->zbus->multifunction)
>>>> +               pdev->detached_vf = 1;
>>>
>>> The enable hook seems like it's a bit too late for this sort of
>>> screwing around with the pci_dev. Anything in the setup path that
>>> looks at ->detached_vf would see it cleared while anything that looks
>>> after the device is enabled will see it set. Can this go into
>>> pcibios_add_device() or a fixup instead?
>>>
>>
>> This particular check could go into pcibios_add_device() yes.
>> We're also currently working on a slight rework of how
>> we establish the VF to parent PF linking including the sysfs
>> part of that. The latter sadly can only go after the sysfs
>> for the virtfn has been created and that only happens
>> after all fixups. We would like to do both together because
>> the latter sets pdev->is_virtfn which I think is closely related.
>>
>> I was thinking of starting another discussion
>> about adding a hook that is executed just after the sysfs entries
>> for the PCI device are created but haven't yet.
> 
> if all you need is sysfs then pcibios_bus_add_device() or a bus
> notifier should work

So this might go a bit off track but the problem is that
on s390 a VF can be disabled and reenabled with disable_slot()/enable_slot().
In this case pcibios_bus_add_device() is not called again but
the PF/VF link needs to be reestablished.

> 
>> That said pcibios_enable_device() is called before drivers
>> like vfio-pci are enabled
> 
> Hmm, is that an s390 thing? I was under the impression that drivers
> handled enabling the device rather than assuming the platform did it
> for them. Granted it's usually one of the first things a driver does,
> but there's still scope for surprising behaviour.

No you're absolutely right I formulated this wrong, pcibios_enable_device()
is called by the drivers but before they can really use the device.

But yes I'm not super happy with this either and I
agree for this patch series we should move the check to pcibios_add_device()
and thinking about it more I think I'll really have to find a better
place for our linking as well, pcibios_enable_device() does work
nicely in practice buy it indeed poses room for surprising behavior.

> 
... snip ...
