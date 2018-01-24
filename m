From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 4/4] KVM: s390: introduce and use
 kvm_s390_test_cpuflags()
Date: Wed, 24 Jan 2018 17:43:03 +0100
Message-ID: <20180124174303.5cf1b95e.cohuck@redhat.com>
References: <20180123170531.13687-1-david@redhat.com>
        <20180123170531.13687-5-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180123170531.13687-5-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 23 Jan 2018 18:05:31 +0100
David Hildenbrand <david@redhat.com> wrote:

> Use it just like kvm_s390_set_cpuflags() and kvm_s390_clear_cpuflags().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/interrupt.c |  2 +-
>  arch/s390/kvm/kvm-s390.c  |  2 +-
>  arch/s390/kvm/kvm-s390.h  |  7 ++++++-
>  arch/s390/kvm/priv.c      |  4 ++--
>  arch/s390/kvm/sigp.c      | 14 +++++---------
>  5 files changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
