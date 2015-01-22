From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH/RFC 01/21] KVM: remove unneeded return value of vcpu_postcreate
Date: Thu, 22 Jan 2015 17:55:39 +0100
Message-ID: <54C12B8B.7080506@redhat.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com> <1421329414-76826-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 15/01/2015 14:43, Christian Borntraeger wrote:
> From: Dominik Dingel <dingel@linux.vnet.ibm.com>
> 
> Only x86 and s390 provides such vcpu_postcreate implementation.
> On s390 it can't fail and on x86 a fail is also impossible.
> Additionally common code didn't care about return value.
> So we just get rid of it.

s390 doesn't provide it as of this patch.  Perhaps clarify:

The return value of kvm_arch_vcpu_postcreate is not checked in its
caller.  This is okay, because only x86 provides vcpu_postcreate right
now and it could only fail if vcpu_load failed.  But that is not
possible during KVM_CREATE_VCPU (kvm_arch_vcpu_load is void, too), so
just get rid of the unchecked return value.

Paolo

> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
