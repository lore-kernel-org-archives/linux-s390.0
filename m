From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/4] PF: Provide additional direct page notification
Date: Wed, 10 Jul 2013 12:52:06 +0200
Message-ID: <A0CAE7A6-9615-4513-B4F3-35D394D2E32B@suse.de>
References: <1373378207-10451-1-git-send-email-dingel@linux.vnet.ibm.com> <1373378207-10451-4-git-send-email-dingel@linux.vnet.ibm.com> <51DC33E7.1030404@de.ibm.com> <282EB214-206B-4A04-9830-D97679C9F4EC@suse.de> <20130710104253.GQ24941@redhat.com> <13B3500B-18A9-4B97-8C85-597BEAFC9250@suse.de> <20130710104843.GS24941@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130710104843.GS24941@redhat.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Xiantao Zhang <xiantao.zhang@intel.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


On 10.07.2013, at 12:48, Gleb Natapov wrote:

> On Wed, Jul 10, 2013 at 12:45:59PM +0200, Alexander Graf wrote:
>>=20
>> On 10.07.2013, at 12:42, Gleb Natapov wrote:
>>=20
>>> On Wed, Jul 10, 2013 at 12:39:01PM +0200, Alexander Graf wrote:
>>>>=20
>>>> On 09.07.2013, at 18:01, Christian Borntraeger wrote:
>>>>=20
>>>>> On 09/07/13 15:56, Dominik Dingel wrote:
>>>>>> By setting a Kconfig option, the architecture can control when
>>>>>> guest notifications will be presented by the apf backend.
>>>>>> So there is the default batch mechanism, working as before, where =
the vcpu thread
>>>>>> should pull in this information. On the other hand there is now =
the direct
>>>>>> mechanism, this will directly push the information to the guest.
>>>>>>=20
>>>>>> Still the vcpu thread should call check_completion to cleanup =
leftovers,
>>>>>> that leaves most of the common code untouched.
>>>>>>=20
>>>>>> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
>>>>>=20
>>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>=20
>>>>> for the "why". We want to use the existing architectured =
interface.
>>>>=20
>>>> Shouldn't this be a runtime option?
>>>>=20
>>> Why? What is the advantage of using sync delivery when HW can do it
>>> async?
>>=20
>> What's the advantage of having an option at all then? Who selects it?
>>=20
> x86 is stupid and cannot deliver the even asynchronously. Platform =
that
> can do it select the option.

We're in generic code. S390x enables it. X86 does not. That was the =
missing link!

Thanks a lot and sorry for the fuss :).


Alex

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
