From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Date: Thu, 23 Nov 2017 19:43:33 +0100
Message-ID: <38e20093-9f94-9fbb-12c3-329ce6b8467d@redhat.com>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
 <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
 <20171123174804.GB28855@cbox>
 <acf7f751-d73d-8e16-fe9b-2f1f0e1f5e8d@redhat.com>
 <20171123183214.GC28855@cbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171123183214.GC28855@cbox>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@linaro.org>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 23/11/2017 19:32, Christoffer Dall wrote:
> ok, that makes sense.
> 
> And just to be clear, you prefer that over storing the ioctl on the vcpu
> struct, like this:

Yes, please.

Paolo
