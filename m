Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 25 Feb 2016 09:51:40 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 3/5] all: s390: move wrapper infrastructure to generic
 headers
Message-ID: <20160225085140.GC3980@osiris>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
 <1456338854-14901-4-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456338854-14901-4-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160225085140.8i-qLUab7G-KDu0pTBy3oCwiFU7xqNgQRmijv5rIg2c@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 24, 2016 at 09:34:12PM +0300, Yury Norov wrote:
> diff --git a/include/linux/syscalls_structs.h b/include/linux/syscalls_structs.h
> new file mode 100644
> index 0000000..a920cbc
> --- /dev/null
> +++ b/include/linux/syscalls_structs.h
> @@ -0,0 +1,60 @@
> +#ifndef _LINUX_SYSCALL_STRUCTS_H
> +#define _LINUX_SYSCALL_STRUCTS_H
> +
> +struct epoll_event;
> +struct iattr;
> +struct inode;
> +struct iocb;
> +struct io_event;
> +struct iovec;
> +struct itimerspec;
> +struct itimerval;

This is not needed for s390, right? So might be worth a separate patch
which moves the forward declarations?
