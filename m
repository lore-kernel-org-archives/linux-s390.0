Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 20 Feb 2019 09:58:09 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
References: <20190123125513.20210-1-labbott@redhat.com>
 <20190123132401.GG3424@osiris>
 <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
 <20190205124349.GA10167@osiris>
 <541cdc96-7ce0-de6a-0f8b-778ee826a378@redhat.com>
MIME-Version: 1.0
In-Reply-To: <541cdc96-7ce0-de6a-0f8b-778ee826a378@redhat.com>
Message-Id: <20190220085809.GC3992@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Andreas Krebbel <krebbel@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Feb 09, 2019 at 12:34:20PM -0800, Laura Abbott wrote:
> On 2/5/19 12:43 PM, Heiko Carstens wrote:
> >On Tue, Jan 29, 2019 at 08:25:58AM +0100, Laura Abbott wrote:
> >>On 1/23/19 5:24 AM, Heiko Carstens wrote:
> >>>On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
> >>>>There's a build failure with gcc9:
> >>>>
> >>>>  ./arch/s390/include/asm/jump_label.h: Assembler messages:
> >>>>  ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
> >>>>  ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
> >>>>  make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1
> >...
> >>I've had to turn off s390 in Fedora until this gets fixed :(
> >
> >Laura, the patch below should fix this (temporarily). If possible,
> >could you give it a try? It seems to work for me.
> >
> >Subject: [PATCH] s390: disable section anchors
> Tested-by: Laura Abbott <labbott@redhat.com><

The patch won't be used. In the meantime Ilya provided a gcc 9 and
kernel patch which should fix this. The kernel patch is available here
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=146448524bddbf6dfc62de31957e428de001cbda
and will go upstream during the next merge window.

Note: this obviously also requires to update the gcc 9 version in
Fedora, so it contains Ilya's patch, to be able to compile the kernel.

Thanks,
Heiko
