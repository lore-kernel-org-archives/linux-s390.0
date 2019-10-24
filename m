Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr760074.outbound.protection.outlook.com ([40.107.76.74]:34302
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391807AbfJXKPc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 06:15:32 -0400
Subject: Re: PCI/MSI: Remove the PCI_MSI_IRQ_DOMAIN architecture whitelist
References: <mhng-d42f23ae-e51f-49cd-9533-a4c793cd70fe@palmer-si-x1e>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <9ec42e0d-d999-d59c-628a-b7678f132f73@xilinx.com>
Date: Thu, 24 Oct 2019 12:14:31 +0200
MIME-Version: 1.0
In-Reply-To: <mhng-d42f23ae-e51f-49cd-9533-a4c793cd70fe@palmer-si-x1e>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>, michal.simek@xilinx.com
Cc: Christoph Hellwig <hch@infradead.org>, helgaas@kernel.org, tony.luck@intel.com, fenghua.yu@intel.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org, Greg KH <gregkh@linuxfoundation.org>, kstewart@linuxfoundation.org, pbonzini@redhat.com, firoz.khan@linaro.org, yamada.masahiro@socionext.com, longman@redhat.com, mingo@kernel.org, peterz@infradead.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org

On 22. 10. 19 17:10, Palmer Dabbelt wrote:
> On Thu, 17 Oct 2019 23:20:09 PDT (-0700), michal.simek@xilinx.com wrote:
>> Hi,
>>
>> On 17. 10. 19 20:19, Palmer Dabbelt wrote:
>>> This came up in the context of the microblaze port, where a patch was
>>> recently posted to extend the whitelist.
>>
>> I hoped you were aware about this discussion we have with Christoph.
>> https://lkml.org/lkml/2019/10/8/682
>>
>> It means 1/3 and 2/3 should be replaced by mandatory-y and I expect
>> msi.h can be removed from architecture Kbuild too.
> 
> I'd missed it, but that seems like a better way to do it.  I'm going to
> assume you guys are going to handle this, so feel free to drop my patch
> set.

Ok. I have sent it with ccing you.

Thanks,
Michal
