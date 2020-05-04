Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] stats_fs API: create, add and remove stats_fs
 sources and values
References: <20200504110344.17560-1-eesposit@redhat.com>
 <20200504110344.17560-3-eesposit@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9a4e7489-bac4-23dc-b612-73eb91babb6f@infradead.org>
Date: Mon, 4 May 2020 15:11:15 -0700
MIME-Version: 1.0
In-Reply-To: <20200504110344.17560-3-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org

On 5/4/20 4:03 AM, Emanuele Giuseppe Esposito wrote:
> diff --git a/fs/Kconfig b/fs/Kconfig
> index f08fbbfafd9a..1b0de0f19e96 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -328,4 +328,10 @@ source "fs/unicode/Kconfig"
>  config IO_WQ
>  	bool
>  
> +config STATS_FS
> +	bool "Statistics Filesystem"
> +	help
> +	  stats_fs is a virtual file system that provides counters and
> +	  other statistics about the running kernel.
> +
>  endmenu

Hi,

This kconfig entry should be under (inside) "Pseudo filesystems",
i.e., between 'menu "Pseudo filesystems"' and its corresponding
"endmenu".

Thanks.
-- 
~Randy
