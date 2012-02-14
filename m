Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F3A785A.4030500@de.ibm.com>
Date: Tue, 14 Feb 2012 16:06:02 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] KEYS: Enable the compat keyctl wrapper on s390x
References: <20120214145022.12531.16731.stgit@warthog.procyon.org.uk>
In-Reply-To: <20120214145022.12531.16731.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org, dan@danny.cz, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 14/02/12 15:50, David Howells wrote:
> Enable the compat keyctl wrapper on s390x so that 32-bit s390 userspace can
> call the keyctl() syscall.
> 
> There's an s390x assembly wrapper that truncates all the register values to
> 32-bits and this then calls compat_sys_keyctl() - but the latter only exists if
> CONFIG_KEYS_COMPAT is enabled, and the s390 Kconfig doesn't enable it.
> 
> Without this patch, 32-bit calls to the keyctl() syscall are given an ENOSYS
> error:
> 
> 	[root@devel4 ~]# keyctl show
> 	Session Keyring
> 	-3: key inaccessible (Function not implemented)
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: dan@danny.cz
> cc: Carsten Otte <cotte@de.ibm.com>
> cc: Christian Borntraeger <borntraeger@de.ibm.com>
> cc: linux-s390@vger.kernel.org
> cc: stable@vger.kernel.org

Patch looks sane.
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Do you want to push this change via Martins s390 tree or via other
trees?

> ---
> 
>  arch/s390/Kconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index d172758..6d99a5f 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -227,6 +227,9 @@ config COMPAT
>  config SYSVIPC_COMPAT
>  	def_bool y if COMPAT && SYSVIPC
> 
> +config KEYS_COMPAT
> +	def_bool y if COMPAT && KEYS
> +
>  config AUDIT_ARCH
>  	def_bool y
> 
> 
