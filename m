Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171026121602.295e7a6e@mschwideX1>
References: <20171026073610.9139-1-liwang@redhat.com> <20171026112603.7c095ee6@mschwideX1>
 <CAEemH2dtDCe1SPRTfHAmh8s75mek1jh7MwTiiTfWMq1N2AA89Q@mail.gmail.com> <20171026121602.295e7a6e@mschwideX1>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Nov 2017 12:36:32 +0800
Message-ID: <CAEemH2dVN-A==ey-vELKOtCkACCQcbD-_M72S6Mr+DV=TJ1NUA@mail.gmail.com>
Subject: Re: [PATCH] s390/mm: return -ENOMEM in arch_get_unmapped_area[_topdown]
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, mingo@kernel.org, Hugh Dickins <hughd@google.com>, paul.gortmaker@windriver.com, mhocko@suse.com, Shu Wang <shuwang@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 26, 2017 at 6:16 PM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Thu, 26 Oct 2017 17:47:39 +0800
> Li Wang <liwang@redhat.com> wrote:
>
>> On Thu, Oct 26, 2017 at 5:26 PM, Martin Schwidefsky
>> <schwidefsky@de.ibm.com> wrote:
>> > On Thu, 26 Oct 2017 15:36:10 +0800
>> > Li Wang <liwang@redhat.com> wrote:
>> >
>> > The code in mmap.c checks for the per-task limit, 31-bit vs 64-bit.
>> > pgalloc.c checks for the maximum allowed address and does not care
>> > about the task.
>> >
>> >> Fixes: 8ab867cb0806 (s390/mm: fix BUG_ON in crst_table_upgrade)
>> >> Signed-off-by: Li Wang <liwang@redhat.com>
>> >
>> > I don't think this patch fixes anything.
>>
>> At least there is a logic error i think, after apply the patch
>> "s390/mm: fix BUG_ON in crst_table_upgrade",
>> it makes no sense to compare "if (end >= TASK_SIZE_MAX) return
>> -ENOMEM" in crst_table_upgrade() function.
>>
>> isn't it?
>
> Be careful with TASK_SIZE vs. TASK_SIZE_MAX. They return different
> values for 31-bit compat tasks.

what do you think this reproducer now failed(mmap into high region
succeeded) on the latest kernel?
should we enlarge the HIGH_ADDR to -PAGE_SIZE?

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/types.h>

#define HIGH_ADDR (void *)(1L << 53)

int main(void)
{

    void *addr;
    long map_sz = getpagesize();
    int fd = open("testfile", O_RDWR | O_CREAT, 0666);

    /* Attempt to mmap into highmem addr, should get ENOMEM */
    addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
            MAP_SHARED | MAP_FIXED, fd, 0);
    if (addr != MAP_FAILED) {
        printf("FAIL: mmap into high region succeeded unexpectedly\n");
        munmap(addr, map_sz);
        close(fd);
    }

    if (errno != ENOMEM) {
        printf("FAIL: mmap into high region failed unexpectedly -
expect errno=ENOMEM, got\n");
    } else {
        printf("PASS: mmap into high region failed as expected\n");
    }

    return 0;
}



>
> If the addr parameter is correctly aligned then the if condition in
> crst_table_upgrade is superfluous as TASK_SIZE_MAX is now -PAGE_SIZE
> with the introduction of 5 level page tables. It is important for older
> kernels with only 4 level page tables with a TASK_SIZE_MAX of 2**53.
>
> On the other hand if addr is ever a value between -PAGE_SIZE and -1
> we would end up with an endless loop. That makes the if condition a
> safe-guard and I would like to keep it.
>
> --
> blue skies,
>    Martin.
>
> "Reality continues to ruin my life." - Calvin.
>



-- 
Li Wang
liwang@redhat.com
