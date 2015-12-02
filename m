From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 04/23] KVM: s390: rewrite vcpu_post_run and drop out
 early
Date: Wed, 2 Dec 2015 14:04:30 +0100
Message-ID: <565EEC5E.4030601@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
 <1449054384-76374-5-git-send-email-borntraeger@de.ibm.com>
 <565EE20D.4010008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <565EE20D.4010008@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On 12/02/2015 01:20 PM, Paolo Bonzini wrote:
> 
> 
> On 02/12/2015 12:06, Christian Borntraeger wrote:
>> +	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);
> 
> This is preexisting but... boy it's ugly. :)
> 
> Do you gain much over the simpler
> 
> 	vcpu->run->s.regs.gprs[14] = vcpu->arch.sie_block->gg14;
> 	vcpu->run->s.regs.gprs[15] = vcpu->arch.sie_block->gg15;
> 

Its just legacy code from the old days.
There is a difference, but it seems to a missed opportunity from gcc

        vcpu->arch.sie_block->gg14 = vcpu->run->s.regs.gprs[14];
    839c:       e3 30 f0 b8 00 04       lg      %r3,184(%r15)
    83a2:       e3 10 32 40 00 04       lg      %r1,576(%r3)
    83a8:       e3 20 30 80 00 04       lg      %r2,128(%r3)
    83ae:       e3 20 21 b8 00 04       lg      %r2,440(%r2)
    83b4:       e3 20 10 a0 00 24       stg     %r2,160(%r1)
        vcpu->arch.sie_block->gg15 = vcpu->run->s.regs.gprs[15];
    83ba:       e3 10 32 40 00 04       lg      %r1,576(%r3)
    83c0:       e3 20 30 80 00 04       lg      %r2,128(%r3)
    83c6:       e3 20 21 c0 00 04       lg      %r2,448(%r2)
    83cc:       e3 20 10 a8 00 24       stg     %r2,168(%r1)

gcc seems to reuse and reload %r2 and %r3, maybe register pressure.



the memcpy gives

    memcpy(&vcpu->arch.sie_block->gg14, &vcpu->run->s.regs.gprs[14], 16);
    839c:       e3 30 f0 b8 00 04       lg      %r3,184(%r15)
    83a2:       e3 10 32 40 00 04       lg      %r1,576(%r3)
    83a8:       e3 20 30 80 00 04       lg      %r2,128(%r3)
    83ae:       d2 0f 10 a0 21 b8       mvc     160(16,%r1),440(%r2)

I will prepare a patch and do my usual micro benchmark. Unless
things get much worse I will schedule this for the next pull.

Christian
