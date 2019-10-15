Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 15 Oct 2019 18:46:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH RFC 0/5] ARM: Raspberry Pi 4 DMA support
Message-ID: <20191015174616.GO13874@arrakis.emea.arm.com>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
 <20191014205859.GA7634@iMac-3.local>
 <384b42df01c0af973002fba0d5f02068e7f2e7b3.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <384b42df01c0af973002fba0d5f02068e7f2e7b3.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: linux-s390@vger.kernel.org, f.fainelli@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, hch@infradead.org, iommu@lists.linux-foundation.org, mbrugger@suse.com, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net

On Tue, Oct 15, 2019 at 09:48:22AM +0200, Nicolas Saenz Julienne wrote:
> A little off topic but I was wondering if you have a preferred way to refer to
> the arm architecture in a way that it unambiguously excludes arm64 (for example
> arm32 would work).

arm32 should be fine. Neither arm64 nor arm32 are officially endorsed
ARM Ltd names (officially the exception model is AArch32 while the
instruction set is one of A32/T32/T16).

-- 
Catalin
