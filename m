Return-Path: <owner-linux-mm@kvack.org>
Date: Thu, 14 Jan 2016 08:45:00 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v5 5/7] s390: mm/gup: add gup trace points
Message-ID: <20160114074500.GA4073@osiris>
References: <1449696151-4195-1-git-send-email-yang.shi@linaro.org>
 <1449696151-4195-6-git-send-email-yang.shi@linaro.org>
 <56969389.9060703@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56969389.9060703@linaro.org>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: "Shi, Yang" <yang.shi@linaro.org>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linaro-kernel@lists.linaro.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 13, 2016 at 10:12:25AM -0800, Shi, Yang wrote:
> Hi folks,
> 
> Any comment for this one? The tracing part review has been done.
> 
> Thanks,
> Yang

If the rest of this series has been acked by the appropriate maintainers
please feel free to add an

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

for this specific patch.

> 
> On 12/9/2015 1:22 PM, Yang Shi wrote:
> >Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> >Cc: linux-s390@vger.kernel.org
> >Signed-off-by: Yang Shi <yang.shi@linaro.org>
> >---
> >  arch/s390/mm/gup.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> >diff --git a/arch/s390/mm/gup.c b/arch/s390/mm/gup.c
> >index 12bbf0e..a1d5db7 100644
> >--- a/arch/s390/mm/gup.c
> >+++ b/arch/s390/mm/gup.c
> >@@ -12,6 +12,8 @@
> >  #include <linux/rwsem.h>
> >  #include <asm/pgtable.h>
> >
> >+#include <trace/events/gup.h>
> >+
> >  /*
> >   * The performance critical leaf functions are made noinline otherwise gcc
> >   * inlines everything into a single function which results in too much
> >@@ -188,6 +190,9 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> >  	end = start + len;
> >  	if ((end <= start) || (end > TASK_SIZE))
> >  		return 0;
> >+
> >+	trace_gup_get_user_pages_fast(start, nr_pages);
> >+
> >  	/*
> >  	 * local_irq_save() doesn't prevent pagetable teardown, but does
> >  	 * prevent the pagetables from being freed on s390.
> >
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
