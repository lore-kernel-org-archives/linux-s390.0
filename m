Return-Path: <linux-kernel-owner+w=401wt.eu-S1752980AbYIBOYf@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200809022334.21821.rusty@rustcorp.com.au>
References: <20080730165656.118280544@de.ibm.com>
	 <200808261138.28076.rusty@rustcorp.com.au>
	 <1220272130.23719.6.camel@localhost>
	 <200809022334.21821.rusty@rustcorp.com.au>
Content-Type: text/plain
Date: Tue, 02 Sep 2008 16:16:16 +0200
Message-Id: <1220364976.29912.10.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2008-09-02 at 23:34 +1000, Rusty Russell wrote:
> On Monday 01 September 2008 22:28:50 Martin Schwidefsky wrote:
> > On Tue, 2008-08-26 at 11:38 +1000, Rusty Russell wrote:
> > > Hmm, #define KERN_IGNORE KERN_DEBUG?
> >
> > Hmm, shouldn't KERN_xxx levels be independent of the special id 0?
> 
> I don't know.  Why should something be untranslatable?

Do we really want to require that every message printed with the kmsg
macros has to be documented? I don't think this is a good idea. The
special id 0 is there to tell the script not to bother with a particular
message, e.g. the lovely "module <x> has been loaded" messages. The
message still can be translated.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
