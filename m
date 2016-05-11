From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Wed, 11 May 2016 11:04:38 +0300
Message-ID: <20160511075438.GA15628@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <7091358.aJt1stteb5@wuerfel>
 <5731D68D.2090109@huawei.com>
 <4119683.coHZhzaE6c@wuerfel>
 <57329320.1000500@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57329320.1000500@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 11, 2016 at 10:04:16AM +0800, Zhangjian (Bamvor) wrote:
[...]

> >>Ok, I will test the ltp syscall test.
> >>With this changes, the issue I mentioned should be fixed. But we still
> >>use mmap2 syscall for ILP32 application when we pass the offset instead
> >>of page offset. Is it correct?
> >
> >I don't remember. It's probably not important whether we have the shift
> >in there, as long as it's independent of the actual kernel page size and
> >user space and kernel agree on the calling conventions.
> Well. I am ok with where to shift the pages size because we get the same
> result. I was just thinking if we should get rid of the name of mmap2 in our
> ILP32 porting. Actually, it is mmap but we name it as mmap2. User may confused
> if they do not know the implementations.
> 

This is what generic unistd.h does. If you want to change it, you'd
change each arch that uses generic unistd.h.

> Regards
> 
> Bamvor
> 
> >
> >	Arnd
> >
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
