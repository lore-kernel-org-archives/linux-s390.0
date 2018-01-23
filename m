From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC 2/2] KVM: s390: vsie: store guest addresses of
 satellite blocks in vsie_page
Date: Tue, 23 Jan 2018 13:29:12 +0100
Message-ID: <20180123132912.5d37026b.cohuck@redhat.com>
References: <20180116171526.12343-1-david@redhat.com>
        <20180116171526.12343-3-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116171526.12343-3-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 16 Jan 2018 18:15:26 +0100
David Hildenbrand <david@redhat.com> wrote:

> This way, the values cannot changed, even if another VCPU might try to

s/changed/be changed/ (or change?)

> mess with the nested SCB currently getting executed by another VCPU.
> 
> We now always use the same gpa for pinning and unpinning a page (for
> unpinning, it is only relevant to mark the guest page dirty for
> migration).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/vsie.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
