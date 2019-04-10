Return-Path: <linux-doc-owner@vger.kernel.org>
Date: Wed, 10 Apr 2019 13:46:48 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH v5 4/6] s390/pci: add support for generic boot option
 iommu.dma_mode
In-Reply-To: <20190409125308.18304-5-thunder.leizhen@huawei.com>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com> <20190409125308.18304-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1904101346060.1774@schleppi>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Apr 2019, Zhen Lei wrote:
> s390_iommu=strict is equivalent to iommu.dma_mode=strict.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Sebastian Ott <sebott@linux.ibm.com>
