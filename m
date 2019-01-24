From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 06/13] KVM: s390: remove kvm_s390_ from gisa static
 inline functions
Date: Thu, 24 Jan 2019 15:26:06 +0100
Message-ID: <20190124152606.31d179a5.cohuck@redhat.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-7-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-7-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:32 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> This will shorten the length of code lines. All GISA related
> static inline functions are local to interrupt.c.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
