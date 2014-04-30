From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 1/6] KVM: s390: Handle MVPG partial execution interception
Date: Wed, 30 Apr 2014 12:07:33 +0200
Message-ID: <5360CB65.5040109@de.ibm.com>
References: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com> <1398778608-3887-2-git-send-email-borntraeger@de.ibm.com> <20140430080709.GA7723@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140430080709.GA7723@osiris>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 30/04/14 10:07, Heiko Carstens wrote:
> On Tue, Apr 29, 2014 at 03:36:43PM +0200, Christian Borntraeger wrote:
>> +static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
>> +{
>> +	unsigned long hostaddr, srcaddr, dstaddr;
>> +	psw_t *psw = &vcpu->arch.sie_block->gpsw;
>> +	struct mm_struct *mm = current->mm;
>> +	int reg1, reg2, rc;
>> +
>> +	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
>> +	srcaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg2]);
>> +	dstaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg1]);
>> +
>> +	/* Make sure that the source is paged-in */
>> +	hostaddr = gmap_fault(srcaddr, vcpu->arch.gmap);
>> +	if (IS_ERR_VALUE(hostaddr))
>> +		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> 
> FWIW (and nothing that should keep this code from going upstream),
> this is not entirely correct, since gmap_fault() may return -ENOMEM.
> So a host out-of-memory situation will incorrectly result in a guest
> addressing exception, which is most likely not what we want.
> 
Indeed, host out-of-memory situation will cause architectural non-compliance in some areas of KVM/s390.
The proper Linux way (returning -ENOMEM  (or EFAULT?) in the KVM_RUN ioctl) will cause qemu to print an error and abort(), which is also not ideal.
The s390 way, should probably be to inject an uncorrectable storage error machine check.

So the question is what is the right thing to  do for these cases?

Paolo, what is the x86 way of dealing with situations like this (here we fail to allocate a pud,pmd,pte or helper structure). Looks like you return
-ENOMEM to qemu. Is that true for all cases?

Christian
