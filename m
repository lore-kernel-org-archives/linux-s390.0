From: Avi Kivity <avi@redhat.com>
Subject: Re: -next Jan 11 : s390/kvm build failure
Date: Mon, 11 Jan 2010 12:32:06 +0200
Message-ID: <4B4AFE26.5080503@redhat.com>
References: <20100111194431.c103db9b.sfr@canb.auug.org.au> <4B4AFA45.8000004@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4B4AFA45.8000004@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-next@vger.kernel.org, kvm@vger.kernel.org, mtosatti@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 01/11/2010 12:15 PM, Sachin Sant wrote:
>
> Probable cause could be the following commits :
>
> commit a94db899e8e5b7c4d47e42982800243dcdc69a38
> KVM: split kvm_arch_set_memory_region into prepare and commit
>
> commit fe7701e1daa1ad09d5d271897b6cc65697d33db2
> KVM: switch vcpu context to use SRCU
>

Yes.  Marcelo?  ia64 suffers from the same issue.



-- 
error compiling committee.c: too many arguments to function
