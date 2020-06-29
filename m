Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Jun 2020 13:55:37 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
Message-ID: <20200629115537.GC4468@osiris>
References: <20200625150029.45019-1-david@redhat.com>
 <20200626192253.2281d95d@thinkpad>
 <20200626204621.55248f99@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626204621.55248f99@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Jun 26, 2020 at 08:46:21PM +0200, Gerald Schaefer wrote:
> Verified with DCSS overlapping boot and standby memory, works fine.
> As expected, the error message changes, but I don't think that is a
> problem, as long as you also remove the old -ENOSPC case / comment
> in arch/s390/mm/extmem.c. It is actually more correct now I guess,
> -ENOSPC doesn't look like the correct return value anyway.
> 
> Thanks for cleaning up! Looks good to me, and removes > 100 LOC,
> unless Heiko remembers some other issues from ancient times.
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> [DCSS]

Looks good to me too. Gerald, thanks for looking and verifying this,
and David, thanks for providing the patch.

Applied.
