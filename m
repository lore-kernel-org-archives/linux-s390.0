From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 1/4] KVM: s390: rename __set_cpuflag() to
 kvm_s390_set_cpuflags()
Date: Wed, 24 Jan 2018 17:30:08 +0100
Message-ID: <20180124173008.1ca19282.cohuck@redhat.com>
References: <20180123170531.13687-1-david@redhat.com>
        <20180123170531.13687-2-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180123170531.13687-2-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 23 Jan 2018 18:05:28 +0100
David Hildenbrand <david@redhat.com> wrote:

> No need to make this function special. Move it to a header right away.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/interrupt.c | 29 ++++++++++++-----------------
>  arch/s390/kvm/kvm-s390.h  |  5 +++++
>  2 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
