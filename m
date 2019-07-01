Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38438 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfGARbs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Jul 2019 13:31:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so3540485wro.5
        for <linux-s390@vger.kernel.org>; Mon, 01 Jul 2019 10:31:47 -0700 (PDT)
Subject: Re: [GIT PULL 0/7] KVM: s390: add kselftests
References: <20190701125848.276133-1-borntraeger@de.ibm.com>
 <b5f74797-1ff7-26fc-4a5a-1fdabef22671@redhat.com>
 <b1ff22c4-7a2e-158d-e179-d08d3d281a97@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9697009-cda2-9a22-436d-e80475c5adba@redhat.com>
Date: Mon, 1 Jul 2019 19:31:44 +0200
MIME-Version: 1.0
In-Reply-To: <b1ff22c4-7a2e-158d-e179-d08d3d281a97@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

On 01/07/19 17:29, Christian Borntraeger wrote:
> 
> 
> On 01.07.19 16:07, Paolo Bonzini wrote:
>> On 01/07/19 14:58, Christian Borntraeger wrote:
>>> Paolo, Radim,
>>>
>>> kselftest for s390x. There is a small conflict with Linus tree due to
>>> 61cfcd545e42 ("kvm: tests: Sort tests in the Makefile alphabetically")
>>> which is part of kvm/master but not kvm/next.
>>> Other than that this looks good.
>>
>> Thanks! I'll delay this to after the first merge window pull request to
>> avoid the conflict.
> 
> I do not have to do anything, correct?

No, it's done on your side. Just an explanation of why you'll not see
this in kvm/next for a week or so.

Paolo

> As an alternative I could rebase on top of rc6.
>>
>> Paolo
>>
>>>
>>> The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:
>>>
>>>   Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.3-1
>>>
>>> for you to fetch changes up to 8343ba2d4820b1738bbb7cb40ec18ea0a3b0b331:
>>>
>>>   KVM: selftests: enable pgste option for the linker on s390 (2019-06-04 14:05:38 +0200)
>>>
>>> ----------------------------------------------------------------
>>> KVM: s390: add kselftests
>>>
>>> This is the initial implementation for KVM selftests on s390.
>>>
>>> ----------------------------------------------------------------
>>> Christian Borntraeger (1):
>>>       KVM: selftests: enable pgste option for the linker on s390
>>>
>>> Thomas Huth (6):
>>>       KVM: selftests: Guard struct kvm_vcpu_events with __KVM_HAVE_VCPU_EVENTS
>>>       KVM: selftests: Introduce a VM_MODE_DEFAULT macro for the default bits
>>>       KVM: selftests: Align memory region addresses to 1M on s390x
>>>       KVM: selftests: Add processor code for s390x
>>>       KVM: selftests: Add the sync_regs test for s390x
>>>       KVM: selftests: Move kvm_create_max_vcpus test to generic code
>>>
>>>  MAINTAINERS                                        |   2 +
>>>  tools/testing/selftests/kvm/Makefile               |  14 +-
>>>  tools/testing/selftests/kvm/include/kvm_util.h     |   8 +
>>>  .../selftests/kvm/include/s390x/processor.h        |  22 ++
>>>  .../kvm/{x86_64 => }/kvm_create_max_vcpus.c        |   3 +-
>>>  .../testing/selftests/kvm/lib/aarch64/processor.c  |   2 +-
>>>  tools/testing/selftests/kvm/lib/kvm_util.c         |  23 +-
>>>  tools/testing/selftests/kvm/lib/s390x/processor.c  | 286 +++++++++++++++++++++
>>>  tools/testing/selftests/kvm/lib/x86_64/processor.c |   2 +-
>>>  tools/testing/selftests/kvm/s390x/sync_regs_test.c | 151 +++++++++++
>>>  10 files changed, 503 insertions(+), 10 deletions(-)
>>>  create mode 100644 tools/testing/selftests/kvm/include/s390x/processor.h
>>>  rename tools/testing/selftests/kvm/{x86_64 => }/kvm_create_max_vcpus.c (93%)
>>>  create mode 100644 tools/testing/selftests/kvm/lib/s390x/processor.c
>>>  create mode 100644 tools/testing/selftests/kvm/s390x/sync_regs_test.c
>>>
>>
> 
