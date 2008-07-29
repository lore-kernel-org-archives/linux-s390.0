Return-Path: <linux-kernel-owner+w=401wt.eu-S1756226AbYG2PBS@vger.kernel.org>
Message-ID: <ef1cd66f0807290801q647d7efbn9f9058531bc6f32c@mail.gmail.com>
Date: Tue, 29 Jul 2008 16:01:01 +0100
From: "=?ISO-8859-1?Q?Jochen_Vo=DF?=" <jochen.voss@googlemail.com>
Subject: Re: [patch 02/15] kmsg: Kernel message catalog script.
In-Reply-To: <1217329750.10259.38.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080728175355.734299984@de.ibm.com>
	 <20080728175511.260174666@de.ibm.com>
	 <20080728192828.GA11431@uranus.ravnborg.org>
	 <1217320950.10259.15.camel@localhost>
	 <20080729084536.GA29659@uranus.ravnborg.org>
	 <1217329750.10259.38.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Martin,

I think the changelog needs fixing, too:

2008/7/29 Martin Schwidefsky <schwidefsky@de.ibm.com>:
> The kmsg check is invoked with "make K=1" and reads the source files for
> all objects that are built by the current configuration and searches for
> matching kmsg descriptions for the kmsg messages in the source which
> have a messages id > 0. If a message description can not be found the
> script prints a blueprint and causes a make error.
>
> The kmsg man page creation is invoked with "make K=2" and reads the source
> files for all built objects, looks up the message description and writes
> a man page to $(objtree)/man.
This should be "D=1" and "D=2" now, shouldn't it?

I hope this helps,
Jochen
-- 
http://seehuhn.de/
