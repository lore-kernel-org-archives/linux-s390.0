Return-Path: <SRS0=/4+2=SF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87tvff24a1.fsf@concordia.ellerman.id.au>
 <20190403111134.GA7159@fuggles.cambridge.arm.com>
 <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
 <20190403151932.GA16866@fuggles.cambridge.arm.com>
 <032faa2f-6317-75b6-8514-076ef1a244e8@kernel.dk>
 <20190403154902.GB16866@fuggles.cambridge.arm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <086cdf60-8973-02e6-191b-b818e6f12468@kernel.dk>
Date: Wed, 3 Apr 2019 09:51:21 -0600
MIME-Version: 1.0
In-Reply-To: <20190403154902.GB16866@fuggles.cambridge.arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Will Deacon <will.deacon@arm.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On 4/3/19 9:49 AM, Will Deacon wrote:
> On Wed, Apr 03, 2019 at 09:39:52AM -0600, Jens Axboe wrote:
>> On 4/3/19 9:19 AM, Will Deacon wrote:
>>> On Wed, Apr 03, 2019 at 07:49:26AM -0600, Jens Axboe wrote:
>>>> On 4/3/19 5:11 AM, Will Deacon wrote:
>>>>> will@autoplooker:~/liburing/test$ ./io_uring_register 
>>>>> RELIMIT_MEMLOCK: 67108864 (67108864)
>>>>> [   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
>>>>> [   35.478969] Mem abort info:
>>>>> [   35.479296]   ESR = 0x96000004
>>>>> [   35.479785]   Exception class = DABT (current EL), IL = 32 bits
>>>>> [   35.480528]   SET = 0, FnV = 0
>>>>> [   35.480980]   EA = 0, S1PTW = 0
>>>>> [   35.481345] Data abort info:
>>>>> [   35.481680]   ISV = 0, ISS = 0x00000004
>>>>> [   35.482267]   CM = 0, WnR = 0
>>>>> [   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>>>>> [   35.483486] [0000000000000070] pgd=0000000000000000
>>>>> [   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>>>> [   35.484788] Modules linked in:
>>>>> [   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
>>>>> [   35.486712] Hardware name: linux,dummy-virt (DT)
>>>>> [   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
>>>>> [   35.488228] pc : link_pwq+0x10/0x60
>>>>> [   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
>>>>> [   35.489550] sp : ffff000017e2bbc0
>>>>
>>>> Huh, this looks odd, it's crashing inside the wq setup.
>>>
>>> Enabling KASAN seems to indicate a double-free, which may well be related.
>>
>> Does this help?
> 
> Yes, thanks for the quick patch. Feel free to add:
> 
> Reported-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Will Deacon <will.deacon@arm.com>
> 
> if you spin a proper patch.

Great, thanks for reporting/testing.

-- 
Jens Axboe


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
