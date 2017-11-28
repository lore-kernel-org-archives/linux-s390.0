From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] KVM: s390: mark irq_state.flags as non-usable
Date: Tue, 28 Nov 2017 22:02:03 +0100
Message-ID: <70c411f4-69da-c5ec-147d-4c32366d8572@redhat.com>
References: <20171124144316.34418-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171124144316.34418-1-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 24.11.2017 15:43, Christian Borntraeger wrote:
> Old kernels did not check for zero in the irq_state.flags field and old
> QEMUs did not zero the flag/reserved fields when calling
> KVM_S390_*_IRQ_STATE.  Let's add comments to prevent future uses of
> these fields.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
