Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Jan 2016 11:15:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
Message-Id: <20160127111546.2212f191f5f313b613f6b60b@linux-foundation.org>
In-Reply-To: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ebiederm@xmission.com, kexec@lists.infradead.org, linux-s390@vger.kernel.org, holzheu@linux.vnet.ibm.com, dyoung@redhat.com, 0x7f454c46@gmail.com, Xunlei Pang <xlpang@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 27 Jan 2016 14:48:31 +0300 Dmitry Safonov <dsafonov@virtuozzo.com> wrote:

> For allocation of kimage failure or kexec_prepare or load segments
> errors there is no need to keep crashkernel memory mapped.
> It will affect only s390 as map/unmap hook defined only for it.
> As on unmap s390 also changes os_info structure let's check return code
> and add info only on success.
> 

This conflicts (both mechanically and somewhat conceptually) with
Xunlei Pang's "kexec: Introduce a protection mechanism for the
crashkernel reserved memory" and "kexec: provide
arch_kexec_protect(unprotect)_crashkres()".

http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory.patch
http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory-v4.patch

and

http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres.patch
http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres-v4.patch

so can we please sort all that out?
