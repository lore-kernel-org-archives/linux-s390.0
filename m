From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 16 May 2018 11:40:20 +0000
Subject: Re: [PATCH v2 2/2] KVM: s390: vsie: simplify < 8k address checks
Message-Id: <20180516134020.5abc43b4.cohuck@redhat.com>
In-Reply-To: <4f49ca9d-7794-3350-d14b-4364ff76bd21@linux.ibm.com>
References: <4f49ca9d-7794-3350-d14b-4364ff76bd21@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed,  9 May 2018 16:12:18 +0200
David Hildenbrand <david@redhat.com> wrote:

> This makes it certainly more readable.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/vsie.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
