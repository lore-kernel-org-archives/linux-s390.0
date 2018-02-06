From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1] KVM: s390: use switch vs jump table in interrupt.c
Date: Tue, 6 Feb 2018 15:29:43 +0100
Message-ID: <20180206152943.4859454d.cohuck@redhat.com>
References: <20180206141743.24497-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180206141743.24497-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue,  6 Feb 2018 15:17:43 +0100
David Hildenbrand <david@redhat.com> wrote:

> Just like for the interception handlers, let's also use a switch-case
> in our interrupt delivery code.

Amusingly, we did have a switch/case in the past :)

Nice that we can get rid of the I/O interrupt special casing.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/interrupt.c | 84 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 50 insertions(+), 34 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
