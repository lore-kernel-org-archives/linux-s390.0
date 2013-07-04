From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/2] KVM: s390: use cookies for ioeventfd
Date: Thu, 04 Jul 2013 08:54:32 +0200
Message-ID: <51D51C28.7040306@redhat.com>
References: <1372861854-23043-1-git-send-email-cornelia.huck@de.ibm.com> <1372861854-23043-3-git-send-email-cornelia.huck@de.ibm.com> <51D443A0.9040703@redhat.com> <20130703183325.2d483df8@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130703183325.2d483df8@gondolin>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 03/07/2013 18:33, Cornelia Huck ha scritto:
> On Wed, 03 Jul 2013 17:30:40 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> Il 03/07/2013 16:30, Cornelia Huck ha scritto:
>>> +	/*
>>> +	 * Return cookie in gpr 2, but don't overwrite the register if the
>>> +	 * diagnose will be handled by userspace.
>>> +	 */
>>> +	if (ret != -EOPNOTSUPP)
>>> +		vcpu->run->s.regs.gprs[2] = ret;
>>
>> I think this should now be "if (ret >= 0)".
> 
> Hm, we don't want to kill gpr 2's old contents if userspace will do
> something, which means -EOPNOTSUPP.

In the end kvm_io_bus_write_cookie only returns -EOPNOTSUPP if there is
an error, so it works.  But if this were to change, the code would
break.  That's why I suggested testing "ret >= 0" rather than "ret !=
-EOPNOTSUPP".  But in the end it is the same.

>>
>>>  	/* kvm_io_bus_write returns -EOPNOTSUPP if it found no match. */
>>
>> The comment is now obsolete.
> 
> s/kvm_io_bus_write/kvm_io_bus_write_cookie/ ? Otherwise, this is still
> true.

True but somewhat misplaced, it is basically saying the same thing as
the "Return cookie in gpr 2" comment just above.

Anyhow, these are very small details.  I changed kvm_io_bus_write to
kvm_io_bus_write_cookie in the comment and applied the patches to kvm-queue.

Paolo

>>
>>>  	return ret < 0 ? ret : 0;
>>
>> Otherwise looks good, thanks!
>>
>> Paolo
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
