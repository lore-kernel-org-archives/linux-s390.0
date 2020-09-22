Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] vfio/pci: Decouple PCI_COMMAND_MEMORY bit checks
 from is_virtfn
References: <1599749997-30489-1-git-send-email-mjrosato@linux.ibm.com>
 <1599749997-30489-4-git-send-email-mjrosato@linux.ibm.com>
 <08afc6b2-7549-5440-a947-af0b598288c2@linux.ibm.com>
 <20200922104030.07e0dfd9@x1.home>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <852ca3a6-6521-a3c4-c70d-383be3c2dc2d@linux.ibm.com>
Date: Tue, 22 Sep 2020 12:57:37 -0400
MIME-Version: 1.0
In-Reply-To: <20200922104030.07e0dfd9@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

On 9/22/20 12:40 PM, Alex Williamson wrote:
> On Mon, 21 Sep 2020 08:43:29 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> On 9/10/20 10:59 AM, Matthew Rosato wrote:
>>> While it is true that devices with is_virtfn=1 will have a Memory Space
>>> Enable bit that is hard-wired to 0, this is not the only case where we
>>> see this behavior -- For example some bare-metal hypervisors lack
>>> Memory Space Enable bit emulation for devices not setting is_virtfn
>>> (s390). Fix this by instead checking for the newly-added
>>> no_command_memory bit which directly denotes the need for
>>> PCI_COMMAND_MEMORY emulation in vfio.
>>>
>>> Fixes: abafbc551fdd ("vfio-pci: Invalidate mmaps and block MMIO access on disabled memory")
>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>>
>> Polite ping on this patch as the other 2 have now received maintainer
>> ACKs or reviews.  I'm concerned about this popping up in distros as
>> abafbc551fdd was a CVE fix.  Related, see question from the cover:
>>
>> - Restored the fixes tag to patch 3 (but the other 2 patches are
>>     now pre-reqs -- cc stable 5.8?)
> 
> I've got these queued in my local branch which I'll push to next for
> v5.10.  I'm thinking that perhaps the right thing would be to add the
> fixes tag to all three patches, otherwise I could see that the PCI/VF
> change might get picked as a dependency, but not the s390 specific one.
> Does this sound correct to everyone?  Thanks,

Sounds good to me.  Thanks!
