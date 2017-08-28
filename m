From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 11/11] KVM: s390: expose no-DAT to guest and migration
 support
Date: Mon, 28 Aug 2017 14:12:01 +0200
Message-ID: <20170828141201.1700c41b.cohuck@redhat.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
        <1503907651-65296-5-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503907651-65296-5-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 28 Aug 2017 10:07:31 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> 
> The STFLE bit 147 indicates whether the ESSA no-DAT operation code is
> valid, the bit is not normally provided to the host; the host is
> instead provided with an SCLP bit that indicates whether guests can
> support the feature.
> 
> This patch:
> * enables the STFLE bit in the guest if the corresponding SCLP bit is
>   present in the host.
> * adds support for migrating the no-DAT bit in the PGSTEs
> * fixes the software interpretation of the ESSA instruction that is
>   used when migrating, both for the new operation code and for the old
>   "set stable", as per specifications.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/page-states.h | 2 +-
>  arch/s390/kvm/kvm-s390.c            | 8 ++++++--
>  arch/s390/kvm/priv.c                | 6 +++++-
>  arch/s390/mm/pgtable.c              | 6 +++++-
>  4 files changed, 17 insertions(+), 5 deletions(-)

This is a bit hard to review without the previous patches (I had to
hunt down MACHINE_HAS_TLB_GUEST, for example), and it seems much if not
all of this is not externally documented... but it seems consistent and
reasonable, so

Acked-by: Cornelia Huck <cohuck@redhat.com>
