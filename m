Return-Path: <linux-kernel-owner+w=401wt.eu-S1756148AbYHALk2@vger.kernel.org>
Subject: RE: [patch 2/3] kmsg: Kernel message catalog script.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <007c01c8f2f7$89f55620$9de00260$@css.fujitsu.com>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171157.170172806@de.ibm.com>
	 <007c01c8f2f7$89f55620$9de00260$@css.fujitsu.com>
Content-Type: text/plain
Date: Fri, 01 Aug 2008 13:39:48 +0200
Message-Id: <1217590788.10483.14.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Takashi Nishiie <t-nishiie@np.css.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, 'Andrew Morton' <akpm@linux-foundation.org>, 'Michael Holzheu' <holzheu@de.ibm.com>, 'Gerrit Huizenga' <gh@us.ibm.com>, 'Greg Kroah-Hartman' <gregkh@suse.de>, 'Randy Dunlap' <randy.dunlap@oracle.com>, 'Jan Kara' <jack@suse.cz>, 'Pavel Machek' <pavel@ucw.cz>, 'Sam Ravnborg' <sam@ravnborg.org>, 'Joe Perches' <joe@perches.com>, 'Jochen =?ISO-8859-1?Q?Vo=DF=27?= <jochen.voss@googlemail.com>, 'Kunai Takashi' <kunai@linux-foundation.jp>, 'Tim Bird' <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-07-31 at 19:23 +0900, Takashi Nishiie wrote:
>   However, there is a problem of the scale in numbering of not only a
> specific module but also all modules to the message. (There might be 
> at least 34000 relating messages or more. )

Could you explain this a bit more? I'm not sure I understood it
correctly. I'm unsure about the term "relating message". A single ksmg
message can be printed from several modules if it is the same message.
Do you want to create a list of modules that issue a particular message?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
