Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Jan 2021 14:40:21 +0100
From: Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH V3 0/3] mm/memory_hotplug: Pre-validate the address range
 with platform
Message-ID: <20210119134016.GA23408@linux>
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <d57036a1-de12-2d32-be65-daaa3dc5b772@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57036a1-de12-2d32-be65-daaa3dc5b772@redhat.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:33:03PM +0100, David Hildenbrand wrote:
> Minor thing, we should make up our mind if we want to call stuff
> internally "memhp_" or "mhp". I prefer the latter, because it is shorter.

I would rather use the latter as well. I used that in [1].
MEMHP_MERGE_RESOURCE should be renamed if we agree on that.

[1] https://patchwork.kernel.org/project/linux-mm/cover/20201217130758.11565-1-osalvador@suse.de/


-- 
Oscar Salvador
SUSE L3
