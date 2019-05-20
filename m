Return-Path: <SRS0=Q8yj=TU=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC PATCH 1/4] KVM: selftests: Guard struct kvm_vcpu_events with
 __KVM_HAVE_VCPU_EVENTS
References: <20190516111253.4494-1-thuth@redhat.com>
 <20190516111253.4494-2-thuth@redhat.com>
 <e8a57340-6f8d-90b8-ad73-c39c19f5c9a4@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8fda58ac-0e0c-6576-f492-2a9f9d2a3194@redhat.com>
Date: Mon, 20 May 2019 10:08:00 +0200
MIME-Version: 1.0
In-Reply-To: <e8a57340-6f8d-90b8-ad73-c39c19f5c9a4@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 20/05/2019 09.12, Christian Borntraeger wrote:
> 
> On 16.05.19 13:12, Thomas Huth wrote:
>> The struct kvm_vcpu_events code is only available on certain architectures
>> (arm, arm64 and x86). To be able to compile kvm_util.c also for other
>> architectures, we've got to fence the code with __KVM_HAVE_VCPU_EVENTS.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> According to the MAINTAINERS patches, you want me to pick these patches. Correct?

That would be nice, yes. But if you don't want to be responsible for
s390x-related KVM selftest patches, please let me know, then I'll drop
these hunks from the patches again.

 Thomas
