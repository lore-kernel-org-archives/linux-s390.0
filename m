Return-Path: <linux-kselftest-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9cd12ce-d4cf-95b7-15f8-84112527f6a7@redhat.com>
Date: Tue, 30 Jul 2019 21:06:03 +0200
MIME-Version: 1.0
In-Reply-To: <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>

On 30/07/19 16:57, Christian Borntraeger wrote:
> While this fixes the test (and the migration does work fine), it still
> means that s390x overindicates the dirty bit for sparsely populated
> 1M segments. It is just a performance issue, but maybe we should try 
> to get this fixed. Not sure what to do here to remember us about this, 
> adding this as expected fail?

if it's only on the first access after enabling dirty logging, that
shouldn't be that bad?

Paolo
