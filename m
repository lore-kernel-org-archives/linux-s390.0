From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/5] KVM: s390: add debug tracing for cpu features of
 CPU model
Date: Wed, 20 Dec 2017 17:37:07 +0100
Message-ID: <20171220173707.4a1d1856.cohuck@redhat.com>
References: <20171220155300.102321-1-borntraeger@de.ibm.com>
        <20171220155300.102321-4-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220155300.102321-4-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 20 Dec 2017 16:52:58 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The cpu model already traces the cpu facilities, the ibc and
> guest CPU ids. We should do the same for the cpu features (on
> success only).
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
