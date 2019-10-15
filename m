Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] scripts/gdb: fix debugging modules on s390
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <356384d7-d14f-2c9d-1c13-3d96e75e1727@siemens.com>
Date: Tue, 15 Oct 2019 17:43:18 +0200
Content-Transfer-Encoding: 8BIT
References: <20191015105313.12663-1-iii@linux.ibm.com>
 <356384d7-d14f-2c9d-1c13-3d96e75e1727@siemens.com>
Message-Id: <EC1E8F36-C374-4130-9841-CC35F557B7CE@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

> Am 15.10.2019 um 17:21 schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
>> @@ -113,6 +113,12 @@ lx-symbols command."""
>>         if module_file:
>>             gdb.write("loading @{addr}: {filename}\n".format(
>>                 addr=module_addr, filename=module_file))
>> +            if utils.is_target_arch('s390'):
>> +                # Module text is preceded by PLT stubs on s390.
>> +                module_arch = module['arch']
>> +                plt_offset = int(module_arch['plt_offset'])
>> +                plt_size = int(module_arch['plt_size'])
>> +                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
> 
> Shouldn't we report the actual address above, ie. reorder this tuning
> with the gdb.write?

That's a tough question. I thought about this, and the argument for
showing the fixed up address is that if someone does the math with
symbol offsets from e.g. objdump, the result will be consistent with
what gdb shows.

On the other hand side, why would anyone do this? that's exactly what
this gdb script is for. So showing the actual address at which the
memory was allocated gives the user some additional information, and is
also consistent with what cat /proc/modules would show.

At the end of the day, I don't have a strong opinion on this, so if you
think it's better to show the fixed up address, I'll send a v2.

Best regards,
Ilya
