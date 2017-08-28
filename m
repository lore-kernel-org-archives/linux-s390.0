From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 05/11] KVM: s390: Support Configuration z/Architecture
 Mode
Date: Mon, 28 Aug 2017 13:35:11 +0200
Message-ID: <20170828133511.4e4c4434.cohuck@redhat.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
        <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 28 Aug 2017 10:07:28 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> kvm has always supported the concept of starting in z/Arch mode so let's
> reflect the feature bit to the guest.
> 
> Also, we change sigp set architecture to reject any request to change
> architecture modes.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/sigp.c             | 36 +++++++++++++++++-------------------
>  arch/s390/tools/gen_facilities.c |  1 +
>  2 files changed, 18 insertions(+), 19 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
