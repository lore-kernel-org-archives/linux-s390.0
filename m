From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC v9 PATCH 20/21] memory-hotplug: clear hwpoisoned flag when
 onlining pages
Date: Thu, 06 Sep 2012 16:41:57 +0800
Message-ID: <504861D5.201@cn.fujitsu.com>
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>	<1346837155-534-21-git-send-email-wency@cn.fujitsu.com> <CA+quRcZtQCmFa4=1fq1iainQROy3NgtAXjLFF9cixs6KVXoMDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CA+quRcZtQCmFa4=1fq1iainQROy3NgtAXjLFF9cixs6KVXoMDA@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: =?UTF-8?B?YW5keXd1MTA25bu65Zu9?= <wujianguo106@gmail.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org, cmetcalf@tilera.com, sparclinux@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com
List-ID: <linux-s390.vger.kernel.org>

At 09/06/2012 03:27 PM, andywu106=E5=BB=BA=E5=9B=BD Wrote:
> 2012/9/5 <wency@cn.fujitsu.com>
>>
>> From: Wen Congyang <wency@cn.fujitsu.com>
>>
>> hwpoisoned may set when we offline a page by the sysfs interface
>> /sys/devices/system/memory/soft=5Foffline=5Fpage or
>> /sys/devices/system/memory/hard=5Foffline=5Fpage. If we don't clear
>> this flag when onlining pages, this page can't be freed, and will
>> not in free list. So we can't offline these pages again. So we
>> should clear this flag when onlining pages.
>>
>> CC: David Rientjes <rientjes@google.com>
>> CC: Jiang Liu <liuj97@gmail.com>
>> CC: Len Brown <len.brown@intel.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Christoph Lameter <cl@linux.com>
>> Cc: Minchan Kim <minchan.kim@gmail.com>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>> CC: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>> ---
>>  mm/memory=5Fhotplug.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/mm/memory=5Fhotplug.c b/mm/memory=5Fhotplug.c
>> index 270c249..140c080 100644
>> --- a/mm/memory=5Fhotplug.c
>> +++ b/mm/memory=5Fhotplug.c
>> @@ -661,6 +661,11 @@ EXPORT=5FSYMBOL=5FGPL(=5F=5Fonline=5Fpage=5Fincreme=
nt=5Fcounters);
>>
>>  void =5F=5Fonline=5Fpage=5Ffree(struct page *page)
>>  {
>> +#ifdef CONFIG=5FMEMORY=5FFAILURE
>> +       /* The page may be marked HWPoisoned by soft/hard offline page */
>> +       ClearPageHWPoison(page);
>=20
> Hi Congyang,
> I think you should decrease mce=5Fbad=5Fpages counter her
> atomic=5Flong=5Fsub(1, &mce=5Fbad=5Fpages);

Yes, thanks for pointing it out.

Thanks
Wen Congyang

>=20
>>
>> +#endif
>> +
>>         ClearPageReserved(page);
>>         init=5Fpage=5Fcount(page);
>>         =5F=5Ffree=5Fpage(page);
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe, send a message with 'unsubscribe linux-mm' in
>> the body to majordomo@kvack.org.  For more info on Linux MM,
>> see: http://www.linux-mm.org/ .
>> Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
>=20

=

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
