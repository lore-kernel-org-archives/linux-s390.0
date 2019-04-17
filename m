Return-Path: <SRS0=rjjQ=ST=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH] KVM: s390: Fix potential spectre warnings
References: <20190417005414.47801-1-farman@linux.ibm.com>
 <bdea8892-6818-93fa-fa2a-b2bad69a50d1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b8a0bab-576b-190d-1213-acea61f94a85@redhat.com>
Date: Wed, 17 Apr 2019 15:13:00 +0200
MIME-Version: 1.0
In-Reply-To: <bdea8892-6818-93fa-fa2a-b2bad69a50d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 17/04/19 09:49, David Hildenbrand wrote:
> return kvm->arch.adapters[array_index_nospec(id, MAX_S390_IO_ADAPTERS)];
> 
> should exactly fit into a single line if I am not wrong.

git grep "\\[.*array_index_nospec" suggests that the preferred idiom is

	var = array_index_nospec(var, SIZE)

which makes sense since it sanitizes var once and for all.

Paolo
