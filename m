From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/5] KVM: s390: add debug tracing for cpu features of CPU
 model
Date: Mon, 8 Jan 2018 12:14:05 +0100
Message-ID: <fff142f5-f6c1-a56d-89e9-0425950202c9@redhat.com>
References: <20171220155300.102321-1-borntraeger@de.ibm.com>
 <20171220155300.102321-4-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220155300.102321-4-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 20.12.2017 16:52, Christian Borntraeger wrote:

"We already trace ... related to the CPU model. We should ..."

> The cpu model already traces the cpu facilities, the ibc and
> guest CPU ids. We should do the same for the cpu features (on
> success only).

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
