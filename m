From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/2] KVM: s390: use cookies for ioeventfd
Date: Mon, 15 Jul 2013 14:03:14 +0200
Message-ID: <51E3E502.6080401@redhat.com>
References: <1372861854-23043-1-git-send-email-cornelia.huck@de.ibm.com> <1372861854-23043-3-git-send-email-cornelia.huck@de.ibm.com> <51D443A0.9040703@redhat.com> <20130703183325.2d483df8@gondolin> <51D51C28.7040306@redhat.com> <20130714092516.GC4063@redhat.com> <20130714101959.GD4063@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130714101959.GD4063@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 14/07/2013 12:19, Gleb Natapov ha scritto:
> On Sun, Jul 14, 2013 at 12:25:16PM +0300, Gleb Natapov wrote:
>> On Thu, Jul 04, 2013 at 08:54:32AM +0200, Paolo Bonzini wrote:
>>> Il 03/07/2013 18:33, Cornelia Huck ha scritto:
>>>> On Wed, 03 Jul 2013 17:30:40 +0200
>>>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>
>>>>> Il 03/07/2013 16:30, Cornelia Huck ha scritto:
>>>>>> +	/*
>>>>>> +	 * Return cookie in gpr 2, but don't overwrite the register if the
>>>>>> +	 * diagnose will be handled by userspace.
>>>>>> +	 */
>>>>>> +	if (ret != -EOPNOTSUPP)
>>>>>> +		vcpu->run->s.regs.gprs[2] = ret;
>>>>>
>>>>> I think this should now be "if (ret >= 0)".
>>>>
>>>> Hm, we don't want to kill gpr 2's old contents if userspace will do
>>>> something, which means -EOPNOTSUPP.
>>>
>>> In the end kvm_io_bus_write_cookie only returns -EOPNOTSUPP if there is
>>> an error, so it works.  But if this were to change, the code would
>>> break.  That's why I suggested testing "ret >= 0" rather than "ret !=
>>> -EOPNOTSUPP".  But in the end it is the same.
>>>
>>>>>
>>>>>>  	/* kvm_io_bus_write returns -EOPNOTSUPP if it found no match. */
>>>>>
>>>>> The comment is now obsolete.
>>>>
>>>> s/kvm_io_bus_write/kvm_io_bus_write_cookie/ ? Otherwise, this is still
>>>> true.
>>>
>>> True but somewhat misplaced, it is basically saying the same thing as
>>> the "Return cookie in gpr 2" comment just above.
>>>
>>> Anyhow, these are very small details.  I changed kvm_io_bus_write to
>>> kvm_io_bus_write_cookie in the comment and applied the patches to kvm-queue.
>>>
>> 1/2 broke x86. QEMU prints "Invalid read from memory region kvm-pic" and
>> guest hangs. Looks like IO is forwarded to userspace instead of in kernel device
>> for some reason. Un-applying for now.
>>
> OK, stupid typo. Will amend the commit instead of dropping.
> 
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 6cde6fa..a86735d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2942,7 +2942,7 @@ static int __kvm_io_bus_read(struct kvm_io_bus *bus, struct kvm_io_range *range,
>  		return -EOPNOTSUPP;
>  
>  	while (idx < bus->dev_count &&
> -		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
> +		kvm_io_bus_sort_cmp(range, &bus->range[idx]) == 0) {
>  		if (!kvm_iodevice_read(bus->range[idx].dev, range->addr,
>  				       range->len, val))
>  			return idx;
> --
> 			Gleb.
> 

We can introduce an

int __kvm_io_bus_sort_cmp(const struct kvm_io_range *p1, const struct kvm_io_range *p2)

function so that this kind of typo doesn't happen again in the future.

I'll post a patch later.

Paolo
