From: zhouchengming <zhouchengming1@huawei.com>
Subject: Re: [PATCH 17/23] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
Date: Sat, 25 Jun 2016 17:36:26 +0800
Message-ID: <576E509A.7090702@huawei.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com> <1464048292-30136-18-git-send-email-ynorov@caviumnetworks.com> <57577611.9000607@huawei.com> <20160608170048.GA24482@yury-N73SV>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------020409060404030701010104"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160608170048.GA24482@yury-N73SV>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, kilobyte@angband.pl, pinskia@gmail.com, szabolcs.nagy@arm.com, Nathan_Lynch@mentor.com, heiko.carstens@de.ibm.com, agraf@suse.de, geert@linux-m68k.org, Prasun.Kapoor@caviumnetworks.com, klimov.linux@gmail.com, broonie@kernel.org, schwidefsky@de.ibm.com, bamvor.zhangjian@huawei.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

--------------020409060404030701010104
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 2016/6/9 1:00, Yury Norov wrote:
> On Wed, Jun 08, 2016 at 09:34:09AM +0800, zhouchengming wrote:
>> On 2016/5/24 8:04, Yury Norov wrote:
>>> Here new aarch32 ptrace syscall handler is introsuced to avoid run-time
>>> detection of the task type.
>>>
>>> Signed-off-by: Yury Norov<ynorov@caviumnetworks.com>
>
> [...]
>
>> Hello, I found ilp32 will use sys_ptrace, not compat_sys_ptrace. So I write
>> a little patch to see if can solve the problem correctly.
>>
>> Thanks.
>>
>>  From f6156236df578bb05c4a17e7f9776ceaf8f7afe6 Mon Sep 17 00:00:00 2001
>> From: Zhou Chengming<zhouchengming1@huawei.com>
>> Date: Wed, 8 Jun 2016 09:46:23 +0800
>> Subject: [PATCH] ilp32: use compat_sys_ptrace instead of sys_ptrace
>>
>> When we analyze a testcase of ptrace that failed on ilp32, we found
>> the syscall that the ilp32 uses is sys_ptrace, not compat_sys_ptrace.
>> Because in include/uapi/asm-generic/unistd.h it's defined like:
>> __SYSCALL(__NR_ptrace, sys_ptrace)
>> So we change it to __SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace),
>> let compat tasks use the compat_sys_ptrace.
>>
>> Signed-off-by: Zhou Chengming<zhouchengming1@huawei.com>
>> ---
>>   include/uapi/asm-generic/unistd.h |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/uapi/asm-generic/unistd.h
>> b/include/uapi/asm-generic/unistd.h
>> index 2862d2e..50ee770 100644
>> --- a/include/uapi/asm-generic/unistd.h
>> +++ b/include/uapi/asm-generic/unistd.h
>> @@ -364,7 +364,7 @@ __SC_WRAP(__NR_syslog, sys_syslog)
>>
>>   /* kernel/ptrace.c */
>>   #define __NR_ptrace 117
>> -__SYSCALL(__NR_ptrace, sys_ptrace)
>> +__SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
>>
>>   /* kernel/sched/core.c */
>>   #define __NR_sched_setparam 118
>> --
>> 1.7.7
>>
>
> Hi Zhou,
>
> Thank you for the catch.
>
> Could you also show the test that is failed for you. It should
> probably be sent to LTP maillist.
>
> I'm not sure your fix correct as it affects other architectures that
> use standard unistd.h. I think it's better to redirect the syscall in
> arch/arm64/kernel/sys_ilp32.c with corresponding definition.
>
> Yury
>
> .
>

Sorry, I missed this mail. Thanks for your reply. :)
I attach the testcase file of ptrace that failed on ilp32.
I also think it's better to redirect the syscall in ilp32, so I changed
the patch.


 From 7e692ba1adf02c2a2f125836f5222f455c9ffe56 Mon Sep 17 00:00:00 2001
From: Zhou Chengming <zhouchengming1@huawei.com>
Date: Sat, 25 Jun 2016 18:02:51 +0800
Subject: [PATCH] ilp32 should use compat_sys_ptrace

The file include/uapi/asm-generic/unistd.h defines this:
__SYSCALL(__NR_ptrace, sys_ptrace)
It may cause some ptrace tests failed on ilp32. So we redirect the ptrace
syscall in arch/arm64/kernel/sys_ilp32.c with corresponding definition.

Signed-off-by: Zhou Chengming <zhouchengming1@huawei.com>
---
  arch/arm64/kernel/sys_ilp32.c |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index d85fe94..06d5e1b 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -46,6 +46,9 @@
  asmlinkage long ilp32_sys_rt_sigreturn_wrapper(void);
  #define compat_sys_rt_sigreturn        ilp32_sys_rt_sigreturn_wrapper

+/* ilp32 should use compat_sys_ptrace */
+#define sys_ptrace		       compat_sys_ptrace
+
  #include <asm/syscall.h>

  #undef __SYSCALL
-- 
1.7.7




--------------020409060404030701010104
Content-Type: text/plain; charset="gb18030";
	name="tc_ptrace_setoptions_09.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tc_ptrace_setoptions_09.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/ptrace.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/user.h>
#include <signal.h>

int main()
{
    pid_t child;
    unsigned long exit_status;
    int status;
    int is_get_event = 0;
    long ptrace_ret;

    int result = SIGTRAP | (PTRACE_EVENT_EXIT<<8);

    child = fork();
    if(child < 0)
    {
        printf("fork error\n");
        exit(1);
    }
    else if(child == 0)
    {
        sleep(1);
        exit(127);
    }
    else
    {
        ptrace_ret = ptrace(PTRACE_ATTACH, child, NULL, NULL);
        if(ptrace_ret != 0)                                   
        {
            printf("ptrace PTRACE_ATTACH error %d \n", errno);
            exit(1);
        }

        printf("ATTACH SUCCESS\n");
        sleep(1);
       
        ptrace_ret = ptrace(PTRACE_SETOPTIONS, child, NULL, PTRACE_O_TRACEEXIT);
        if(ptrace_ret != 0)                                   
        {
            printf("ptrace PTRACE_SETOPTIONS PTRACE_O_TRACEFORK error %d \n", errno);
            ptrace(PTRACE_DETACH, child, NULL, NULL);
            exit(1);
        }

        printf("SETOPTIONS SUCCESS!\n");

        while(1)
        {
            usleep(1);
            pid_t pid;
            if ((pid = wait(&status)) == -1) {
                perror("wait");
                exit(1);
            };
   
            printf("pid : %d\n", pid);
            printf("the child process stops. status: %d, signal? %d, exit? %d, continue? %d, stop? %d\n" , WEXITSTATUS(status) , WIFSIGNALED(status) , WIFEXITED(status) , WIFCONTINUED(status) ,WIFSTOPPED(status));

            if (WSTOPSIG(status) == SIGTRAP)
            {
                printf("status : %d\n", status>>8);
                if (status>>8 == result)
                {
                    if (ptrace(PTRACE_GETEVENTMSG, child, NULL, &exit_status))
                    {
                        perror("error geteventmsg");
                        exit(1);
                    }
                
                    printf("exit_status %d\n", WEXITSTATUS((int)exit_status));

                    exit_status = WEXITSTATUS(exit_status);

                    if (exit_status != 127)
                    {
                        printf("exit status is not equal with 127!\n");
                        exit(1);
                    }
                    is_get_event = 1;
                }
            }

            if (WIFEXITED(status))
            {
                printf("child exit!\n");
                break;
            }

            if(ptrace(PTRACE_CONT, pid, NULL, (void *) SIGCONT))
            {
                printf("ptrace cont %d error %d\n", pid, errno);
                exit(1);
            }

        }

        if (is_get_event)
            exit(0);
        else
            exit(1);
    }
}

--------------020409060404030701010104--
