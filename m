Return-Path: <SRS0=zbpt=TY=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH] KVM: selftests: enable pgste option for the linker on
 s390
References: <20190523164309.13345-1-thuth@redhat.com>
 <20190524103301.87017-1-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <798bd397-d44f-0076-3f87-ea0214ceb614@redhat.com>
Date: Fri, 24 May 2019 20:16:46 +0200
MIME-Version: 1.0
In-Reply-To: <20190524103301.87017-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Andrew Jones <drjones@redhat.com>, linux-kselftest@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 24/05/2019 12.33, Christian Borntraeger wrote:
> To avoid testcase failures we need to enable the pgstes. This can be
> done with /proc/sys/vm/allocate_pgste or with a linker option that
> creates an  S390_PGSTE program header.

Oh, right, I initially enabled it on my LPAR via "sysctl
vm.allocate_pgste=1" when I started working on the selftests and then
completely forgot about this... The linker option is certainly the
better way to do this, thanks for the patch!

Reviewed-by: Thomas Huth <thuth@redhat.com>
