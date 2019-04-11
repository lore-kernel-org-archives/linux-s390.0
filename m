Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 11 Apr 2019 09:40:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
In-Reply-To: <CAK8P3a1-1axfWq5Y1pK9XORMdsbmZyq75p+V5Do71hNRowct+g@mail.gmail.com>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-5-arnd@arndb.de>
        <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
        <20190410175946.0e6d2b00@mschwideX1>
        <CAK8P3a1-1axfWq5Y1pK9XORMdsbmZyq75p+V5Do71hNRowct+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190411094055.5884244c@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Ingo Franzki <ifranzki@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 10 Apr 2019 20:57:21 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Apr 10, 2019 at 5:59 PM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > On Tue, 9 Apr 2019 11:54:30 +0200 Harald Freudenberger <freude@linux.ibm.com> wrote:  
> > > On 08.04.19 23:26, Arnd Bergmann wrote:  
> > > >             }  
> > > Thanks Arnd, but as Nathan already wrote, I'd prefer to have the
> > > variable initialized with 0 instead of -1.
> > > If you agree with this, I'll rewrite the patch and apply it to our
> > > internal git and it will appear at kernel org with the next s390 code merge then.  
> >
> > Do we agreement on func_coed=0 for this one ?  
> 
> Yes, I think that was the consensus.
> 
>        Arnd
> 

Ok, committed with func_code=0.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
