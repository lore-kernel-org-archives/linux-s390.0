Return-Path: <linux-kernel-owner+w=401wt.eu-S1756430AbYLHGfH@vger.kernel.org>
Message-ID: <493CB8FA.3050308@uniadex.co.jp>
Date: Mon, 8 Dec 2008 15:04:42 +0900
From: "Takahashi, Hideki" <hideki.takahashi@uniadex.co.jp>
MIME-Version: 1.0
Subject: kprintk patch and OSS Message Pedia
References: <20080925162827.818261893@de.ibm.com> <20080925163020.899754085@de.ibm.com>
In-Reply-To: <20080925163020.899754085@de.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "lf_kernel_messages@lists.linux-foundation.org" <lf_kernel_messages@lists.linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?windows-1252?Q?Jochen_Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>, "Klaus-D. Wacker" <kdwacker@de.ibm.com>, "server-messagedb-tf@ipa.go.jp" <server-messagedb-tf@ipa.go.jp>
List-ID: <linux-s390.vger.kernel.org>

Hello Mr. Martin schwidefsky,
   I expect your patch will be merged into the kernel tree soon.
   My friends and I have been working for providing a kernel
   message online manual called "OSS Message Pedia" (mPedia) in
   Japan.
   I=92d like to introduce mPedia briefly here because the kprintk
   patch will affect our mPedia activities in Japan.

   Development of OSS Message Pedia was partly supported by IPA
   (Information-Technology Promotion Agency) Japan and it has
   been opened to the public.
   mPedia has internationalization function inside but currently
   it has only Japanese contents except some sample English contents.
   For example, you can find English contents with the following URL:

      http://ossmpedia.org/messages/linux/2.6.9-34.EL/297.en

   (You can change the tag 'languages' to "ja" to get Japanese
    contents.)

   Also you can find some English documentation about mPedia by
   visiting the following URL:

       http://ossmpedia.wiki.sourceforge.net/

   We hope we could have some contribution to the kernel messaging
   with the mPedia activities in Japan. Though we don't have a
   particular solution about how to tie-up the kernel messaging at
   this moment, we think some difficulties in the mPedia maintenance
   and enhancements could be reduced with the kprintk patch.

   (1) We have about 850 kernel message explanation contents in
       Japanese. The each content includes meaning, actions, etc.

   (2) We're now considering how to translate Japanese contents
       into English. (No bright idea came yet.)

   We appreciate your efforts for improving kernel messaging and
   the patch integration.

   (I added "server-messagedb-tf@ipa.go.jp" in CC.)

   Thank you.

Best Regards,
Hideki Takahashi
