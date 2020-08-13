Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbgHMNJ5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 09:09:57 -0400
Subject: Re: [PATCH v2] PCI: Introduce flag for detached virtual functions
References: <1597260071-2219-1-git-send-email-mjrosato@linux.ibm.com>
 <1597260071-2219-2-git-send-email-mjrosato@linux.ibm.com>
 <20200812143254.2f080c38@x1.home>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <d2237715-298c-30a9-a05d-2b1c72476441@linux.ibm.com>
Date: Thu, 13 Aug 2020 09:09:45 -0400
MIME-Version: 1.0
In-Reply-To: <20200812143254.2f080c38@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

On 8/12/20 4:32 PM, Alex Williamson wrote:
> On Wed, 12 Aug 2020 15:21:11 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> s390x has the notion of providing VFs to the kernel in a manner
>> where the associated PF is inaccessible other than via firmware.
>> These are not treated as typical VFs and access to them is emulated
>> by underlying firmware which can still access the PF.  After
>> abafbc55 however these detached VFs were no longer able to work
>> with vfio-pci as the firmware does not provide emulation of the
>> PCI_COMMAND_MEMORY bit.  In this case, let's explicitly recognize
>> these detached VFs so that vfio-pci can allow memory access to
>> them again.
>>
> 
> Might as well include a fixes tag too.
> 
> Fixes: abafbc551fdd ("vfio-pci: Invalidate mmaps and block MMIO access on disabled memory")
> 
> You might also extend the sha1 in the log to 12 chars as well, or
> replace it with a reference to the fixes tag.
> 
Sure.

>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
..snip..
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 8355306..23a6972 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -445,6 +445,7 @@ struct pci_dev {
>>   	unsigned int	is_probed:1;		/* Device probing in progress */
>>   	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
>>   	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
>> +	unsigned int	detached_vf:1;		/* VF without local PF access */
> 
> Is there too much implicit knowledge in defining a "detached VF"?  For
> example, why do we know that we can skip the portion of
> vfio_config_init() that copies the vendor and device IDs from the
> struct pci_dev into the virtual config space?  It's true on s390x, but
> I think that's because we know that firmware emulates those registers
> for us.  We also skip the INTx pin register sanity checking.  Do we do
> that because we haven't installed the broken device into an s390x
> system?  Because we know firmware manages that for us too?  Or simply
> because s390x doesn't support INTx anyway, and therefore it's another
> architecture implicit decision?

That's a fair point.  This was also discussed (overnight for me) in 
another thread that this patch is very s390-specific.  It doesn't have 
to be, we could also emulate these additional pieces to make things more 
general-purpose here.

> 
> If detached_vf is really equivalent to is_virtfn for all cases that
> don't care about referencing physfn on the pci_dev, then we should
> probably have a macro to that effect.  Otherwise, if we're just trying
> to describe that the memory bit of the command register is
> unimplemented but always enabled, like a VF, should we specifically
> describe that attribute instead?  If so, should we instead do that with
> pci_dev_flags_t?  Thanks,

Well, that's the particular issue that got us looking at this but I'm 
not so sure we wouldn't find further oddities later, hence the desire 
for a more general-purpose bit.

> 
> Alex
> 
>>   	pci_dev_flags_t dev_flags;
>>   	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>>   
> 
