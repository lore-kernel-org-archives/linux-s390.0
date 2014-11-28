From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 08/11] KVM: s390: refactor interrupt delivery code
Date: Fri, 28 Nov 2014 18:17:16 +0100
Message-ID: <5478AE1C.5090700@redhat.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com> <1417181139-25623-9-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-9-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 28/11/2014 14:25, Christian Borntraeger wrote:
> +static int __must_check __deliver_cpu_timer(struct kvm_vcpu *vcpu)
> +{
> +	int rc;

Same here...

Paolo
