Return-Path: <linux-kernel-owner+w=401wt.eu-S1753359AbYHPTg4@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Joe Perches <joe@perches.com>
In-Reply-To: <1218326902.14983.22.camel@localhost>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <3ae72650807301502h3e54e80yb405af7192048b89@mail.gmail.com>
	 <20080730220432.GA24800@suse.de> <1217495404.8555.20.camel@localhost>
	 <20080805223117.GA6552@suse.de> <1218011716.20769.12.camel@localhost>
	 <20080806200721.GA30086@suse.de>  <1218097901.1033.10.camel@localhost>
	 <1218124771.5882.37.camel@localhost>  <1218326902.14983.22.camel@localhost>
Content-Type: text/plain
Date: Sat, 16 Aug 2008 12:36:14 -0700
Message-Id: <1218915375.24527.105.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2008-08-10 at 02:08 +0200, Martin Schwidefsky wrote:
> On Thu, 2008-08-07 at 08:59 -0700, Joe Perches wrote:
> > On Thu, 2008-08-07 at 10:31 +0200, Martin Schwidefsky wrote:
> > > 1) The message tag is for the user of the system. If it does not have a
> > > fixed position it gets confusing.
> > I think the message tag today is not useful for a user.
> > It seems a barely useful maintainer value.
> > Perhaps the message tag allows for run-time language
> > translation and maybe a bit better selective logging.
> Aehhm, .. what ? If a user does not understand a message directly
> how can he NOT be interested in the kmsg tag? As a random example
> consider the situation when the user gets the message
> 
> 	monwriter.1: Writing monitor data failed with rc=5
> 
> Usually a user will go "Huh?" except if he is a z/VM expert. Looking
> at the source code won't help too much either:
> 
> static int monwrite_diag(struct monwrite_hdr *myhdr, char *buffer, int fcn)
> {
>         struct appldata_product_id id;
>         int rc;
> 
>         strcpy(id.prod_nr, "LNXAPPL");
>         id.prod_fn = myhdr->applid;
>         id.record_nr = myhdr->record_num;
>         id.version_nr = myhdr->version;
>         id.release_nr = myhdr->release;
>         id.mod_lvl = myhdr->mod_level;
>         rc = appldata_asm(&id, fcn, (void *) buffer, myhdr->datalen);
>         if (rc <= 0)
>                 return rc;
>         if (rc == 5)
>                 return -EPERM;
>         kmsg_err(1,"Writing monitor data failed with rc=%i\n", rc);
>         return -EINVAL;
> }
> 
> What the user should do is to cut-copy-paste the kmsg tag monwriter.1
> and pass it to man:
> 
> # man monwriter.1
> 
> What the user will then get is the man page that has been generated
> from the kmsg comment with "make D=2":
> 
> --- snip
> monwriter.1(9)                                                  monwriter.1(9)
> 
> Message
>        monwriter.1: Writing monitor data failed with rc=%i
> 
> Severity
>        Error
> 
> Parameters
>        @1: return code
> 
> Description
>        The  monitor  stream  application  device driver used the z/VM diagnose
>        call DIAG X'DC' to start writing monitor data. z/VM returned  an  error
>        and  the  monitor data cannot be written. If the return code is 5, your
>        z/VM guest virtual machine is not authorized to write monitor data.
> 
> User action
>        If the return code is 5, ensure that your z/VM guest virtual  machine's
>        entry in the z/VM directory includes the OPTION APPLMON statement.  For
>        other return codes see the section about DIAGNOSE Code X'DC'  in  "z/VM
>        CP Programming Services".

Doesn't this example better illustrate the barely useful
user value of such a message and documentation?

In your example, monwriter.1 with a return code of 5 isn't possible.
