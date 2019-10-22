Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f173.google.com ([209.85.210.173]:35034 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731410AbfJVPKu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Oct 2019 11:10:50 -0400
Received: by mail-pf1-f173.google.com with SMTP id 205so10842132pfw.2
        for <linux-s390@vger.kernel.org>; Tue, 22 Oct 2019 08:10:50 -0700 (PDT)
Date: Tue, 22 Oct 2019 08:10:48 -0700 (PDT)
Subject: Re: PCI/MSI: Remove the PCI_MSI_IRQ_DOMAIN architecture whitelist
In-Reply-To: <995f625b-1f56-6d97-ba99-9a4298e9dd37@xilinx.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-d42f23ae-e51f-49cd-9533-a4c793cd70fe@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com, helgaas@kernel.org, tony.luck@intel.com, fenghua.yu@intel.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org, Greg KH <gregkh@linuxfoundation.org>, kstewart@linuxfoundation.org, pbonzini@redhat.com, firoz.khan@linaro.org, yamada.masahiro@socionext.com, longman@redhat.com, mingo@kernel.org, peterz@infradead.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org

On Thu, 17 Oct 2019 23:20:09 PDT (-0700), michal.simek@xilinx.com wrote:
> Hi,
>
> On 17. 10. 19 20:19, Palmer Dabbelt wrote:
>> This came up in the context of the microblaze port, where a patch was
>> recently posted to extend the whitelist.
>
> I hoped you were aware about this discussion we have with Christoph.
> https://lkml.org/lkml/2019/10/8/682
>
> It means 1/3 and 2/3 should be replaced by mandatory-y and I expect
> msi.h can be removed from architecture Kbuild too.

I'd missed it, but that seems like a better way to do it.  I'm going to assume 
you guys are going to handle this, so feel free to drop my patch set.

Thanks!
