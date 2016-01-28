Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 Jan 2016 11:32:17 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
Message-ID: <20160128113217.79d37ff5@holzheu>
In-Reply-To: <20160127111546.2212f191f5f313b613f6b60b@linux-foundation.org>
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
	<20160127111546.2212f191f5f313b613f6b60b@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ebiederm@xmission.com, kexec@lists.infradead.org, linux-s390@vger.kernel.org, dyoung@redhat.com, 0x7f454c46@gmail.com, Xunlei Pang <xlpang@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 27 Jan 2016 11:15:46 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 27 Jan 2016 14:48:31 +0300 Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> 
> > For allocation of kimage failure or kexec_prepare or load segments
> > errors there is no need to keep crashkernel memory mapped.
> > It will affect only s390 as map/unmap hook defined only for it.
> > As on unmap s390 also changes os_info structure let's check return code
> > and add info only on success.
> > 
> 
> This conflicts (both mechanically and somewhat conceptually) with
> Xunlei Pang's "kexec: Introduce a protection mechanism for the
> crashkernel reserved memory" and "kexec: provide
> arch_kexec_protect(unprotect)_crashkres()".
> 
> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory.patch
> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory-v4.patch
> 
> and
> 
> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres.patch
> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres-v4.patch

Hmm, It looks to me that arch_kexec_(un)protect_crashkres() has exactly
the same semantics as crash_(un)map_reserved_pages().

On s390 we don't have the crashkernel memory mapped and therefore need
crash_map_reserved_pages() before loading something into crashkernel
memory.

Perhaps I missed something?
Michael
