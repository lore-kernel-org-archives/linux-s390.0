Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACtXKtSzv666_FCHpVm0EkyW=c32kQA9o9-zDqVtJcFYk9mHqQ@mail.gmail.com>
References: <1362921205-10295-1-git-send-email-steliannirlu@gmail.com>
 <CAOJsxLGZ=6r85D5OBrFehbpjVSTvK-vaMGQGD9W0ssymT4QyTw@mail.gmail.com>
 <20130311113303.GB12193@osiris> <CACtXKtSzv666_FCHpVm0EkyW=c32kQA9o9-zDqVtJcFYk9mHqQ@mail.gmail.com>
From: Stelian Nirlu <steliannirlu@gmail.com>
Date: Mon, 11 Mar 2013 18:26:54 +0200
Message-ID: <CACtXKtQP20FdOxo0PVmxKuB4Gh7Z+O8tVNXrFnZB5=dtwReO=w@mail.gmail.com>
Subject: Re: [PATCH] s390: replace kmalloc + memset with kzalloc
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Pekka Enberg <penberg@kernel.org>, schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11 March 2013 18:10, Stelian Nirlu <steliannirlu@gmail.com> wrote:
>
>
> On 11 March 2013 13:33, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>>
>> On Sun, Mar 10, 2013 at 04:14:00PM +0200, Pekka Enberg wrote:
>> > On Sun, Mar 10, 2013 at 3:13 PM, Stelian Nirlu <steliannirlu@gmail.com>
>> > wrote:
>> > > Signed-off-by: Stelian Nirlu <steliannirlu@gmail.com>
>> > > ---
>> > >  arch/s390/net/bpf_jit_comp.c |    3 +--
>> > >  1 file changed, 1 insertion(+), 2 deletions(-)
>> > >
>> > > diff --git a/arch/s390/net/bpf_jit_comp.c
>> > > b/arch/s390/net/bpf_jit_comp.c
>> > > index 0972e91..e645528 100644
>> > > --- a/arch/s390/net/bpf_jit_comp.c
>> > > +++ b/arch/s390/net/bpf_jit_comp.c
>> > > @@ -747,10 +747,9 @@ void bpf_jit_compile(struct sk_filter *fp)
>> > >
>> > >         if (!bpf_jit_enable)
>> > >                 return;
>> > > -       addrs = kmalloc(fp->len * sizeof(*addrs), GFP_KERNEL);
>> > > +       addrs = kzalloc(fp->len * sizeof(*addrs), GFP_KERNEL);
>> >
>> > kcalloc() might be more appropriate here to protect against integer
>> > overflow if "fp->len" is too large.
>>
>> Stelian, care to send an updated patch which uses kcalloc()
>> instead of kzalloc()?
>>
>
> Yes, sure, I will send the updated patch as soon as possible.
>
> Thank you,
> Stelian

I've sent the updated patch.
Mail subject: [PATCH v2] s390: use kcalloc instead of kmalloc and memset
