From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Date: Thu, 17 Aug 2017 11:16:59 +0200
Message-ID: <b69bc1e0-9d7b-5412-ba56-a5261d539a5b@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
 <20170817093612.024cc4bc.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170817093612.024cc4bc.cohuck@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>
Cc: linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, Christoffer Dall <cdall@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Mackerras <paulus@ozlabs.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On 17/08/2017 09:36, Cornelia Huck wrote:
>> What if we just sent a "vcpu move" request to all vcpus with the new 
>> pointer after it moved? That way the vcpu thread itself would be 
>> responsible for the migration to the new memory region. Only if all 
>> vcpus successfully moved, keep rolling (and allow foreign get_vcpu again).
>>
>> That way we should be basically lock-less and scale well. For additional 
>> icing, feel free to increase the vcpu array x2 every time it grows to 
>> not run into the slow path too often.
> 
> I'd prefer the rcu approach: This is a mechanism already understood
> well, no need to come up with a new one that will likely have its own
> share of problems.

What Alex is proposing _is_ RCU, except with a homegrown
synchronize_rcu.  Using kvm->srcu seems to be the best of both worlds.

Paolo
