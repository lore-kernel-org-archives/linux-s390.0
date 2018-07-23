Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 23 Jul 2018 08:07:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] arch/s390: Use new return type vm_fault_t
In-Reply-To: <20180722152248.GB12125@bombadil.infradead.org>
References: <20180722134109.GA31840@jordon-HP-15-Notebook-PC>
        <20180722152248.GB12125@bombadil.infradead.org>
MIME-Version: 1.0
Message-Id: <20180723080738.4189e957@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Souptick Joarder <jrdr.linux@gmail.com>, heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org, keescook@chromium.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
List-ID: <linux-s390.vger.kernel.org>

On Sun, 22 Jul 2018 08:22:48 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> On Sun, Jul 22, 2018 at 07:11:09PM +0530, Souptick Joarder wrote:
> > use new return type vm_fault_t for fault handler vdso_fault.
> > 
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>  
> 
> Reviewed-by: Matthew Wilcox <willy@infradead.org>

I modified the patch description a bit and then added the patch
to my tree. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
