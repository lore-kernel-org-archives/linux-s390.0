From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/2] KVM: s390: use switch vs jump table in
 intercept.c
Date: Tue, 6 Feb 2018 13:51:25 +0100
Message-ID: <20180206135125.52d9d168.cohuck@redhat.com>
References: <20180206112127.19014-3-borntraeger@de.ibm.com>
        <20180206124700.19177-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180206124700.19177-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue,  6 Feb 2018 12:47:00 +0000
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Instead of having huge jump tables for function selection,
> let's use normal switch/case statements for the instruction
> handlers in intercept.c We can now also get rid of
> intercept_handler_t.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/intercept.c | 51 +++++++++++++++++++++++++++--------------------
>  arch/s390/kvm/kvm-s390.h  |  2 --
>  2 files changed, 29 insertions(+), 24 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
