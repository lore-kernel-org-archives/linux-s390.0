From: "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu
 preempted check
Date: Fri, 21 Oct 2016 20:39:52 +0200
Message-ID: <20161021183951.GA29131@potion>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Pan Xinhui' <xinhui.pan@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "xen-devel-request@lists.xenproject.org" <xen-devel-request@lists.xenproject.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kernellwp@gmail.com" <kernellwp@gmail.com>, "jgross@suse.com" <jgross@suse.com>, "peterz@infradead.org" <peterz@infradead.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "paulus@samba.org" <paulus@samba.org>, pbonzini@r
List-ID: <linux-s390.vger.kernel.org>

2016-10-21 11:27+0000, David Laight:
> From: Pan Xinhui
>> Sent: 20 October 2016 22:28
>> Commit ("x86, kvm: support vcpu preempted check") add one field "__u8
>> preempted" into struct kvm_steal_time. This field tells if one vcpu is
>> running or not.
>> 
>> It is zero if 1) some old KVM deos not support this filed. 2) the vcpu is
>> preempted. Other values means the vcpu has been preempted.
>> 
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>  Documentation/virtual/kvm/msr.txt | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/virtual/kvm/msr.txt b/Documentation/virtual/kvm/msr.txt
>> index 2a71c8f..3376f13 100644
>> --- a/Documentation/virtual/kvm/msr.txt
>> +++ b/Documentation/virtual/kvm/msr.txt
>> @@ -208,7 +208,8 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
>>  		__u64 steal;
>>  		__u32 version;
>>  		__u32 flags;
>> -		__u32 pad[12];
>> +		__u8  preempted;
>> +		__u32 pad[11];
>>  	}
> 
> I think I'd be explicit about the 3 pad bytes you've left.

Seconded.

With that change are all KVM bits

Acked-by: Radim Krčmář <rkrcmar@redhat.com>
