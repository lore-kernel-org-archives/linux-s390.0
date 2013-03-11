Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 11 Mar 2013 12:33:03 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: replace kmalloc + memset with kzalloc
Message-ID: <20130311113303.GB12193@osiris>
References: <1362921205-10295-1-git-send-email-steliannirlu@gmail.com>
 <CAOJsxLGZ=6r85D5OBrFehbpjVSTvK-vaMGQGD9W0ssymT4QyTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOJsxLGZ=6r85D5OBrFehbpjVSTvK-vaMGQGD9W0ssymT4QyTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pekka Enberg <penberg@kernel.org>
Cc: Stelian Nirlu <steliannirlu@gmail.com>, schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 10, 2013 at 04:14:00PM +0200, Pekka Enberg wrote:
> On Sun, Mar 10, 2013 at 3:13 PM, Stelian Nirlu <steliannirlu@gmail.com> wrote:
> > Signed-off-by: Stelian Nirlu <steliannirlu@gmail.com>
> > ---
> >  arch/s390/net/bpf_jit_comp.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> > index 0972e91..e645528 100644
> > --- a/arch/s390/net/bpf_jit_comp.c
> > +++ b/arch/s390/net/bpf_jit_comp.c
> > @@ -747,10 +747,9 @@ void bpf_jit_compile(struct sk_filter *fp)
> >
> >         if (!bpf_jit_enable)
> >                 return;
> > -       addrs = kmalloc(fp->len * sizeof(*addrs), GFP_KERNEL);
> > +       addrs = kzalloc(fp->len * sizeof(*addrs), GFP_KERNEL);
> 
> kcalloc() might be more appropriate here to protect against integer
> overflow if "fp->len" is too large.

Stelian, care to send an updated patch which uses kcalloc()
instead of kzalloc()?
