From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 2/3] kvm: Note down when cpu relax intercepted
 or pause loop exited
Date: Tue, 17 Jul 2012 14:01:48 +0530
Message-ID: <500522F4.7090601@linux.vnet.ibm.com>
References: <20120716082445.23477.15128.sendpatchset@codeblue.in.ibm.com> <20120716082514.23477.23849.sendpatchset@codeblue.in.ibm.com> <5003E682.20909@redhat.com> <50044E58.60905@linux.vnet.ibm.com> <500520A8.50106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <500520A8.50106@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Srikar <srikar@linux.vnet.ibm.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/17/2012 01:52 PM, Avi Kivity wrote:
> On 07/16/2012 08:24 PM, Raghavendra K T wrote:
>> So are you saying allow vcpu to spin in non over-commit scenarios? So
>> that we avoid all yield_to etc...
>>
>> ( Or even in some other place where it is useful).
>
> When is yielding useful, if you're not overcommitted?
>

Right. There is no need to do yield_to when run queue has only one task.
