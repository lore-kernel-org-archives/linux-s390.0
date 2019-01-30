Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 30 Jan 2019 09:53:50 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
References: <20190123125513.20210-1-labbott@redhat.com>
 <20190123132401.GG3424@osiris>
 <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
Message-Id: <20190130085350.GB5299@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Andreas Krebbel <krebbel@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 29, 2019 at 08:25:58AM +0100, Laura Abbott wrote:
> On 1/23/19 5:24 AM, Heiko Carstens wrote:
> >On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
> >>There's a build failure with gcc9:
...
> >Hmmm, this works only for the kernel image, but not for modules, which
> >we compile with "-fPIC", which again doesn't work as described in the
> >referenced bugzilla:
> >                                       ^~~
> >./arch/s390/include/asm/jump_label.h:19:2: note: in expansion of macro 'asm_volatile_goto'
> >   asm_volatile_goto("0: brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
> >
> >Andreas, Ilya, any idea how to fix this?
> 
> I've had to turn off s390 in Fedora until this gets fixed :(

I assume this means you only turned off CONFIG_JUMP_LABEL on s390
until we have a fix for this?
