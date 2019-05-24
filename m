Return-Path: <linux-kselftest-owner@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20190523164309.13345-1-thuth@redhat.com>
 <0ad63449-c329-f38d-b879-6e427e6a8656@de.ibm.com>
Date: Fri, 24 May 2019 14:17:41 +0200
MIME-Version: 1.0
In-Reply-To: <0ad63449-c329-f38d-b879-6e427e6a8656@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e6f953be-00af-756e-4c0a-649294efbd91@de.ibm.com>
Subject: Re:  [PATCH v1 0/9] KVM selftests for s390x
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org



On 24.05.19 13:11, Christian Borntraeger wrote:
> I do get
> 
> [10400.440298] kvm-s390: failed to commit memory region
> [10400.508723] kvm-s390: failed to commit memory region
> 
> when running the tests. Will have a look.

It comes from kvm_vm_free. This calls KVM_SET_USER_MEMORY_REGION with size 0,
which the s390 code does not like.
