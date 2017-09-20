Return-Path: <stable-owner@vger.kernel.org>
Date: Wed, 20 Sep 2017 08:51:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: Fix perf event init
In-Reply-To: <20170920050757.22857-1-paul.burton@imgtec.com>
References: <20170920050757.22857-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170920085100.6adb0e0d@mschwideX1>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/stable/>
List-Post: <mailto:stable@vger.kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Paul,

On Tue, 19 Sep 2017 22:07:57 -0700
Paul Burton <paul.burton@imgtec.com> wrote:

> Commit c311c797998c ("cpumask: make "nr_cpumask_bits" unsigned")
> modified cpumsf_pmu_event_init() to cast the struct perf_event cpu field
> to an unsigned integer before it is compared with nr_cpumask_bits. This
> is broken because the cpu field may be -1 for events which follow a
> process rather than being affine to a particular CPU. When this is the
> case the cast to an unsigned int results in a value equal to ULONG_MAX,
> which is always greater than nr_cpumask_bits so we always fail
> cpumsf_pmu_event_init() and return -ENODEV.
> 
> The check against nr_cpumask_bits seems nonsensical anyway, so this
> patch simply removes it. The cpu field is going to either be 0 or a
> valid CPU number. Comparing it with nr_cpumask_bits is effectively
> checking that it's a valid cpu number, but it seems safe to rely on the
> core perf events code to ensure that's the case.
> 
> The end result is that this fixes use of perf when not constraining
> events to a particular CPU, and fixes the "perf list hw" command which
> fails to list any events without this.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: c311c797998c ("cpumask: make "nr_cpumask_bits" unsigned")
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: stable <stable@vger.kernel.org> # v4.12+
> 
> ---
> This patch is purely speculative, based upon fixing perf on MIPS
> following the offending commit c311c797998c ("cpumask: make
> "nr_cpumask_bits" unsigned") which made the same change to both MIPS &
> s390. I leave it to s390 developers to verify whether this affects them
> in the same way as it affected MIPS thus whether this fix is correct
> there too.

Thanks for the patch, there is indeed an issue with nr_cpumask_bits.
But we already have a slightly different fix for this queued on the
fixes branch of s390/linux:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=fixes&id=fc3100d64f0ae383ae8d845989103da06d62763b

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
