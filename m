Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 1 Feb 2016 21:45:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
Message-Id: <20160201214540.c0b4b8c2.akpm@linux-foundation.org>
In-Reply-To: <56A9D7F2.5000504@virtuozzo.com>
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
	<20160128062906.GA4170@dhcp-128-25.nay.redhat.com>
	<56A9D7F2.5000504@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Minfei Huang <mhuang@redhat.com>, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ebiederm@xmission.com, linux-s390@vger.kernel.org, 0x7f454c46@gmail.com, kexec@lists.infradead.org, holzheu@linux.vnet.ibm.com, dyoung@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 28 Jan 2016 11:57:22 +0300 Dmitry Safonov <dsafonov@virtuozzo.com> wrote:

> On 01/28/2016 09:29 AM, Minfei Huang wrote:
> > On 01/27/16 at 02:48pm, Dmitry Safonov wrote:
> >> For allocation of kimage failure or kexec_prepare or load segments
> >> errors there is no need to keep crashkernel memory mapped.
> >> It will affect only s390 as map/unmap hook defined only for it.
> >> As on unmap s390 also changes os_info structure let's check return code
> >> and add info only on success.
> > Hi, Dmitry.
> >
> > Previously, I sent a patch to fix this issue. You can refer it in
> > following link.
> >
> > http://lists.infradead.org/pipermail/kexec/2015-July/013960.html
> Oh, scratch my patch - I'm fine with yours, wanted to do the similar thing
> because it has dazzled me while I was debugging around.

There were a bunch of patches tossed around in that thread but I'm not
sure that anything actually got applied?  Perhaps some resending is
needed.
