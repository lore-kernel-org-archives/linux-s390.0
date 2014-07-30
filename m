Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1406708378.22788.5.camel@BR9GV9YG.de.ibm.com>
Subject: Re: [PATCH] s390: net: qeth_core_main.c: Cleaning up missing
 null-terminate in conjunction with strncpy
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Wed, 30 Jul 2014 10:19:38 +0200
In-Reply-To: <CAFo99gbG6an7nWm9xL2A73tRQNOYgKTWdebmT=Etx0LcAWAsRA@mail.gmail.com>
References: <1406385326-3289-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
	 <1406639627.13705.11.camel@BR9GV9YG.de.ibm.com>
	 <CAFo99gbG6an7nWm9xL2A73tRQNOYgKTWdebmT=Etx0LcAWAsRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com, Ursula Braun <ursula.braun@de.ibm.com>, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2014-07-29 at 15:21 +0200, Rickard Strandqvist wrote:
> 
> Den 29 jul 2014 15:13 skrev "Ursula Braun"
> <ubraun@linux.vnet.ibm.com>:
> >
> > On Sat, 2014-07-26 at 16:35 +0200, Rickard Strandqvist wrote:
> > > Replacing strncpy with strlcpy to avoid strings that lacks null
> terminate.
> > >
> > > Signed-off-by: Rickard Strandqvist
> <rickard_strandqvist@spectrumdigital.se>
> > > ---
> > >  drivers/s390/net/qeth_core_main.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/s390/net/qeth_core_main.c
> b/drivers/s390/net/qeth_core_main.c
> > > index f54bec5..ec9b4d7 100644
> > > --- a/drivers/s390/net/qeth_core_main.c
> > > +++ b/drivers/s390/net/qeth_core_main.c
> > > @@ -5275,7 +5275,7 @@ static int qeth_add_dbf_entry(struct
> qeth_card *card, char *name)
> > >       new_entry = kzalloc(sizeof(struct qeth_dbf_entry),
> GFP_KERNEL);
> > >       if (!new_entry)
> > >               goto err_dbg;
> > > -     strncpy(new_entry->dbf_name, name, DBF_NAME_LEN);
> > > +     strlcpy(new_entry->dbf_name, name, DBF_NAME_LEN);
> > >       new_entry->dbf_info = card->debug;
> > >       mutex_lock(&qeth_dbf_list_mutex);
> > >       list_add(&new_entry->dbf_list, &qeth_dbf_list);
> >
> > It is guaranteed that the string ch->id always fits into
> DBF_NAME_LEN.
> > What's in this case the benefit of replacing strncpy() by strlcpy()
> > here?
> 
> Hi
> 
> If it is really so!
> It can just as well replacing it with strcpy...
> 
> BR
> Rickard Strandqvist

And what would be the benefit of this change? 
