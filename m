From: Sachin Sant <sachinp@in.ibm.com>
Subject: -next Jan 11 : s390/kvm build failure
Date: Mon, 11 Jan 2010 15:45:33 +0530
Message-ID: <4B4AFA45.8000004@in.ibm.com>
References: <20100111194431.c103db9b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100111194431.c103db9b.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-next@vger.kernel.org, kvm@vger.kernel.org, mtosatti@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Today's next build on s390 failed with:

In file included from arch/s390/kvm/kvm-s390.c:30:
arch/s390/kvm/kvm-s390.h: In function 'kvm_s390_vcpu_set_mem':
arch/s390/kvm/kvm-s390.h:75: warning: assignment from incompatible pointer type
arch/s390/kvm/kvm-s390.h:77: error: dereferencing pointer to incomplete type
arch/s390/kvm/kvm-s390.c: At top level:
arch/s390/kvm/kvm-s390.c:692: error: conflicting types for 'kvm_arch_prepare_memory_region'
include/linux/kvm_host.h:258: error: previous declaration of 'kvm_arch_prepare_memory_region' was here
arch/s390/kvm/kvm-s390.c: In function 'kvm_arch_prepare_memory_region':
arch/s390/kvm/kvm-s390.c:698: warning: unused variable 'vcpu'
arch/s390/kvm/kvm-s390.c:697: warning: unused variable 'i'
arch/s390/kvm/kvm-s390.c: At top level:
arch/s390/kvm/kvm-s390.c:725: error: conflicting types for 'kvm_arch_commit_memory_region'
include/linux/kvm_host.h:262: error: previous declaration of 'kvm_arch_commit_memory_region' was here
arch/s390/kvm/kvm-s390.c: In function 'kvm_arch_commit_memory_region':
arch/s390/kvm/kvm-s390.c:731: error: 'i' undeclared (first use in this function)
arch/s390/kvm/kvm-s390.c:731: error: (Each undeclared identifier is reported only once
arch/s390/kvm/kvm-s390.c:731: error: for each function it appears in.)
arch/s390/kvm/kvm-s390.c:731: error: 'vcpu' undeclared (first use in this function)
arch/s390/kvm/kvm-s390.c:731: warning: left-hand operand of comma expression has no effect

and few more 

In file included from arch/s390/kvm/intercept.c:20:
arch/s390/kvm/kvm-s390.h: In function 'kvm_s390_vcpu_set_mem':
arch/s390/kvm/kvm-s390.h:75: warning: assignment from incompatible pointer type
arch/s390/kvm/kvm-s390.h:77: error: dereferencing pointer to incomplete type
make[1]: *** [arch/s390/kvm/intercept.o] Error 1

Probable cause could be the following commits :

commit a94db899e8e5b7c4d47e42982800243dcdc69a38
KVM: split kvm_arch_set_memory_region into prepare and commit

commit fe7701e1daa1ad09d5d271897b6cc65697d33db2
KVM: switch vcpu context to use SRCU

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
