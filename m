Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 11 Jan 2021 14:43:08 +0100
From: Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH V2 1/3] mm/hotplug: Prevalidate the address range being
 added with platform
Message-ID: <20210111134303.GA3031@linux>
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
 <1608218912-28932-2-git-send-email-anshuman.khandual@arm.com>
 <10e733fa-4568-d38f-9b95-2ccc5dc627b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10e733fa-4568-d38f-9b95-2ccc5dc627b8@redhat.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Mon, Jan 11, 2021 at 11:51:47AM +0100, David Hildenbrand wrote:
> AFAIKs, all memhp_get_pluggable_range() users pass "1".
> 
> What about the "add_pages()-only" path?

I guess you refer to memremap_pages(), right?
If so, moving the added memhp_range_allowed() check above the if-else might do
the trick

-- 
Oscar Salvador
SUSE L3
