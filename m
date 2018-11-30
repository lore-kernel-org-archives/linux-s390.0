From: Michael Mueller <mimu@linux.ibm.com>
Date: Fri, 30 Nov 2018 13:17:21 +0000
Subject: Re: [PATCH v3 12/12] KVM: s390: allow to change the IAM clear strategy dynamically
Message-Id: <c09a0cb8-048b-a66a-60c4-447c1d5e90ce@linux.ibm.com>
In-Reply-To: <20181129133853.5ed7aabe.cohuck@redhat.com>
References: <20181129133853.5ed7aabe.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 29.11.18 13:38, Cornelia Huck wrote:
> On Wed, 28 Nov 2018 11:19:43 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> The sysctl file /proc/sys/s390/iam_clear_strategy defines under which
>> condition the GISA IAM is cleared before entering the SIE in routine
>> vcpu_pre_run().
>>
>> The following IAM clear strategies are available:
>>
>>    0 : the mask is never cleared
>>    1 : the mask is cleared if I/O interruptions are not
>>        disabled by the PSW of the vcpu entering the SIE
>>    2 : the mask is unconditionally cleared
>>
>> The default IAM clear strategy after system boot is 0.
>>
>> Set the new strategy by means of the sysctl command or write to the file.
>>
>>    sysctl s390.iam_clear_strategy=1
>>    echo 2 >/proc/sys/s390/iam_clear_strategy
> 
> This wants some documentation, I think. How is the admin supposed to
> know which strategy to choose?

The patch will be dropped. The strategy will not be changeable by
an admin. The IAM will never be cleared by the host program during
normal operation except for the GISA clear and GISA drop cases.

> 
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
>>   arch/s390/kvm/kvm-s390.c  |  1 +
>>   arch/s390/kvm/kvm-s390.h  |  1 +
>>   3 files changed, 71 insertions(+)
> 

-- 
Mit freundlichen Gr��en / Kind regards
Michael M�ller

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K�deritz
Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
