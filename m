Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:58081 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfJQHPH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Oct 2019 03:15:07 -0400
Subject: Re: [PATCH] scripts/gdb: fix debugging modules on s390
References: <20191015105313.12663-1-iii@linux.ibm.com>
 <356384d7-d14f-2c9d-1c13-3d96e75e1727@siemens.com>
 <EC1E8F36-C374-4130-9841-CC35F557B7CE@linux.ibm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5d50b9ad-3e70-27d4-e73a-f67a33b39e7f@siemens.com>
Date: Thu, 17 Oct 2019 09:05:28 +0200
MIME-Version: 1.0
In-Reply-To: <EC1E8F36-C374-4130-9841-CC35F557B7CE@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 15.10.19 17:43, Ilya Leoshkevich wrote:
>> Am 15.10.2019 um 17:21 schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>
>>> @@ -113,6 +113,12 @@ lx-symbols command."""
>>>         if module_file:
>>>             gdb.write("loading @{addr}: {filename}\n".format(
>>>                 addr=module_addr, filename=module_file))
>>> +            if utils.is_target_arch('s390'):
>>> +                # Module text is preceded by PLT stubs on s390.
>>> +                module_arch = module['arch']
>>> +                plt_offset = int(module_arch['plt_offset'])
>>> +                plt_size = int(module_arch['plt_size'])
>>> +                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
>>
>> Shouldn't we report the actual address above, ie. reorder this tuning
>> with the gdb.write?
> 
> That's a tough question. I thought about this, and the argument for
> showing the fixed up address is that if someone does the math with
> symbol offsets from e.g. objdump, the result will be consistent with
> what gdb shows.
> 
> On the other hand side, why would anyone do this? that's exactly what
> this gdb script is for. So showing the actual address at which the
> memory was allocated gives the user some additional information, and is
> also consistent with what cat /proc/modules would show.
> 
> At the end of the day, I don't have a strong opinion on this, so if you
> think it's better to show the fixed up address, I'll send a v2.

One of the original ideas of the printout was to provide the information
needed to reproduce potential issues manually. From that perspective,
the fixed-up address would the the thing to print.

If you think the vanilla address has some value as well, we could make
an s390-specifi printout of both values.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
