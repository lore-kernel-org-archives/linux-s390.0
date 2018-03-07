References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
	<20180302092318.GA6026@stefanha-x1.localdomain>
	<6a3461c2-368d-1aa1-5b86-a6a602251829@linux.vnet.ibm.com>
	<20180305110356.GF7910@stefanha-x1.localdomain>
	<12e1269c-6eae-a400-cc00-2c5c8e4bb8f9@linux.vnet.ibm.com>
	<c4c4c483-d7aa-7361-774e-254c5517468b@de.ibm.com>
	<a90027f7-5b85-a6b1-0f0e-9d0a2510ece5@de.ibm.com>
	<20180306073458.24118b01@mschwideX1>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 07:52:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180306073458.24118b01@mschwideX1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <55bacbf2-8b30-1082-ff25-0174470c24b8@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/qemu-devel/>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, famz@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, mreitz@redhat.com, qemu-s390x@nongnu.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 03/06/2018 01:34 AM, Martin Schwidefsky wrote:
> On Mon, 5 Mar 2018 20:08:45 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Do you happen to run with a recent host kernel that has
>>
>> commit 7041d28115e91f2144f811ffe8a195c696b1e1d0
>>      s390: scrub registers on kernel entry and KVM exit
>>
>> Can you run with this on top
>> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
>> index 13a133a6015c..d6dc0e5e8f74 100644
>> --- a/arch/s390/kernel/entry.S
>> +++ b/arch/s390/kernel/entry.S
>> @@ -426,13 +426,13 @@ ENTRY(system_call)
>>          UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
>>          BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
>>          stmg    %r0,%r7,__PT_R0(%r11)
>> -       # clear user controlled register to prevent speculative use
>> -       xgr     %r0,%r0
>>          mvc     __PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
>>          mvc     __PT_PSW(16,%r11),__LC_SVC_OLD_PSW
>>          mvc     __PT_INT_CODE(4,%r11),__LC_SVC_ILC
>>          stg     %r14,__PT_FLAGS(%r11)
>>   .Lsysc_do_svc:
>> +       # clear user controlled register to prevent speculative use
>> +       xgr     %r0,%r0
>>          # load address of system call table
>>          lg      %r10,__THREAD_sysc_table(%r13,%r12)
>>          llgh    %r8,__PT_INT_CODE+2(%r11)
>>
>>
>> To me it looks like that the critical section cleanup (interrupt during system call entry) might
>> save the registers again into ptregs but we have already zeroed out r0.
>> This patch moves the clearing of r0 after sysc_do_svc, which should fix the critical
>> section cleanup.
>>
>> Adding Martin and Heiko. Will spin a patch.
> 
> Argh, yes. Thanks Chrisitan, this is it. I have been searching for the bug
> for days now. The point is that if the system call handler is interrupted
> after the xgr but before .Lsysc_do_svc the code at .Lcleanup_system_call
> repeats the stmg for %r0-%r7 but now %r0 is already zero.
> 
> Please commit a patch for this and I'll will queue it up immediately.
> 

This patch does fix the QEMU crash. I haven't seen the crash after 
running the test case for more than a day. Thanks to everyone for taking 
a look at this problem :)

Thanks
Farhan
