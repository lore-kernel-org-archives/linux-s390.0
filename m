Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/7] pm: improve error code of pm_notifier_call_chain()
Date: Thu, 7 Jul 2011 23:06:02 +0200
References: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com> <20110703171539.GF21127@elf.ucw.cz> <CAC5umyibWo===0Lr5Wz2moOvnf0qiAvFLo4--sLCRmx4sJrdRA@mail.gmail.com>
In-Reply-To: <CAC5umyibWo===0Lr5Wz2moOvnf0qiAvFLo4--sLCRmx4sJrdRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201107072306.02708.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, Jiri Kosina <jkosina@suse.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Monday, July 04, 2011, Akinobu Mita wrote:
> 2011/7/4 Pavel Machek <pavel@ucw.cz>:
> > On Sun 2011-07-03 23:16:15, Akinobu Mita wrote:
> >> This enables pm_notifier_call_chain() to get the actual error code
> >> in the callback rather than always assume -EINVAL by converting all
> >> PM notifier calls to return encapsulate error code with
> >> notifier_from_errno().
> >>
> >> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> >> Cc: Pavel Machek <pavel@ucw.cz>
> >
> > Nothing obviously wrong here.
> 
> Thanks. Can I add your ACK for this patch?

Do you want me to take this patch?

Rafael
