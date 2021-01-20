Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 0/4] vfio-pci/zdev: Fixing s390 vfio-pci ISM support
References: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
 <d44a5da8-1cb9-8b1c-ef48-caea4bda2fa8@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <18cf09c6-5331-b5df-c421-aade717f9766@linux.ibm.com>
Date: Wed, 20 Jan 2021 09:02:07 -0500
MIME-Version: 1.0
In-Reply-To: <d44a5da8-1cb9-8b1c-ef48-caea4bda2fa8@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On 1/20/21 4:02 AM, Pierre Morel wrote:
> 
> 
> On 1/19/21 9:02 PM, Matthew Rosato wrote:
>> Today, ISM devices are completely disallowed for vfio-pci passthrough as
>> QEMU will reject the device due to an (inappropriate) MSI-X check.
>> However, in an effort to enable ISM device passthrough, I realized 
>> that the
>> manner in which ISM performs block write operations is highly 
>> incompatible
>> with the way that QEMU s390 PCI instruction interception and
>> vfio_pci_bar_rw break up I/O operations into 8B and 4B operations -- ISM
>> devices have particular requirements in regards to the alignment, size 
>> and
>> order of writes performed.  Furthermore, they require that legacy/non-MIO
>> s390 PCI instructions are used, which is also not guaranteed when the I/O
>> is passed through the typical userspace channels.
>>
>> As a result, this patchset proposes a new VFIO region to allow a guest to
>> pass certain PCI instruction intercepts directly to the s390 host kernel
>> PCI layer for execution, pinning the guest buffer in memory briefly in
>> order to execute the requested PCI instruction.
>>
>> Changes from RFC -> v1:
>> - No functional changes, just minor commentary changes -- Re-posting 
>> along
>> with updated QEMU set.
>>
> 
> Hi,
> 
> there are is a concerns about this patch series:
> As the title says it is strongly related to ISM hardware.
> 
> Why being so specific?

Because prior investigations have shown that the region can only be 
safely used by a device type that does not implement MSI-X (use of this 
region by a vfio-pci device that has MSI-X capability interferes with 
vfio-pci MSI-X masking, since we are bypassing the typical VFIO bar 
regions and vfio-pci MSI-X masking is triggered by those region accesses).

So, in lieu of another suggestion that would overcome that issue (nobody 
has suggested anything thus far), the proposal is to limit the region's 
use to fix the specific problem at hand (ISM devices won't function 
properly if passed through).  That doesn't preclude this region from 
being used for a different device type later, but ISM is why we are 
introducing it now.
