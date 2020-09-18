Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200918124533.3487701-1-hch@lst.de> <20200918124533.3487701-9-hch@lst.de>
In-Reply-To: <20200918124533.3487701-9-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Sep 2020 15:48:35 +0200
Message-ID: <CAK8P3a07PbzpGfnVew7VAq2=iD418V-ryvOC94qAQzW0nQAbAA@mail.gmail.com>
Subject: Re: [PATCH 8/9] mm: remove compat_process_vm_{readv,writev}
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Networking <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Fri, Sep 18, 2020 at 2:45 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Now that import_iovec handles compat iovecs, the native syscalls
> can be used for the compat case as well.
>
> diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
> index a4840b9d50ad14..f2fe0a33bcfdd5 100644
> --- a/arch/x86/entry/syscall_x32.c
> +++ b/arch/x86/entry/syscall_x32.c
> @@ -17,6 +17,8 @@
>  #define __x32_sys_getsockopt   __x64_sys_getsockopt
>  #define __x32_sys_setsockopt   __x64_sys_setsockopt
>  #define __x32_sys_vmsplice     __x64_sys_vmsplice
> +#define __x32_sys_process_vm_readv     __x64_sys_process_vm_readv
> +#define __x32_sys_process_vm_writev    __x64_sys_process_vm_writev
>
>  #define __SYSCALL_64(nr, sym)
>

I forgot this hack existed, and just sent a patch with subject "x86: add
__X32_COND_SYSCALL() macro" instead.

If I understand this right, the macros above should no longer be needed
once my patch gets merged.

        Arnd
