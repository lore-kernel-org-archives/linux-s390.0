Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Sep 2011 15:59:12 -0700
From: Andrew Morton <akpm@google.com>
Subject: Re: [patch 1/2] kdump: Initialize vmcoreinfo note at startup
Message-Id: <20110920155912.d107fd49.akpm@google.com>
In-Reply-To: <20110920143436.019045253@linux.vnet.ibm.com>
References: <20110920143400.776127689@linux.vnet.ibm.com>
	<20110920143436.019045253@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: vgoyal@redhat.com, ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 20 Sep 2011 16:34:01 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> Currently the vmcoreinfo note is only initialized in case of kdump. On s390
> it is possible to create kernel dumps with other dump mechanisms than kdump
> (e.g. via hypervisor dump or stand-alone dump tools). For those dumps it
> would also be desirable to include the vmcoreinfo data. To accomplish this,
> with this patch the vmcoreinfo ELF note is always initialized, not only in
> case of a (kdump) crash. On s390 we will add an ABI defined pointer at
> a well known address to vmcoreinfo so that dump analysis tools are able to
> find this information.
> 
> In particular on s390 we have a tool named zgetdump. With this tool it is
> possible to convert dump formats on the fly using fuse. E.g. you can mount a
> s390 stand-alone dump as ELF dump. When this is done, the tool finds the
> vmcoreinfo in the stand-alone dump via the well known ABI defined address and
> it creates the respective VMCOREINFO ELF note in the output ELF dump. This then
> can be used e.g. by makedumpfile for dump filtering.  No more need for a
> vmlinux file with debug information.
> 
> So this will look like the following:
> $ zgetdump --mount standalone.dump -f elf /mnt
> $ ls /mnt
>   dump.elf
> $ readelf -n /mnt/dump.elf
> $ ...
>   VMCOREINFO            0x00000474      Unknown note type: (0x00000000)
> $ makedumpfile -c -d 31 /mnt/dump.elf dump.kdump
> 
> ...
>
> -void crash_save_vmcoreinfo(void)
> +static void update_vmcoreinfo_note(void)
>  {
> -	u32 *buf;
> +	u32 *buf = (u32 *) vmcoreinfo_note;

The cast is unneeded?

>  	if (!vmcoreinfo_size)
>  		return;
> -
> -	vmcoreinfo_append_str("CRASHTIME=%ld", get_seconds());
> -
> -	buf = (u32 *)vmcoreinfo_note;

As was the space you added after it ;)

>  	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
>  			      vmcoreinfo_size);
> -
>  	final_note(buf);
>  }
