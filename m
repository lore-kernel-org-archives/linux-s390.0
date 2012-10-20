From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH 1/10] memory-hotplug : check whether memory is offline
 or not when removing memory
Date: Sat, 20 Oct 2012 08:50:45 +0800
Message-ID: <5081F565.8020605@cn.fujitsu.com>
References: <506E43E0.70507@jp.fujitsu.com> <506E451E.1050403@jp.fujitsu.com> <CAHGf_=rVDm-JygjPoLHbmF28Dgd52HFc4-b5KCxhEieG60okuw@mail.gmail.com> <50812F13.20503@cn.fujitsu.com> <5081609C.9080702@gmail.com> <CAHGf_=q=Agidyj_j6jhBdhNmJBy2u1dP+UMAoXbM=_=DyZJs_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CAHGf_=q=Agidyj_j6jhBdhNmJBy2u1dP+UMAoXbM=_=DyZJs_w@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Wen Congyang <wencongyang@gmail.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org, cmetcalf@tilera.com, sparclinux@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

At 10/20/2012 02:33 AM, KOSAKI Motohiro Wrote:
>> I think it again, and found that this check is necessary. Because we only
>> lock memory hotplug when offlining pages. Here is the steps to offline and
>> remove memory:
>>
>> 1. lock memory hotplug
>> 2. offline a memory section
>> 3. unlock memory hotplug
>> 4. repeat 1-3 to offline all memory sections
>> 5. lock memory hotplug
>> 6. remove memory
>> 7. unlock memory hotplug
>>
>> All memory sections must be offlined before removing memory. But we don't
>> hold
>> the lock in the whole operation. So we should check whether all memory
>> sections
>> are offlined before step6.
> 
> You should describe the race scenario in the patch description. OK?
> 

OK

Thanks
Wen Congyang

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
