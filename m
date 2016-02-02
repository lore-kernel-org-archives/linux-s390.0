Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 2 Feb 2016 21:56:32 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
Message-ID: <20160202135632.GA4499@dhcp-128-25.nay.redhat.com>
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
 <20160128062906.GA4170@dhcp-128-25.nay.redhat.com>
 <56A9D7F2.5000504@virtuozzo.com>
 <20160201214540.c0b4b8c2.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160201214540.c0b4b8c2.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ebiederm@xmission.com, linux-s390@vger.kernel.org, 0x7f454c46@gmail.com, kexec@lists.infradead.org, holzheu@linux.vnet.ibm.com, dyoung@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 02/01/16 at 09:45pm, Andrew Morton wrote:
> On Thu, 28 Jan 2016 11:57:22 +0300 Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> 
> > On 01/28/2016 09:29 AM, Minfei Huang wrote:
> > > On 01/27/16 at 02:48pm, Dmitry Safonov wrote:
> > >> For allocation of kimage failure or kexec_prepare or load segments
> > >> errors there is no need to keep crashkernel memory mapped.
> > >> It will affect only s390 as map/unmap hook defined only for it.
> > >> As on unmap s390 also changes os_info structure let's check return code
> > >> and add info only on success.
> > > Hi, Dmitry.
> > >
> > > Previously, I sent a patch to fix this issue. You can refer it in
> > > following link.
> > >
> > > http://lists.infradead.org/pipermail/kexec/2015-July/013960.html
> > Oh, scratch my patch - I'm fine with yours, wanted to do the similar thing
> > because it has dazzled me while I was debugging around.
> 
> There were a bunch of patches tossed around in that thread but I'm not
> sure that anything actually got applied?  Perhaps some resending is
> needed.
> 

Hi, Andrew.

I will work on it to update a new patch.

Thanks
Minfei
