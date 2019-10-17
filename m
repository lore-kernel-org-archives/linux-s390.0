Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41651 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503282AbfJQSWb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Oct 2019 14:22:31 -0400
Received: by mail-pf1-f182.google.com with SMTP id q7so2160852pfh.8
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 11:22:30 -0700 (PDT)
Subject: PCI/MSI: Remove the PCI_MSI_IRQ_DOMAIN architecture whitelist
Date: Thu, 17 Oct 2019 11:19:34 -0700
Message-Id: <20191017181937.7004-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com, helgaas@kernel.org
Cc: tony.luck@intel.com, fenghua.yu@intel.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org, Greg KH <gregkh@linuxfoundation.org>, Palmer Dabbelt <palmer@sifive.com>, kstewart@linuxfoundation.org, pbonzini@redhat.com, firoz.khan@linaro.org, yamada.masahiro@socionext.com, longman@redhat.com, mingo@kernel.org, peterz@infradead.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org

This came up in the context of the microblaze port, where a patch was
recently posted to extend the whitelist.
