From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
Date: Sun, 22 Apr 2018 17:53:21 +0200
Message-ID: <28eacee1-eafe-dc95-c008-61bc656b931c@linux.ibm.com>
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d7ed9844-0753-6d7a-ccd8-48e89992a34e@redhat.com>
 <d6e8e85b-525e-906a-3c17-ea5faef143cb@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d6e8e85b-525e-906a-3c17-ea5faef143cb@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
List-ID: <linux-s390.vger.kernel.org>



On 04/22/2018 05:06 PM, Tony Krowiak wrote:
> On 04/20/2018 08:26 AM, David Hildenbrand wrote:
>> On 19.04.2018 23:13, Tony Krowiak wrote:
>>> Introduces a new function to reset the crypto attributes for all
>>> vcpus whether they are running or not. Each vcpu in KVM will
>>> be removed from SIE prior to resetting the crypto attributes in its
>>> SIE state description. After all vcpus have had their crypto attributes
>>> reset the vcpus will be restored to SIE.
>>>
>>> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
>>> function to fix a reported issue whereby the crypto key wrapping
>>> attributes could potentially get out of synch for running vcpus.
>>>
>>> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> A reported-by for a code refactoring is strange.
> 
> I was asked to include this.

Is this a refactoring or a fix? I the message you state that you are
fixing an issue (aka bug). If you are not, fixing an issue, but indeed
just refactoring, Suggested-by would be more appropriate.

Regards,
Halil
