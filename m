Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgJSKzS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Oct 2020 06:55:18 -0400
Subject: Re: s390 - buildroot + qemu
References: <CAKwvOd=0nOhK4KoLb1_Jni5u3ENDx10QeAxfYcSbtFQs77FxAw@mail.gmail.com>
 <30b7bea6-1135-609b-f1e5-a4f243e1dcc1@roeck-us.net>
 <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <c461496a-1ea4-4d44-4913-950cabcd3e31@de.ibm.com>
Date: Mon, 19 Oct 2020 12:54:56 +0200
In-Reply-To: <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>, Guenter Roeck <linux@roeck-us.net>
Cc: egorenar@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>



On 17.10.20 01:40, Nick Desaulniers wrote:
> On Fri, Oct 16, 2020 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/16/20 4:11 PM, Nick Desaulniers wrote:
>>> Hello all,
>>> I'm working on integrating the latest release of buildroot (2020.08.1)
>>> into our CI for ClangBuiltLinux.
>>>
>>> https://github.com/ClangBuiltLinux/boot-utils/pull/25
>>> https://github.com/ClangBuiltLinux/boot-utils/pull/26
>>> https://github.com/ClangBuiltLinux/continuous-integration/pull/327
>>>
>>> I'm seeing the following error from QEMU:
>>> KASLR disabled: CPU has no PRNG
>>> Linux version 5.9.0-00732-g04ed4527465f (ndesaulniers@<myhost>) #30
>>> SMP Fri Oct 16 15:49:05 PDT 2020Kernel fault: interruption code 0005
>>> ilc:2
>>> PSW : 0000200180000000 000000000001779e
>>>       R:0 T:0 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:0 CC:2 PM:0 RI:0 EA:3
>>> GPRS: 0000000000000001 0000000c00000000 00000003fffffff4 00000000fffffff0
>>>       0000000000000000 00000000fffffff4 000000000000000c 00000000fffffff0
>>>       00000000fffffffc 0000000000000000 00000000fffffff8 00000000008a75a8
>>>       0000000000000009 0000000000000002 0000000000000008 000000000000bce0

Do you have more information? If not, any chance to run objdump on the kernel
and check what instructions do you have aroung address 0x1779e
[...]

> Hopefully qemu supports something newer than Z900?  Or can we change
> arch/s390/Kconfig:255 to use a different arch? Is arch9 == z900???:

Newer QEMUs do support up to z13, so I think this is not an issue as long
as you have an uptodate qemu.
