From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 04/23] KVM: s390: rewrite vcpu_post_run and drop out
 early
Date: Wed, 2 Dec 2015 13:20:29 +0100
Message-ID: <565EE20D.4010008@redhat.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
 <1449054384-76374-5-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-5-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>



On 02/12/2015 12:06, Christian Borntraeger wrote:
> +	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);

This is preexisting but... boy it's ugly. :)

Do you gain much over the simpler

	vcpu->run->s.regs.gprs[14] = vcpu->arch.sie_block->gg14;
	vcpu->run->s.regs.gprs[15] = vcpu->arch.sie_block->gg15;

?

Paolo
