Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1523041723.6127.33.camel@perches.com>
Subject: s390: defective uses of va_arg in __debug_sprintf_event
From: Joe Perches <joe@perches.com>
Date: Fri, 06 Apr 2018 12:08:43 -0700
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Petr Mladek <pmladek@suse.com>
List-ID: <linux-s390.vger.kernel.org>

debug_sprintf_event calls __debug_sprintf_event
with a format and arguments.

There various types of arguments used in these
call, but __debug_sprintf_event uses va_arg
with only long as the type argument so random
errors could occur because the type and argument
are supposed to match.

    debug_entry_t *__debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
    {
    	    [...]
    	    va_start(ap, string);
    	    curr_event->string = string;
    	    for (idx = 0; idx < min(numargs, (int)(id->buf_size / sizeof(long)) - 1); idx++)
    	    	    curr_event->args[idx] = va_arg(ap, long);
    	    va_end(ap);
    	    [...]
    }

from man va_arg

    va_arg()

    if type is not compatible with the type of the actual next argument
    (as promoted according to the default argument promotions),
    random errors will occur.

For instance, uses like:

arch/s390/kernel/perf_cpum_sf.c:919:    debug_sprintf_event(sfdbg, 6, "pmu_enable: es=%i cs=%i ed=%i cd=%i "
arch/s390/kernel/perf_cpum_sf.c-920-                        "tear=%p dear=%p\n", cpuhw->lsctl.es, cpuhw->lsctl.cs,
arch/s390/kernel/perf_cpum_sf.c-921-                        cpuhw->lsctl.ed, cpuhw->lsctl.cd,
arch/s390/kernel/perf_cpum_sf.c-922-                        (void *) cpuhw->lsctl.tear, (void *) cpuhw->lsctl.dear);

where the first 3 arguments are int but their type
as used by va_arg in __debug_sprintf_event is long
which could produce random errors.

Instead of adding complete format % decoding,
perhaps the easiest solution is to change all
the formats to use %lu or %ld and cast each
argument as appropriate.

And I found this when looking at another defect
in debug_sprintf_event where a %p<foo> extension
is unintentionally used via a string concatenation.
as pointed out by Rasmus Villemoes
---
 arch/s390/kernel/perf_cpum_sf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 1c9ddd7aa5ec..1c449a6f841a 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -212,9 +212,7 @@ static int realloc_sampling_buffer(struct sf_buffer *sfb,
 	 * the sampling buffer origin.
 	 */
 	if (sfb->sdbt != get_next_sdbt(tail)) {
-		debug_sprintf_event(sfdbg, 3, "realloc_sampling_buffer: "
-				    "sampling buffer is not linked: origin=%p"
-				    "tail=%p\n",
+		debug_sprintf_event(sfdbg, 3, "realloc_sampling_buffer: sampling buffer is not linked: origin=%p tail=%p\n",
 				    (void *) sfb->sdbt, (void *) tail);
 		return -EINVAL;
 	}
