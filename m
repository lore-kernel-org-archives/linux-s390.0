Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/power: Expose pfn_is_nosave prototype
In-Reply-To: <1929721.iDiXxTFbjN@kreacher>
References: <20190523114736.30268-1-malat@debian.org> <20190524104418.17194-1-malat@debian.org> <1929721.iDiXxTFbjN@kreacher>
Date: Tue, 28 May 2019 11:16:30 +1000
Message-ID: <875zpvqsy9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mathieu Malaterre <malat@debian.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> On Friday, May 24, 2019 12:44:18 PM CEST Mathieu Malaterre wrote:
>> The declaration for pfn_is_nosave is only available in
>> kernel/power/power.h. Since this function can be override in arch,
>> expose it globally. Having a prototype will make sure to avoid warning
>> (sometime treated as error with W=1) such as:
>> 
>>   arch/powerpc/kernel/suspend.c:18:5: error: no previous prototype for 'pfn_is_nosave' [-Werror=missing-prototypes]
>> 
>> This moves the declaration into a globally visible header file and add
>> missing include to avoid a warning on powerpc. Also remove the
>> duplicated prototypes since not required anymore.
>> 
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> v2: As suggestion by christophe remove duplicates prototypes
>> 
>>  arch/powerpc/kernel/suspend.c | 1 +
>>  arch/s390/kernel/entry.h      | 1 -
>>  include/linux/suspend.h       | 1 +
>>  kernel/power/power.h          | 2 --
>>  4 files changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/kernel/power/power.h b/kernel/power/power.h
>> index 9e58bdc8a562..44bee462ff57 100644
>> --- a/kernel/power/power.h
>> +++ b/kernel/power/power.h
>> @@ -75,8 +75,6 @@ static inline void hibernate_reserved_size_init(void) {}
>>  static inline void hibernate_image_size_init(void) {}
>>  #endif /* !CONFIG_HIBERNATION */
>>  
>> -extern int pfn_is_nosave(unsigned long);
>> -
>>  #define power_attr(_name) \
>>  static struct kobj_attribute _name##_attr = {	\
>>  	.attr	= {				\
>> 
>
> With an ACK from the powerpc maintainers, I could apply this one.

Sent.

cheers
