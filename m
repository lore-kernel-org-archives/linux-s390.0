Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 Jan 2016 10:42:23 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: fix normalization bug in exception table sorting
Message-ID: <20160104094223.GA4179@osiris>
References: <1451651962-4180-1-git-send-email-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451651962-4180-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 01, 2016 at 01:39:22PM +0100, Ard Biesheuvel wrote:
> The normalization pass in the sorting routine of the relative exception
> table serves two purposes:
> - it ensures that the address fields of the exception table entries are
>   fully ordered, so that no ambiguities arise between entries with
>   identical instruction offsets (i.e., when two instructions that are
>   exactly 8 bytes apart each have an exception table entry associated with
>   them)
> - it ensures that the offsets of both the instruction and the fixup fields
>   of each entry are relative to their final location after sorting.
> 
> Commit eb608fb366de ("s390/exceptions: switch to relative exception table
> entries") ported the relative exception table format from x86, but modified
> the sorting routine to only normalize the instruction offset field and not
> the fixup offset field. The result is that the fixup offset of each entry
> will be relative to the original location of the entry before sorting,
> likely leading to crashes when those entries are dereferenced.

Applied, thanks a lot!

I was wondering why this never was observed on s390 during the last three
years.

The kernel text extable entries will be sorted during build time and I
verified that for the majority of modules the extable entries are already
sorted. And even if they are not sorted there isn't any major shuffling.
So it looks like we were simply lucky...
