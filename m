Return-Path: <linux-kernel-owner+w=401wt.eu-S1755289AbYGaKYR@vger.kernel.org>
From: "Takashi Nishiie" <t-nishiie@np.css.fujitsu.com>
References: <20080730165656.118280544@de.ibm.com> <20080730171157.170172806@de.ibm.com>
In-Reply-To: <20080730171157.170172806@de.ibm.com>
Subject: RE: [patch 2/3] kmsg: Kernel message catalog script.
Date: Thu, 31 Jul 2008 19:23:56 +0900
Message-ID: <007c01c8f2f7$89f55620$9de00260$@css.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: 'Martin Schwidefsky' <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Michael Holzheu' <holzheu@de.ibm.com>, 'Gerrit Huizenga' <gh@us.ibm.com>, 'Greg Kroah-Hartman' <gregkh@suse.de>, 'Randy Dunlap' <randy.dunlap@oracle.com>, 'Jan Kara' <jack@suse.cz>, 'Pavel Machek' <pavel@ucw.cz>, 'Sam Ravnborg' <sam@ravnborg.org>, 'Joe Perches' <joe@perches.com>, =?iso-8859-1?Q?'Jochen_Vo=DF'?= <jochen.voss@googlemail.com>, 'Kunai Takashi' <kunai@linux-foundation.jp>, 'Tim Bird' <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

> 
> /*?
>  * Tag: <component>.<id>
>  * Text: "<kmsg message text>"
>  * Severity: <severity>
>  * Parameter:
>  *   @1: <description of the first message parameter>
>  *   @2: <description of the second message parameter>
>  *   ...
>  * Description:
>  * <What is the kmsg message all about>
>  * User action:
>  * <What can the user do to fix the problem>  */
> 
> The script looks for a kmsg comment for a kmsg printk at three places, 
> the source file where the kmsg call is located, in the architecture 
> dependent file Documentation/kmsg/$ARCH/<component> and in the common 
> file Documentation/kmsg/<component>.
> 
> The kmsg check is invoked with "make D=1" and reads the source files 
> for all objects that are built by the current configuration and 
> searches for matching kmsg descriptions for the kmsg messages in the 
> source which have a messages id > 0. If a message description can not 
> be found the script prints a blueprint and causes a make error.
> 
> The kmsg man page creation is invoked with "make D=2" and reads the 
> source files for all built objects, looks up the message description 
> and writes a man page to $(objtree)/man.

  I think it is good to number the message. It might be gospel for 
providing with the support service for the corporation.
  However, there is a problem of the scale in numbering of not only a
specific module but also all modules to the message. (There might be 
at least 34000 relating messages or more. )

  It introduces the following Web sites as a approach that arranges 
the message on a Japanese Web site though it apologizes. 

OSS Message Pedia
http://ossmpedia.org/
(Attention: This Web site is being written in Japanese. )

Thanks

--
NISHIIE Takashi
