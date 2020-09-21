Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-2-hch@lst.de>
 <20200920151510.GS32101@casper.infradead.org>
 <20200920180742.GN3421308@ZenIV.linux.org.uk>
 <20200920190159.GT32101@casper.infradead.org>
 <20200920191031.GQ3421308@ZenIV.linux.org.uk>
 <20200920192259.GU32101@casper.infradead.org>
 <CALCETrXVtBkxNJcMxf9myaKT9snHKbCWUenKHGRfp8AOtORBPg@mail.gmail.com>
 <CAK8P3a37BRFj_qg61gP2oVrjJzBrZ58y1vggeTk_5n55Ou5U2Q@mail.gmail.com>
 <8363d874e503470f8caa201e85e9fbd4@AcuMS.aculab.com>
From: Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <7fc71d22-e213-b050-75fe-b45adc6bf0d8@gmail.com>
Date: Mon, 21 Sep 2020 19:31:49 +0300
MIME-Version: 1.0
In-Reply-To: <8363d874e503470f8caa201e85e9fbd4@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>, 'Arnd Bergmann' <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>

On 21/09/2020 00:13, David Laight wrote:
> From: Arnd Bergmann
>> Sent: 20 September 2020 21:49
>>
>> On Sun, Sep 20, 2020 at 9:28 PM Andy Lutomirski <luto@kernel.org> wrote:
>>> On Sun, Sep 20, 2020 at 12:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>> On Sun, Sep 20, 2020 at 08:10:31PM +0100, Al Viro wrote:
>>>>> IMO it's much saner to mark those and refuse to touch them from io_uring...
>>>>
>>>> Simpler solution is to remove io_uring from the 32-bit syscall list.
>>>> If you're a 32-bit process, you don't get to use io_uring.  Would
>>>> any real users actually care about that?
>>>
>>> We could go one step farther and declare that we're done adding *any*
>>> new compat syscalls :)
>>
>> Would you also stop adding system calls to native 32-bit systems then?
>>
>> On memory constrained systems (less than 2GB a.t.m.), there is still a
>> strong demand for running 32-bit user space, but all of the recent Arm
>> cores (after Cortex-A55) dropped the ability to run 32-bit kernels, so
>> that compat mode may eventually become the primary way to run
>> Linux on cheap embedded systems.
>>
>> I don't think there is any chance we can realistically take away io_uring
>> from the 32-bit ABI any more now.
> 
> Can't it just run requests from 32bit apps in a kernel thread that has
> the 'in_compat_syscall' flag set?
> Not that i recall seeing the code where it saves the 'compat' nature
> of any requests.
> 
> It is already completely f*cked if you try to pass the command ring
> to a child process - it uses the wrong 'mm'.

And how so? io_uring uses mm of a submitter. The exception is SQPOLL
mode, but it requires CAP_SYS_ADMIN or CAP_SYS_NICE anyway.

> I suspect there are some really horrid security holes in that area.
> 
> 	David.
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

-- 
Pavel Begunkov
