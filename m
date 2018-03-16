Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 16 Mar 2018 01:52:40 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 18/36] fs: add ksys_write() helper; remove in-kernel
 calls to sys_write()
Message-ID: <20180316085240.GG4151@infradead.org>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-19-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315190529.20943-19-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org, arnd@arndb.de, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

I really don't like this, as this is the wrong level of abstraction.

> diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
> index 79b7a3438d54..5a9cfde5fc28 100644
> --- a/arch/s390/kernel/compat_linux.c
> +++ b/arch/s390/kernel/compat_linux.c
> @@ -468,7 +468,7 @@ COMPAT_SYSCALL_DEFINE3(s390_write, unsigned int, fd, const char __user *, buf, c
>  	if ((compat_ssize_t) count < 0)
>  		return -EINVAL; 
>  
> -	return sys_write(fd, buf, count);
> +	return ksys_write(fd, buf, count);
>  }

This looks bogus to me.  Why does s390 have its own compat version of
write but not any of the other read and write familty calls?

> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index 99e0b649fc0e..2d365c398ccc 100644
> --- a/init/do_mounts_rd.c
> +++ b/init/do_mounts_rd.c
> @@ -270,7 +270,7 @@ int __init rd_load_image(char *from)
>  			printk("Loading disk #%d... ", disk);
>  		}
>  		sys_read(in_fd, buf, BLOCK_SIZE);
> -		sys_write(out_fd, buf, BLOCK_SIZE);
> +		ksys_write(out_fd, buf, BLOCK_SIZE);
>  #if !defined(CONFIG_S390)
>  		if (!(i % 16)) {
>  			pr_cont("%c\b", rotator[rotate & 0x3]);

All the do_mounts / initramfs code should be rewritten to use filp_open
and vfs_read/vfs_write instead of adding hacks like this.
