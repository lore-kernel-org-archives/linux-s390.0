From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 2/4] KVM: s390: reuse kvm_s390_set_cpuflags()
Date: Tue, 23 Jan 2018 18:44:38 +0100
Message-ID: <a018b91c-e8fe-bb6a-b73a-747bd6667841@redhat.com>
References: <20180123170531.13687-1-david@redhat.com>
 <20180123170531.13687-3-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180123170531.13687-3-david@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 23.01.2018 18:05, David Hildenbrand wrote:
> Use it in all places where we set cpuflags.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/interrupt.c |  4 ++--
>  arch/s390/kvm/kvm-s390.c  | 17 ++++++++---------
>  arch/s390/kvm/vsie.c      |  2 +-
>  3 files changed, 11 insertions(+), 12 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
