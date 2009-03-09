Return-Path: <linux-kernel-owner+w=401wt.eu-S1753557AbZCIJrT@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.29-rc7,s390] System goes into endless loop during boot or logon
Date: Mon, 9 Mar 2009 10:46:57 +0100
References: <200903080835.14032.elendil@planet.nl> <200903091025.53284.elendil@planet.nl> <20090309093354.GA4124@cetus.boeblingen.de.ibm.com>
In-Reply-To: <20090309093354.GA4124@cetus.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903091046.58973.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-s390@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Monday 09 March 2009, Hendrik Brueckner wrote:
> On Mon, Mar 09, 2009 at 10:25:51AM +0100, Frans Pop wrote:
> > > Where? Do you have NMI watchdog output, or even sysrq-t?
> >
> > I'm afraid I have no idea.
> >
> > AFAICT s390 does not have an NMI watchdog. And I have no idea how I
> > could trigger a sysrq given that I can't login and only have a dumb
> > console or SSH session to work with anyway.
>
> If SSH works,  try to trigger the sysrq function trough
> /proc/sysrq-trigger, e.g.  echo l > /proc/sysrq-trigger

Yeah, I'm aware of that. Problem is that the loop starts when I try to log 
in over SSH. I do get the welcome message, but I never get a prompt. And 
as soon as the loop starts, the system is completely unresponsive. Even a 
shutdown triggered from the system console does nothing. Only thing I can 
do is a hard "poweroff".
