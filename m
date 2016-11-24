Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: next: s390 crash due to 's390: move sys_call_table and last_break
 from thread_info to thread_struct'
References: <20161115153554.GA22064@roeck-us.net>
 <20161115165416.00dbc85d@mschwide>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a6c571e2-412a-b344-b20a-d813851a1419@roeck-us.net>
Date: Thu, 24 Nov 2016 12:53:52 -0800
MIME-Version: 1.0
In-Reply-To: <20161115165416.00dbc85d@mschwide>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Martin,

On 11/15/2016 07:54 AM, Martin Schwidefsky wrote:
> On Tue, 15 Nov 2016 07:35:54 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> Hi Martin,
>>
>> my s390 qemu boot test crashes in -next as follows.
>>
>> Kernel stack overflow.
>> CPU: 0 PID: 923 Comm: modprobe Not tainted 4.9.0-rc5-next-20161115 #1
>> Hardware name: QEMU             QEMU                  QEMU             (KVM)
>> task: 000000001d805100 task.stack: 000000001d898000
>> Krnl PSW : 0404e00180000000 0000000000ac2b42 (pgm_check_handler+0xd6/0x1b4)
>>            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>> Krnl GPRS: 0000000000000020 0000000000000000 0000000000000004 0000000000000000
>>            0000000000400034 0000000000000000 000000007ff3b350 0000000000000001
>>            0404e00180000000 0000000000ac2b42 0000000000ac2ad0 000000007ff38178
>>            000000001d805100 0000000000ac335e 0000000000000200 000000007ff380d8
>> Krnl Code: 0000000000ac2b34: a7840005		brc	8,ac2b3e
>>            0000000000ac2b38: d2ffe0e8d000	mvc	232(256,%r14),0(%r13)
>>           #0000000000ac2b3e: 41b0f0a0		la	%r11,160(%r15)
>>           >0000000000ac2b42: eb07b0180024	stmg	%r0,%r7,24(%r11)
>>            0000000000ac2b48: d23fb0580200	mvc	88(64,%r11),512
>>            0000000000ac2b4e: eb89b0080024	stmg	%r8,%r9,8(%r11)
>>            0000000000ac2b54: d203b0a0008c	mvc	160(4,%r11),140
>>            0000000000ac2b5a: d207b0a800a8	mvc	168(8,%r11),168
>> Call Trace:
>> no locks held by modprobe/923.
>> Last Breaking-Event-Address:
>>  [<0000000000000000>]           (null)
>>  Kernel panic - not syncing: Corrupt kernel stack, can't continue.
>>
>> Bisect points to commit 1914608db9 ("s390: move sys_call_table and last_break
>> from thread_info to thread_struct"). Reverting that patch fixes the problem.
>>
>> Configuration is s390:defconfig with CONFIG_MARCH_Z900=y.
>>
>> Bisect log is attached.
>> A complete log is at:
>> http://kerneltests.org/builders/qemu-s390-next/builds/252/steps/qemubuildcommand/logs/stdio
>
> Thanks for the report. Builds for Z900 and Z990 are borked. This hunk
>
> @@ -287,7 +292,13 @@ ENTRY(system_call)
>         mvc     __PT_INT_CODE(4,%r11),__LC_SVC_ILC
>         stg     %r14,__PT_FLAGS(%r11)
>  .Lsysc_do_svc:
> -       lg      %r10,__TI_sysc_table(%r12)      # address of system call table
> +       # load address of system call table
> +#ifdef CONFIG_HAVE_MARCH_Z990_FEATURES
> +       lg      %r10,__TASK_thread+__THREAD_sysc_table(%r12)
> +#else
> +       lghi    %r10,__TASK_thread
> +       lg      %r10,__THREAD_sysc_table(%r10,%r12)
> +#endif
>         llgh    %r8,__PT_INT_CODE+2(%r11)
>         slag    %r8,%r8,2                       # shift and test for svc 0
>         jnz     .Lsysc_nr_ok
>
> makes ill use of %r10 in the #else part. Should be fixed now and tomorrows -next
> tree will have the fix. Thanks again.
>

This is still crashing in -next with exactly the same message.

Guenter
