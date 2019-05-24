Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20190523164309.13345-1-thuth@redhat.com>
 <0ad63449-c329-f38d-b879-6e427e6a8656@de.ibm.com>
 <e6f953be-00af-756e-4c0a-649294efbd91@de.ibm.com>
Date: Fri, 24 May 2019 14:29:43 +0200
MIME-Version: 1.0
In-Reply-To: <e6f953be-00af-756e-4c0a-649294efbd91@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <411d4ad9-b43e-d3ae-1b66-65888c894caa@de.ibm.com>
Subject: Re:  [PATCH v1 0/9] KVM selftests for s390x
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org



On 24.05.19 14:17, Christian Borntraeger wrote:
> 
> 
> On 24.05.19 13:11, Christian Borntraeger wrote:
>> I do get
>>
>> [10400.440298] kvm-s390: failed to commit memory region
>> [10400.508723] kvm-s390: failed to commit memory region
>>
>> when running the tests. Will have a look.
> 
> It comes from kvm_vm_free. This calls KVM_SET_USER_MEMORY_REGION with size 0,
> which the s390 code does not like.
> 

The doc says about  KVM_SET_USER_MEMORY_REGION:

This ioctl allows the user to create or modify a guest physical memory
slot.  When changing an existing slot, it may be moved in the guest
physical memory space, or its flags may be modified.  --> It may not be
resized. <----

$ strace -f -e trace=ioctl tools/testing/selftests/kvm/s390x/sync_regs_test 
ioctl(3, KVM_CHECK_EXTENSION, KVM_CAP_SYNC_REGS) = 1
ioctl(4, KVM_CHECK_EXTENSION, KVM_CAP_IMMEDIATE_EXIT) = 1
ioctl(3, KVM_CREATE_VM, 0)              = 4
ioctl(4, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=2097152, userspace_addr=0x3ffac500000}) = 0
ioctl(4, KVM_CREATE_VCPU, 5)            = 7
ioctl(8, KVM_GET_VCPU_MMAP_SIZE, 0)     = 4096
ioctl(8, KVM_GET_VCPU_MMAP_SIZE, 0)     = 4096
ioctl(7, KVM_GET_SREGS, 0x3ffef0fdb90)  = 0
ioctl(7, KVM_SET_SREGS, 0x3ffef0fdb90)  = 0
ioctl(7, KVM_GET_REGS, 0x3ffef0fdcf8)   = 0
ioctl(7, KVM_SET_REGS, 0x3ffef0fdcf8)   = 0
ioctl(7, KVM_GET_SREGS, 0x3ffef0fdd78)  = 0
ioctl(7, KVM_SET_SREGS, 0x3ffef0fdd78)  = 0
ioctl(7, KVM_RUN, 0)                    = 0
ioctl(7, KVM_GET_REGS, 0x3ffef0fdf90)   = 0
ioctl(7, KVM_GET_SREGS, 0x3ffef0fe010)  = 0
ioctl(7, KVM_RUN, 0)                    = 0
ioctl(7, KVM_GET_REGS, 0x3ffef0fdf90)   = 0
ioctl(7, KVM_GET_SREGS, 0x3ffef0fe010)  = 0
ioctl(7, KVM_RUN, 0)                    = 0
ioctl(4, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=0, userspace_addr=0x3ffac500000}) = 0
+++ exited with 0 +++

So the testcase is wrong? (I think the s390 code is also not fully correct will double check)
