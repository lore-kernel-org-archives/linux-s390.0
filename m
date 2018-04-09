Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <a15062721388e1d7a9bdfe2ad57d5f872d9daa7a.camel@perches.com>
Subject: Re: s390: defective uses of va_arg in __debug_sprintf_event
From: Joe Perches <joe@perches.com>
In-Reply-To: <20180409143934.3f27902c@mschwideX1>
References: <1523041723.6127.33.camel@perches.com>
         <20180409143934.3f27902c@mschwideX1>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 09 Apr 2018 07:38:27 -0700
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Petr Mladek <pmladek@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2018-04-09 at 14:39 +0200, Martin Schwidefsky wrote:
> On Fri, 06 Apr 2018 12:08:43 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > debug_sprintf_event calls __debug_sprintf_event
> > with a format and arguments.
> > 
> > There various types of arguments used in these
> > call, but __debug_sprintf_event uses va_arg
> > with only long as the type argument so random
> > errors could occur because the type and argument
> > are supposed to match.
> > 
> >     debug_entry_t *__debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
> >     {
> >     	    [...]
> >     	    va_start(ap, string);
> >     	    curr_event->string = string;
> >     	    for (idx = 0; idx < min(numargs, (int)(id->buf_size / sizeof(long)) - 1); idx++)
> >     	    	    curr_event->args[idx] = va_arg(ap, long);
> >     	    va_end(ap);
> >     	    [...]
> >     }
> > 
> > from man va_arg
> > 
> >     va_arg()
> > 
> >     if type is not compatible with the type of the actual next argument
> >     (as promoted according to the default argument promotions),
> >     random errors will occur.
> > 
> > For instance, uses like:
> > 
> > arch/s390/kernel/perf_cpum_sf.c:919:    debug_sprintf_event(sfdbg, 6, "pmu_enable: es=%i cs=%i ed=%i cd=%i "
> > arch/s390/kernel/perf_cpum_sf.c-920-                        "tear=%p dear=%p\n", cpuhw->lsctl.es, cpuhw->lsctl.cs,
> > arch/s390/kernel/perf_cpum_sf.c-921-                        cpuhw->lsctl.ed, cpuhw->lsctl.cd,
> > arch/s390/kernel/perf_cpum_sf.c-922-                        (void *) cpuhw->lsctl.tear, (void *) cpuhw->lsctl.dear);
> > 
> > where the first 3 arguments are int but their type
> > as used by va_arg in __debug_sprintf_event is long
> > which could produce random errors.
> 
> In principle you are right that the va_arg handling is not 100%
> correct. It works though because the C ABI for s390x requires
> that arguments are sign- or zero-extended to 64 bits by the caller
> of a function. This is true for values passed in registers and for
> the variable argument list.

Thanks.

Reference:
http://legacy.redhat.com/pub/redhat/linux/7.1/es/os/s390x/doc/lzsabi0.pdf
(found via your explanation)

It might be nice to explain that somewhere in
Documentation/s390 if it's not there already.
