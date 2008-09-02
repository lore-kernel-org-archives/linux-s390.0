Return-Path: <linux-kernel-owner+w=401wt.eu-S1753970AbYIBOAS@vger.kernel.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Date: Tue, 2 Sep 2008 23:34:19 +1000
References: <20080730165656.118280544@de.ibm.com> <200808261138.28076.rusty@rustcorp.com.au> <1220272130.23719.6.camel@localhost>
In-Reply-To: <1220272130.23719.6.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809022334.21821.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?utf-8?q?Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Monday 01 September 2008 22:28:50 Martin Schwidefsky wrote:
> On Tue, 2008-08-26 at 11:38 +1000, Rusty Russell wrote:
> > Hmm, #define KERN_IGNORE KERN_DEBUG?
>
> Hmm, shouldn't KERN_xxx levels be independent of the special id 0?

I don't know.  Why should something be untranslatable?

Rusty.
