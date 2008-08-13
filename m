Return-Path: <linux-kernel-owner+w=401wt.eu-S1752620AbYHMEdT@vger.kernel.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Date: Wed, 13 Aug 2008 14:33:01 +1000
References: <20080730165656.118280544@de.ibm.com> <20080730171156.824640459@de.ibm.com>
In-Reply-To: <20080730171156.824640459@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808131433.02966.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?utf-8?q?Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thursday 31 July 2008 02:56:57 Martin Schwidefsky wrote:
> From: Michael Holzheu <holzheu@de.ibm.com>
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>
> Introduce a new family of printk macros which prefixes each kmsg message
> with a component name and allows to tag the printk with a message id.

Can you hash the format string to generate the id?  6 hex digits should be 
enough, and your tool can check for clashes.  As it's bad form to have 
identical strings for different semantics anyway, this seems to make sense.

Rusty.
