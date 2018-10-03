From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 03 Oct 2018 11:52:02 +0000
Subject: Re: [GIT PULL 00/28] KVM: s390: Features for 4.20
Message-Id: <556c80d1-7560-1076-44cb-db18a5bef14a@redhat.com>
In-Reply-To: <20181002070655.224110-1-borntraeger@de.ibm.com>
References: <20181002070655.224110-1-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 02/10/2018 09:06, Christian Borntraeger wrote:
> Paolo, Radim,
> 
> the first pull request for 4.20 (or 5?) for KVM on s390.  Mostly the
> vfio-ap support (KVM virtualization for crypto cards).  This touches
> also base s390 - and depending on the kind of change I also expect
> future changes for vfio-ap via Martins tree.
> 
> In case there will be addon changes via Martins tree I have created the
> topic branch "apv11" and merged that. If necessary, Martin can pull that
> topic branch as well.  As of today there is no conflict, so right now
> this goes via the KVM tree.

Sounds good, thanks.  I'll send the pull request for 4.19 tomorrow and
then pull.

Paolo

> Please pull
> 
> The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:
