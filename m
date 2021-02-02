Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 2 Feb 2021 16:06:41 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH V5 2/4] arm64/mm: Define arch_get_mappable_range()
Message-ID: <20210202160640.GE26895@gaia>
References: <1612149902-7867-1-git-send-email-anshuman.khandual@arm.com>
 <1612149902-7867-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612149902-7867-3-git-send-email-anshuman.khandual@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, david@redhat.com, osalvador@suse.de, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:55:00AM +0530, Anshuman Khandual wrote:
> This overrides arch_get_mappable_range() on arm64 platform which will be
> used with recently added generic framework. It drops inside_linear_region()
> and subsequent check in arch_add_memory() which are no longer required. It
> also adds a VM_BUG_ON() check that would ensure that mhp_range_allowed()
> has already been called.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
