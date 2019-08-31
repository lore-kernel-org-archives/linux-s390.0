Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:6156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfHaI5l (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 31 Aug 2019 04:57:41 -0400
Subject: Re: [PATCH v2 7/9] sparc64: numa: check the node id consistently for
 sparc64
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
 <1567231103-13237-8-git-send-email-linyunsheng@huawei.com>
 <20190830.235337.570776316111294728.davem@davemloft.net>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0195eb73-99ae-fec2-3e11-2cb9e6677926@huawei.com>
Date: Sat, 31 Aug 2019 16:57:04 +0800
MIME-Version: 1.0
In-Reply-To: <20190830.235337.570776316111294728.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, linuxarm@huawei.com

On 2019/8/31 14:53, David Miller wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Sat, 31 Aug 2019 13:58:21 +0800
> 
>> According to Section 6.2.14 from ACPI spec 6.3 [1], the setting
>> of proximity domain is optional, as below:
> 
> What in the world does the ACPI spec have to do with sparc64 NUMA
> node ID checking?

I am not sure I understand your question fully here.

Here is my issue when the bios does not implement the proximity domain
of a device because the feature is optional according to the ACPI spec,
the dev_to_node(dev) return -1, which causes out of bound access when
using the value to get the device's cpu mask by calling cpumask_of_node.

Did you mean sparc64 system does not has ACPI, the device's node id will
not specified by ACPI, so the ACPI is unrelated here?

Or did you mean the commit log is not clear enough to justify the change?

Or did you mean this problem should be fixed in somewhere else?

Any detail advice and suggestion will be very helpful, thanks.

> 
> .
> 
