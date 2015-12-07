Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 7 Dec 2015 14:47:44 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] qeth: don't rely on signedness of char
Message-ID: <20151207134744.GB2716@osiris>
References: <1449351173-6915-1-git-send-email-linux@rasmusvillemoes.dk>
 <1449489755.18521.7.camel@BR9GV9YG.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449489755.18521.7.camel@BR9GV9YG.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 07, 2015 at 01:02:35PM +0100, Ursula Braun wrote:
> Rasmus,
> 
> I do not see a need for your first patch proposal. Our code works fine
> in our environment.
> 
> But I will pickup your second part to remove the explicit setting of the
> 0-termination. Thanks!
> 
> Regards, Ursula

Hi Uschi,

das untenstehende habe ich schon diverse male geschrieben, um zu
verhindern, dass "wir" uns mit einfach vermeidbaren Dingen auf externen
Mailinglisten unbeliebt machen:

Just a general comment and unrelated to this patch.
Please, when replying:

- don't top-post
- use interleaved style with an empty line after each quoted block
- trim your replies to only the relevant parts

See also: https://en.wikipedia.org/wiki/Posting_style

This should make your and everybody else's life easier when your are
participating on external mailing lists.
