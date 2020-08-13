Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Introduce flag for detached virtual functions
References: <1597260071-2219-1-git-send-email-mjrosato@linux.ibm.com>
 <1597260071-2219-2-git-send-email-mjrosato@linux.ibm.com>
 <CAOSf1CFjaVoeTyk=cLmWhBB6YQrHQkcD8Aj=ZYrB4kYc-rqLiw@mail.gmail.com>
 <2a862199-16c8-2141-d27f-79761c1b1b25@linux.ibm.com>
 <CAOSf1CE6UyL9P31S=rAG=VZKs-JL4Kbq3VMZNhyojHbkPHSw0Q@mail.gmail.com>
 <dc79c8a9-1bbc-380f-741f-bca270a34483@linux.ibm.com>
 <17be8c41-8989-f1da-a843-30f0761f42de@linux.ibm.com>
 <6ffa5f39-3607-88c7-81f9-dc97d12d09df@linux.ibm.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <f862f188-1f4d-d83d-452e-7fbda55426c7@linux.ibm.com>
Date: Thu, 13 Aug 2020 15:28:51 +0200
MIME-Version: 1.0
In-Reply-To: <6ffa5f39-3607-88c7-81f9-dc97d12d09df@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, pmorel@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, linux-s390@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>



On 8/13/20 3:11 PM, Matthew Rosato wrote:
> On 8/13/20 8:34 AM, Niklas Schnelle wrote:
>>
>>
>> On 8/13/20 12:40 PM, Niklas Schnelle wrote:
>>>
>>>
>>> On 8/13/20 11:59 AM, Oliver O'Halloran wrote:
>>>> On Thu, Aug 13, 2020 at 7:00 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>>>>>
>>>>>
>>>>> On 8/13/20 3:55 AM, Oliver O'Halloran wrote:
>>>>>> On Thu, Aug 13, 2020 at 5:21 AM Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>>>>>> *snip*
>>>>>>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>>>>>>> index 3902c9f..04ac76d 100644
>>>>>>> --- a/arch/s390/pci/pci.c
>>>>>>> +++ b/arch/s390/pci/pci.c
>>>>>>> @@ -581,6 +581,14 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
>>>>>>>   {
>>>>>>>          struct zpci_dev *zdev = to_zpci(pdev);
>>>>>>>
>>>>>>> +       /*
>>>>>>> +        * If we have a VF on a non-multifunction bus, it must be a VF that is
>>>>>>> +        * detached from its parent PF.  We rely on firmware emulation to
>>>>>>> +        * provide underlying PF details.
>>>>>>> +        */
>>>>>>> +       if (zdev->vfn && !zdev->zbus->multifunction)
>>>>>>> +               pdev->detached_vf = 1;
>>>>>>
>>>>>> The enable hook seems like it's a bit too late for this sort of
>>>>>> screwing around with the pci_dev. Anything in the setup path that
>>>>>> looks at ->detached_vf would see it cleared while anything that looks
>>>>>> after the device is enabled will see it set. Can this go into
>>>>>> pcibios_add_device() or a fixup instead?
>>>>>>
>>>>>
>>>>> This particular check could go into pcibios_add_device() yes.
>>>>> We're also currently working on a slight rework of how
>>>>> we establish the VF to parent PF linking including the sysfs
>>>>> part of that. The latter sadly can only go after the sysfs
>>>>> for the virtfn has been created and that only happens
>>>>> after all fixups. We would like to do both together because
>>>>> the latter sets pdev->is_virtfn which I think is closely related.
>>>>>
>>>>> I was thinking of starting another discussion
>>>>> about adding a hook that is executed just after the sysfs entries
>>>>> for the PCI device are created but haven't yet.
>>>>
>>>> if all you need is sysfs then pcibios_bus_add_device() or a bus
>>>> notifier should work
>>>
>>> So this might go a bit off track but the problem is that
>>> on s390 a VF can be disabled and reenabled with disable_slot()/enable_slot().
>>> In this case pcibios_bus_add_device() is not called again but
>>> the PF/VF link needs to be reestablished.
>>
>> Scratch that I must have made some stupid mistake last time I tried
>> this, with your suggestion I tried again and it works perfectly
>> moving the setup into pcibios_bus_add_device().
>> Thank you, this is actually much nicer!
>>
> 
> OK, and I can likewise relocate the setting of detached_vf to pcibios_bus_add_device().
> 
Yes and I would suggest we add it in arch/s390/pci_bus.c just
after the the setup_virtfn stuff, then that can stay static
and the fix minimal.
I'll send a new version of my patches internally later, still
running it on the different configurations.
