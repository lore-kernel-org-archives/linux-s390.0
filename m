From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: Re: [RFC PATCH V6 04/19] memory-hotplug: offline and remove memory
 when removing the memory device
Date: Thu, 9 Aug 2012 17:41:04 +0200
Message-ID: <CAFEPiEY7gBeLoEJggSjFsF92X1Lw9DzPvEfCxhBx75NKCiL6XQ@mail.gmail.com>
References: <1343980161-14254-1-git-send-email-wency@cn.fujitsu.com>
	<1343980161-14254-5-git-send-email-wency@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1343980161-14254-5-git-send-email-wency@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: wency@cn.fujitsu.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org, cmetcalf@tilera.com, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com
List-ID: <linux-s390.vger.kernel.org>

Hi,

> We should offline and remove memory when removing the memory device.
> The memory device can be removed by 2 ways:
> 1. send eject request by SCI
> 2. echo 1 >/sys/bus/pci/devices/PNP0C80:XX/eject
>

[snip]

> +
> +static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
> +{
> +       int result;
> +
> +       /*
> +        * Ask the VM to offline this memory range.
> +        * Note: Assume that this function returns zero on success
> +        */
> +       result = acpi_memory_device_remove_memory(mem_device);
> +

here we should check the result of acpi_memory_device_remove_memory()
and not continue if it failed.

>         /* Power-off and eject the device */
>         result = acpi_memory_powerdown_device(mem_device);
>         if (result) {

thanks,

- Vasilis

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
