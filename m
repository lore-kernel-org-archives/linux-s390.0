From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [Patch v4 08/12] memory-hotplug: remove memmap of sparse-vmemmap
Date: Tue, 04 Dec 2012 17:47:00 +0800
Message-ID: <50BDC694.1060509@cn.fujitsu.com>
References: <1354010422-19648-1-git-send-email-wency@cn.fujitsu.com> <1354010422-19648-9-git-send-email-wency@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1354010422-19648-9-git-send-email-wency@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org, cmetcalf@tilera.com, sparclinux@vger.kernel.org, David Rientjes <rientjes@google.com>, Jiang Liu <liuj97@gmail.com>, Len Brown <len.brown@intel.com>, benh@kernel.crashing.org, paulus@samba.org, Christoph Lameter <cl@linux.com>, Minchan Kim <minchan.kim@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Jianguo Wu <wujianguo@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

On 11/27/2012 06:00 PM, Wen Congyang wrote:
>   static int __remove_section(struct zone *zone, struct mem_section *ms)
>   {
>   	unsigned long flags;
> @@ -330,9 +317,9 @@ static int __remove_section(struct zone *zone, struct mem_section *ms)
>   	pgdat_resize_lock(pgdat,&flags);
>   	sparse_remove_one_section(zone, ms);
>   	pgdat_resize_unlock(pgdat,&flags);
> -	return 0;
> +
> +	return ret;

I think we don't need to change this line. :)

Reviewed-by: Tang Chen <tangchen@cn.fujitsu.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
