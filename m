Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr810072.outbound.protection.outlook.com ([40.107.81.72]:23639
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504133AbfJRGUc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Oct 2019 02:20:32 -0400
Subject: Re: PCI/MSI: Remove the PCI_MSI_IRQ_DOMAIN architecture whitelist
References: <20191017181937.7004-1-palmer@sifive.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <995f625b-1f56-6d97-ba99-9a4298e9dd37@xilinx.com>
Date: Fri, 18 Oct 2019 08:20:09 +0200
MIME-Version: 1.0
In-Reply-To: <20191017181937.7004-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>, Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com, helgaas@kernel.org
Cc: tony.luck@intel.com, fenghua.yu@intel.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org, Greg KH <gregkh@linuxfoundation.org>, kstewart@linuxfoundation.org, pbonzini@redhat.com, firoz.khan@linaro.org, yamada.masahiro@socionext.com, longman@redhat.com, mingo@kernel.org, peterz@infradead.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org

Hi,

On 17. 10. 19 20:19, Palmer Dabbelt wrote:
> This came up in the context of the microblaze port, where a patch was
> recently posted to extend the whitelist.

I hoped you were aware about this discussion we have with Christoph.
https://lkml.org/lkml/2019/10/8/682

It means 1/3 and 2/3 should be replaced by mandatory-y and I expect
msi.h can be removed from architecture Kbuild too.

Thanks,
Michal
