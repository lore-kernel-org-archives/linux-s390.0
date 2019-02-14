Return-Path: <linux-kbuild-owner@vger.kernel.org>
Subject: Re: [PATCH 03/11] kernel/locks: consolidate RWSEM_GENERIC_* options
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-4-hch@lst.de>
 <CAMuHMdW4C1McxL-e7ZSiSOiiE5D=xbBK8FZOwuJ1w0kK3CR1Hg@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <d9aeeedd-ce72-f58f-d858-3e340c073414@redhat.com>
Date: Thu, 14 Feb 2019 10:26:52 -0500
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW4C1McxL-e7ZSiSOiiE5D=xbBK8FZOwuJ1w0kK3CR1Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild <linux-kbuild@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 02/14/2019 05:52 AM, Geert Uytterhoeven wrote:
> On Thu, Feb 14, 2019 at 12:08 AM Christoph Hellwig <hch@lst.de> wrote:
>> Introduce one central definition of RWSEM_XCHGADD_ALGORITHM and
>> RWSEM_GENERIC_SPINLOCK in kernel/Kconfig.locks and let architectures
>> select RWSEM_XCHGADD_ALGORITHM if they want it, otherwise default to
>> the spinlock version.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Note that this conflicts with "[PATCH v4 2/3] locking/rwsem: Remove
> rwsem-spinlock.c & use rwsem-xadd.c for all archs"
> https://lore.kernel.org/lkml/1550095217-12047-3-git-send-email-longman@redhat.com/
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
Christoph,

Would you mind dropping just patch 3 from your series?

Thanks,
Longman
