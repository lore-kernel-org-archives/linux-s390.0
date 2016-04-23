From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64 - LTP results
Date: Sat, 23 Apr 2016 11:37:29 +0800
Message-ID: <571AEDF9.6030701@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160405224412.GA18300@yury-N73SV>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------020706090806000800000105"
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160405224412.GA18300@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, gcc@gcc.gnu.org
List-ID: <linux-s390.vger.kernel.org>

--------------020706090806000800000105
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Yury

On 2016/4/6 6:44, Yury Norov wrote:
> There are about 20 failing tests of 782 in lite scenario.
> float_bessel
> float_exp_log
> float_iperb
> float_power
> float_trigo
> pipeio_1
> pipeio_3
> pipeio_5
> pipeio_8
> abort01
> clone02
> kill11
> mmap16
> open12
> pause01
> rename11
> rmdir02
> umount2_01
> umount2_02
> umount2_03
> utime06
> mtest06
>
> The list is rough because some tests fail not every time.
>
> Tests abort01 and kill11 fail for lp64 too, so maybe there's
> a reason unrelated to ilp32 itself.
>
> float_xxx tests fail because they call unwind() from signal context,
> and GCC for ilp32 has problem with it, as Andrew told.
Is there some progress about this issue. When we talk about unwind
functions, do you mean the function in libgcc?

We encountered another issue(abort not segfault) which also called
pthread_cancel(). The test code is in the attachment. Here is the
backtrace:

```
Program received signal SIGABRT, Aborted.
[Switching to Thread 0xf77ee330 (LWP 2958)]
0x000000000040f5bc in raise (sig=sig@entry=6)
     at ../sysdeps/unix/sysv/linux/raise.c:55
55      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  0x000000000040f5bc in raise (sig=sig@entry=6)
     at ../sysdeps/unix/sysv/linux/raise.c:55
#1  0x000000000040f884 in abort () at abort.c:89

#2  0x00000000004073b4 in uw_update_context_1 (
     context=context@entry=0xf77ec820, fs=fs@entry=0xf77ebec8)
at /home/GCC-Build/p660/p660_build_dir/src/gcc-4.9/libgcc/unwind-dw2.c:1430

#3  0x00000000004078c0 in uw_update_context (context=context@entry=0xf77ec820,
     fs=fs@entry=0xf77ebec8)
    at /home/GCC-Build/p660/p660_build_dir/src/gcc-4.9/libgcc/unwind-dw2.c:1506
#4  0x0000000000407a9c in uw_advance_context (fs=0xf77ebec8,
     context=0xf77ec820)
     at /home/GCC-Build/p660/p660_build_dir/src/gcc-4.9/libgcc/unwind-dw2.c:1529
#5  _Unwind_ForcedUnwind_Phase2 (exc=exc@entry=0xf77ee580,
     context=context@entry=0xf77ec820)
     at /home/GCC-Build/p660/p660_build_dir/src/gcc-4.9/libgcc/unwind.inc:185
#6  0x0000000000408228 in _Unwind_ForcedUnwind (exc=0xf77ee580,
     stop=stop@entry=0x405440 <unwind_stop>, stop_argument=0xf77eddd8)
     at /home/GCC-Build/p660/p660_build_dir/src/gcc-4.9/libgcc/unwind.inc:207
#7  0x00000000004055c4 in __pthread_unwind (buf=<optimized out>)
     at unwind.c:126
#8  0x00000000004050b4 in __do_cancel () at ./pthreadP.h:283
#9  sigcancel_handler (sig=<optimized out>, si=<optimized out>,
     ctx=<optimized out>) at nptl-init.c:225
---Type <return> to continue, or q <return> to quit---
#10 <signal handler called>

#11 0x0000000000000000 in ?? ()

#12 0x0000000000423084 in __select (nfds=-66661, readfds=<optimized out>,
     writefds=<optimized out>, exceptfds=<optimized out>, timeout=0x0)
     at ../sysdeps/unix/sysv/linux/generic/select.c:45
#13 0x0000000000400604 in TEST_TaskDelay (
     uiMillSecs=<error reading variable: can't compute CFA for this frame>)
     at test-cancel.c:18
#14 0x0000000000400680 in printids (
     s=<error reading variable: can't compute CFA for this frame>)
     at test-cancel.c:38
#15 0x00000000004006d0 in thr_fn (
     arg=<error reading variable: can't compute CFA for this frame>)
     at test-cancel.c:49
#16 0x0000000000401b28 in start_thread (arg=0x4a3000) at pthread_create.c:335
#17 0x0000000000401b28 in start_thread (arg=0x4a3000) at pthread_create.c:335
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
```

Such abort is raise by the following code:
```
static void
uw_update_context_1 (struct _Unwind_Context *context, _Unwind_FrameState *fs)
{
//...
   /* Compute this frame's CFA.  */
   switch (fs->regs.cfa_how)
     {
     case CFA_REG_OFFSET:
       cfa = _Unwind_GetPtr (&orig_context, fs->regs.cfa_reg);
       cfa += fs->regs.cfa_offset;
       break;

     case CFA_EXP:
       {
         const unsigned char *exp = fs->regs.cfa_exp;
         _uleb128_t len;

         exp = read_uleb128 (exp, &len);
         cfa = (void *) (_Unwind_Ptr)
           execute_stack_op (exp, exp + len, &orig_context, 0);
         break;
       }

     default:
       gcc_unreachable ();
     }
   context->cfa = cfa;
//...
}
``

Any suggestion is appreciated.

CC gcc mailing list. Sorry if it is off topic.

Regards

Bamvor



> pipeio_x tests are very unstable and may fail randomly. I strongly
> suspect race conditions, as they all work like a charm if pinned to
> single CPU with taskset. Probably, race is the reason of clone02 too.
> Though I'm not sure, is the race in kernel, glibc or test itself.
>
> But I know for sure that pause01 fails due to test design:
> 	if (setitimer(ITIMER_REAL, &it, NULL)) // For 1000us
> 		tst_brkm(TBROK | TERRNO, NULL, "setitimer() failed");
>
> 	TEST(pause());
>
> As setitimer() and pause() calls are not atomic, alarm may come before pause()
> is called, and be silently dropped by the handler. Next pause() call hangs
> test forever. I already reported to LTP list.
>
> open12, rename11, rmdir02, mmap16, mtest06 - all call mkfs tool, and it returns
> error code. I didn't investigate it much yet.
>
> umount02_x, utime06 - cannot reproduce out of scenario, even run it in infinite
> loop - they work fine.
>
> Full test log is attached.
>
> Yury
>

--------------020706090806000800000105
Content-Type: text/plain; charset="UTF-8"; name="test-cancel.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="test-cancel.c"

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>
#include <sys/select.h>

int TEST_TaskDelay(int uiMillSecs)
{
    int iRet;
    struct timeval tv;

    tv.tv_usec = (uiMillSecs % 1000) * 1000;
    tv.tv_sec  = uiMillSecs / 1000;

    do{
        iRet = select(1, NULL, NULL, NULL, &tv );
    }while((-1 == iRet) && (EINTR == errno));

    return 0;
}


void printids(const char *s)
{
    unsigned int uiIndex;
	pid_t pid;
	pthread_t tid;
	pid = getpid();
	tid = pthread_self();
	printf("%s pid %u tid %u (0x%x)\n", s, (unsigned int) pid, (unsigned int) tid, (unsigned int) tid);



    for(uiIndex = 0; uiIndex < 9000; uiIndex++)
    {
        TEST_TaskDelay(100);
	printf("\n jijun TEST_TaskDelay uiIndex=%d return \n ",uiIndex);
    }
    return 0;



}

void *thr_fn(void *arg)
{
	printids("new thread: ");
	return NULL;
}


int main(void)
{
	int err;
	pthread_t ntid;
	//pthread_t ntid1;	
	err = pthread_create(&ntid,NULL,thr_fn,NULL);
	if (err != 0)
		printf("can't create thread: %s\n", strerror(err));
#if 0
	err = pthread_create(&ntid1,NULL,thr_fn,NULL);
	if (err != 0)
		printf("can't create thread: %s\n", strerror(err));
#endif


	sleep(2);
	pthread_cancel(ntid);
	//pthread_cancel(ntid1);
	sleep(2);
	
	return 0;

}

--------------020706090806000800000105--
