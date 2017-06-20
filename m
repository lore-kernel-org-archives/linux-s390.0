Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH] kernel/perf: correct return code of rb_alloc_aux() if !has_aux(ev)
In-Reply-To: <1497954399-6355-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1497954399-6355-1-git-send-email-brueckner@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 15:26:03 +0300
Message-ID: <877f06zvz8.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pu Hou <bjhoupu@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hendrik Brueckner <brueckner@linux.vnet.ibm.com> writes:

> If the event for which an AUX area is about to be allocated, does
> not support setting up an AUX area, rb_alloc_aux() return -ENOTSUPP.
>
> This error condition is being returned unfiltered to the user space,
> and, for example, the perf tools fails with:
>
>   failed to mmap with 524 (INTERNAL ERROR: strerror_r(524, 0x3fff497a1c8, 512)=22)
>
> This error can be easily seen with "perf record -m 128,256 -e cpu-clock".
>
> The 524 error code maps to -ENOTSUPP (in rb_alloc_aux()). The -ENOTSUPP
> error code shall be only used within the kernel.  So the correct error
> code would then be -EOPNOTSUPP.
>
> With this commit, the perf tool then reports:
>
>   failed to mmap with 95 (Operation not supported)
>
> which is more clear.

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Curious as to why does the tool allow this.

Regards,
--
Alex
