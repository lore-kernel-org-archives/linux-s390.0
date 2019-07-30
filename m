Return-Path: <linux-kselftest-owner@vger.kernel.org>
Subject: Re: [PATCH 0/2] KVM: selftests: Enable ucall and dirty_log_test on
 s390x
References: <20190730100112.18205-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d35baab0-8a31-f686-8302-950e4fb9c07d@redhat.com>
Date: Tue, 30 Jul 2019 13:36:14 +0200
MIME-Version: 1.0
In-Reply-To: <20190730100112.18205-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>

On 30/07/19 12:01, Thomas Huth wrote:
> Implement the ucall() interface on s390x to be able to use the
> dirty_log_test KVM selftest on s390x, too.
> 
> Thomas Huth (2):
>   KVM: selftests: Implement ucall() for s390x
>   KVM: selftests: Enable dirty_log_test on s390x
> 
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  tools/testing/selftests/kvm/dirty_log_test.c  | 70 +++++++++++++++++--
>  .../testing/selftests/kvm/include/kvm_util.h  |  2 +-
>  tools/testing/selftests/kvm/lib/ucall.c       | 34 +++++++--
>  .../selftests/kvm/s390x/sync_regs_test.c      |  6 +-
>  5 files changed, 98 insertions(+), 15 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

(apart from the small review comment on patch 2).

Paolo
