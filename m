From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 06/11] KVM: s390: Multiple Epoch Facility support
Date: Tue, 29 Aug 2017 14:59:31 +0200
Message-ID: <5a54bb4b-64cb-e24c-808c-b7c3d11af8f7@de.ibm.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
 <1503907651-65296-3-git-send-email-borntraeger@de.ibm.com>
 <705f3223-ed61-e9da-814c-238d21322f6b@redhat.com>
 <a0a71df6-5a52-2237-e7fd-a705da4af83a@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <a0a71df6-5a52-2237-e7fd-a705da4af83a@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Collin L. Walling" <walling@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 08/29/2017 02:46 PM, Christian Borntraeger wrote:
>>> +
>>> +	if (test_kvm_facility(vcpu->kvm, 139)) {
>>
>> Although scb_s->epdx won't be interpreted without ECD_MEF, this should
>> be (so data is only copied if really enabled).
>>
>> if (scb_s->ecd | ECD_MEF)
> 
> As you said, it does not matter but it certainly is clearer. I can fix.

FWIW, It will be & and not |

so

if (scb_s->ecd & ECD_MEF)
