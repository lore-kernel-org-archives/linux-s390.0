Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC PATCH 4/4] KVM: selftests: Add the sync_regs test for s390x
References: <20190516111253.4494-1-thuth@redhat.com>
 <20190516111253.4494-5-thuth@redhat.com>
 <20190523105623.3zlnbleniovobwzk@kamzik.brq.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6fbe22d3-b9a9-48c5-8227-743841332ae0@redhat.com>
Date: Thu, 23 May 2019 13:19:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190523105623.3zlnbleniovobwzk@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 23/05/2019 12.56, Andrew Jones wrote:
> On Thu, May 16, 2019 at 01:12:53PM +0200, Thomas Huth wrote:
>> The test is an adaption of the same test for x86. Note that there
>> are some differences in the way how s390x deals with the kvm_valid_regs
>> in struct kvm_run, so some of the tests had to be removed. Also this
>> test is not using the ucall() interface on s390x yet (which would need
>> some work to be usable on s390x), so it simply drops out of the VM with
>> a diag 0x501 breakpoint instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  MAINTAINERS                                   |   1 +
>>  tools/testing/selftests/kvm/Makefile          |   2 +
>>  .../selftests/kvm/s390x/sync_regs_test.c      | 151 ++++++++++++++++++
>>  3 files changed, 154 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/s390x/sync_regs_test.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 514d1f88ee26..68f76ee9e821 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8645,6 +8645,7 @@ F:	arch/s390/include/asm/gmap.h
>>  F:	arch/s390/include/asm/kvm*
>>  F:	arch/s390/kvm/
>>  F:	arch/s390/mm/gmap.c
>> +F:	tools/testing/selftests/kvm/s390x/
>>  F:	tools/testing/selftests/kvm/*/s390x/
> 
> Do we need these lines added? We have tools/testing/selftests/kvm/ in the
> common KVM section already. If we do want to specify them specifically,
> then I guess we need x86 and arm MAINTAINERS updates as well.

I think they are helpful in the sense that the s390x maintainers get
CC:-ed on related patches as well, and if I've got Christian right, he's
interested in getting informed here. For Arm related patches, I guess
you should ask the Arm maintainers first. For x86, it does not really
matter, since the maintainers are the same.

 Thomas
