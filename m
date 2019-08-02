Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33549 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfHBNnj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Aug 2019 09:43:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so77347488wru.0
        for <linux-s390@vger.kernel.org>; Fri, 02 Aug 2019 06:43:38 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] KVM: selftests: Enable ucall and dirty_log_test on
 s390x
References: <20190731151525.17156-1-thuth@redhat.com>
 <551b42ae-78a1-e55a-e4b8-bb5cc3a8eb8b@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9684b15d-39a4-2c1b-3269-466ceb37ef90@redhat.com>
Date: Fri, 2 Aug 2019 15:43:36 +0200
MIME-Version: 1.0
In-Reply-To: <551b42ae-78a1-e55a-e4b8-bb5cc3a8eb8b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>

On 02/08/19 15:39, Christian Borntraeger wrote:
> On 31.07.19 17:15, Thomas Huth wrote:
>> Implement the ucall() interface on s390x to be able to use the
>> dirty_log_test KVM selftest on s390x, too.
>>
>> v3:
>>  - Fix compilation issue on aarch64 (thanks to Andrew for testing it!)
>>  - Added Reviewed-bys
>>
>> v2:
>>  - Split up ucall.c into architecture specific files
>>  - Removed some #ifdef __s390x__  in the dirty_log patch
>>
>> Thomas Huth (3):
>>   KVM: selftests: Split ucall.c into architecture specific files
>>   KVM: selftests: Implement ucall() for s390x
>>   KVM: selftests: Enable dirty_log_test on s390x
>>
>>  tools/testing/selftests/kvm/Makefile          |   9 +-
>>  tools/testing/selftests/kvm/dirty_log_test.c  |  61 ++++++-
>>  .../testing/selftests/kvm/include/kvm_util.h  |   8 +-
>>  .../testing/selftests/kvm/lib/aarch64/ucall.c | 112 +++++++++++++
>>  tools/testing/selftests/kvm/lib/s390x/ucall.c |  56 +++++++
>>  tools/testing/selftests/kvm/lib/ucall.c       | 157 ------------------
>>  .../testing/selftests/kvm/lib/x86_64/ucall.c  |  56 +++++++
>>  .../selftests/kvm/s390x/sync_regs_test.c      |   6 +-
>>  8 files changed, 287 insertions(+), 178 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/lib/aarch64/ucall.c
>>  create mode 100644 tools/testing/selftests/kvm/lib/s390x/ucall.c
>>  delete mode 100644 tools/testing/selftests/kvm/lib/ucall.c
>>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/ucall.c
>>
> 
> Paolo, I guess you do not mind if I carry patch 1 also via the s390x tree?

Sure,

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
