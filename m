Return-Path: <SRS0=e7nO=SU=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH] KVM: s390: Fix potential spectre warnings
References: <20190417005414.47801-1-farman@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Apr 2019 09:19:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190417005414.47801-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fa4c8bfd-ddb2-cf68-4ec2-d002b0154837@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 17.04.19 02:54, Eric Farman wrote:
> Fix some warnings from smatch:
> 
> arch/s390/kvm/interrupt.c:2310 get_io_adapter() warn: potential spectre issue 'kvm->arch.adapters' [r] (local cap)
> arch/s390/kvm/interrupt.c:2341 register_io_adapter() warn: potential spectre issue 'dev->kvm->arch.adapters' [w]
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> A recent patch from Paolo [1] acted as a reminder (thanks, Christian!)
> that I had one for the s390 KVM code after some code reviews [2].
> Let's clean that up.
> 
> [1] https://patchwork.kernel.org/patch/10895463/
> [2] https://patchwork.kernel.org/patch/10788565/#22484223

Thanks applied.
