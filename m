From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
Date: Wed, 22 Aug 2018 11:18:52 -0400
Message-ID: <c2ec9629-bd52-5855-a62f-9d3e4289ecd3@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
 <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
 <20180821172548.57a6c758.cohuck@redhat.com>
 <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
 <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
 <20180822114250.59a250aa.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180822114250.59a250aa.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/22/2018 05:42 AM, Cornelia Huck wrote:
> On Wed, 22 Aug 2018 01:18:20 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On 08/21/2018 07:07 PM, Tony Krowiak wrote:
>>> This convention has been enforced by the kernel since v1. This is also
>>> enforced by both the LPAR as well as in z/VM. The following is from the
>>> PR/SM Planning Guide:
>>>
>>> Control Domain
>>> A logical partition's control domains are those cryptographic domains for which remote secure
>>> administration functions can be established and administered from this logical partition. This
>>> logical partition’s control domains must include its usage domains. For each index selected in the
>>> usage domain index list, you must select the same index in the control domain index list
>>>    
> That's interesting.
>
>> IMHO this quote is quite a half-full half-empty cup one:
>> * it mandates the set of usage domains is a subset of the set
>> of the control domains, but
>> * it speaks of independent controls, namely about the 'usage domain index'
>> and the 'control domain index list' and makes the enforcement of the rule
>> a job of the administrator (instead of codifying it in the controls).
> I'm wondering if a configuration with a usage domain that is not also a
> control domain is rejected outright? Anybody tried that? :)

That's been tried and is not rejected.

>
>>> Consequently, I'm going to opt for ensuring this is clearly documented. Based on the fact you've
>>> requested clarification of many points described in this section of the doc, I
>>> think I'll try putting my meager skills as a wordsmith to work to hopefully clarify things.
>>> I'll run it by you when I complete that task to see if I've succeeded:)
>> I don't think just a doc update will do. Let me explain why.
>>
>> What describe as "... note that the AQM and ADM masks configured for the
>> mediated matrix device will be logically OR'd together to create the ADM
>> stored in the CRYCB referenced from the guest's SIE state description."
>> is a gotcha at best. The member of struct ap_matrix and the member of the
>> respective apcb in the crycb are both called 'adm', but ap_matrix.adm is
>> not an ADM as we know it from the architecture, but rather ~ AQM & ADM.
>>
>> I feel pretty strongly about this one. If we want to keep the enforcement
>> in the kernel, I guess, the assign_domain should set the bit corresponding
>> bit not only in ap_matrix.aqm but also in ap_matrix.adm. When the
>> ap_matrix is committed into the crycb no further manipulating the masks
>> should take place.
> Would you be fine if the control domain interface stated that it is
> used to configure _additional_ control domains and the usage domain
> interface stated that it is used to define usage and implicitly also
> control domains? (And make the usage domain interface also set the
> equivalent bit in the control domain mask.)

I think that is the better way to go and is something Halil recommended
in another post.

>
>> I don't feel strongly about whether to enforce this convention about AQM
>> and ADM in the kernel or not. Frankly, I don't know what is behind the
>> rule. Since I can't tell if any problems are to be expected if this
>> convention is violated, I would feel more comfortable if the rule was
>> accommodated higher in the management stack.
> I guess it depends:
>
> - If this is a case of: "Don't configure control domains that are not
>    also usage domains. You are likely to go through
>    {code,firmware,hardware} paths that are generally not used.",
>    configure it in the kernel.
> - If this rather is "Everybody is doing that, it's a general
>    convention.", configure it higher up in the stack (libvirt?)

I have come to the conclusion that the convention should be enforced
in the sysfs interfaces of the mediated matrix device as follows:

1. All domains assigned as usage domains will also be implicitly
    assigned as control domains.

2. Control domains that are not usage domains may be assigned via
    the assign_control_domain interface.

My reason is to maintain consistency across platforms, because:

1. The architecture doc states that control domains are a superset
    of the usage domains.

2. The HMC interface for assigning domains to the LPAR enforces
    the convention.

3. The PR/SM documentation states the same.



>
