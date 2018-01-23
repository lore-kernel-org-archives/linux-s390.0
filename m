From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 3/4] KVM: s390: introduce and use
 kvm_s390_clear_cpuflags()
Date: Tue, 23 Jan 2018 18:46:17 +0100
Message-ID: <ab96e236-7fdf-fd86-614c-ac062ea9b3b3@redhat.com>
References: <20180123170531.13687-1-david@redhat.com>
 <20180123170531.13687-4-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180123170531.13687-4-david@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 23.01.2018 18:05, David Hildenbrand wrote:
> Use it just like kvm_s390_set_cpuflags().
> 
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/interrupt.c |  8 ++++----
>  arch/s390/kvm/kvm-s390.c  | 11 +++++------
>  arch/s390/kvm/kvm-s390.h  |  5 +++++
>  arch/s390/kvm/priv.c      |  2 +-
>  arch/s390/kvm/vsie.c      |  2 +-
>  5 files changed, 16 insertions(+), 12 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
