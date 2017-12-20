From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/5] KVM: s390: use created_vcpus in more places
Date: Wed, 20 Dec 2017 17:35:11 +0100
Message-ID: <20171220173511.707fae13.cohuck@redhat.com>
References: <20171220155300.102321-1-borntraeger@de.ibm.com>
        <20171220155300.102321-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220155300.102321-3-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 20 Dec 2017 16:52:57 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> commit a03825bbd0c3 ("KVM: s390: use kvm->created_vcpus") introduced
> kvm->created_vcpus to avoid races with the existing kvm->online_vcpus
> scheme. One place was "forgotten" and one new place was "added".
> Let's fix those.
> 
> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Fixes: 4e0b1ab72b8a ("KVM: s390: gs support for kvm guests")
> Fixes: a03825bbd0c3 ("KVM: s390: use kvm->created_vcpus")
> ---
>  arch/s390/kvm/kvm-s390.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
