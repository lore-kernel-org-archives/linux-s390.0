From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [RFC v9 PATCH 06/21] memory-hotplug: export the function acpi_bus_remove()
Date: Tue, 2 Oct 2012 13:28:24 -0400
Message-ID: <CAHGf_=rX-OHFkBCKzdOi-ydF3VY+Sv_J1osDzZ_MiYEoop145A@mail.gmail.com>
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-7-git-send-email-wency@cn.fujitsu.com> <506A36A1.6030709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <506A36A1.6030709@gmail.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Ni zhan Chen <nizhan.chen@gmail.com>
Cc: wency@cn.fujitsu.com, x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org, cmetcalf@tilera.com, sparclinux@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, isimatu.yasuaki@jp.fujitsu.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 1, 2012 at 8:34 PM, Ni zhan Chen <nizhan.chen@gmail.com> wrote:
> On 09/05/2012 05:25 PM, wency@cn.fujitsu.com wrote:
>>
>> From: Wen Congyang <wency@cn.fujitsu.com>
>>
>> The function acpi_bus_remove() can remove a acpi device from acpi device.
>
> IIUC, s/acpi device/acpi bus

IIUC, acpi_bus_remove() mean "remove the device from a bus".

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
