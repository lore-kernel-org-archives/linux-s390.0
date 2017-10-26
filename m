Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171026112603.7c095ee6@mschwideX1>
References: <20171026073610.9139-1-liwang@redhat.com> <20171026112603.7c095ee6@mschwideX1>
From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Oct 2017 17:47:39 +0800
Message-ID: <CAEemH2dtDCe1SPRTfHAmh8s75mek1jh7MwTiiTfWMq1N2AA89Q@mail.gmail.com>
Subject: Re: [PATCH] s390/mm: return -ENOMEM in arch_get_unmapped_area[_topdown]
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, mingo@kernel.org, hughd@google.com, paul.gortmaker@windriver.com, mhocko@suse.com, Shu Wang <shuwang@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 26, 2017 at 5:26 PM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Thu, 26 Oct 2017 15:36:10 +0800
> Li Wang <liwang@redhat.com> wrote:
>
>> That would be very hard to get -ENOMEM returned in crst_table_upgrade()
>> because the condition(addr + len <= TASK_SIZE) makes all 'end' value
>> is smaller/equal than 'TASK_SIZE_TASK'. So let's move it to the upper
>> layer.
>
> I have a hard time understanding what scenario you describe. There is no
> 'TASK_SIZE_TASK', only TASK_SIZE, TASK_SIZE_OF and TASK_SIZE_MAX.

Sorry for the typo, I was thinking about to write TASK_SIZE_MAX.

>
> The code in mmap.c checks for the per-task limit, 31-bit vs 64-bit.
> pgalloc.c checks for the maximum allowed address and does not care
> about the task.
>
>> Fixes: 8ab867cb0806 (s390/mm: fix BUG_ON in crst_table_upgrade)
>> Signed-off-by: Li Wang <liwang@redhat.com>
>
> I don't think this patch fixes anything.

At least there is a logic error i think, after apply the patch
"s390/mm: fix BUG_ON in crst_table_upgrade",
it makes no sense to compare "if (end >= TASK_SIZE_MAX) return
-ENOMEM" in crst_table_upgrade() function.

isn't it?


Thanks for reviewing quick.


-- 
Li Wang
liwang@redhat.com
