From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PULL 3/4] KVM: s390: Fix possible memory leak in SIGP functions
Date: Tue, 25 Mar 2014 15:39:41 +0100
Message-ID: <5331952D.4030408@de.ibm.com>
References: <1395754523-43697-1-git-send-email-borntraeger@de.ibm.com> <1395754523-43697-4-git-send-email-borntraeger@de.ibm.com> <53318C82.80600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53318C82.80600@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 25/03/14 15:02, Paolo Bonzini wrote:
> Il 25/03/2014 14:35, Christian Borntraeger ha scritto:
>> From: Thomas Huth <thuth@linux.vnet.ibm.com>
>>
>> When kvm_get_vcpu() returned NULL for the destination CPU in
>> __sigp_emergency() or __sigp_external_call(), the memory for the
>> "inti" structure was not released anymore. This patch fixes this
>> issue by moving the check for !dst_vcpu before the kzalloc() call.
>>
>> Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
>> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Should patch 2 and this one have a Cc: stable?

This bug is not yet in 3.14-rc
It is only in kvm/next via commit  1ee0bc559dc34fe36a29494faf7b7c91533bd31c ( KVM: s390: get rid of local_int array)
So no need for stable.
patch 2 just reduces the memory usage from 64 bytes to 8 bytes.
Dont think we should use the stable folks for that.

Christian
