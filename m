From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [BUG Fix Patch 1/6] Bug fix: Hold spinlock across find|remove
 /sys/firmware/memmap/X operation.
Date: Wed, 16 Jan 2013 10:12:07 +0800
Message-ID: <50F60C77.9000201@cn.fujitsu.com>
References: <1358247267-18089-1-git-send-email-tangchen@cn.fujitsu.com> <1358247267-18089-2-git-send-email-tangchen@cn.fujitsu.com> <CAGRGNgWCdvWhp=9+PDRbC9bK100BdBv9kpcsqoM-J6ipq22Szw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAGRGNgWCdvWhp=9+PDRbC9bK100BdBv9kpcsqoM-J6ipq22Szw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Julian Calaby <julian.calaby@gmail.com>
Cc: akpm@linux-foundation.org, rientjes@google.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com, wency@cn.fujitsu.com, hpa@zytor.com, linfeng@cn.fujitsu.com, laijs@cn.fujitsu.com, mgorman@suse.de, yinghai@kernel.org, glommer@parallels.com, jiang.liu@huawei.com, x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org, cmetcalf@tilera.com, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/16/2013 06:26 AM, Julian Calaby wrote:
> Hi Tang,
>
> One minor point.
>
>>
>>   /*
>> - * Search memmap entry
>> + * firmware_map_find_entry: Search memmap entry.
>> + * @start: Start of the memory range.
>> + * @end:   End of the memory range (exclusive).
>> + * @type:  Type of the memory range.
>> + *
>> + * This function is to find the memmap entey of a given memory range.
>> + * The caller must hold map_entries_lock, and must not release the lock
>> + * until the processing of the returned entry has completed.
>> + *
>> + * Return pointer to the entry to be found on success, or NULL on failure.
>
> Why not make this completely kernel-doc compliant as you're already
> re-writing the comment?

Hi Julian,

Thank you for reminding me this. I think I may have some more problems
like this. I'll post a patch to fix as many of them as I can. :)

Thanks.
