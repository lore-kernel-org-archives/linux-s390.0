From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 30 Apr 2018 12:51:37 +0000
Subject: Re: [PATCH v1 2/3] KVM: s390: no need to inititalize kvm->arch members to 0
Message-Id: <20180430145137.2daa1dad.cohuck@redhat.com>
In-Reply-To: <f4c3e805-9cf5-8e4a-b4b7-a63a9d2fe1ec@linux.ibm.com>
References: <f4c3e805-9cf5-8e4a-b4b7-a63a9d2fe1ec@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 27 Apr 2018 14:36:12 +0200
David Hildenbrand <david@redhat.com> wrote:

> KVM is allocated with kzalloc(), so these members are already 0.

I suppose that we will always have a zeroed allocation here, or things
may suddenly break anyway.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
