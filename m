Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <20200221182503.28317-1-logang@deltatee.com>
 <20200221182503.28317-8-logang@deltatee.com>
 <CAPcyv4gNi3sesGnujShStoF8bi8kYg+MQkqhQRCT_1+wex5wbw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6e2591ad-4605-aba4-c7b8-2345940e91b4@deltatee.com>
Date: Mon, 2 Mar 2020 14:20:07 -0700
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gNi3sesGnujShStoF8bi8kYg+MQkqhQRCT_1+wex5wbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 7/7] mm/memremap: Set caching mode for PCI P2PDMA
 memory to WC
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>, Jason Gunthorpe <jgg@ziepe.ca>



On 2020-02-29 3:47 p.m., Dan Williams wrote:
> On Fri, Feb 21, 2020 at 10:25 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>> PCI BAR IO memory should never be mapped as WB, however prior to this
>> the PAT bits were set WB and it was typically overridden by MTRR
>> registers set by the firmware.
>>
>> Set PCI P2PDMA memory to be WC (writecombining) as the only current
>> user (the NVMe CMB) was originally mapped WC before the P2PDMA code
>> replaced the mapping with devm_memremap_pages().
> 
> Will the change to UC regress this existing use case?

I don't think so. They've been essentially mapped UC for a long time now
(since the P2PDMA patch set was merged) and nobody has complained.
