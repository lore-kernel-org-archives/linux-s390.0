From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 1/2] KVM: s390: allow user space to handle instr 0x0000
Date: Wed, 20 Jul 2016 16:35:49 +0200
Message-ID: <578F8C45.6060505@de.ibm.com>
References: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com>
 <1469018400-8397-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1469018400-8397-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, marc.zyngier@arm.com, cdall@cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

Marc, Christoffer,
FYI/FYA
the CAP number will conflict with your kvmarm changes.
I assume Paolo/Radim will resolve this when merging.

Seems that you have no hit in api.txt, correct?



> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index c4d2fb0..299306d 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
[...]
> +7.8 KVM_CAP_S390_USER_INSTR0
> +
> +Architectures: s390
[...]

> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -867,6 +867,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_VCPU_ATTRIBUTES 127
>  #define KVM_CAP_MAX_VCPU_ID 128
>  #define KVM_CAP_X2APIC_API 129
> +#define KVM_CAP_S390_USER_INSTR0 130
