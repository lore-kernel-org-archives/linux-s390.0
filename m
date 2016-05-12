From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Thu, 12 May 2016 20:52:46 +0800
Message-ID: <57347C9E.7010708@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <573305A8.50406@huawei.com> <5733149C.4030903@huawei.com>
 <5250356.myv9GIZ34h@wuerfel> <5733FC71.8070101@huawei.com>
 <20160512082427.GA1587@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160512082427.GA1587@yury-N73SV>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

On 2016/5/12 16:24, Yury Norov wrote:
> On Thu, May 12, 2016 at 11:45:53AM +0800, Zhangjian (Bamvor) wrote:
>
> [...]
>
>>> Hmm, that is indeed tricky. I think COMPAT_SYSCALL_WRAP4 rightfully
>>> refuses the loff_t argument here, as the common case is that this is
>>> not possible.
>> It works if I apply the following patch, I defined the wrong `__TYPE_IS_xxx`
>> yesterday. Should we merge this into ILP32 series or send the compat.h
>> and syscalls.h individually? The current series of ILP32 is a little bit
>> long and hard to review.
>> diff --git a/include/linux/compat.h b/include/linux/compat.h
>> index ba6ebe0..22a9565 100644
>> --- a/include/linux/compat.h
>> +++ b/include/linux/compat.h
>> @@ -747,7 +747,8 @@ asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
>>   #ifndef __SC_COMPAT_CAST
>>   #define __SC_COMPAT_CAST(t, a) ({                                      \
>>          BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&              \
>> -                    !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t));            \
>> +                    !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t) &&           \
>> +                    !__TYPE_IS_LOFFT(t));                              \
>
> I think it's wrong, as loff_t is 64-bit in 32-bit userspace, and this
> will clear meaningful data in top halve.
Yes. It is my fault. The original thoughts is clear the up 32bit for size_t.
How should we skip the loff_t?

Regards

Bamvor
